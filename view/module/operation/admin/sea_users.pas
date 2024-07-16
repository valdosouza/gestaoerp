unit sea_users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaUsers = class(TBaseSearch)
    GroupBox1: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    E_BuscaCodigo: TEdit;
    E_BuscaNome: TEdit;
    Label22: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Sb_Sair_1: TSpeedButton;
    DBGrid1: TDBGrid;
    ChBx_Inativos: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaUsers: TSeaUsers;

implementation

{$R *.dfm}

end.
