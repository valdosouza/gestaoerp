unit sea_group_menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaGroupMenu = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_grupo: TLabel;
    Lb_subgrupo: TLabel;
    E_BuscaGrupo: TEdit;
    E_BuscaSubGrupo: TEdit;
    ChBx_Grupo: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeaGroupMenu: TSeaGroupMenu;

implementation

{$R *.dfm}

end.
