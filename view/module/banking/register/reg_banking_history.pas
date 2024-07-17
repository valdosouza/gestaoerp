unit reg_banking_history;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegBankingHistory = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    PNL_BOTOES: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Sb_Pesquisar: TSpeedButton;
    SpeedButton6: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegBankingHistory: TRegBankingHistory;

implementation

{$R *.dfm}

end.
