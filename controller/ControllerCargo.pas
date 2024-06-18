unit ControllerCargo;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblCargo ,Un_MSg,Generics.Collections;

Type
  TListaCargo = TObjectList<TCargo>;

  TControllerCargo = Class(TControllerBase)

  private

  public
    Registro : TCargo;
    Lista : TListaCargo;
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
    Function GetcargoVendedor : Integer;
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

constructor TControllerCargo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCargo.Create;
  Lista := TListaCargo.Create;
end;

function TControllerCargo.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCargo.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerCargo.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CARGO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCargo.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerCargo.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerCargo.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CARGO');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCargo.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerCargo.getById;
begin
  _getByKey(Registro);
end;


function TControllerCargo.GetcargoVendedor: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat('select CRG_CODIGO ',
                     'from TB_CARGO ',
                     'where ( CRG_DESCRICAO =:CRG_DESCRICAO ) '
                     ));
      ParamByName('CRG_DESCRICAO').AsString := 'VENDEDOR';
      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        REsult := FieldByName('CRG_CODIGO').AsInteger;
      End
      else
      BEgin
        Registro.codigo := 0;
        Registro.Descricao :=  'VENDEDOR';
        Self.insert;
        REsult := Registro.Codigo;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerCargo.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TCargo;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CARGO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TCargo.Create;
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
