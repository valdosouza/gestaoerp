unit sea_vehicle_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaVehicleBrand = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaMarca: TLabel;
    L_BuscaModelo: TLabel;
    E_BuscaMarca: TEdit;
    E_BuscaModelo: TEdit;
    ChBx_Marca: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaVehicleBrand: TSeaVehicleBrand;

implementation

{$R *.dfm}

end.
