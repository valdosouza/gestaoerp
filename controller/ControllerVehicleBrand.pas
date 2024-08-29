unit ControllerVehicleBrand;

interface

uses STDatabase,Classes, STQuery,SysUtils,ControllerBase,
      tblVehicleBrand ,Un_MSg,Generics.Collections, prm_vehicle_brand, controllerfornecedor;

Type
  TListaBrand = TObjectList<TVehicleBrand>;

  TControllerVehicleBrand = Class(TControllerBase)

  private
    FParametros: TPrmVehicleBrand;
    procedure setFParametros(const Value: TPrmVehicleBrand);

  protected

  public
    Registro : TVehicleBrand;
    Lista : TListaBrand;
    Fornecedor : TControllerFornecedor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmVehicleBrand read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;


function TControllerVehicleBrand.Clear: Boolean;
begin
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerVehicleBrand.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TVehicleBrand.Create;
  Lista := TListaBrand.Create;
  FParametros := TPrmVehicleBrand.Create;
  Fornecedor := TControllerFornecedor.Create(Self);
end;

function TControllerVehicleBrand.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerVehicleBrand.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  FParametros.DisposeOf;
  Fornecedor.DisposeOf;
  inherited;
end;

function TControllerVehicleBrand.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MARCAMODELO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerVehicleBrand.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_MARCAMODELO');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerVehicleBrand.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TVehicleBrand;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        ' SELECT v.*, m.mod_codigo, m.MOD_DESCRICAO '+
        ' FROM TB_MARCA_VEICULO v '+
        ' LEFT OUTER JOIN TB_MODELO m ' +
        '   ON (m.MOD_CODMRC = v.MRC_CODIGO) ' +
        ' WHERE 1=1 ';

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND v.MRC_DESCRICAO LIKE :MRC_DESCRICAO';
        ParamByName('MRC_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.ModeloDescricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND m.MOD_DESCRICAO LIKE :MOD_DESCRICAO';
        ParamByName('MOD_DESCRICAO').AsString := Concat('%',FParametros.FieldName.ModeloDescricao,'%');
      end;

      if FParametros.FieldName.MarcasVazio then
        SQL.Text := SQL.Text + ' AND m.MOD_DESCRICAO IS NULL '
      else
        SQL.Text := SQL.Text + ' AND m.MOD_DESCRICAO IS NOT NULL ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TVehicleBrand.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        LITem.ModeloDescricao := FieldByName('MOD_DESCRICAO').AsString;

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerVehicleBrand.setFParametros(const Value: TPrmVehicleBrand);
begin
  FParametros := Value;
end;

function TControllerVehicleBrand.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerVehicleBrand.getById;
begin
  _getByKey(Registro);
end;

function TControllerVehicleBrand.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TVehicleBrand;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MARCA_VEICULO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TVehicleBrand.Create;
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
