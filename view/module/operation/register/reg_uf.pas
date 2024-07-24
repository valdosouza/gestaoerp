unit reg_uf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls;

type
  TRegUf = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    Lb_Sigla: TLabel;
    Lb_Sub_Tributario: TLabel;
    Lb_Aliq_Interna: TLabel;
    Lb_Aliq_Interstadual: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Sigla: TEdit;
    E_Sub_tributario: TEdit;
    E_Aliq_Interna: TEdit;
    E_Aliq_Interestadual: TEdit;
    Pg_Itens: TPageControl;
    tbs_st: TTabSheet;
    Pnl_ST: TPanel;
    Sb_Ins_Ncm: TSpeedButton;
    Sb_Exc_Ncm: TSpeedButton;
    Sb_Grv_Ncm: TSpeedButton;
    tbs_FCP: TTabSheet;
    Pnl_FCP: TPanel;
    Sb_Ins_Fcp: TSpeedButton;
    Sb_Exc_Fcp: TSpeedButton;
    Sb_Grv_Fcp: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegUf: TRegUf;

implementation

{$R *.dfm}

end.
