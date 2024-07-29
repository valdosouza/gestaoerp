unit reg_vehicle_model;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegVehicleModel = class(TBaseRegistry)
    Panel1: TPanel;
    L_Descricao: TLabel;
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegVehicleModel: TRegVehicleModel;

implementation

{$R *.dfm}

end.
