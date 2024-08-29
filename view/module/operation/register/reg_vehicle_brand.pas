unit reg_vehicle_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.Grids,
  Vcl.DBGrids, ControllerVehicleBrand, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, ControllerVehicleModel;

type
  TRegVehicleBrand = class(TBaseRegistry)
    Panel1: TPanel;
    L_Descricao: TLabel;
    L_Fornecedor: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    DBLCB_Fornecedor: TComboBox;
    Panel2: TPanel;
    Sb_Modelos: TSpeedButton;
    grdModelos: TDBGrid;
    ds_Modelos: TDataSource;
    cds_Modelos: TFDMemTable;
    cds_ModelosMOD_DESCRICAO: TStringField;
    cds_ModelosCodigo: TIntegerField;
    cds_ModelosCodigoMarca: TIntegerField;
    procedure Sb_ModelosClick(Sender: TObject);
  private
    VehicleBrand : TControllerVehicleBrand;
    VehicleModel : TControllerVehicleModel;
    procedure carregarModelos(MOD_CODMRC: integer);
    procedure MontarComboBoxFornecedor;
  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  end;

var
  RegVehicleBrand: TRegVehicleBrand;

implementation

uses reg_vehicle_model, UN_MSG;

{$R *.dfm}

procedure TRegVehicleBrand.carregarModelos(MOD_CODMRC: integer);
var
  i: Integer;
begin
  VehicleModel.Clear;

  VehicleModel.Parametros.FieldName.CodigoMarca := MOD_CODMRC;

  VehicleModel.Search;

  if not cds_Modelos.Active then
    cds_Modelos.CreateDataSet;

  cds_Modelos.EmptyDataSet;

  cds_Modelos.DisableControls;

  for i := 0 to Pred(VehicleModel.Lista.Count) do
    cds_Modelos.AppendRecord([VehicleModel.lista[I].Codigo, VehicleModel.lista[I].CodigoMarca, VehicleModel.Lista[i].Descricao]);

  cds_Modelos.EnableControls;
end;

procedure TRegVehicleBrand.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleBrand.ClearAllFields;
begin
  inherited;
  VehicleBrand.clear;
end;

procedure TRegVehicleBrand.CriarVariaveis;
begin
  inherited;
  VehicleBrand := TControllerVehicleBrand.create(self);
  VehicleModel := TControllerVehicleModel.create(self);
end;

procedure TRegVehicleBrand.Delete;
begin
  VehicleBrand.delete;
  inherited;
end;

procedure TRegVehicleBrand.FinalizaVariaveis;
begin
  inherited;
  VehicleBrand.DisposeOf;
  VehicleModel.DisposeOf;
end;

procedure TRegVehicleBrand.IniciaVariaveis;
begin
  MontarComboBoxFornecedor;
  if Self.CodigoRegistro > 0 then
  Begin
    carregarModelos(Self.CodigoRegistro);
    VehicleBrand.Registro.Codigo := Self.CodigoRegistro;
    VehicleBrand.getbyId;
  End;
  inherited;
end;

procedure TRegVehicleBrand.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleBrand.Save;
begin
  with VehicleBrand do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Fabricante := Fornecedor.getCodigoLista(DBLCB_Fornecedor.Text); //MRC_CODFAB
    salva;
  End;
  CodigoRegistro := VehicleBrand.Registro.Codigo;
  inherited;
end;

procedure TRegVehicleBrand.ShowData;
var Lc_Aux: string;
begin
  with VehicleBrand do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    Lc_Aux := Fornecedor.getDescLista(Registro.Fabricante);
    DBLCB_Fornecedor.ItemIndex := DBLCB_Fornecedor.Items.IndexOf(Lc_Aux);
  End;
  inherited;
end;

procedure TRegVehicleBrand.Sb_ModelosClick(Sender: TObject);
var
  Lc_form : TRegVehicleModel;
begin
  if cds_Modelos.IsEmpty then
    exit;

  Lc_form := TRegVehicleModel.Create(self);
  Try
    Lc_form.CodigoRegistro := cds_Modelos.FieldByName('Codigo').AsInteger;
    Lc_form.CodigoMarca := cds_Modelos.FieldByName('CodigoMarca').AsInteger;
    Lc_form.ShowModal;
    //recarregar
    IniciaVariaveis;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TRegVehicleBrand.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegVehicleBrand.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegVehicleBrand.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

procedure TRegVehicleBrand.MontarComboBoxFornecedor;
var
  i : Integer;
begin
  with vehiclebrand do
  Begin
    fornecedor.search;
    DBLCB_Fornecedor.Items.Clear;
    for i := 0 to Pred(fornecedor.lista.Count) do
      DBLCB_Fornecedor.Items.Add(fornecedor.lista[I].Descricao);
  End;
end;

end.

