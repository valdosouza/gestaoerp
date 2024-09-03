unit ControllerVehicleModel;

interface

uses STDatabase,Classes, STQuery,SysUtils,ControllerBase,FireDAC.Stan.Param,
      tblVehicleModel ,Un_MSg,Generics.Collections, prm_Vehicle_Model;

Type
  TListaModel = TObjectList<TVehicleModel>;

  TControllerVehicleModel = Class(TControllerBase)

  private
    FParametros: TPrmVehicleModel;
    procedure setFParametros(const Value: TPrmVehicleModel);

  public
    Registro : TVehicleModel;
    Lista : TListaModel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure clear;

    procedure search;
    property Parametros : TPrmVehicleModel read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;


procedure TControllerVehicleModel.clear;
begin
  clearObj(Registro);
end;

constructor TControllerVehicleModel.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TVehicleModel.Create;
  Lista := TListaModel.Create;
  Parametros := TPrmVehicleModel.Create;
end;

function TControllerVehicleModel.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerVehicleModel.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Parametros.DisposeOf;
  inherited;
end;

function TControllerVehicleModel.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MODELO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerVehicleModel.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_MODELO');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerVehicleModel.search;
var
  Lc_Qry : TSTQuery;
  LITem : TVehicleModel;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_MODELO WHERE 1=1 ';

      if FParametros.FieldName.CodigoMarca > 0 then
      begin
        SQL.Text := SQL.Text + ' AND MOD_CODMRC LIKE :MOD_CODMRC';
        ParamByName('MOD_CODMRC').AsInteger := FParametros.FieldName.CodigoMarca;
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TVehicleModel.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerVehicleModel.setFParametros(const Value: TPrmVehicleModel);
begin
  FParametros := Value;
end;

function TControllerVehicleModel.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerVehicleModel.getById;
begin
  _getByKey(Registro);
end;

function TControllerVehicleModel.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TVehicleModel;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_MODELO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TVehicleModel.Create;
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
