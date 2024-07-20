unit ControllerCtrlEstoqueZerado;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblCtrlEstoqueZerado ,Un_MSg,Generics.Collections;

Type
  TListaCtrlEstoqueZerado = TObjectList<TCtrlEstoqueZerado>;

  TControllerCtrlEstoqueZerado = Class(TControllerBase)

  private
    FNotificaEmail: Boolean;
    procedure setfFNotificaEmail(const Value: Boolean);

  public
    Registro : TCtrlEstoqueZerado;
    Lista : TListaCtrlEstoqueZerado;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
    property NotificaEmail :Boolean read FNotificaEmail;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerCtrlEstoqueZerado.Create(AOwner: TComponent);
begin
  inherited;
  FNotificaEmail := ( Fc_Tb_Geral('L','EST_NOTIFICA_EMAIL','N')  = 'S');
  Registro := TCtrlEstoqueZerado.Create;
  Lista := TListaCtrlEstoqueZerado.Create;
end;

function TControllerCtrlEstoqueZerado.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCtrlEstoqueZerado.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerCtrlEstoqueZerado.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CTRL_ESTOQUE_ZERADO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCtrlEstoqueZerado.migra: boolean;
begin
  try
    Result := True;
    SaveObj(Registro);
  Except
    Result := False;
  end;


end;

function TControllerCtrlEstoqueZerado.replace: boolean;
begin
  try
    Result := True;
    replaceObj(Registro);
  Except
    Result := False;
  end;
end;

function TControllerCtrlEstoqueZerado.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CTRL_ESTOQUE_ZERADO');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


procedure TControllerCtrlEstoqueZerado.setfFNotificaEmail(const Value: Boolean);
begin
  FNotificaEmail := Value;
end;

function TControllerCtrlEstoqueZerado.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerCtrlEstoqueZerado.getById;
begin
  _getByKey(Registro);
end;

function TControllerCtrlEstoqueZerado.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TCtrlEstoqueZerado;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CTRL_ESTOQUE_ZERADO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TCtrlEstoqueZerado.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


end.
