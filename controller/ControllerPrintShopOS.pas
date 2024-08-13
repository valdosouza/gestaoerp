unit ControllerPrintShopOS;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblPrintShopOS, Md5, STQuery, ControllerAnnotation,
      ControllerNotaFiscal, Vcl.StdCtrls;
Type
  TControllerPrintShopOS = Class(TControllerBase)
  private

  public
    Registro : TPrintShopOS;
    Anotacao : TControllerAnnotation;
    NotaFiscal : TControllerNotaFiscal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getByPedido:Boolean;
    function getAllByKey:boolean;
    procedure ComboMaterial(Combo:TComboBox);
    procedure ComboFabricante(Combo:TComboBox);
    procedure ComboFaca(Combo:TComboBox);

  End;

  implementation


procedure TControllerPrintShopOS.ComboFabricante(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct MANUFACTURER ',
                'from TB_PRINT_SHOP_OS ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('MANUFACTURER').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPrintShopOS.ComboFaca(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct KNIFE ',
                'from TB_PRINT_SHOP_OS ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('KNIFE').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPrintShopOS.ComboMaterial(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct MATERIAL ',
                'from TB_PRINT_SHOP_OS ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('MATERIAL').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

constructor TControllerPrintShopOS.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPrintShopOS.Create;
  Anotacao := TControllerAnnotation.Create(self);
  NotaFiscal := TControllerNotaFiscal.Create(self);
end;

function TControllerPrintShopOS.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPrintShopOS.Destroy;
begin
  NotaFiscal.DisposeOf;
  Anotacao.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPrintShopOS.insert: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ID');
    if Registro.Numero = '' then
      Registro.Numero := Registro.Codigo.ToString();
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerPrintShopOS.save: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'ID',Registro.Estabelecimento);
    if Registro.Numero = '' then
      Registro.Numero := Registro.Codigo.ToString();
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerPrintShopOS.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerPrintShopOS.getByKey: Boolean;
begin
  Try
    Self._getByKey(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPrintShopOS.getByPedido: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select * ',
                'from TB_PRINT_SHOP_OS ',
                'where TB_ORDER_ID =:TB_ORDER_ID ',
                '  AND(TB_INSTITUTION_ID =:TB_INSTITUTION_ID) '
      ));
      ParambyNAme('TB_ORDER_ID').AsInteger := Registro.Ordem;
      ParambyNAme('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.

