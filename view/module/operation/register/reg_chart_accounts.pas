unit reg_chart_accounts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.ComCtrls;

type
  TRegChartAccounts = class(TBaseRegistry)
    Pnl_Dados: TPanel;
    L_Codplc: TLabel;
    L_Descricao: TLabel;
    E_Codplc: TEdit;
    E_Descricao: TEdit;
    DBRadioGroup1: TRadioGroup;
    DBRadioGroup2: TRadioGroup;
    DBRadioGroup3: TRadioGroup;
    Panel3: TPanel;
    Trw_PlanoContas: TTreeView;
    Sb_configura: TSpeedButton;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Sb_Buscar: TSpeedButton;
    Sb_Filtrar: TSpeedButton;
    E_BuscaDescricao: TMaskEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegChartAccounts: TRegChartAccounts;

implementation

{$R *.dfm}

end.
