unit reg_service;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, QEdit_Setes;

type
  TRegService = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_DescricaoServico: TLabel;
    L_PrecoCusto: TLabel;
    L_Grupo: TLabel;
    L_SubGrupo: TLabel;
    SB_Grupos: TSpeedButton;
    L_Aq_Margem: TLabel;
    L_Medida: TLabel;
    L_Vl_Venda: TLabel;
    Sb_Medida: TSpeedButton;
    L_Aq_Comissao: TLabel;
    E_DescricaoServico: TEdit;
    E_PrecoCusto: TEdit;
    E_Codigo: TEdit;
    DBLCB_Grupo: TComboBox;
    DBLCB_SubGrupo: TComboBox;
    E_Aq_Margem: TEdit_Setes;
    E_Vl_Venda: TEdit_Setes;
    DBLCB_Medida: TComboBox;
    e_aq_comissao: TEdit_Setes;
    ChBx_ativo: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ME_Observ: TMemo;
    tbs_Internet: TTabSheet;
    Panel2: TPanel;
    L_Cadastro: TLabel;
    Sb_Category: TSpeedButton;
    Trw_Cadastro: TTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegService: TRegService;

implementation

{$R *.dfm}

end.
