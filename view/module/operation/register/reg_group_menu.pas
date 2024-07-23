unit reg_group_menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TRegGroupMenu = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Descricao: TLabel;
    Lb_Desconto: TLabel;
    Lb_Sequencia: TLabel;
    E_Descricao: TEdit;
    E_Vl_Desconto: TEdit;
    DBRG_Tamanhos: TRadioGroup;
    DBRG_Interface: TRadioGroup;
    DBRG_Composicao: TRadioGroup;
    ChBx_Propag_Tamanho: TCheckBox;
    ChBx_Agrupar_Abas: TCheckBox;
    E_Sequencia: TEdit;
    ChBx_Ativo: TCheckBox;
    ChBx_show_descktop: TCheckBox;
    Chbx_Ifood: TCheckBox;
    Panel1: TPanel;
    Sb_SubGrupos: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegGroupMenu: TRegGroupMenu;

implementation

{$R *.dfm}

end.
