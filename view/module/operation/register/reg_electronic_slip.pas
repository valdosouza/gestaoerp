unit reg_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegElectronicSlip = class(TBaseRegistry)
    Pnl_fundos: TPanel;
    Lb_Carteira: TLabel;
    Sb_Carteira: TSpeedButton;
    Lb_Cedente_Convenio: TLabel;
    Lb_Varia_Carteira: TLabel;
    Lb_Modelo_Boleto: TLabel;
    Lb_Local_Pagamneto: TLabel;
    Lb_Inst_Pagamento_1: TLabel;
    Lb_Inst_Pagamento_2: TLabel;
    Lb_IntrucaoAdicional: TLabel;
    Lb_Remessa_Retorno: TLabel;
    Sb_Path_remessa: TSpeedButton;
    Lb_Tx_Multa: TLabel;
    Lb_Tx_Juros: TLabel;
    Lb_Protesto: TLabel;
    Lb_Vl_Tarifa: TLabel;
    Lb_Dias_Protesto: TLabel;
    Lb_Tx_Desconto: TLabel;
    Lb_Vl_Mora_Min: TLabel;
    Lb_LayoutRemessa: TLabel;
    Lb_CodTransmissao: TLabel;
    Lb_Posto_Benef: TLabel;
    Lb_Negativacao: TLabel;
    Lb_Dias_Negativacao: TLabel;
    Dblcb_Carteira: TComboBox;
    E_Cedente_Convenio: TEdit;
    E_Varia_Carteira: TEdit;
    Cb_Modelo_Boleto: TComboBox;
    E_Local_Pagamento: TEdit;
    E_Inst_Pagamento_1: TEdit;
    E_Inst_Pagamento_2: TEdit;
    E_Path_Remessa_Retorno: TEdit;
    E_Tx_Multa: TEdit;
    E_Tx_Juros: TEdit;
    Cb_Protesto: TComboBox;
    DBMemo1: TMemo;
    E_Tx_Mora: TEdit;
    E_VL_Tarifa: TEdit;
    E_Dias_Protesto: TEdit;
    RG_Aceite: TRadioGroup;
    E_Tx_Desconto: TEdit;
    E_VL_MORA_MIN: TEdit;
    Cb_LayoutRemessa: TComboBox;
    E_CodTransmissao: TEdit;
    E_POSTO_BENEF: TEdit;
    Cb_Negativacao: TComboBox;
    E_Dias_Negativacao: TEdit;
    Lb_Tx_Mora: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegElectronicSlip: TRegElectronicSlip;

implementation

{$R *.dfm}

end.
