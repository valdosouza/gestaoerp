unit reg_users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, ControllerUsuario, System.StrUtils;

type
  TRegUsers = class(TBaseRegistry)
    Panel1: TPanel;
    L_Senha: TLabel;
    L_Codigo: TLabel;
    L_Nome: TLabel;
    L_Nivel: TLabel;
    sb_reseta: TSpeedButton;
    sb_permissao: TSpeedButton;
    Label1: TLabel;
    E_Nome: TEdit;
    E_Login: TEdit;
    E_Senha: TEdit;
    E_Codigo: TEdit;
    CB_Nivel: TComboBox;
    Cbx_Ativo: TCheckBox;
    pnl_auth_card: TPanel;
    L_Auth_card: TLabel;
    E_Auth_card: TEdit;
    RegUsers: TGroupBox;
    Label5: TLabel;
    L_lgn_email: TLabel;
    L_pwd_email: TLabel;
    L_Usr_Mail: TLabel;
    L_Lbl_Name: TLabel;
    L_porta_email: TLabel;
    L_Srv_Smtp: TLabel;
    Label13: TLabel;
    L_Assinatura: TLabel;
    sb_TestarEmail: TSpeedButton;
    E_Srv_Smtp: TEdit;
    E_lgn_email: TEdit;
    E_pwd_email: TEdit;
    E_Usr_Mail: TEdit;
    E_Lbl_Name: TEdit;
    E_porta_email: TEdit;
    Cbx_Req_Autenticacao: TCheckBox;
    Cbx_Req_Con_ssl: TCheckBox;
    chbx_notifica_login: TCheckBox;
    M_Assinatura: TMemo;
    procedure sb_TestarEmailClick(Sender: TObject);
    procedure sb_permissaoClick(Sender: TObject);
  private
    { Private declarations }
    function validaEnvioEmailteste:boolean;
    procedure EnvioEmailteste;
  protected
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure setPerfil; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    function ValidaInsert():boolean; Override;
    procedure Insert;Override;
    function ValidateChange():boolean; Override;
    procedure Change;Override;
    function ValidateDelete():boolean; Override;
    procedure Delete;Override;
    function ValidateSave():boolean; Override;
    procedure Save;Override;
    function ValidateCancel():boolean; Override;
    procedure Cancel; Override;
  public
    users : TControllerUsuario;
  end;

var
  RegUsers: TRegUsers;

implementation

{$R *.dfm}

uses UN_MSG, Md5;

{ TRegUsers }

procedure TRegUsers.Cancel;
begin
  inherited;
end;

procedure TRegUsers.Change;
begin
  inherited;
  E_Nome.SetFocus;
end;

procedure TRegUsers.CriarVariaveis;
begin
  inherited;
  users := TControllerUsuario.create(self);
end;

procedure TRegUsers.Delete;
begin
  users.delete;
  inherited;
end;

procedure TRegUsers.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(users);
end;

procedure TRegUsers.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    users.Registro.Codigo := Self.CodigoRegistro;
    users.getbyId;
  End;
  inherited;
end;

procedure TRegUsers.Insert;
begin
  inherited;
  E_Nome.SetFocus;
end;

procedure TRegUsers.Save;
begin
  with users do
  Begin
    Registro.Nome := E_Nome.Text;

    //Usuário Ativo
    Registro.Ativo := IfThen(Cbx_Ativo.Checked, SIM, NAO);

    //usuario
    Registro.Login := E_Login.Text;
    //senha
    Registro.Senha := MD5String(E_Senha.Text);

    //nivel de acesso
    Registro.Nivel := IntToStr(CB_Nivel.ItemIndex);

    //Informe o número do cartão para ser utilizado na autorização
    Registro.CartaoAutorizacao := E_Auth_card.Text;

    //*****GRUPO: Configurações para Envio de e-mail
    //    Servidor de saída (SMTP);
    Registro.emailSMTP := E_Srv_Smtp.Text;

    //porta
    Registro.emailPorta := E_porta_email.Text;

    //Requer Autenticação
    Registro.emailAutenticacao := IfThen(Cbx_Req_Autenticacao.Checked, SIM, NAO);

    //equer uma conexão de segurança (SSL)
    Registro.emailSSL := IfThen(Cbx_Req_Con_ssl.Checked, SIM, NAO);

    //Nome que aparecerá no título do emails
    Registro.emailLabel := E_Lbl_Name.Text;

    //Usuário (Quando Requerido pelo Servidor
    Registro.email := E_Usr_Mail.Text;

    //e-mail
    Registro.emailLogin := E_lgn_email.Text;

    //senha
    Registro.emailSenha := E_pwd_email.Text;

    //Quero receber notificação de tentativas ou login efetuado
    Registro.NotificarPorEmail := IfThen(chbx_notifica_login.Checked, SIM, NAO);

    //assinatura
    Registro.emailAssinatura := M_Assinatura.Text;

    salva;
  End;
  CodigoRegistro := users.Registro.Codigo;
  inherited;
end;

procedure TRegUsers.setPerfil;
begin
  inherited;
end;

procedure TRegUsers.ShowData;
begin
  with users do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Nome.Text  := Registro.Nome;

    //Usuário ativo
    if Registro.Ativo = SIM then
      Cbx_Ativo.Checked := True
    else
      Cbx_Ativo.Checked := False;

    //usuario
     E_Login.Text := Registro.Login;
    //senha
     E_Senha.Text := Registro.Senha;

    //nivel de acesso
    CB_Nivel.ItemIndex := StrToInt(Registro.Nivel);

    //Informe o número do cartão para ser utilizado na autorização
    E_Auth_card.Text := Registro.CartaoAutorizacao;

    //*****GRUPO: Configurações para Envio de e-mail
    //    Servidor de saída (SMTP);
    E_Srv_Smtp.Text := Registro.emailSMTP;

    //porta
    E_porta_email.Text := Registro.emailPorta;

    //Requer Autenticação
    if Registro.emailAutenticacao = SIM then
      Cbx_Req_Autenticacao.Checked := True
    else
      Cbx_Req_Autenticacao.Checked := False;

    //equer uma conexão de segurança (SSL)
    if Registro.emailSSL = SIM then
      Cbx_Req_Con_ssl.Checked := True
    else
      Cbx_Req_Con_ssl.Checked := False;

    //Nome que aparecerá no título do emails
    E_Lbl_Name.Text := Registro.emailLabel;

    //Usuário (Quando Requerido pelo Servidor
    E_Usr_Mail.Text := Registro.email;

    //e-mail
    E_lgn_email.Text := Registro.emailLogin;

    //senha
    E_pwd_email.Text := Registro.emailSenha;

    //Quero receber notificação de tentativas ou login efetuado
    if Registro.NotificarPorEmail = SIM then
      chbx_notifica_login.Checked := True
    else
      chbx_notifica_login.Checked := False;

    //assinatura
    M_Assinatura.Text := Registro.emailAssinatura;
  End;
  inherited;
end;

procedure TRegUsers.ShowNoData;
begin
  E_Codigo.clear;
  E_Nome.clear;
end;

function TRegUsers.ValidaInsert: boolean;
begin
  Result := True;
end;

function TRegUsers.ValidateCancel: boolean;
begin
  Result := True;
end;

function TRegUsers.ValidateChange: boolean;
begin
  Result := True;
end;

function TRegUsers.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemExcluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegUsers.ValidateSave: boolean;
begin
  Result := True;

  if TRIM(E_Nome.Text) = EmptyStr then
  begin
    MensagemValidaPreenchimentoCampo(L_Nome.Caption);
    result:=False;
    E_Nome.SetFocus;
    Exit;
  end;

  if TRIM(E_Login.Text) = EmptyStr then
  begin
    MensagemValidaPreenchimentoCampo('Login do Usuário');
    result:=False;
    E_Login.SetFocus;
    Exit;
  end;

  if (TRIM(E_Senha.Text) = '') and (cbx_Ativo.Checked) then //nao usa mais DB
  begin
    MensagemValidaPreenchimentoCampo(L_Senha.Caption);
    result:=False;
    E_Senha.SetFocus;
    Exit;
  end;
end;

function TRegUsers.validaEnvioEmailteste: boolean;
begin
  Result:=true;
  if TRIM(E_Srv_Smtp.Text) = '' then
  begin
    MensagemValidaPreenchimentoCampo(L_Srv_Smtp.Caption);
   result:=False;
   Exit;
  end;
  if TRIM(E_Usr_Mail.Text) = '' then
  begin
    MensagemValidaPreenchimentoCampo(L_Usr_Mail.Caption);
   result:=False;
   Exit;
  end;

  if TRIM(E_pwd_email.Text) = '' then
  begin
    MensagemValidaPreenchimentoCampo(L_pwd_email.Caption);
    result:=False;
    Exit;
  end;
end;

procedure TRegUsers.EnvioEmailteste;
{Var
  Lc_Aux : String;
  Lc_Destinatario : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Corpo : String;
  Lc_arq_pdf : string;
  lc_anexo :TStringList;
  LcEnviaemail : TFr_envia_email;
  LcEmailTo : String; }
begin
  {//Envia email para a propria empresa
  Lc_Destinatario := TStringList.Create;
  Lc_Destinatario.Clear;
  if (InputQuery('Envio teste de e-mail ', 'Informe um e-mail válido', LcEmailTo)) then
  Begin
    Lc_Destinatario.Add(concat(' ',LcEmailTo));
  end;
  Lc_Destinatario.Add(concat(' ',E_lgn_email.Text));
  //Sobre Anexos
  Lc_Anexo        := TStringList.Create;
  Lc_Anexo.Clear;
  Lc_Anexo.add('Sem anexo');

  Lc_Corpo := '<html>'+
              '<head>'+
              '  <meta content="text/html; charset=ISO-8859-1"'+
              ' http-equiv="content-type">'+
              '</head>'+
              '<body>'+
              'Ol&aacute;,<br>'+
              '<br>'+
              'email de teste enviado pelo Sistema Gestão da Setes.'+
              '<br>'+
              '</body>'+
              '</html>';

  LcEnviaemail := TFr_envia_email.create(nil);
  Try
    with LcEnviaemail do
    Begin
      with Id_Mail do
      Begin
        Host      := E_Srv_Smtp.Text;
        Port      := E_porta_email.Text;
        SetSSL    := Cbx_Req_Con_ssl.Checked;
        SetTLS    := Cbx_Req_Autenticacao.Checked;
        From      := E_lgn_email.Text;
        FromName  := E_Lbl_Name.Text;
        Username  := E_Usr_Mail.Text;
        Password  := E_pwd_email.Text;;
      end;
      Lc_AssuntoEmail := 'Envio de teste';
      It_Tipo_Envio := 'T';
      It_Assunto := Lc_AssuntoEmail;
      It_Destino := Lc_Destinatario;
      It_Corpo := Lc_Corpo;
      It_Anexo   := lc_anexo;
      ShowModal;
    end;
  Finally
    LcEnviaemail.Disposeof;
  End;  }
end;

procedure TRegUsers.sb_permissaoClick(Sender: TObject);
//Var
  //Lc_Form : TFr_Permissao;
begin
  {Lc_Form := TFr_Permissao.Create(nil);
  Try
    Lc_Form.It_Tp_Acesso := 1;
    Lc_Form.It_Cd_Usuario := Tb_Usuario.FieldByName('USU_CODIGO').AsInteger;
    Lc_Form.ShowModal;
  Finally
    Lc_Form .disposeOf;
  End;}
end;

procedure TRegUsers.sb_TestarEmailClick(Sender: TObject);
begin
  if validaEnvioEmailteste then
  Begin
    EnvioEmailteste;
  End;
end;

end.
