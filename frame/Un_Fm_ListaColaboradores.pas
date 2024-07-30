unit Un_Fm_ListaColaboradores;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,STTransaction,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Data.DB, IBX.IBCustomDataSet, STQuery, Un_DM, STDatabase,
  IBX.IBDatabase, IBX.IBQuery;

type
  TFm_ListaColaboradores = class(TFrame)
    Label19: TLabel;
    Sb_Cadastro: TSpeedButton;
    Dblcb_Vendedor: TDBLookupComboBox;
    Qr_ListaVendedor: TSTQuery;
    DS_ListaVendedor: TDataSource;
    IBT_Lista: TSTTransaction;
    procedure Sb_CadastroClick(Sender: TObject);
    procedure Dblcb_VendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Tipo : String;
  public
    { Public declarations }

    procedure ListaVendedor;
    procedure ListaColaborador;
  end;

implementation

{$R *.dfm}

uses Un_Colaborador, RN_Permissao, Un_Regra_Negocio, UN_Sistema, UN_Principal,
  env;

procedure TFm_ListaColaboradores.Dblcb_VendedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Vendedor.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaColaboradores.ListaColaborador;
Var
  Lc_Compartilha: Boolean;
  Lc_SqlTxt: StriNg;
begin
  Tipo := 'Colaborador';
  Lc_Compartilha := not(Fc_Tb_Geral('L', 'PES_G_COMPARTILHA', 'S') = 'S');
  IF not IBT_Lista.InTransaction THEN IBT_Lista.StartTransaction;
  IF IBT_Lista.InTransaction THEN IBT_Lista.Commit;
  with Qr_ListaVendedor do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := concat(
                  ' SELECT CLB_CODIGO, CLB_NOME, ',
                  ' CLB_AQ_COM_vda,CLB_AQ_COM_SRV ' ,
                  ' FROM TB_COLABORADOR ',
                  ' WHERE (CLB_DEMISSAO IS NULL) '
    );
    if Lc_Compartilha then
      Lc_SqlTxt := Lc_SqlTxt + 'and clb_codmha = :clb_codmha ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY CLB_NOME ');

    if Lc_Compartilha then
      ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
    Active := true;
    FetchAll;
  end;
end;

procedure TFm_ListaColaboradores.ListaVendedor;
Var
  Lc_Inst_Vend: Boolean;
  Lc_Pizzaria : Boolean;
  Lc_Compartilha: Boolean;
  Lc_SqlTxt: StriNg;
begin
  Tipo := 'Vendedor';
  Lc_Inst_Vend := (Fc_Aq_Geral('L', 'ORDEM DE SERVICO', 'OSR_P_INSTALA_VENDE','N') = 'S');
  Lc_Pizzaria := Fc_VerificaFormularioDisponivel('Fr_Pizzaria');
  Lc_Compartilha := not(Fc_Tb_Geral('L', 'PES_G_COMPARTILHA', 'S') = 'S');
  IF not DM.IBT_Listas.InTransaction THEN DM.IBT_Listas.StartTransaction;
  IF DM.IBT_Listas.InTransaction THEN DM.IBT_Listas.Commit;
  with Qr_ListaVendedor do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt :=
      ' SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda,CLB_AQ_COM_SRV '
      +
      ' FROM TB_COLABORADOR tb_colaborador '
      +
      '     INNER JOIN TB_CARGO tb_cargo ' + '     ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG) ' + ' WHERE (CLB_DEMISSAO IS NULL) ';
    if Lc_Inst_Vend then
      Lc_SqlTxt := Lc_SqlTxt +
        ' AND ( (CRG_DESCRICAO LIKE ''VENDEDOR%'') or (CRG_DESCRICAO LIKE ''INSTALADOR%'') ) '
    else
    if Lc_Pizzaria then
      Lc_SqlTxt := Lc_SqlTxt +
        ' AND ( (CRG_DESCRICAO LIKE ''VENDEDOR%'') or (CRG_DESCRICAO LIKE ''%BOY%'') ) '
    else
      Lc_SqlTxt := Lc_SqlTxt + 'AND  (CRG_DESCRICAO LIKE ''VENDEDOR%'') ';

    if Lc_Compartilha then
      Lc_SqlTxt := Lc_SqlTxt + 'and clb_codmha = :clb_codmha ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY CLB_NOME ');

    if Lc_Compartilha then
      ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
    Active := true;
    FetchAll;
  end;
end;

procedure TFm_ListaColaboradores.Sb_CadastroClick(Sender: TObject);
Var
  Lc_Form : TFr_Colaborador;
begin
  if Fc_VerificaPermissao('Fr_Colaborador','Cadastro do Colaborador','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TFr_Colaborador.Create(nil);
    Lc_Form.ShowModal;
    if Tipo = 'Vendedor' then
      ListaVendedor
    else
      ListaColaborador;
    Lc_Form.DisposeOf
  End;

end;

end.
