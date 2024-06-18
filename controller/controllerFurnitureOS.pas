unit controllerFurnitureOS;

interface

uses STDatabase,Classes, STQuery, Vcl.StdCtrls,  SysUtils,ControllerBase,
      tblFurnitureOS ,Un_MSg,Generics.Collections,ControllerNotaFiscal,
      ControllerAnnotation;

Type
  TListaFurnitureOS = TObjectList<TFurnitureOS>;

  TControllerFurnitureOS = Class(TControllerBase)

  private

  public
    Registro : TFurnitureOS;
    NotaFiscal : TControllerNotaFiscal;
    Anotacao : TControllerAnnotation;
    Lista : TListaFurnitureOS;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbySearch;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure ComboEquipment(Combo:TComboBox);
    procedure ComboEnvironment(Combo:TComboBox);
    procedure ComboBrand(Combo:TComboBox);
    procedure ComboModel(Combo:TComboBox);
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

procedure TControllerFurnitureOS.ComboBrand(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct fu.brand ',
                'from tb_furniture_os fu ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('brand').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFurnitureOS.ComboEnvironment(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct fu.environment ',
                'from tb_furniture_os fu ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('environment').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFurnitureOS.ComboEquipment(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct fu.equipment ',
                'from tb_furniture_os fu ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('equipment').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerFurnitureOS.ComboModel(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct fu.model ',
                'from tb_furniture_os fu ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('model').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

constructor TControllerFurnitureOS.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFurnitureOS.Create;
  NotaFiscal := TControllerNotaFiscal.create(self);
  Anotacao := TControllerAnnotation.Create(self);
  Lista := TListaFurnitureOS.Create;
end;

function TControllerFurnitureOS.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerFurnitureOS.Destroy;
begin
  Anotacao.DisposeOf;
  NotaFiscal.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerFurnitureOS.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerFurnitureOS.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerFurnitureOS.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerFurnitureOS.getbySearch;
var
  Lc_Qry : TSTQuery;
begin

  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_FURNITURE_OS ',
                     'where ID IS NOT NULL '
      ));

      if Registro.Equipamento.Length > 0 then
        sql.add(' AND (EQUIPMENT =:EQUIPMENT) ');

      if Registro.Ambiente.Length > 0 then
        sql.add(' AND (ENVIRONMENT =:ENVIRONMENT) ');

      if Registro.Marca.Length > 0 then
        sql.add(' AND (BRAND =:BRAND) ');

      if Registro.Modelo.Length > 0 then
        sql.add(' AND (MODEL =:MODEL) ');

      //PASSAGEM DE PARAMETOS

      if Registro.Equipamento.Length > 0 then
        ParamByName('EQUIPMENT').AsString := Registro.Equipamento;

      if Registro.Ambiente.Length > 0 then
        ParamByName('ENVIRONMENT').AsString := Registro.Ambiente;

      if Registro.Marca.Length > 0 then
        ParamByName('BRAND').AsString := Registro.Marca;

      if Registro.Modelo.Length > 0 then
        ParamByName('MODEL').AsString := Registro.Modelo;

      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFurnitureOS.getById;
begin
  _getByKey(Registro);
end;

function TControllerFurnitureOS.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TFurnitureOS;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_FURNITURE_OS '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TFurnitureOS.Create;
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
