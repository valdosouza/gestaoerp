unit sea_vehicle_kind;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerVehicleKind;

type
  TSeaVehicleKind = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchDescricao: TStringField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    vehicleKind : TControllerVehicleKind;
  end;

var
  SeaVehicleKind: TSeaVehicleKind;

implementation

uses reg_vehicle_kind;

{$R *.dfm}

procedure TSeaVehicleKind.CriarVariaveis;
begin
  inherited;
  vehicleKind := TControllerVehicleKind.create(self);
end;

procedure TSeaVehicleKind.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(vehicleKind);
end;

procedure TSeaVehicleKind.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaVehicleKind.openRegister(pCodigo: Integer);
var
  Lc_form : TRegVehicleKind;
begin
  Lc_form := TRegVehicleKind.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaVehicleKind.Search;
var
  i: Integer;
begin
  vehicleKind.Clear;

  vehicleKind.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  vehicleKind.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  vehicleKind.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(vehicleKind.Lista.Count) do
    cds_search.AppendRecord([vehicleKind.Lista[i].Codigo, vehicleKind.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaVehicleKind.SetRegister;
begin
  openRegister(0);
end;

end.
