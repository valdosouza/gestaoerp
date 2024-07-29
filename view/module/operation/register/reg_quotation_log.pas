unit reg_quotation_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons;

type
  TRegQuotationLog = class(TFr_Base)
    GroupBox1: TGroupBox;
    L_Orcamento: TLabel;
    L_BuscaFantasia: TLabel;
    RG_Situacao: TRadioGroup;
    E_Orcamento: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    ChBx_Bloqueados: TCheckBox;
    E_BuscaFantasia: TMaskEdit;
    DBG_Pesquisa: TDBGrid;
    Label12: TLabel;
    DBG_Itens: TDBGrid;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    SB_Sair: TSpeedButton;
    SB_Retonar: TSpeedButton;
    Sb_Desbloqueia: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegQuotationLog: TRegQuotationLog;

implementation

{$R *.dfm}

end.
