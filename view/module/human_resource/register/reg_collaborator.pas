unit reg_collaborator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, base_registry, ControllerColaborador, System.StrUtils;

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
    DBCB_Sexo: TComboBox;
    DBLCB_Cargo: TComboBox;
    DBLCB_Cidade: TComboBox;
    e_ADMISSAO: TDateTimePicker;
    PG_Informacoes: TPageControl;
    tsObservacao: TTabSheet;
    ME_Observ: TMemo;
    tsdocumentos: TTabSheet;
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
    e_militar: TEdit;
    Chbx_CPF: TCheckBox;
    chbx_CNPJ: TCheckBox;
    E_Cpf_CNPJ: TMaskEdit;
    tsComissao: TTabSheet;
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
    tsOutras: TTabSheet;
    Pnl_Outra_Inf: TPanel;
    Lb_Usuario: TLabel;
    DBLCB_Usuario: TComboBox;
    CB_UF: TComboBox;
    E_DEMISSAO: TEdit;
    procedure Sb_CepClick(Sender: TObject);
    procedure Sb_EnderecoClick(Sender: TObject);
    procedure SB_CargoClick(Sender: TObject);
  private
    procedure MontarComboBoxCargo;
    procedure MontarComboBoxCidade;
    procedure MontarComboBoxUsuario;
  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
    colaborador : TControllerColaborador;
  end;

var
  RegCollaborator: TRegCollaborator;

implementation

uses UN_MSG, env, sea_job_position, methods;

{$R *.dfm}

procedure TRegCollaborator.Change;
begin
  inherited;
  E_Nome.SetFocus;
end;

procedure TRegCollaborator.ClearAllFields;
begin
  inherited;
  colaborador.clear;
end;

procedure TRegCollaborator.CriarVariaveis;
begin
  inherited;
  colaborador := TControllerColaborador.create(self);
end;

procedure TRegCollaborator.Delete;
begin
  colaborador.delete;
  inherited;
end;

procedure TRegCollaborator.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(colaborador);
end;

procedure TRegCollaborator.IniciaVariaveis;
begin
  MontarComboBoxCidade;
  MontarComboBoxCargo;
  MontarComboBoxUsuario;
  if Self.CodigoRegistro > 0 then
  Begin
    colaborador.Registro.Codigo := Self.CodigoRegistro;
    colaborador.getbyId;
  End;
  inherited;
end;

procedure TRegCollaborator.Insert;
begin
  inherited;
  E_Nome.SetFocus;
end;

procedure TRegCollaborator.Save;
begin
  with colaborador do
  Begin
    Registro.Pais := 1058; // Tb_Colaborador.FieldByName('CLB_CODPAI').AsInteger  := 1058;
    Registro.Estabelecimento := Gb_CodMha;
    Registro.Nome := E_Nome.Text;
    Registro.Sexo := DBCB_Sexo.Text;
    Registro.Cep := E_Cep.Text;
    Registro.Endereco := E_Endereco.Text;
    Registro.Bairro := E_Bairro.Text;
    Registro.Estado := CB_UF.Text;
    registro.Cidade := DBLCB_Cidade.Text;
    registro.email := E_Email.Text;
    registro.Fone := E_Fone.Text;
    registro.Celular := E_Celular.Text;
    registro.Cargo := cargo.getCodigoLista(DBLCB_Cargo.Text);
    registro.Admissao := e_ADMISSAO.Date;
    if E_Demissao.Text <> EmptyStr then
      registro.Demissao := StrToDate(E_Demissao.Text);
    //observações
    registro.Observacao := ME_Observ.Text;
    //documentos
    registro.NAscimento := E_DataNasc.Date;
    registro.CPFCNPJ := E_Cpf_CNPJ.Text;
    registro.Identidade := E_Identidade.Text;
    registro.PIS := E_Pis.Text;
    registro.TituloEleitor := E_Tit_Eleit.Text;
    registro.TituloZona := E_Zona.Text;
    registro.SecaoZona := E_Secao.Text;
    registro.NomePai := E_Pai.Text;
    registro.NomeMae := E_Mae.Text;
    registro.CertificadoMilitar := e_militar.Text;
    registro.Salario := StrToFloatDef(E_Salario.Text, 0);
    //comissao
    registro.ComissaoAliqVenda := StrToFloatDef(E_AQ_COm.Text, 0);
    registro.ComissaoVenda := IfThen(dbbx_comissaoProd.Checked, SIGLA_S, SIGLA_N);
    if Rg_FmaCalcComVda.ItemIndex = 0 then
      registro.ComissaoPorProduto := 'C' //Calculo pela Aliquota do Cadastro
    else
      registro.ComissaoPorProduto := 'V'; //Calculo pela soma da Aliquota ao item de venda

    registro.ComissaoAliqServico := StrToFloatDef(e_VL_AQ_SRV.Text, 0);
    registro.ComissaoServico := IfThen(dbbx_comissaoSrv.Checked, SIGLA_S, SIGLA_N);
    if Rg_FmaCalcComSrv.ItemIndex = 0 then
      registro.ComissaoPorServico := 'C'  //Calculo pela Aliquota do Cadastro
    else
      registro.ComissaoPorServico := 'S'; //Calculo pela soma da Aliquota ao item de serviço

    //outras informações
    Registro.Usuario := usuario.getCodigoLista(DBLCB_usuario.Text);
    salva;
  End;
  inherited;
end;

procedure TRegCollaborator.SB_CargoClick(Sender: TObject);
begin
  inherited;
  TSetesForms.Show(TSeaJobPosition);
{
Var
  Lc_Form : TFr_Cargo;
begin
  Try
    Lc_Form := TFr_Cargo.Create(nil);
    Lc_Form.ShowModal;
  Finally
    DM.Qr_Cargo.Active:=false;
    DM.Qr_Cargo.Active:=True;
    Tb_Colaborador.FieldByName('CLB_CODCRG').AsInteger := TFr_Cargo(Lc_Form).It_Cd_Cadastro;
    DBLCB_Cargo.KeyValue := TFr_Cargo(Lc_Form).It_Cd_Cadastro;
    DBLCB_Cargo.SetFocus;
    Lc_Form.DisposeOf;
  End;

  ChamarTela(TSeaJobPosition);
}
end;

procedure TRegCollaborator.Sb_CepClick(Sender: TObject);
begin
  inherited;
  {if (E_cep.Text = '') then
    Begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Informe o Número do Cep.'+EOLN+EOLN,
                  ['OK'],[bEscape],mpInformacao);
    E_cep.SetFocus;
    end
  else
    Pc_BuscaCep(E_cep.Text);}
end;

procedure TRegCollaborator.Sb_EnderecoClick(Sender: TObject);
begin
  inherited;
{  if not Assigned(Fr_PesqEndereco) then Application.CreateForm(TFr_PesqEndereco, Fr_PesqEndereco);
  if Fr_PesqEndereco.showmodal = mrOk then
  begin
    with Fr_PesqEndereco do
    Begin
      if (StrGrd_Logradouro.RowCount > 1) and (StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row]<>'') then
      Begin
        E_Cep.Text := StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row];
        Tb_Colaborador.FieldByName('CLB_CEP').AsString := StrGrd_Logradouro.Cells[1,StrGrd_Logradouro.row];

        E_Endereco.Text := StrGrd_Logradouro.Cells[2,StrGrd_Logradouro.row];
        Tb_Colaborador.FieldByName('CLB_ENDER').AsString := E_Endereco.Text;

        E_Bairro.Text := StrGrd_Logradouro.Cells[3,StrGrd_Logradouro.row];
        Tb_Colaborador.FieldByName('CLB_BAIRRO').AsString := E_Bairro.Text;

        DBLCB_UF.KeyValue := Fc_BuscaCodigoEstado(StrGrd_Logradouro.Cells[5,StrGrd_Logradouro.row]);
        Tb_Colaborador.FieldByName('CLB_UF').AsString := DBLCB_UF.KeyValue;

        DBLCB_Cidade.KeyValue := Fc_BuscaCodigoCidade(0,StrGrd_Logradouro.Cells[4,StrGrd_Logradouro.row],StrGrd_Logradouro.Cells[5,StrGrd_Logradouro.row]);
        Tb_Colaborador.FieldByName('CLB_CIDADE').AsString := DBLCB_Cidade.KeyValue;

        if E_Endereco.CanFocus then E_Endereco.SetFocus;
      end;
    end;
  end;}
end;

procedure TRegCollaborator.ShowData;
Var
  Lc_Aux : String;
begin
  with colaborador do
  Begin
    E_Codigo.Text := Registro.Codigo.ToString;
    E_Nome.Text := Registro.Nome;
    DBCB_Sexo.ItemIndex := DBCB_Sexo.Items.IndexOf(Registro.Sexo);
    E_Cep.Text := Registro.Cep;
    E_Endereco.Text:= Registro.Endereco;
    E_Bairro.Text:= Registro.Bairro;
    CB_UF.ItemIndex := CB_UF.Items.IndexOf(Registro.Estado);
    DBLCB_Cidade.ItemIndex := DBLCB_Cidade.Items.IndexOf(Registro.Cidade);
    E_Email.Text := registro.email;
    E_Fone.Text := registro.Fone;
    E_Celular.Text := registro.Celular;
    Lc_Aux := cargo.getDescricaoLista(Registro.Cargo);
    DBLCB_Cargo.ItemIndex := DBLCB_Cargo.Items.IndexOf(Lc_Aux);
    e_ADMISSAO.Date := registro.Admissao;
    E_Demissao.Text := DateToStr(registro.Demissao);
    //observações
    ME_Observ.Text := registro.Observacao;
    //documentos
    E_DataNasc.Date := registro.NAscimento;
    E_Cpf_CNPJ.Text := registro.CPFCNPJ;
    E_Identidade.Text := registro.Identidade;
    E_Pis.Text := registro.PIS;
    E_Tit_Eleit.Text := registro.TituloEleitor;
    E_Zona.Text := registro.TituloZona;
    E_Secao.Text := registro.SecaoZona;
    E_Pai.Text := registro.NomePai;
    E_Mae.Text := registro.NomeMae;
    e_militar.Text := registro.CertificadoMilitar;
    E_Salario.Text := FloatToStrF(Registro.Salario, ffFixed, 10, 2);
    //comissao
    E_AQ_COm.Text := FloatToStrF(Registro.ComissaoAliqVenda, ffFixed, 10, 2);
    if registro.ComissaoVenda = SIGLA_S then
      dbbx_comissaoProd.Checked := True
    else
      dbbx_comissaoProd.Checked := False;
    if registro.ComissaoPorProduto = 'C' then
      Rg_FmaCalcComVda.ItemIndex := 0
    else
      Rg_FmaCalcComVda.ItemIndex := 1;

    e_VL_AQ_SRV.Text := FloatToStrF(Registro.ComissaoAliqServico, ffFixed, 10, 2);
    if registro.ComissaoServico = SIGLA_S then
      dbbx_comissaoSrv.Checked := True
    else
      dbbx_comissaoSrv.Checked := False;
    if registro.ComissaoPorServico = 'C' then
      Rg_FmaCalcComSrv.ItemIndex := 0
    else
      Rg_FmaCalcComSrv.ItemIndex := 1;

     //outras informações
     Lc_Aux := usuario.getNomeLista(Registro.Usuario);
     DBLCB_usuario.ItemIndex := DBLCB_usuario.Items.IndexOf(Lc_Aux);
    End;
  inherited;
end;

procedure TRegCollaborator.ShowNoData;
begin
  E_Codigo.clear;
  E_Nome.clear;
  PG_Informacoes.ActivePage := tsdocumentos;
end;

function TRegCollaborator.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegCollaborator.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Nome.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_Nome.Caption);
    Result := False;
    E_Nome.SetFocus;
    Exit;
  end;

  if (DBLCB_Cargo.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_Cargo.Caption);
    Result := False;
    DBLCB_Cargo.SetFocus;
    Exit;
  end;

  if (E_Cpf_CNPJ.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo('CPF/CNPJ');
    Result := False;
    PG_Informacoes.ActivePage := tsdocumentos;
    E_Cpf_CNPJ.SetFocus;
    Exit;
  end
  else
  Begin
    IF Length(E_Cpf_CNPJ.Text) = 11 then
    Begin
      {if not TestaCpf(E_Cpf_CNPJ.Text) then
      Begin
        MensagemPadrao(' Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'CPF do Colaborador Inválido.'+EOLN+
                       'Verifique o CPF do Colaborador.' + EOLN,
                       ['OK'],[bEscape],mpErro);
        Result := False;
        PG_Informacoes.ActivePage:= TBS_documentos;
        E_Cpf_CNPJ.SetFocus;
        exit;
      end;   }
    end
    else
    Begin
      {if not TestaCgc(E_Cpf_CNPJ.Text) then
      Begin
        MensagemPadrao(' Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'CNPJ do Colaborador Inválido.'+EOLN+
                       'Verifique o CNPJ do Colaborador.' + EOLN,
                       ['OK'],[bEscape],mpErro);
        Result := False;
        PG_Informacoes.ActivePage:= TBS_documentos;
        E_Cpf_CNPJ.SetFocus;
        exit;
      end; }
    end;
  end;

  if DBLCB_Usuario.Text <> EmptyStr then
  begin
    if colaborador.Registro.Codigo > 0 then
    begin
      colaborador.VerificaExistenciaUsuario(colaborador.Registro.Usuario);
      if colaborador.exist then
      begin
        MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'Este usuário está sendo usado pelo colaborador ' + colaborador.Registro.Nome + '.'+EOLN+
                       'Não é permitido usar o mesmo usuário em mais de um colaborador ao mesmo tempo' + EOLN+
                       'Por favor retire o usuário do outro colaborador ou utilize outro usuário neste.'+EOLN,
                       ['OK'],[bEscape],mpErro);
        Result := False;
        PG_Informacoes.ActivePage:= tsOutras;
        DBLCB_Usuario.SetFocus;
        exit;
      end;
    end;
  end;

  {if (Trim(DBLCB_Usuario.Text)<> '') then
  Begin
    colab.Registro.Codigo := Tb_Colaborador.fieldByName('clb_codigo').AsInteger;
    colab.VerificaExistenciaUsuario(DBLCB_Usuario.KeyValue);
    if colab.exist then
    Begin
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Este usuário está sendo usado pelo colaborador ' + Colab.Registro.Nome + '.'+EOLN+
                     'Não é permitido usar o mesmo usuário em mais de um colaborador ao mesmo tempo' + EOLN+
                     'Por favor retire o usuário do outro colaborador ou utilize outro usuário neste.'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      PG_Informacoes.ActivePage:= tbs_Outras;
      DBLCB_Usuario.SetFocus;
      exit;
    End;
  End;    }



end;

procedure TRegCollaborator.MontarComboBoxCidade;
var
  i : Integer;
begin
  with colaborador do
  Begin
    if CB_UF.Text <> EmptyStr then
      cidade.Parametros.FieldName.Estado := CB_UF.Text;
    Cidade.search;
    DBLCB_Cidade.Items.Clear;
    for i := 0 to Pred(Cidade.lista.Count) do
      DBLCB_Cidade.Items.Add(Cidade.lista[I].Descricao);
  End;
end;

procedure TRegCollaborator.MontarComboBoxCargo;
var
  i : Integer;
begin
  with colaborador do
  Begin
    Cargo.search;
    DBLCB_Cargo.Items.Clear;
    for i := 0 to Pred(cargo.lista.Count) do
      DBLCB_Cargo.Items.Add(cargo.lista[I].Descricao);
  End;
end;

procedure TRegCollaborator.MontarComboBoxUsuario;
var
  i : Integer;
begin
  with colaborador do
  Begin
    Usuario.search;
    DBLCB_Usuario.Items.Clear;
    for i := 0 to Pred(Usuario.lista.Count) do
      DBLCB_Usuario.Items.Add(Usuario.lista[I].Nome);
  End;
end;

end.
