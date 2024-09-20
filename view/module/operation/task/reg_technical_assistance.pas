unit reg_technical_assistance;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TRegTechnicalAssistance = class(TBaseRegistry)
    Pnl_Abertura: TPanel;
    L_Prazo: TLabel;
    SB_Cliente: TSpeedButton;
    L_Numero: TLabel;
    Lb_Numero: TLabel;
    L_Pedido: TLabel;
    L_Codcli: TLabel;
    Sb_Pesq_Cliente: TSpeedButton;
    E_Prazo: TDateTimePicker;
    E_Pedido: TEdit;
    chbx_Fantasia: TCheckBox;
    chbx_Nome: TCheckBox;
    DBLCB_Empresa: TComboBox;
    E_Codcli: TEdit;
    GroupBox1: TGroupBox;
    DBG_Produtos: TDBGrid;
    GroupBox2: TGroupBox;
    L_Etapa: TLabel;
    L_Dt_Registro: TLabel;
    L_Dt_Prevista: TLabel;
    L_Vl_Custo: TLabel;
    L_Vl_Cliente: TLabel;
    L_Situacao: TLabel;
    L_Dt_Realizada: TLabel;
    L_Descritivo: TLabel;
    spb_situacao: TSpeedButton;
    L_Hr_Prevista: TLabel;
    E_Etapa: TEdit;
    E_Dt_Registro: TDateTimePicker;
    E_Descritivo: TMemo;
    E_Vl_Custo: TEdit;
    E_Vl_Cliente: TEdit;
    DBLCB_Situacao: TComboBox;
    E_Dt_Realizada: TMaskEdit;
    E_Dt_Prevista: TDateTimePicker;
    E_Hr_Prevista: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegTechnicalAssistance: TRegTechnicalAssistance;

implementation

{$R *.dfm}

end.
