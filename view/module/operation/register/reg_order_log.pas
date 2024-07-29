unit reg_order_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons;

type
  TRegOrderLog = class(TFr_Base)
    GroupBox1: TGroupBox;
    L_Pedido: TLabel;
    L_BuscaFantasia: TLabel;
    L_BuscaRazao: TLabel;
    RG_Situacao: TRadioGroup;
    E_Pedido: TMaskEdit;
    Rg_Tipo: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    ChBx_Bloqueados: TCheckBox;
    E_BuscaRazao: TMaskEdit;
    E_BuscaFantasia: TMaskEdit;
    DBG_Pesquisa: TDBGrid;
    Label12: TLabel;
    DBG_Itens: TDBGrid;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    SB_Sair: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Retonar: TSpeedButton;
    sb_autorizaPedido: TSpeedButton;
    Sb_Desbloqueia: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegOrderLog: TRegOrderLog;

implementation

{$R *.dfm}

end.
