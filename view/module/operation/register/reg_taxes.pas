unit reg_taxes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, QEdit_Setes;

type
  TRegTaxes = class(TBaseRegistry)
    Panel2: TPanel;
    L_Aq_Pis: TLabel;
    L_Aq_Cofins: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Irpj: TLabel;
    L_Aq_Icms: TLabel;
    E_Aq_Pis: TEdit_Setes;
    E_Aq_Cofins: TEdit_Setes;
    E_Aq_CSLL: TEdit_Setes;
    E_Aq_Irpj: TEdit_Setes;
    E_Aq_Icms: TEdit_Setes;
    Panel1: TPanel;
    Btn_Ok: TButton;
    Btn_Cancelar: TButton;
    Btn_Aplicar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegTaxes: TRegTaxes;

implementation

{$R *.dfm}

end.
