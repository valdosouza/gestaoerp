unit reg_banking_account;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Menus, Vcl.Buttons;

type
  TRegBankingAccount = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Codigo: TLabel;
    Lb_DtAbert: TLabel;
    Lb_Banco: TLabel;
    Lb_Agencia: TLabel;
    Lb_Conta: TLabel;
    Lb_Fone: TLabel;
    Lb_Fax: TLabel;
    Lb_Gerente: TLabel;
    Lb_Limite: TLabel;
    Lb_DataVencto: TLabel;
    Lb_Empresa: TLabel;
    Lb_DV: TLabel;
    Lb_DV_2: TLabel;
    E_Codigo: TEdit;
    E_DtAbert: TEdit;
    E_agencia: TEdit;
    E_conta: TEdit;
    E_fone: TEdit;
    E_Fax: TEdit;
    E_Gerente: TEdit;
    E_Limite: TEdit;
    E_DtVencto: TEdit;
    DBLCB_Banco: TComboBox;
    DBLCB_Empresa: TComboBox;
    DBEdit1: TEdit;
    DBEdit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegBankingAccount: TRegBankingAccount;

implementation

{$R *.dfm}

end.
