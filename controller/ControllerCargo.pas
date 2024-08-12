unit ControllerCargo;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCargo, prm_job_position;

Type
  TListaCargo = TObjectList<TCargo>;
  TControllerCargo = Class(TControllerBase)
  private
    FParametros: TPrmJobPosition;
    procedure setFParametros(const Value: TPrmJobPosition);
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
    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmJobPosition read FParametros write setFParametros;

  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerCargo.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCargo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCargo.Create;
  Lista := TListaCargo.Create;
  FParametros := TPrmJobPosition.Create;
end;

function TControllerCargo.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerCargo.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerCargo.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CARGO');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerCargo.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerCargo.replace: boolean;
begin
  Result := True;
  replaceObj(Registro);
end;

function TControllerCargo.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CARGO');
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerCargo.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCargo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CARGO ',
                      'WHERE CRG_CODIGO IS NOT NULL '
      ));
      if FParametros.FieldName.Descricao <> '' then
        sql.add(' AND ( CRG_DESCRICAO LIKE :CRG_DESCRICAO ) ');

      if FParametros.FieldName.Descricao <> '' then
        ParamByName('CRG_DESCRICAO').AsString := concat('%',FParametros.FieldName.Descricao,'%');

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

procedure TControllerCargo.setFParametros(const Value: TPrmJobPosition);
begin
  FParametros := Value;
end;

function TControllerCargo.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
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
  Lc_Qry := GeraQuery;
  Try
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
  Result := True;
  Lc_Qry := GeraQuery;
  Try
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
