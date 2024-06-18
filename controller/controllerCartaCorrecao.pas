unit controllerCartaCorrecao;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblCartaCorrecao, Md5, STQuery,
      Generics.Collections,objInvoiceRectification,ControllerGestaoWeb;

Type
  TListaCartaCorrecao = TObjectList<TCartaCorrecao>;

  TControllerCartaCorrecao = Class(TControllerBase)

  private
    ExportGestaoWeb : TControllerGestaoWeb;
  public
    Registro : TCartaCorrecao;
    Lista: TListaCartaCorrecao;
    Obj:TObjInvoiceRectification;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
    function update:Boolean;
    procedure getlist;
    procedure FillDataObjeto(pReg: TCartaCorrecao);
    procedure getSincronia;
  End;

  implementation
{ ControllerCartaCorrecao}

function TControllerCartaCorrecao.update: Boolean;
begin
  try
    updateObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

procedure TControllerCartaCorrecao.clear;
begin

end;

constructor TControllerCartaCorrecao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCartaCorrecao.Create;
  Lista := TListaCartaCorrecao.Create;
  Obj := TObjInvoiceRectification.create;
  ExportGestaoWeb := TControllerGestaoWeb.Create(Self);
end;

function TControllerCartaCorrecao.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCartaCorrecao.Destroy;
begin
  ExportGestaoWeb.DisposeOf;
  Obj.Destroy;;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerCartaCorrecao.FillDataObjeto(pReg: TCartaCorrecao);
begin
  with obj do
  Begin
    with CartaCorrecao do
    Begin
      Codigo          := pReg.Codigo;
      Estabelecimento := Obj.Estabelecimento;
      Terminal        := Obj.Terminal;
      NotaFiscal      := pReg.Codnfl;
      DataEmissao     := pReg.Data;
      Chave           := pReg.Chave;
      protocolo       := pReg.Protocolo;
      CodigoUF        := pReg.Codufe;
      Sequencia       := pReg.Sequencia;
      Observacao      := pReg.Detalhe;
      Status          := pReg.Codsit;
      Motivo          := pReg.Motivo;
    End;
  End;
end;

function TControllerCartaCorrecao.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCartaCorrecao.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCartaCorrecao.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCartaCorrecao.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
procedure TControllerCartaCorrecao.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TCartaCorrecao;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT CCE.* ',
                      'FROM TB_CARTA_CORRECAO CCE '
                    ));
      if FPeriodo then
      Begin
        sql.add(concat(
                  '  INNER JOIN TB_NOTA_FISCAL NF ',
                  '  ON (NF.NFL_CODIGO = CCE.CCE_CODNFL) '
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
        LITem := TCartaCorrecao.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCartaCorrecao.getSincronia;
begin
  _getByKey(Registro);
end;

end.
