unit reg_contacts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, System.StrUtils,
  ControllerContato, ControllerCargo, ControllerEmpresa, sea_job_position;

type
  TRegContacts = class(TBaseRegistry)
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    L_Nome: TLabel;
    E_Nome: TEdit;
    CB_Sexo: TComboBox;
    L_Sexo: TLabel;
    L_Aniversario: TLabel;
    E_Aniver: TMaskEdit;
    E_Data: TDateTimePicker;
    L_Data: TLabel;
    CB_Empresa: TComboBox;
    L_Empresa: TLabel;
    L_Cargo: TLabel;
    CB_Cargo: TComboBox;
    E_Cep: TEdit;
    L_Cep: TLabel;
    Sb_Cep: TSpeedButton;
    E_Endereco: TEdit;
    L_Endereco: TLabel;
    L_Complemento: TLabel;
    E_Complemento: TEdit;
    CB_UF: TComboBox;
    L_UF: TLabel;
    L_Bairro: TLabel;
    E_Bairro: TEdit;
    L_Cidade: TLabel;
    E_Cidade: TEdit;
    L_Pais: TLabel;
    E_Pais: TEdit;
    L_Fone: TLabel;
    E_Fone: TEdit;
    L_Ramal: TLabel;
    E_Ramal: TEdit;
    L_Celular: TLabel;
    E_Celular: TEdit;
    L_Email: TLabel;
    E_Email: TEdit;
    CHK_Contato: TCheckBox;
    L_MSN: TLabel;
    E_MSN: TEdit;
    PG_Informacoes: TPageControl;
    TabSheet1: TTabSheet;
    ME_Observ: TMemo;
    Sb_Contato: TSpeedButton;
    procedure Sb_CepClick(Sender: TObject);
    procedure Sb_ContatoClick(Sender: TObject);
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
  private
    contato : TControllerContato;
    empresa : TControllerEmpresa;
    cargo : TControllerCargo;

    procedure MontarComboBoxEmpresa;
    procedure MontarComboBoxCargo;
    procedure BuscaCep(Pc_Cep: String);
  end;

var
  RegContacts: TRegContacts;

implementation

uses UN_MSG, ENV, api_route_cep;

{$R *.dfm}

procedure TRegContacts.Change;
begin
  inherited;
  //E_Descricao.SetFocus;
end;

procedure TRegContacts.ClearAllFields;
begin
  inherited;
  contato.clear;
end;

procedure TRegContacts.CriarVariaveis;
begin
  inherited;
  contato := TControllercontato.create(self);
  empresa := TControllerEmpresa.create(self);
  cargo := TControllerCargo.create(self);
end;

procedure TRegContacts.Delete;
begin
  contato.delete;
  inherited;
end;

procedure TRegContacts.FinalizaVariaveis;
begin
  inherited;
  contato.DisposeOf;
  empresa.DisposeOf;
  cargo.DisposeOf;
end;

procedure TRegContacts.IniciaVariaveis;
begin
  MontarComboBoxCargo;
  MontarComboBoxEmpresa;
  if Self.CodigoRegistro > 0 then
  Begin
    contato.Registro.Codigo := Self.CodigoRegistro;
    contato.getbyId;
  End;
  inherited;
end;

procedure TRegContacts.Insert;
begin
  inherited;
  E_Nome.SetFocus;
  E_Aniver.Clear;
  E_Data.DateTime := now;
end;

procedure TRegContacts.Save;
begin
  with contato do
  Begin
    Registro.Cadastro := E_Data.DateTime;
    Registro.Codemp := empresa.getCodigoEmpresaLista(CB_empresa.Text);
    Registro.Sexo := CB_Sexo.Text;

    if E_Aniver.Text <> '  /  ' then
      Registro.Aniver := StrToDate(E_Aniver.Text+'/1900');

    Registro.Nome := E_Nome.Text;
    Registro.Cargo := cargo.getCodigoLista(CB_Cargo.Text);

    Registro.Cep := E_Cep.Text;
    Registro.Ender := E_Endereco.Text;
    Registro.Complem := E_Complemento.Text;

    Registro.Bairro := E_Bairro.Text;
    Registro.Cidade := E_Cidade.Text;
    Registro.Estado := CB_UF.Text;
    Registro.Pais := E_Pais.Text;
    Registro.Bairro := E_Bairro.Text;

    Registro.Fone := E_Fone.Text;
    Registro.Ramal := E_Ramal.Text;
    Registro.Celular := E_Celular.Text;
    Registro.Email := E_Email.Text;
    Registro.Principal := IfThen(CHK_Contato.Checked, SIGLA_S, SIGLA_N);

    Registro.Msn := E_MSN.Text;

    Registro.Observ := ME_Observ.Text;

    salva;
  End;
  CodigoRegistro := contato.Registro.Codigo;
  inherited;
end;

procedure TRegContacts.BuscaCep(Pc_Cep: String);
Var
  Lc_Cep : TCependereco;
begin
  Lc_Cep := Fc_BuscaPorCep(Pc_Cep);
  if (trim(Lc_Cep.FLogradouro) <> EmptyStr) then
  Begin
    CB_UF.Text      := Lc_Cep.FUF;
    //MontarComboBoxCidade;
    E_Cidade.Text  := UpperCase(Lc_Cep.FCidade);
    E_Endereco.Text := Lc_Cep.FLogradouro;
    E_Bairro.Text := Lc_Cep.FBairro;
    if E_Endereco.CanFocus then E_Endereco.SetFocus;
  end;
end;

procedure TRegContacts.Sb_CepClick(Sender: TObject);
begin
  if (E_cep.Text = '') then
  begin
    MensagemPadrao(TITULO_ERRO, ATENCAO + EOLN + EOLN +
                   'Informe o Número do Cep.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpInformacao);
    if E_cep.CanFocus then E_cep.SetFocus;
  end
  else
  Begin
    BuscaCep(E_cep.Text);
  end;
end;

procedure TRegContacts.Sb_ContatoClick(Sender: TObject);
Var
  sTemp : String;
  Lc_Form : TSeaJobPosition;
begin
  Lc_Form := TSeaJobPosition.Create(nil);
  Try
    Lc_Form.ShowModal;
  Finally
    sTemp := cargo.getDescricaoLista(Lc_Form.cds_searchCodigo.AsInteger);
    CB_Cargo.ItemIndex := CB_Cargo.Items.IndexOf(sTemp);
    CB_Cargo.SetFocus;

    Lc_Form .disposeOf;
  End;
end;

procedure TRegContacts.ShowData;
Var
  sTemp : String;
begin
  with contato do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Nome.Text  := Registro.Nome;

    E_Data.DateTime := Registro.Cadastro;
    sTemp := empresa.getNumeroNomeLista(Registro.Codemp);
    CB_empresa.ItemIndex := CB_empresa.Items.IndexOf(sTemp);
    CB_Sexo.ItemIndex := StrToInt(IfThen(Registro.Sexo = 'M', '0', '1'));
    E_Aniver.Text := DateToStr(Registro.Aniver);

    E_Nome.Text := Registro.Nome;
    sTemp := cargo.getDescricaoLista(Registro.Cargo);
    CB_Cargo.ItemIndex := CB_Cargo.Items.IndexOf(sTemp);

    E_Cep.Text :=  Registro.Cep;
    E_Endereco.Text := Registro.Ender;
    E_Complemento.Text := Registro.Complem;

    E_Bairro.Text := Registro.Bairro;
    E_Cidade.Text := Registro.Cidade;
    CB_UF.Text := Registro.Estado;
    E_Pais.Text := Registro.Pais;

    E_Fone.Text := Registro.Fone;
    E_Ramal.Text := Registro.Ramal;
    E_Celular.Text := Registro.Celular;
    E_Email.Text := Registro.Email;

    if Registro.Principal = SIGLA_S then
      CHK_Contato.Checked := True
    else
      CHK_Contato.Checked := False;

    E_MSN.Text := Registro.Msn;

    ME_Observ.Text := Registro.Observ;
  End;
  inherited;
end;

procedure TRegContacts.ShowNoData;
begin
  E_Codigo.clear;
  E_Nome.clear;
end;

function TRegContacts.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegContacts.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Nome.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Nome.Caption);
    Result := False;
    E_Nome.SetFocus;
    Exit;
  end;
end;

procedure TRegContacts.MontarComboBoxCargo;
var
  i : Integer;
begin
  with cargo do
  begin
    search;
    CB_Cargo.Items.Clear;
    for i := 0 to Pred(lista.Count) do
      CB_Cargo.Items.Add(lista[I].Descricao);
  end;
end;

procedure TRegContacts.MontarComboBoxEmpresa;
var
  i : Integer;
begin
  with empresa do
  begin
    search;
    CB_Empresa.Items.Clear;
    for i := 0 to Pred(lista.Count) do
      CB_Empresa.Items.Add(lista[I].NumeroNome);
  end;
end;

end.
