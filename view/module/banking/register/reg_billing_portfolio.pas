unit reg_billing_portfolio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegBillingPortfolio = class(TBaseRegistry)
    Pnl_fundos: TPanel;
    Label_1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    E_Numero: TEdit;
    DBLCB_Banco: TComboBox;
    E_Descricao: TEdit;
    Rg_Tp_Emissao: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegBillingPortfolio: TRegBillingPortfolio;

implementation

{$R *.dfm}

end.
