unit Un_tr_send_email;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, ACBrMail, types, ACBrBase, ExtCtrls,
  ControllerPedido, ControllerUsuario;

type
  TTRSendEmail = class(TThread)
    procedure AfterMailProcess(Sender: TObject);

  private
    { Private declarations }
    FCtrlUsuario : TControllerUsuario;

    FAssunto : String;
    FDestino: TStringList;
    FAnexo: TStringList;

    Id_Mail: TACBrMail;
    FUsuario: String;
    FModulo: String;
    FSaldoEstoque: Real;

    FAutenticado: boolean;
    FDescricaoProduto: String;
    FCodigoProduto: Integer;
    FEmailEstoquenotifica: String;
    FDataHora: TDateTime;

    function  GeraEmail: String;
    function  GeraEmailLogin: String;
    function  GeraEmailEstoqueZeradoNetagativo: String;
    function envia:Boolean;

    function remetenteAtivo:Boolean;
    function remetenteAutomatico:Boolean;


    procedure Id_MailAfterMailProcess(Sender: TObject);
    procedure Id_MailConnected(Sender: TObject);
    procedure Id_MailMailException(const AMail: TACBrMail; const E: Exception;
      var ThrowIt: Boolean);
    procedure Id_MailMailProcess(const AMail: TACBrMail;
      const aStatus: TMailStatus);
    procedure setFUsuario(const Value: String);
    procedure setFModulo(const Value: String);
    procedure setFSaldoEstoque(const Value: Real);
    procedure setFAutenticado(const Value: boolean);
    procedure executeLogin;
    procedure executeEstoque;
    procedure setFCodigoProduto(const Value: Integer);
    procedure setFDescricaoProduto(const Value: String);
    procedure setFEmailEstoquenotifica(const Value: String);
    procedure setFDataHora(const Value: TDateTime);
  public
    constructor Create();
    destructor Destroy; override;
    procedure execute;override;
    property Usuario : String read FUsuario write setFUsuario;
    property Autenticado : boolean read FAutenticado write setFAutenticado;
    Property Modulo : String read FModulo write setFModulo;
    property CodigoProduto : Integer read FCodigoProduto write setFCodigoProduto;
    property DescricaoProduto : String read FDescricaoProduto write setFDescricaoProduto;
    property SaldoEstoque : Real read FSaldoEstoque write setFSaldoEstoque;
    property EmailEstoquenotifica : String read FEmailEstoquenotifica write setFEmailEstoquenotifica;
    property DataHora : TDateTime read FDataHora write setFDataHora;
  end;

implementation

uses   mimemess, IniFiles, TypInfo, UnFunctions, un_sistema;

procedure TTRSendEmail.AfterMailProcess(Sender: TObject);
begin

end;

constructor TTRSendEmail.Create();
begin
  inherited Create (True);
  FCtrlUsuario := TControllerUsuario.create(nil);
  Id_Mail := TACBrMail.create(NIL);
  Id_Mail.OnAfterMailProcess := AfterMailProcess;
  Id_Mail.UseThread := True;
  FDestino:= TStringList.create;
  FAnexo:= TStringList.create;
  FreeOnTerminate := TRue;
end;

destructor TTRSendEmail.Destroy;
begin
  FCtrlUsuario.DisposeOf;
  FDestino.DisposeOf;
  FAnexo.DisposeOf;
  Id_Mail.DisposeOf;
  inherited;
end;


function TTRSendEmail.envia: Boolean;
var
  Lc_I : Integer;
  Lc_Aux : String;
begin
  //Verifica Coenexão com a Internet
  if Fc_PingConectadoSetes then
  Begin;
    // Configura o Remetente da Mensagem
    with Id_Mail do
    begin

      for Lc_I := 0 to (FDestino.Count -1) do
      Begin
        Lc_Aux := Trim(Fdestino.Strings[Lc_I]);
        AddAddress(Lc_Aux,Lc_Aux);
      end;
      //Assunto
      Subject := FAssunto;
      IsHTML := True; // define que a mensagem é html
      Body.Append(GeraEmail);
      //Adiciona Anexo
      if not (FAnexo.Strings[0] = 'Sem anexo') then
      Begin
        //Adicona parte do Aenxo
        if FAnexo.Count > 0 then
        Begin
          for Lc_I := 0 to (FAnexo.Count -1) do
          Begin
            if (FileExists(FAnexo.Strings[Lc_I])) then
            Begin
              AddAttachment(FAnexo.Strings[Lc_I],'AddAttachment');
            end
            else
            Begin
              {
              MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                             'O arquivo para anexar ao email não foi encontrado.' + EOLN +
                             'Nome do Arquivo: ' + FAnexo.Strings[Lc_I] + EOLN +
                             'Verifique e tente novamente.' + EOLN,
                            ['OK'], [bEscape], mpAlerta);
              }
            end;
          end;
        end;
      end;
    end;
    try
      Id_Mail.Send();
    except
      Self.Terminate;
    end;
  End;
end;

procedure TTRSendEmail.execute;
begin
  if FModulo = 'LOGIN' then
  Begin
    executeLogin;
  End
  else
  if FModulo = 'ESTOQUE' then
  Begin
    executeEstoque;
  End;
  Terminate;
end;


procedure TTRSendEmail.executeEstoque;
begin
  Synchronize(
    procedure
    begin
      FDestino.Clear;
      FDestino.Add(concat(' ', Fc_Tb_Geral('L','EST_IDENTIF_EMAIL','') ));
      FAnexo.Clear;
      FAnexo.Add('Sem anexo');
      GeraEmail;
      if remetenteAutomatico then
        Envia;
    end
  );
end;

procedure TTRSendEmail.executeLogin;
begin
  with FCtrlUsuario DO
  Begin
    Registro.Login := FUsuario;
    getByLogin;
    if FCtrlUsuario.exist then
    Begin
      if ( Registro.emailSMTP <> '' ) and
         ( Registro.email <> '' ) and
         ( Registro.emailPorta <> '' ) and
         ( Registro.emailLogin <> '' ) and
         ( Registro.emailSenha <> '' ) and
         ( Registro.NotificarPorEmail = 'S' ) then
      Begin
        FDestino.Clear;
        FDestino.Add(concat(' ', Registro.emailLogin ));
        FAnexo.Clear;
        FAnexo.Add('Sem anexo');
        GeraEmail;
        if RemetenteAtivo then
          Envia;
      end;
    End;
  end;
end;


function TTRSendEmail.GeraEmail: String;
Begin
  if FModulo = 'LOGIN' then
  Begin
    REsult := GeraEmailLogin;
  End;

  if FModulo = 'ESTOQUE' then
  Begin
    REsult := GeraEmailEstoqueZeradoNetagativo;
  End;

end;


function TTRSendEmail.GeraEmailEstoqueZeradoNetagativo: String;
begin
  FAssunto := 'Produto com estoque igual ou menor que zero';

  REsult  := concat(
                 '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> ',
                 '<html> ',
                 '<head> ',
                 '  <meta content="text/html; charset=ISO-8859-1" ',
                 ' http-equiv="content-type"> ',
                 '  <title>Produto com estoque igual ou menor que zero</title> ',
                 '</head> ',
                 '<body> ',
                 '<table style="text-align: left; width: 605px; height: 116px;"  ',
                 ' border="1" cellpadding="0" cellspacing="0"> ',
                 '  <tbody> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Código Produto&nbsp;</td> ',
                 '      <td style="width: 790px;">' , InttoStr(FCodigoProduto) ,'</td> ',
                 '    </tr> ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Descricao do produto</td> ',
                 '      <td style="width: 790px;">', FDescricaoProduto+'</td> ',
                 '    </tr>  ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Saldo </td> ',
                 '      <td style="width: 790px;">' , FloatToStrF(FSaldoEstoque,ffFixed,10,2) ,'</td> ',
                 '    </tr> ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Data e Hora </td> ',
                 '      <td style="width: 790px;">' , DateTimeToStr(FDataHora) ,'</td> ',
                 '    </tr> ',

                 '  </tbody> ',
                 '</table> ',
                 '</body> ',
                 '</html> '
  );

end;

function TTRSendEmail.GeraEmailLogin: String;
begin
  if FAutenticado then
    FAssunto := 'Login Efetuado no Sistema Setes'
  else
    FAssunto := 'Tentativa de Login Sistema Setes';

  REsult  := concat(
                 '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> ',
                 '<html> ',
                 '<head> ',
                 '  <meta content="text/html; charset=ISO-8859-1" ',
                 ' http-equiv="content-type"> ',
                 '  <title>Tentativa de Login</title> ',
                 '</head> ',
                 '<body> ',
                 '<table style="text-align: left; width: 605px; height: 116px;"  ',
                 ' border="1" cellpadding="0" cellspacing="0"> ',
                 '  <tbody> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Data&nbsp;</td> ',
                 '      <td style="width: 10px;">:</td> ',
                 '      <td style="width: 790px;">' , DateTimeToStr(Now) ,'</td> ',
                 '    </tr> ',
                 '    <tr> ',
                 '      <td style="width: 159px;">Nome do Usuário</td> ',
                 '      <td style="width: 10px;">:</td>  ',
                 '      <td style="width: 790px;">', FUsuario+'</td> ',
                 '    </tr>  ',

                 '    <tr> ',
                 '      <td style="width: 159px;">Nome do Computador</td> ',
                 '      <td style="width: 10px;">:</td> ',
                 '      <td style="width: 790px;">' , Fc_NomeComputador ,'</td> ',
                 '    </tr> ',

                 '  </tbody> ',
                 '</table> ',
                 '</body> ',
                 '</html> '
  );

end;

procedure TTRSendEmail.Id_MailAfterMailProcess(Sender: TObject);
begin


end;

procedure TTRSendEmail.Id_MailConnected(Sender: TObject);
begin

end;

procedure TTRSendEmail.Id_MailMailException(const AMail: TACBrMail;
  const E: Exception; var ThrowIt: Boolean);
begin

end;

procedure TTRSendEmail.Id_MailMailProcess(const AMail: TACBrMail;
  const aStatus: TMailStatus);
begin

end;

function TTRSendEmail.remetenteAtivo: Boolean;
begin
  Result := False;
  if FCtrlUsuario.exist then
  Begin
    with Id_Mail do
    Begin
      From      := FCtrlUsuario.Registro.emailLogin;
      FromName  := FCtrlUsuario.Registro.emailLabel;

      Host      := FCtrlUsuario.Registro.emailSMTP;
      Port      := FCtrlUsuario.Registro.emailPorta;
      SetSSL    := (  FCtrlUsuario.Registro.emailSSL = 'S');
      SetTLS    := ( FCtrlUsuario.Registro.emailAutenticacao = 'S');
      if Length(  FCtrlUsuario.Registro.email) > 0 then
        Username := FCtrlUsuario.Registro.email
      else
        Username := FCtrlUsuario.Registro.emailLogin;
      Password := FCtrlUsuario.Registro.emailSenha;
    end;
    Result := True;
  End;
end;

function TTRSendEmail.remetenteAutomatico: Boolean;
begin
  Result := True;
  with Id_Mail do
  Begin
    From      := 'sistemanfe@setes.com.br';
    FromName  := 'Sistema Setes - Envio Automático';

    Host := 'setes.com.br';
    SetSSL := False;
    SetTLS := True;
    Username := 'sistemanfe@setes.com.br';
    Password := 'Eqpm20mrdsncdJ16!';
    Port := '587';
  end;
end;

procedure TTRSendEmail.setFAutenticado(const Value: boolean);
begin
  FAutenticado := Value;
end;

procedure TTRSendEmail.setFCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TTRSendEmail.setFDataHora(const Value: TDateTime);
begin
  FDataHora := Value;
end;

procedure TTRSendEmail.setFDescricaoProduto(const Value: String);
begin
  FDescricaoProduto := Value;
end;

procedure TTRSendEmail.setFEmailEstoquenotifica(const Value: String);
begin
  FEmailEstoquenotifica := Value;
end;

procedure TTRSendEmail.setFModulo(const Value: String);
begin
  FModulo := Value;
end;

procedure TTRSendEmail.setFSaldoEstoque(const Value: Real);
begin
  FSaldoEstoque := Value;
end;

procedure TTRSendEmail.setFUsuario(const Value: String);
begin
  FUsuario := Value;
end;

end.



