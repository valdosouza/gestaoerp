unit Un_Fm_ListaTecnicos;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,UN_Principal,env,
  IBX.IBCustomDataSet, STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls,
  IBX.IBQuery;

type
  TFm_ListaTecnicos = class(TFrame)
    Label19: TLabel;
    Sb_Medida: TSpeedButton;
    Dblcb_Lista: TDBLookupComboBox;
    Qr_Lista: TSTQuery;
    DS_Lista: TDataSource;
    procedure Sb_MedidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar;
  end;

implementation

{$R *.dfm}

uses UN_Sistema, Un_Colaborador, RN_Permissao, Un_Regra_Negocio, PrintPizzaria,
  Un_DM;

{ TFm_ListaTecnicos }

procedure TFm_ListaTecnicos.Listar;
Var
  Lc_Compartilha :boolean;
  Lc_SqlTxt : StriNg;
begin
  with  Qr_Lista do
  Begin
    if DM.IBT_Listas.InTransaction then DM.IBT_Listas.CommitRetaining;
    Lc_Compartilha := not (Fc_Tb_Geral('L','PES_G_COMPARTILHA','S') = 'S');
    Active:=false;
    SQL.Clear;
    Lc_SqlTxt := ' SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda,CLB_AQ_COM_SRV '+
                 ' FROM TB_COLABORADOR tb_colaborador '+
                 '     INNER JOIN TB_CARGO tb_cargo '+
                 '     ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG) '+
                 ' WHERE (CLB_DEMISSAO IS NULL) ';
    Lc_SqlTxt := Lc_SqlTxt + ' AND ( (CRG_DESCRICAO LIKE ''TECNIC%'') or (CRG_DESCRICAO LIKE ''TÉCNIC%'') ) ';
    if Lc_Compartilha then
      Lc_SqlTxt := Lc_SqlTxt + 'and clb_codmha = :clb_codmha ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY CLB_NOME ');

    if Lc_Compartilha then
      ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
    Active:=true;
    FetchAll;
  end;
end;

procedure TFm_ListaTecnicos.Sb_MedidaClick(Sender: TObject);
Var
  Lc_Form : TFr_Colaborador;
begin
  if Fc_VerificaPermissao('Fr_Colaborador','Cadastro do Colaborador','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TFr_Colaborador.Create(Self);
    Lc_Form.ShowModal;
    Listar;
    FreeAndNil(Lc_Form);
  End;
end;

end.
