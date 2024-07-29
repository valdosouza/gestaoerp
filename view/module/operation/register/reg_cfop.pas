unit reg_cfop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegCfop = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Desc_Abreviada: TLabel;
    L_Descricao: TLabel;
    L_CFOP: TLabel;
    L_Registro: TLabel;
    L_Codigo: TLabel;
    L_Aplicacao: TLabel;
    E_Codigo: TEdit;
    E_Desc_Abreviada: TEdit;
    E_Descricao: TEdit;
    E_CFOP: TEdit;
    Rgp_Sentido: TRadioGroup;
    Rgp_Interno: TRadioGroup;
    E_Registro: TEdit;
    Rgp_Ativo: TRadioGroup;
    DBMemo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegCfop: TRegCfop;

implementation

{$R *.dfm}

end.
