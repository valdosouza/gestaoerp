unit reg_collaborator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TRegCollaborator = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Nome: TLabel;
    Lb_Endereco: TLabel;
    Lb_Bairro: TLabel;
    Lb_Cep: TLabel;
    Lb_Fone: TLabel;
    Lb_Email: TLabel;
    Lb_Codigo: TLabel;
    Lb_Celular: TLabel;
    Lb_Adimissao: TLabel;
    Lb_Demissao: TLabel;
    Lb_Sexo: TLabel;
    Lb_Cargo: TLabel;
    SB_Cargo: TSpeedButton;
    Sb_Cep: TSpeedButton;
    Lb_UF: TLabel;
    Lb_Cidade: TLabel;
    Sb_Endereco: TSpeedButton;
    E_Celular: TMaskEdit;
    E_Nome: TEdit;
    E_Endereco: TEdit;
    E_Bairro: TEdit;
    E_Cep: TEdit;
    E_Fone: TMaskEdit;
    E_Email: TEdit;
    E_Codigo: TEdit;
    E_Demissao: TEdit;
    DBCB_Sexo: TComboBox;
    DBLCB_Cargo: TComboBox;
    DBLCB_UF: TComboBox;
    DBLCB_Cidade: TComboBox;
    e_ADMISSAO: TDateTimePicker;
    PG_Informacoes: TPageControl;
    TabSheet3: TTabSheet;
    ME_Observ: TMemo;
    TBS_documentos: TTabSheet;
    pnl_documentos: TPanel;
    Lb_Secao: TLabel;
    Lb_DataNasc: TLabel;
    Lb_Identidade: TLabel;
    Lb_Pis: TLabel;
    Lb_Tit_Eleit: TLabel;
    Lb_Zona: TLabel;
    Lb_Pai: TLabel;
    Lb_Mae: TLabel;
    Lb_Salario: TLabel;
    Lb_Militar: TLabel;
    E_Secao: TEdit;
    E_Identidade: TEdit;
    E_Pis: TEdit;
    E_Tit_Eleit: TEdit;
    E_Zona: TEdit;
    E_Pai: TEdit;
    E_Mae: TEdit;
    E_DataNasc: TDateTimePicker;
    E_Salario: TEdit;
    dbcert_militar: TEdit;
    Chbx_CPF: TCheckBox;
    chbx_CNPJ: TCheckBox;
    E_Cpf_CNPJ: TMaskEdit;
    TabSheet5: TTabSheet;
    Pnl_Com_Vda: TPanel;
    Lb_AQ_COm: TLabel;
    E_AQ_COm: TEdit;
    dbbx_comissaoProd: TCheckBox;
    Rg_FmaCalcComVda: TRadioGroup;
    Pnl_Com_Srv: TPanel;
    Lb_Vl_AQ_SRV: TLabel;
    dbbx_comissaoSrv: TCheckBox;
    e_VL_AQ_SRV: TEdit;
    Rg_FmaCalcComSrv: TRadioGroup;
    tbs_Outras: TTabSheet;
    Pnl_Outra_Inf: TPanel;
    Lb_Usuario: TLabel;
    DBLCB_Usuario: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegCollaborator: TRegCollaborator;

implementation

{$R *.dfm}

end.
