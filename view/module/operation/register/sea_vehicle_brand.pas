unit sea_vehicle_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerVehicleBrand;

type
  TSeaVehicleBrand = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaMarca: TLabel;
    L_BuscaModelo: TLabel;
    E_BuscaMarca: TEdit;
    E_BuscaModelo: TEdit;
    ChBx_Marca: TCheckBox;
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    cds_searchmodelodescricao: TStringField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    vehicleBrand : TControllerVehicleBrand;
  end;
var
  SeaVehicleBrand: TSeaVehicleBrand;

implementation

uses reg_vehicle_brand;

{$R *.dfm}

{ TSeaVehicleBrand }

procedure TSeaVehicleBrand.CriarVariaveis;
begin
  inherited;
  vehicleBrand := TControllerVehicleBrand.create(self);
end;

procedure TSeaVehicleBrand.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(vehicleBrand);
end;

procedure TSeaVehicleBrand.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaVehicleBrand.openRegister(pCodigo: Integer);
var
  Lc_form : TRegVehicleBrand;
begin
  Lc_form := TRegVehicleBrand.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaVehicleBrand.Search;
var
  i: Integer;
begin
  vehicleBrand.Clear;

  vehicleBrand.Parametros.FieldName.Descricao := E_BuscaMarca.Text;
  vehicleBrand.Parametros.FieldName.ModeloDescricao := E_BuscaModelo.Text;
  vehicleBrand.Parametros.FieldName.MarcasVazio := ChBx_Marca.Checked;

  vehicleBrand.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(vehicleBrand.Lista.Count) do
    cds_search.AppendRecord([vehicleBrand.Lista[i].Codigo, vehicleBrand.Lista[i].Descricao, vehicleBrand.Lista[i].ModeloDescricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaVehicleBrand.SetRegister;
begin
  openRegister(0);
end;

end.
