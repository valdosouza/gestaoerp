unit reg_taxation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TRegTaxation = class(TBaseRegistry)
    pl_fundo: TPanel;
    L_Aq_ICMS: TLabel;
    L_Red_Base: TLabel;
    Label7: TLabel;
    Sb_Observacao: TSpeedButton;
    L_Red_Aliq: TLabel;
    Label9: TLabel;
    SB_Natureza: TSpeedButton;
    L_Situacao_Tributaria: TLabel;
    L_Modal_ICMS_ST: TLabel;
    L_Modal_ICMS: TLabel;
    L_Desoneracao: TLabel;
    L_Simples_Nacional: TLabel;
    Sb_Sit_Trib_ICMS: TSpeedButton;
    Sb_Sit_Trib_CSOSN: TSpeedButton;
    Sb_Modal_ICMS: TSpeedButton;
    Sb_Desoneracao: TSpeedButton;
    Sb_Modal_ICMS_St: TSpeedButton;
    L_Origem: TLabel;
    E_Aq_ICMS: TEdit;
    E_Red_Base: TEdit;
    DBLCB_Observacao: TComboBox;
    E_Red_Aliq: TEdit;
    DBLCB_Natureza: TComboBox;
    Pnl_Outros: TGroupBox;
    L_Transacao_Produto: TLabel;
    L_CodigoNCM: TLabel;
    Sb_Classificacao: TSpeedButton;
    dbcbx_sit_trb: TCheckBox;
    chbx_Consumidor: TCheckBox;
    chbx_micro: TCheckBox;
    chbx_diferido: TCheckBox;
    chbx_destaque: TCheckBox;
    CHBX_ST_ICMS: TCheckBox;
    Cb_Transacao_Produto: TComboBox;
    E_CodigoNCM: TEdit;
    Chbx_Sentido: TCheckBox;
    Dblcb_Situacao_tributaria: TComboBox;
    Dblcb_Modal_ICMS_ST: TComboBox;
    Dblcb_Modal_ICMS: TComboBox;
    Dblcb_Desoneracao: TComboBox;
    Dblcb_Simples_Nacional: TComboBox;
    Pg_Outros: TPageControl;
    tbs_ipi: TTabSheet;
    Panel2: TPanel;
    L_Aq_IPI: TLabel;
    L_Situacao_tributaria_IPI: TLabel;
    Sb_Sit_Trib_IPI: TSpeedButton;
    E_Aq_IPI: TEdit;
    Dblcb_Situacao_tributaria_IPI: TComboBox;
    tbs_pis: TTabSheet;
    Panel3: TPanel;
    L_Aq_PIS: TLabel;
    L_Situacao_tributaria_PIS: TLabel;
    Sb_Sit_Trib_PIS: TSpeedButton;
    E_Aq_Pis: TEdit;
    Dblcb_Situacao_tributaria_PIS: TComboBox;
    tbs_cofins: TTabSheet;
    Panel4: TPanel;
    L_Aq_Cofins: TLabel;
    L__Situacao_tributaria_CFS: TLabel;
    Sb_Sit_Trib_CFS: TSpeedButton;
    E_Aq_Cofins: TEdit;
    Dblcb_Situacao_tributaria_CFS: TComboBox;
    tbs_outros: TTabSheet;
    Panel5: TPanel;
    L_Aq_IRPJ: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Siscomex: TLabel;
    L_Aq_Tec: TLabel;
    L_Aq_ISS: TLabel;
    L_AQ_AFRMM: TLabel;
    E_Aq_IRPJ: TEdit;
    E_Aq_CSLL: TEdit;
    E_Aq_Siscomex: TEdit;
    E_Aq_Tec: TEdit;
    E_Aq_ISS: TEdit;
    E_AQ_AFRMM: TEdit;
    Cb_Origem: TComboBox;
    Chbx_Red_Base_ST: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegTaxation: TRegTaxation;

implementation

{$R *.dfm}

end.
