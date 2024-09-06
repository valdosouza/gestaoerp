unit Un_envia_email;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, ACBrMail, types, ACBrBase, ExtCtrls,
  Vcl.Buttons,ControllerUsuario,ControllerDskMailing;
type
  TFr_envia_email = class(TForm)
    Panel1: TPanel;
    Sb_Cancelar: TSpeedButton;
    RE_Status: TRichEdit;

    procedure FormCreate(Sender: TObject);
    procedure Sb_CancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

    procedure Id_MailConnected(Sender: TObject);

    procedure Id_MailMailProcess(const AMail: TACBrMail;
      const aStatus: TMailStatus);
    procedure Id_MailMailException(const AMail: TACBrMail;
      const E: Exception; var ThrowIt: Boolean);
    procedure Id_MailAfterMailProcess(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Id_MailBeforeMailProcess(Sender: TObject);
  private
    { Private declarations }
    Usuario : TControllerUsuario;
    Mailing : TControllerDskMailing;
  public
    { Public declarations }
    it_Cancela : Boolean;
    Terminado : Boolean;
    //[A]utomatico / [S]Solicitação
    It_Tipo_Envio : String;
    It_Assunto : String;
    It_Destino: TStringList;
    It_Corpo: string;
    It_Anexo: TStringList;
    procedure Pc_Define_RemententeAtivo;
    procedure Pc_Define_Rementente;
    procedure Fc_EnviaEmail;
    procedure AddStatusLine(S: string; Cor: TColor);
    procedure ListarEmailParaEnvio(Pc_cd_Empresa:String;Pc_Tipos : array of string;Pc_Lista:TStringList);

  end;

var
  Fr_envia_email: TFr_envia_email;

implementation

uses UN_Sistema, env, UN_MSG, IdMessageParts,  mimemess, IniFiles, TypInfo,
    UnFunctions;

{$R *.dfm}

procedure TFr_envia_email.Pc_Define_RemententeAtivo;
Begin
  Usuario.Registro.Codigo := Gb_Cd_Usuario;
  Usuario.getbyId;
  if Usuario.exist then
  Begin
    Usuario.Registro.Login := GB_Nm_Usuario;
    Usuario.getByLogin;
  End;
  {
  with Id_Mail do
  Begin
    Host := Usuario.Registro.emailSMTP;
    Port := Usuario.Registro.emailPorta;
    SetSSL := (Usuario.Registro.emailSSL  = 'S');
    SetTLS := (Usuario.Registro.emailAutenticacao = 'S');
    if Length( Usuario.Registro.email) > 0 then
      Username := Usuario.Registro.email
    else
      Username := Usuario.Registro.emailLogin;
    Password := Usuario.Registro.emailSenha;
  end;
  }
end;


procedure TFr_envia_email.ListarEmailParaEnvio(Pc_cd_Empresa: String;
  Pc_Tipos: array of string; Pc_Lista: TStringList);
Var
  I : Integer;
Begin
  Mailing.ListarEmailParaEnvio(Pc_cd_Empresa,Pc_Tipos);
  for I := 0 to Mailing.Lista.Count -1 do
  Begin
    Pc_Lista.Add(' ' + Mailing.Lista[I].email);
  End;

end;
procedure TFr_envia_email.Pc_Define_Rementente;
Begin
  {
  with Id_Mail do
  Begin
    if It_Tipo_Envio = 'A' then   // Envio Erros e outros do sistema
    Begin
      Host := 'setes.com.br';
      SetSSL := true;
      SetTLS := False;
      Username := 'suporte@setes.com.br';
      Password := 'Sucessoem2016!';
      Port := '465';
    End
    else
    Begin
      if It_Tipo_Envio = 'N' then // Envio NFE
      Begin
        Host := 'setes.com.br';
        SetSSL := true;
        SetTLS := False;
        Username := 'sistemanfe@setes.com.br';
        Password := 'Eqpm20mrdsncdJ16!';
        Port := '465';
      End
      else
      begin
        if It_Tipo_Envio = 'T' then   // Envio Erros e outros do sistema
        Begin

        End
        else
        Begin
          //Usuario Ativo
          Pc_Define_RemententeAtivo;
        End;
      End;
    End;
  end;
  }
end;

procedure TFr_envia_email.Fc_EnviaEmail;
var
  Lc_I : Integer;
  Lc_Aux : String;
begin
{
  //Verifica Coenexão com a Internet
  if Fc_PingConectadoSetes then
  Begin;
    // Configura o Remetente da Mensagem

    with Id_Mail do
    begin

      if It_Tipo_Envio = 'A' then
      Begin
        From := 'suporte@setes.com.br';
        FromName := 'Suporte Automáticos - Exception';
      end
      else
      Begin
        if It_Tipo_Envio = 'N' then
        Begin
          From := 'sistemanfe@setes.com.br';
          FromName := 'Sistema Automático - NF-e';
        end
        else
        Begin
          if It_Tipo_Envio = 'T' then
          Begin

          end
          else
          Begin
            From := Usuario.Registro.emailLogin;
            FromName := Usuario.Registro.emailLabel;
          End;
        end;
      End;

      for Lc_I := 0 to (It_Destino.Count -1) do
      Begin
        Lc_Aux := Trim(It_Destino.Strings[Lc_I]);
        AddAddress(Lc_Aux,Lc_Aux);
      end;
      //Assunto
      Subject := It_Assunto;
      IsHTML := True; // define que a mensagem html
      Body.Append(It_Corpo);
      //Adiciona Anexo
      if not (It_Anexo.Strings[0] = 'Sem anexo') then
      Begin
        //Adicona parte do Aenxo
        if It_Anexo.Count > 0 then
        Begin
          for Lc_I := 0 to (It_Anexo.Count -1) do
          Begin
            if (FileExists(It_Anexo.Strings[Lc_I])) then
            Begin
              AddAttachment(It_Anexo.Strings[Lc_I],'adAttachment');
            end
            else
            Begin
              MensagemPararExecucao('O arquivo para anexar ao email não foi encontrado.' + EOLN +
                                    'Nome do Arquivo: ' + It_Anexo.Strings[Lc_I]);
            end;
          end;
        end;
      end;
    end;

    try
      //true indica uso de Thread
      Id_Mail.Send(true);
    except
      on E : Exception do
        ShowMessage(E.ClassName+' Erro , com Mensagem : '+E.Message);
    end;
  End;
  }
end;



procedure TFr_envia_email.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Usuario.DisposeOf;
  //It_Destino.DisposeOf;
  //It_Anexo.DisposeOf;
  Action := caFree;
end;

procedure TFr_envia_email.FormCreate(Sender: TObject);
begin
  {
  Usuario := TControllerUsuario.create(Self);
  Mailing := TControllerDskMailing.create(Self);

  Id_Mail.Clear;
  RE_Status.Lines.Clear;
  it_Cancela := False;
  It_Destino := TStringList.Create;
  It_Anexo   := TStringList.Create;
  Id_Mail.DefaultCharset := TMailCharset.UTF_8;
  Id_Mail.IDECharset := TMailCharset.CP1252
  }
end;

procedure TFr_envia_email.Sb_CancelarClick(Sender: TObject);
begin
  if not it_Cancela then
  Begin
    if (MensagemcConfirmaAcao('O envio do e-mail será cancelado.' + EOLN +
                             'Confirmar o cancelamento ?') = mrBotao1) then
    begin
      it_Cancela := true;
      Sb_Cancelar.Caption := 'Fechar';
    end;
  end
  else
  Begin
    Self.Close;
  end;
end;

procedure TFr_envia_email.FormActivate(Sender: TObject);
begin
  Pc_Define_Rementente;
  Fc_EnviaEmail;
end;

procedure TFr_envia_email.AddStatusLine(S: string; Cor: TColor);
begin
  if assigned(RE_Status) then
  Begin
    RE_Status.SelAttributes.Color := Cor;
    RE_Status.Lines.Add(S);
    Application.ProcessMessages;
  End;
end;

procedure TFr_envia_email.Id_MailConnected(Sender: TObject);
begin
  AddStatusLine('Conectado ao Servidor', clGreen);
  Application.ProcessMessages
end;


procedure TFr_envia_email.Id_MailMailProcess(const AMail: TACBrMail;
  const aStatus: TMailStatus);
begin
  case aStatus of
    pmsStartProcess:
      AddStatusLine('Iniciando processo de envio', clGreen);
    pmsConfigHeaders:
      AddStatusLine('Configurando o cabeçalho do e-mail.', clGreen);
    pmsLoginSMTP:
      AddStatusLine('Logando no servidor de e-mail.', clGreen);
    pmsStartSends:
      AddStatusLine('Iniciando os envios.', clGreen);
    pmsSendTo:
      AddStatusLine('Processando lista de destinatários.', clGreen);
    pmsSendCC:
      AddStatusLine('Processando lista CC.', clGreen);
    pmsSendBCC:
      AddStatusLine('Processando lista BCC.', clGreen);
    pmsSendReplyTo:
      AddStatusLine('Processando lista ReplyTo.', clGreen);
    pmsSendData:
      AddStatusLine('Enviando dados.', clGreen);
    pmsLogoutSMTP:
      AddStatusLine('Fazendo Logout no servidor de e-mail.', clGreen);
    pmsDone:
    begin
      AddStatusLine('e-mail enviado com sucesso.', clGreen);
      it_Cancela := true;
      Sb_Cancelar.Caption := 'Fechar';
    end;
  end;
  Application.ProcessMessages;
end;

procedure TFr_envia_email.Id_MailAfterMailProcess(Sender: TObject);
begin
  it_Cancela := true;
  Sb_Cancelar.Caption := 'Fechar';
  Terminado := True;
  if It_Tipo_Envio = 'A' then Self.Close;
end;

procedure TFr_envia_email.Id_MailBeforeMailProcess(Sender: TObject);
begin
  AddStatusLine('Assunto do Email: ' + TACBrMail(Sender).Subject, clBlack);
end;

procedure TFr_envia_email.Id_MailMailException(const AMail: TACBrMail;
  const E: Exception; var ThrowIt: Boolean);
begin
  GeralogFile('Status email',E.Message);
  AddStatusLine(E.Message, clRed);
  It_Cancela := true;
  Sb_Cancelar.Caption := 'Fechar';
end;

end.
