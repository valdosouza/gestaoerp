unit un_fm_item_ifood_agendado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TFmItemIfoodAgendado = class(TFrame)
    E_Nome: TLabel;
    Bve_Panel: TBevel;
    pnl_visualizar: TPanel;
    Panel1: TPanel;
    btn_visualizar: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
