unit ControllerRetornoNFe;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema, tblRetornoNfe,
      Generics.Collections,ObjInvoiceReturn55,ControllerGestaoWeb;

Type
  TListaRetornoNFe = TObjectList<TRetornoNfe>;

  TControllerRetornoNFe = Class(TControllerBase)
  private
    ExportGestaoWeb : TControllerGestaoWeb;
  public
    Registro : TRetornoNFe;
    Lista : TListaRetornoNFe;
    Obj: TObjInvoiceReturn55;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getByNotaFiscal;
    procedure getlist;
    function salva:boolean;
    function atualiza:boolean;
    function migra:Boolean;
    function insere:boolean;
    procedure Clear;
    function UpdateFileXMl:Boolean;
    procedure getSincronia;
    procedure FillDataObjeto(pReg: TRetornoNfe);
  End;


implementation

{ TControllerRetornoNFe }

uses Un_Regra_Negocio;

function TControllerRetornoNFe.atualiza: boolean;
begin
  try
    updateObj(Registro);
    REsult := True;
  except
    REsult := False;
  end;
end;

procedure TControllerRetornoNFe.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerRetornoNFe.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetornoNFe.create;
  Lista := TListaRetornoNFe.Create;
  Obj := TObjInvoiceReturn55.create;
  ExportGestaoWeb := TControllerGestaoWeb.Create(self);
end;

destructor TControllerRetornoNFe.Destroy;
begin
  Obj.Destroy;
  ExportGestaoWeb.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerRetornoNFe.FillDataObjeto(pReg: TRetornoNFe);
begin
  with obj do
  Begin
    Retorno.Codigo          := pReg.NotaFiscal;
    Retorno.Estabelecimento := obj.Estabelecimento;
    Retorno.Terminal        := obj.Terminal;
    Retorno.Numero          := pReg.NumeroInicial;
    Retorno.Serie           := pReg.Serie.ToString;
    Retorno.Status          := pReg.Situacao;
    Retorno.NomeArquivo     := pReg.NomeArquivo;
    Retorno.Motivo          := pReg.Motivo;
  End;
end;

procedure TControllerRetornoNFe.getByNotaFiscal;
var
  Lc_Qry : TSTQuery;
  LITem : TRetornoNFe;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_RETORNO_NFE ',
                      'WHERE NFE_CODNFL=:NFE_CODNFL '
                    ));
      ParamByName('NFE_CODNFL').AsInteger := Registro.NotaFiscal;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetornoNFe.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TRetornoNFe;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT NFE.* ',
                      'FROM TB_RETORNO_NFE NFE '
                    ));

      if FPeriodo then
      Begin
        sql.add(concat(
                  '  INNER JOIN TB_NOTA_FISCAL NF ',
                  '  ON (NF.NFL_CODIGO = NFE.NFE_CODNFL) '
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
        LITem := TRetornoNFe.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetornoNFe.getSincronia;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ',
                '   NFE_CODIGO, ',
                '   NFE_CODNFL, ',
                '   NFE_CODSIT, ',
                '   NFE_ARQUIVO, ',
                '   NFE_NOTA_INI, ',
                '   NFE_NOTA_FIM, ',
                '   NFE_MOTIVO, ',
                '   NFE_CODMHA, ',
                '   n.nfl_serie NFE_SERIE ',
                'FROM tb_retorno_nfe R ',
                '  INNER JOIN tb_nota_fiscal N ',
                '  ON (R.nfe_codnfl = N.nfl_codigo) ',
                'WHERE (NFE_CODIGO=:NFE_CODIGO) ',
                ' ORDER BY NFE_CODNFL ASC '
      ));
      ParamByName('NFE_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerRetornoNFe.insere: boolean;
begin
  Registro.Codigo := Generator('GN_RETORNO_NFE');
  InsertObj(Registro);
end;

function TControllerRetornoNFe.migra: Boolean;
begin
    InsertObj(Registro);
end;

function TControllerRetornoNFe.salva: boolean;
begin
  try
    if registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_RETORNO_NFE');
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerRetornoNFe.UpdateFileXMl: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('UPDATE TB_RETORNO_NFE SET ',
                     'NFE_ARQUIVO =:NFE_ARQUIVO ',
                      'WHERE NFE_CODNFL=:NFE_CODNFL '
                    ));
      ParamByName('NFE_CODNFL').AsInteger := Registro.NotaFiscal;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
