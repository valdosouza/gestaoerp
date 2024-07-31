unit reg_tax_mode_det_bc_icms_st;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TRegTaxModeDetBcIcmsSt = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Grupo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Grupo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegTaxModeDetBcIcmsSt: TRegTaxModeDetBcIcmsSt;

implementation

{$R *.dfm}

end.
