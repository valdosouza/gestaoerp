unit un_fm_item_ifood_agora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Menus;

type
  TFmItemIfoodAgora = class(TFrame)
    E_Nome: TLabel;
    E_Numero: TLabel;
    e_Situacao: TLabel;
    Lb_Pedido: TLabel;
    Bve_Panel: TBevel;
    pnl_visualizar: TPanel;
    btn_visualizar: TSpeedButton;
    Panel1: TPanel;
    E_OrderType: TLabel;
    ItemMenu: TPopupMenu;
    AtualizarStatus: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

implementation

{$R *.dfm}

end.
