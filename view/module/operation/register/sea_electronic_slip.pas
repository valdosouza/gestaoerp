unit sea_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaElectronicSlip = class(TBaseSearch)
    Grp_Parametros: TGroupBox;
    Lb_BuscaBanco: TLabel;
    E_BuscaBanco: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaElectronicSlip: TSeaElectronicSlip;

implementation

{$R *.dfm}

end.
