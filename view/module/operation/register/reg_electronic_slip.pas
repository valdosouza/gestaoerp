unit reg_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegElectronicSlip = class(TBaseRegistry)
    Pnl_fundos: TPanel;
    Label1: TLabel;
    Sb_Carteira: TSpeedButton;
    Label2: TLabel;
    Label4: TLabel;
    Label31: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Sb_Path_remessa: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label_1: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    Label16: TLabel;
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
