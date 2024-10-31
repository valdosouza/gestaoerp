unit ControllerCustomerOrigin;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCustomerOrigin, prm_customer_origin;

Type
  TListCustomerOrigin = TObjectList<TCustomerOrigin>;
  TControllerCustomerOrigin = Class(TControllerBase)
  private
    FParametros: TPrmCustomerOrigin;
    procedure setFParametros(const Value: TPrmCustomerOrigin);
  public
    Registro : TCustomerOrigin;
    Lista : TListCustomerOrigin;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmCustomerOrigin read FParametros write setFParametros;
  End;

implementation

function TControllerCustomerOrigin.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCustomerOrigin.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCustomerOrigin.Create;
  FParametros := TPrmCustomerOrigin.Create;
  Lista := TListCustomerOrigin.Create;
end;

function TControllerCustomerOrigin.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCustomerOrigin.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  inherited;
end;

function TControllerCustomerOrigin.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCustomerOrigin.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'ID',0);
  SaveObj(Registro);
end;

function TControllerCustomerOrigin.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerCustomerOrigin.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCustomerOrigin;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_CUSTOMER_ORIGEN where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ID = :ID';
        ParamByName('ID').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DESCRIPTION LIKE :DESCRIPTION';
        ParamByName('DESCRIPTION').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY DESCRIPTION ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCustomerOrigin.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCustomerOrigin.setFParametros(const Value: TPrmCustomerOrigin);
begin
  FParametros := Value;
end;

procedure TControllerCustomerOrigin.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCustomerOrigin.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

