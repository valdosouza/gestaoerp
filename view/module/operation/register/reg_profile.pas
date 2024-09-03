unit reg_profile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerPerfilUsuario;

type
  TRegProfile = class(TBaseRegistry)
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    L_Descricao: TLabel;
    SB_Permissao: TSpeedButton;
    procedure SB_PermissaoClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
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
    perfilUsuario : TControllerPerfilUsuario;
  end;

var
  RegProfile: TRegProfile;

implementation

uses UN_MSG, ENV, rg_privilege;

{$R *.dfm}

procedure TRegProfile.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegProfile.ClearAllFields;
begin
  inherited;
  perfilUsuario.clear;
end;

procedure TRegProfile.CriarVariaveis;
begin
  inherited;
  perfilUsuario := TControllerperfilUsuario.create(self);
end;

procedure TRegProfile.Delete;
begin
  perfilUsuario.delete;
  inherited;
end;

procedure TRegProfile.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(perfilUsuario);
end;

procedure TRegProfile.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    perfilUsuario.Registro.Codigo := Self.CodigoRegistro;
    perfilUsuario.Registro.CodMha := Gb_CodMha;
    perfilUsuario.getbyId;
  End;
  inherited;
end;

procedure TRegProfile.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegProfile.Save;
begin
  with perfilUsuario do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.CodMha := Gb_CodMha;
    salva;
  End;
  CodigoRegistro := perfilUsuario.Registro.Codigo;
  inherited;
end;

procedure TRegProfile.SB_ExcluirClick(Sender: TObject);
begin
  if Self.CodigoRegistro > 0 then
  Begin
    if (MensagemPadrao('Mensagem de Confirmação',
                       'Excluir ' + perfilUsuario.Registro.Descricao +' de seus arquivos.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
      perfilUsuario.permisssaoPerfil.Registro.Perfil := Self.CodigoRegistro;
      perfilUsuario.permisssaoPerfil.getbyId;
      perfilUsuario.permisssaoPerfil.delete;
      inherited;
    end;
  End;

{procedure TFr_Perfil.SB_ExcluirClick(Sender: TObject);
begin
  if (MensagemPadrao('Mensagem de Confirmação',
                     'Excluir '+Tb_Perfil.FieldByName('PFL_DESCRICAO').AsAnsiString +' de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      Pc_DeletaItensPerfil(Tb_Perfil.FieldByName('PFL_CODIGO').AsInteger);
      Tb_Perfil.Delete;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      Pc_limpa_campo_busca;
      PC_Buscar;
      Pg_Perfil.ActivePage:=tbs_pesquisa;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
end;}

 {
procedure TFr_Perfil.Pc_DeletaItensPerfil(Fc_Cd_Perfil:Integer);
Var
  Lc_Qry:TIBQuery;
Begin
  Lc_Qry := TIBQuery.Create(Self);
  with Lc_Qry do
    Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    SQL.Add('DELETE FROM TB_PERMISSAO_PERFIL '+
            'WHERE PPF_CODPFL =:PPF_CODPFL ');
    ParamByName('PPF_CODPFL').AsInteger := Fc_Cd_Perfil;
    ExecSQL;
    if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;}

end;

procedure TRegProfile.SB_PermissaoClick(Sender: TObject);
Var
  Lc_Form : TRgPrivilege;
begin
  Lc_Form := TRgPrivilege.Create(nil);
  Try
    Lc_Form.Acesso := 2;
    Lc_Form.Usuario := 0;
    Lc_Form.Perfil := perfilUsuario.Registro.codigo;
    Lc_Form.ShowModal;
  Finally
    Lc_Form.DisposeOf;
  End;
end;

procedure TRegProfile.ShowData;
begin
  with perfilUsuario do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegProfile.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegProfile.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegProfile.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
