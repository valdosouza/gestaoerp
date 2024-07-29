unit reg_vehicle_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TRegVehicleBrand = class(TBaseRegistry)
    Panel1: TPanel;
    L_Descricao: TLabel;
    L_Fornecedor: TLabel;
    Sb_Fornecedor: TSpeedButton;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    DBLCB_Fornecedor: TComboBox;
    Panel2: TPanel;
    Sb_Modelos: TSpeedButton;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegVehicleBrand: TRegVehicleBrand;

implementation

{$R *.dfm}

end.
