unit ControllerElectEquip;

interface

uses STDatabase,Classes, STQuery, Vcl.StdCtrls,  SysUtils,ControllerBase,
      tblElectEquip ,Un_MSg,Generics.Collections;

Type
  TListaElecEquip = TObjectList<TElectEquip>;

  TControllerElectEquip = Class(TControllerBase)

  private

  public
    Registro : TElectEquip;
    Lista : TListaElecEquip;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbySearch;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure ComboDevice(Combo:TComboBox);
    procedure ComboBrand(Combo:TComboBox);
    procedure ComboModel(Combo:TComboBox);
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerElectEquip.ComboBrand(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct ee.brand ',
                'from tb_elect_equip ee ',
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

procedure TControllerElectEquip.ComboDevice(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct ee.device ',
                'from tb_elect_equip ee ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('device').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerElectEquip.ComboModel(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct ee.model ',
                'from tb_elect_equip ee ',
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

constructor TControllerElectEquip.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TElectEquip.Create;
  Lista := TListaElecEquip.Create;
end;

function TControllerElectEquip.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerElectEquip.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerElectEquip.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ELECT_EQUIP');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerElectEquip.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ELECT_EQUIP');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerElectEquip.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerElectEquip.getbySearch;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_ELECT_EQUIP ',
                     'where ID IS NOT NULL '
      ));
      //INCREMENTAR SQL
      if Registro.Customer > 0 then
        sql.add(' AND (TB_CUSTOMER_ID =:TB_CUSTOMER_ID) ');

      if Registro.Dispositivo.Length > 0 then
        sql.add(' AND (DEVICE =:DEVICE) ');

      if Registro.Marca.Length > 0 then
        sql.add(' AND (BRAND =:BRAND) ');

      if Registro.Modelo.Length > 0 then
        sql.add(' AND (MODEL =:MODEL) ');

      if Registro.Serie.Length > 0 then
        sql.add(' AND (SERIE =:SERIE) ');

      if Registro.Imei.Length > 0 then
        sql.add(' AND (IMEI =:IMEI)');

      //PASSAGEM DE PARAMETOS
      if Registro.Customer > 0 then
        ParamByName('TB_CUSTOMER_ID').AsInteger := Registro.Customer;

      if Registro.Dispositivo.Length > 0 then
        ParamByName('DEVICE').AsString := Registro.Dispositivo;

      if Registro.Marca.Length > 0 then
        ParamByName('BRAND').AsString := Registro.Marca;

      if Registro.Modelo.Length > 0 then
        ParamByName('MODEL').AsString := Registro.Modelo;

      if Registro.Serie.Length > 0 then
        ParamByName('SERIE').AsString := Registro.Serie;

      if Registro.Imei.Length > 0 then
        ParamByName('IMEI').AsString := Registro.Imei;
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

procedure TControllerElectEquip.getById;
begin
  _getByKey(Registro);
end;

function TControllerElectEquip.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TElectEquip;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ELECT_EQUIP '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TElectEquip.Create;
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
