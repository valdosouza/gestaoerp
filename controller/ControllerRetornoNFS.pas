unit ControllerRetornoNFS;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes, tblREtornoNFS ,
      ControllerLoteNfse, ControllerRpsNfse,ControllerNFSEletronica,
      ObjInvoiceReturnService,ControllerGestaoWeb,
      Generics.Collections;

Type
  TListaRetornoNFS = TObjectList<TRetornoNFS>;

  TControllerRetornoNFS = Class(TControllerBase)
  private
    ExportGestaoWeb : TControllerGestaoWeb;
  public
    Registro : TRetornoNFS;
    Lote : TControllerLoteNfse;
    Rps : TControllerRpsNfse;
    Config : TControllerNFSEletronica;
    Obj: TObjInvoiceReturnService;
    Lista : TListaRetornoNFS;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure inicializa;
    function salva:boolean;
    function Atualiza:boolean;
    procedure getAll;
    procedure getAutorizada;
    procedure Clear;
    procedure ClearDataObj;
    procedure getSincronia;
    procedure getlist;
    procedure FillDataObjeto(pReg: TRetornoNFS);
  End;

implementation

uses Un_Regra_Negocio;

function TControllerRetornoNFS.Atualiza: boolean;
begin
  try
    updateObj(Registro);
    Result := True;
  finally
    Result := True;
  end;
end;

procedure TControllerRetornoNFS.Clear;
begin
  clearObj(registro);
end;

procedure TControllerRetornoNFS.ClearDataObj;
begin
  clearObj(Obj.ReciboProvisorio);
  clearObj(Obj.Retorno);
end;

constructor TControllerRetornoNFS.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetornoNFs.Create;
  Lote := TControllerLoteNfse.Create(Self);
  Rps := TControllerRpsNfse.Create(Self);
  Config := TControllerNFSEletronica.Create(Self);
  Obj := TObjInvoiceReturnService.Create;
  ExportGestaoWeb := TControllerGestaoWeb.Create(Self);
  Lista := TListaRetornoNFS.Create;
end;

destructor TControllerRetornoNFS.Destroy;
begin
  Lista.DisposeOf;
  Obj.Destroy;
  Registro.DisposeOf;
  Lote.DisposeOf;
  Rps.DisposeOf;
  inherited;
end;

procedure TControllerRetornoNFS.FillDataObjeto(pReg: TRetornoNFS);
begin
  Lote.Registro.CodigoNotaFiscal := pReg.CodigoNotaFiscal;
  Lote.Registro.CodigoEstabelecimento := pReg.CodigoEstabelecimento;
  Lote.get;

  Rps.Registro.CodigoNotaFiscal :=  pReg.CodigoNotaFiscal;
  Rps.Registro.CodigoEstabelecimento :=  pReg.CodigoEstabelecimento;
  Rps.get;

  with obj do
  Begin
    with ReciboProvisorio do
    Begin
      Codigo          := pReg.CodigoNotaFiscal;
      Estabelecimento := obj.Estabelecimento;
      DataEmissao     := Rps.Registro.DataEmissao;
      Terminal        := obj.Terminal;
      Numero          := Rps.Registro.Numero;
      Lote            := Self.Lote.Registro.Numero;
      protocolo       := Rps.Registro.Protocolo;
      Observacao      := Rps.Registro.Observacao
    End;
    with Retorno do
    Begin
      Codigo            := pReg.CodigoNotaFiscal;
      Estabelecimento   := obj.Estabelecimento;
      Terminal          := obj.Terminal;
      Numero            := pReg.Numero;
      Rps               := pReg.ReciboProvisorios;
      if pReg.Lote > 0 then
        Lote              := pReg.Lote
      else
        Lote              := Self.Lote.Registro.Numero;
      protocolo         := Obj.ReciboProvisorio.Protocolo;
      CodigoVerificacao := pReg.CodigoVerificacao;
      Tipo              := pReg.Tipo;
      Sincrono          := pReg.Sincrono;
      Status            := pReg.CodigoSituacao;
      NomeArquivo       := pReg.Arquivo;
      Motivo            := pReg.Motivo;
    End;
  End;
end;

procedure TControllerRetornoNFS.getAll;
begin
  Lote.get;
  Rps.get;
  _getByKey(Registro);

end;

procedure TControllerRetornoNFS.getAutorizada;
var
  Lc_Qry : TSTQuery;
  LITem : TRetornoNFS;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT r.* ',
              'FROM TB_NOTA_FISCAL n ',
              '  INNER JOIN TB_RETORNO_NFS r ',
              '  ON (r.NFS_CODNFL = n.NFL_CODIGO) ',
              'WHERE n.NFL_CODIGO =:NFL_CODIGO ',
              ' AND (NFS_CODSIT =:NFS_CODSIT) '
              ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.CodigoNotaFiscal;
      ParamByName('NFS_CODSIT').AsInteger := 4;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro  );
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetornoNFS.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TRetornoNFS;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT NFS.* ',
                      'FROM TB_RETORNO_NFS NFS '
                    ));
      if FPeriodo then
      Begin
        sql.add(concat(
                  '  INNER JOIN TB_NOTA_FISCAL NF ',
                  '  ON (NF.NFL_CODIGO = NFS.NFS_CODNFL) '
        ));

        sql.add('WHERE ( NF.NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ) ');
      End;

      if FPeriodo then
      Begin
        ParamByName('DATAINI').AsDateTime := FDataInicial;
        ParamByName('DATAFIM').AsDateTime := FDataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TRetornoNFS.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerRetornoNFS.getSincronia;
begin
  getAll;
end;

procedure TControllerRetornoNFS.inicializa;
begin
  //Controle de Lote
  Lote.Registro.CodigoEstabelecimento := Registro.CodigoEstabelecimento;
  Lote.Registro.CodigoNotaFiscal := Registro.CodigoNotaFiscal;
  Lote.get;
  //RPS
  Rps.Registro.CodigoEstabelecimento := Registro.CodigoEstabelecimento;
  Rps.Registro.CodigoNotaFiscal := Registro.CodigoNotaFiscal;
  Rps.get;
  //Configuração
  Config.Registro.CodigoEstabelecimento := Registro.CodigoEstabelecimento;
  Config.get;
end;


function TControllerRetornoNFS.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
