unit rg_privilege;

interface


uses
  STQuery, Data.DB, Vcl.DBCtrls,ControllerPermission,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Controls, Classes,Un_Base,
  Vcl.ExtCtrls, Vcl.Forms, SysUtils, Vcl.Graphics, Winapi.Messages,FireDAC.Stan.Param,
  Winapi.Windows, STStoredProc, Vcl.Grids, Vcl.DBGrids, Vcl.CheckLst,
  Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.Menus;

type
  TRgPrivilege = class(TFr_Base)
    Qr_Modulo: TSTQuery;
    Ds_Modulo: TDataSource;
    Qr_Menu: TSTQuery;
    Ds_Menu: TDataSource;
    Qr_ItemMenu: TSTQuery;
    Ds_Interface: TDataSource;
    Ds_Permissao: TDataSource;
    ChkBx_Permissao: TCheckListBox;
    Qr_Permissao: TSTQuery;
    Sb_Menus: TSpeedButton;
    Sb_Interno: TSpeedButton;
    Dbg_Modulo: TDBGrid;
    Dbg_Menu: TDBGrid;
    pnl_bottom: TPanel;
    SB_Sair_0: TSpeedButton;
    SB_Aplicar: TSpeedButton;
    Sb_Limpar: TSpeedButton;
    Grp_Perfil: TGroupBox;
    Label1: TLabel;
    Sb_AplicarPerfil: TSpeedButton;
    Sb_SalvaPerfil: TSpeedButton;
    DBLCB_Perfil: TDBLookupComboBox;
    pnl_body: TPanel;
    pnl_interface: TPanel;
    Dbg_Interfaces: TDBGrid;
    Qr_Perfil: TSTQuery;
    Ds_Perfil: TDataSource;
    procedure SB_Sair_0Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_AplicarClick(Sender: TObject);
    procedure ChkBx_PermissaoClick(Sender: TObject);
    procedure Sb_SalvaPerfilClick(Sender: TObject);
    procedure Sb_AplicarPerfilClick(Sender: TObject);
    procedure Qr_ItemMenuBeforeScroll(DataSet: TDataSet);
    procedure Sb_LimparClick(Sender: TObject);
    procedure Dbg_MenuCellClick(Column: TColumn);
    procedure Sb_MenusClick(Sender: TObject);
    procedure Sb_InternoClick(Sender: TObject);
    procedure Dbg_ModuloCellClick(Column: TColumn);
    procedure Dbg_InterfacesCellClick(Column: TColumn);
  private
    FPerfil: Integer;
    FAcesso: Integer;
    FUsuario: Integer;
    procedure AtivaMenus;
    procedure AtivaInterface;
    procedure CarregaPermissao;
    procedure ConferePermissao;
    function ValidaSAlvaPerfil:Boolean;
    procedure SalvaPerfil;
    procedure AplicaNovoPerfil;
    procedure AplicaPermissao;
    procedure LimpaOperacaoInterface;
    procedure setFAcesso(const Value: Integer);
    procedure setFUsuario(const Value: Integer);
    procedure setPerfil(const Value: Integer);
  protected
    Permissao : TControllerPermission;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure ShowData;
  public
    { Public declarations }
    property Usuario : Integer read FUsuario write setFUsuario;
    property Perfil : Integer read FPerfil write setPerfil;
    property Acesso : Integer read FAcesso write setFAcesso;
  end;

var
  RgPrivilege: TRgPrivilege;

implementation

uses Un_Msg, Un_DM, env,unFunctions;


{$R *.dfm}


procedure TRgPrivilege.SB_Sair_0Click(Sender: TObject);
begin
  if SB_Aplicar.Enabled  then
    begin
      if MessageDlg('Houve alteração na(s) permissães. Deseja salvar as alterações?', mtConfirmation,  [mbYes,mbNo] ,0)  = IDYES then
        SB_AplicarClick(self)
       ELSE
         SB_Aplicar.Enabled:=FALSE;
    end;
  close;
end;

procedure TRgPrivilege.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if shift = [] then
  begin
    case Key of
      VK_F4     : if Sb_AplicarPerfil.Enabled then Sb_AplicarPerfilClick(Sender);
      VK_F5     : if Sb_SalvaPerfil.Enabled   then Sb_SalvaPerfilClick(Sender);
      VK_F10    : if Sb_Limpar.Enabled        then Sb_LimparClick(Sender);
      VK_F11    : if SB_Aplicar.Enabled       then SB_AplicarClick(Sender);
      VK_Escape : if SB_Sair_0.Enabled        then Sb_Sair_0Click(Sender);
    end;
  end;
end;

procedure TRgPrivilege.SB_AplicarClick(Sender: TObject);
begin
  AplicaPermissao;
  SB_Aplicar.Enabled:=False;
end;

procedure TRgPrivilege.ChkBx_PermissaoClick(Sender: TObject);
begin
  SB_Aplicar.Enabled:=True;
end;

procedure TRgPrivilege.AplicaPermissao;
var
  I: Integer;
  Lc_Codigo: Integer;
begin
  for I := 0 to ChkBx_Permissao.Count -1 do
  begin
    Lc_Codigo := StrToIntDef(Copy(ChkBx_Permissao.Items.Strings[I],1,5),0);
    if ChkBx_Permissao.Checked[I] then
    begin
      case FAcesso of
        1:Begin
            Permissao.Registro.Estabelecimento := Gb_CodMha;
            Permissao.Registro.Usuario := FUsuario;
            Permissao.Registro.Privilegio := Lc_Codigo;
            Permissao.replace;
        End;
        2:Begin
            Permissao.Profile.Registro.Perfil     := FPerfil;
            Permissao.Profile.Registro.Privilegio := Lc_Codigo;
            Permissao.Profile.replace;
        End;
      end;
    end
    else
    begin
      case FAcesso of
        1:Begin
            Permissao.Registro.Estabelecimento := Gb_CodMha;
            Permissao.Registro.Usuario := FUsuario;
            Permissao.Registro.Privilegio := Lc_Codigo;
            Permissao.delete;
        End;
        2:Begin
            Permissao.Profile.Registro.Perfil     := FPerfil;
            Permissao.Profile.Registro.Privilegio := Lc_Codigo;
            Permissao.Profile.delete;
        End;
      end;
    end;
  end;
end;


procedure TRgPrivilege.AtivaInterface;
Begin
  with Qr_ItemMenu do
  Begin
    Active := False;
    ParamByName('MNU_CODIGO').AsInteger :=  Qr_Menu.FieldByName('MNU_CODIGO').AsInteger;
    if not Sb_Menus.Enabled then
      ParamByName('IFC_MENU').asAnsiString := 'S'
    else
      ParamByName('IFC_MENU').asAnsiString := 'N';
    Active := True;
  End;
  ChkBx_Permissao.Items.Clear;
  CarregaPermissao;
  ConferePermissao;
End;

procedure TRgPrivilege.AtivaMenus;
Begin
  with Qr_Menu do
  Begin
    Active := False;
    ParamByName('MOD_CODIGO').AsInteger := Qr_Modulo.FieldByName('MOD_CODIGO').AsInteger;
    Active := True;
  End;
  ChkBx_Permissao.Items.Clear;
  AtivaInterface;
End;

procedure TRgPrivilege.IniciaVariaveis;
begin
  ShowData;
end;


procedure TRgPrivilege.LimpaOperacaoInterface;
var
  I: Integer;
begin
  for  I := 0 to ChkBx_Permissao.Count -1 do
  begin
    ChkBx_Permissao.Checked[I] := False;
  end;
end;

procedure TRgPrivilege.CarregaPermissao;
Var
  I : Integer;
  Lc_Descricao : String;
begin
  with Permissao.ItensInterface do
  Begin
    Parametros.FieldName.CodigoInterface := Qr_ItemMenu.FieldByName('IFC_CODIGO').AsInteger;
    search;
    ChkBx_Permissao.Items.Clear;
    for I := 0 to Lista.Count -1 do
    begin
      Lc_Descricao := StrZero(Lista[I].Codigo,5,0) +'-'+ Lista[I].DescricaoOperacao;
      ChkBx_Permissao.Items.Add(Lc_Descricao);
      Next;
    end;
  End;
end;

procedure TRgPrivilege.ConferePermissao;
var
  Lc_I: Integer;
  Lc_Codigo: Integer;
begin
  LimpaOperacaoInterface;
  for  Lc_I := 0 to ChkBx_Permissao.Count -1 do
  begin
    Lc_Codigo := StrToIntDef(Copy(ChkBx_Permissao.Items.Strings[Lc_I],1,5),0);
    case FAcesso of
      1:begin
          Permissao.Parametros.FieldName.Privilegio := Lc_Codigo;
          Permissao.Parametros.FieldName.Usuario    := FUsuario;
          Permissao.Parametros.Estabelecimento := Gb_CodMha;
          ChkBx_Permissao.Checked[Lc_I] := Permissao.getPrivilege;
        end;
      2:begin
          Permissao.Profile.Parametros.FieldName.Perfil := FPerfil;
          Permissao.Profile.Parametros.FieldName.Privilegio    := Lc_Codigo;
          ChkBx_Permissao.Checked[Lc_I] := Permissao.Profile.getPrivilege;
        end;
    end;
  end;
end;


procedure TRgPrivilege.CriarVariaveis;
begin
  inherited;
  Permissao := TControllerPermission.Create(self);
end;

procedure TRgPrivilege.FinalizaVariaveis;
begin
  FreeAndNil(Permissao);
  inherited;
end;

procedure TRgPrivilege.Dbg_InterfacesCellClick(Column: TColumn);
begin
  CarregaPermissao;
  ConferePermissao;
end;

procedure TRgPrivilege.Dbg_MenuCellClick(Column: TColumn);
begin
  AtivaInterface;
end;

procedure TRgPrivilege.Dbg_ModuloCellClick(Column: TColumn);
begin
  AtivaMenus;
end;

procedure TRgPrivilege.SalvaPerfil;
var
  I : Integer;
begin
  Permissao.UserProfile.Registro.Codigo := 0;
  Permissao.UserProfile.Registro.CodMha := Gb_CodMha;
  //Permissao.UserProfile.Registro.Descricao := informado na validação
  Permissao.UserProfile.insert;
  //Seleciona as permissoes do usuario atual
  Permissao.Parametros.FieldName.Usuario := FUsuario;
  Permissao.Parametros.FieldName.Privilegio := 0;
  Permissao.Search;
  for I := 0 to Permissao.Lista.Count -1 do
  Begin
    //Registra os privilegio para este perfil
    Permissao.Profile.Registro.Perfil := Permissao.UserProfile.Registro.Codigo;
    Permissao.Profile.Registro.Privilegio := Permissao.Lista[I].Privilegio;
    Permissao.Profile.replace;
  end;
end;

procedure TRgPrivilege.AplicaNovoPerfil;
var
  Lc_Perfil: String;
  I : Integer;
begin
  Lc_Perfil := DBLCB_Perfil.Text;
  if Lc_Perfil <> '' then
  Begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Dseja Aplicar este perfil às permissães deste usuário?.' + EOLN + EOLN +
                       'As permissães seráo todas redfinidas, deseja continuar?',
                       [SIM, NAO], [bEscape, bNormal], mpConfirmacao, clRed) = mrBotao1) then
    Begin
      //Apaga as permissães atuais
      Permissao.Registro.Usuario := FUsuario;
      Permissao.deletebyUser;

      //Seleciona os privilegios do perfil
      Permissao.Profile.Parametros.FieldName.Perfil := DBLCB_Perfil.KeyValue;
      Permissao.Profile.search;
      for I := 0 to Permissao.Profile.Lista.Count -1 do
      Begin
        Permissao.Registro.Estabelecimento := Gb_CodMha;
        Permissao.Registro.Usuario         := FUsuario;
        Permissao.Registro.Privilegio      := Permissao.Profile.Lista[I].Privilegio;
        Permissao.replace;
      End;
    end;
  End
  else
    begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                    'Por favor escolha um perfil.!!!.'+EOLN+
                    'Tente Novamente...'+EOLN,
                    ['OK'],[bEscape],mpErro);

    end;
end;

procedure TRgPrivilege.Sb_SalvaPerfilClick(Sender: TObject);
begin
  if ValidaSAlvaPerfil then
    SalvaPerfil;
end;

procedure TRgPrivilege.setFAcesso(const Value: Integer);
begin
  FAcesso := Value;
end;

procedure TRgPrivilege.setFUsuario(const Value: Integer);
begin
  FUsuario := Value;
end;

procedure TRgPrivilege.setPerfil(const Value: Integer);
begin
  FPerfil := Value;
end;

procedure TRgPrivilege.ShowData;
begin
  Grp_Perfil.Visible := (FAcesso = 1);
  Qr_Modulo.Active := True;
  Qr_Perfil.Active := True;
  Qr_Perfil.FetchAll;
  AtivaMenus;
  AtivaInterface;
  CarregaPermissao;
  ConferePermissao;
end;

function TRgPrivilege.ValidaSAlvaPerfil: Boolean;
Var
  Lc_Perfil : String;
begin
  Result := True;
  Lc_Perfil := InputBox('Salvar Perfil','Nome do Perfil','');

  if Lc_Perfil = '' then
  begin
    TMsgSetes.ValidaPreenchimentoCampo('Nome do Perfil');
    Result := False;
    Exit;
  end;

  Permissao.UserProfile.Parametros.FieldName.Descricao := Lc_Perfil;
  Permissao.UserProfile.Search;
  if Permissao.UserProfile.Lista.Count > 0 then
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'JÁ existe este Perfil..!!!.'+EOLN+
                   'Tente Novamente...'+EOLN,
                   ['OK'],[bEscape],mpErro);
    Result := False;
    Exit;
  End
  else
  Begin
    Permissao.UserProfile.Registro.Descricao := Lc_Perfil;
  End;
end;

procedure TRgPrivilege.Sb_AplicarPerfilClick(Sender: TObject);
begin
  AplicaNovoPerfil;
  CarregaPermissao;
  ConferePermissao;
end;


procedure TRgPrivilege.Sb_InternoClick(Sender: TObject);
begin
  AtivaInterface;
  Sb_Menus.Enabled := True;
  Sb_Interno.Enabled := False;
end;

procedure TRgPrivilege.Qr_ItemMenuBeforeScroll(DataSet: TDataSet);
begin
  if SB_Aplicar.Enabled  then
  begin
    if MessageDlg('Houve alteração na(s) permissães. Deseja salvar as alterações?', mtConfirmation,  [mbYes,mbNo] ,0)  = IDYES then
      SB_AplicarClick(self)
    else
      SB_Aplicar.Enabled:=FALSE;
  end;
end;


procedure TRgPrivilege.Sb_LimparClick(Sender: TObject);
begin
  if (MensagemPadrao(TITULO_CONFIRMACAO,
                     'Limpar todas as permissães deste usuário.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
    try
      Permissao.Registro.Usuario := FUsuario;
      Permissao.deletebyUser;
      LimpaOperacaoInterface;
    except
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
end;

procedure TRgPrivilege.Sb_MenusClick(Sender: TObject);
begin
  AtivaInterface;
  Sb_Menus.Enabled := False;
  Sb_Interno.Enabled := True;
end;

end.


