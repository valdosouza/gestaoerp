unit reg_electronic_card;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TRegElectronicCard = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    E_Codigo: TEdit;
    grbx_vista: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    E_Aliq_Cred: TEdit;
    E_Prz_Cred: TEdit;
    grbx_parcela: TGroupBox;
    Label9: TLabel;
    Label5: TLabel;
    E_Aliq_Debi: TEdit;
    E_Prz_DEbi: TEdit;
    E_Contato: TEdit;
    E_Fone: TEdit;
    E_Validade: TEdit;
    dbrg_tipo: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegElectronicCard: TRegElectronicCard;

implementation

{$R *.dfm}

end.
