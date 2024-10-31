unit reg_button_image;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerBotao,
  Vcl.Samples.Spin;

type
  TRegButtonImage = class(TBaseRegistry)
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    E_codigo: TEdit;
    L_Path_Botao: TLabel;
    E_Path_Botao: TEdit;
    Sb_Load: TSpeedButton;
    Sb_Path_Botao: TSpeedButton;
    Sb_unload: TSpeedButton;
    E_Sequencia: TEdit;
    L_Sequencia: TLabel;
    L_Mrg_Botao: TLabel;
    L_Largura: TLabel;
    L_Altura: TLabel;
    E_Altura: TEdit;
    E_Largura: TEdit;
    GroupBox1: TGroupBox;
    Sb_Amostra: TSpeedButton;
    E_Label: TMemo;
    E_Mrg_Botao: TSpinEdit;
    OpenDialog: TOpenDialog;
    procedure Sb_Path_BotaoClick(Sender: TObject);
    procedure Sb_LoadClick(Sender: TObject);
    procedure Sb_unloadClick(Sender: TObject);
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
    botao : TControllerBotao;
    procedure Pc_DescarregaImagem;
    procedure Pc_PreVisualizaBotao;
    function ValidaImagem: Boolean;
    procedure Pc_carregaImagem;
  end;

var
  RegButtonImage: TRegButtonImage;

implementation

uses UN_MSG, env, un_sistema;

{$R *.dfm}

procedure TRegButtonImage.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegButtonImage.ClearAllFields;
begin
  inherited;
  botao.clear;
end;

procedure TRegButtonImage.CriarVariaveis;
begin
  inherited;
  botao := TControllerbotao.create(self);
end;

procedure TRegButtonImage.Delete;
begin
  botao.delete;
  inherited;
end;

procedure TRegButtonImage.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(botao);
end;

procedure TRegButtonImage.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    botao.Registro.Codigo := Self.CodigoRegistro;
    botao.getbyId;
  End;
  inherited;
end;

procedure TRegButtonImage.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegButtonImage.Save;
begin
  with botao do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Altura := StrToIntDef(E_Altura.Text, 0);
    Registro.Largura := StrToIntDef(E_Largura.Text, 0);
    Registro.MrgSup := E_Mrg_Botao.Value;
    Registro.Path := E_Path_Botao.Text;
    Registro.Imagem := E_Path_Botao.Text;
    Registro.Sequencia := StrToIntDef(E_Sequencia.Text, 0);
    Registro.BtnLabel := E_Label.Lines.Text;
    salva;
  End;
  CodigoRegistro := botao.Registro.Codigo;
  inherited;
end;

procedure TRegButtonImage.Sb_LoadClick(Sender: TObject);
begin
  inherited;
  Pc_DescarregaImagem;
end;

procedure TRegButtonImage.Sb_Path_BotaoClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
  begin
    //Tb_BotaoBTN_PATH.AsString := OpenDialog.FileName;
    E_Path_Botao.Text := OpenDialog.FileName;
  end;
end;

procedure TRegButtonImage.Sb_unloadClick(Sender: TObject);
begin
  inherited;
  Pc_CarregaImagem;
end;

procedure TRegButtonImage.ShowData;
begin
  with botao do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_Altura.Text := IntToStr(Registro.Altura);
    E_Largura.Text := IntToStr(Registro.Largura);
    E_Mrg_Botao.Value := Registro.MrgSup;
    E_Path_Botao.Text := Registro.Path;
  //  E_Sequencia.Text := Registro.Sequencia;
    e_Label.Lines.Text := Registro.BtnLabel;
  End;
  Pc_PreVisualizaBotao;
  inherited;
end;

procedure TRegButtonImage.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegButtonImage.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegButtonImage.ValidateSave: boolean;
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

function TRegButtonImage.ValidaImagem: Boolean;
begin
  Result := True;
  IF E_Path_Botao.Text = EmptyStr THEN
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'Informe um caminho valido para a imagem.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Path_Botao.Clear;
    Result := FAlse;
    exit;
  End;

  IF not FileExists(E_Path_Botao.Text)  THEN
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O Arquivo informado não foi encontrado.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Path_Botao.Clear;
    Result := FAlse;
    exit;
  End;

  IF UpperCase(Copy(E_Path_Botao.Text,Length(E_Path_Botao.Text)-2,4)) <> 'BMP' THEN
  Begin
    MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                   'O formato do Arquivo deve ser BMP(Bitmap).'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    E_Path_Botao.Clear;
    Result := FAlse;
    exit;
  End;
end;

procedure TRegButtonImage.Pc_carregaImagem;
begin
  if E_Path_Botao.Text <> EmptyStr then
  begin
    Sb_Amostra.Glyph.LoadFromFile(E_Path_Botao.Text);
    Sb_Amostra.Caption := UCWord(E_Descricao.Text);
  end
  else
  begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Informe um caminho valido para a imagem.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TRegButtonImage.Pc_DescarregaImagem;
Begin
  Sb_Amostra.Glyph.FreeImage;
end;

procedure TRegButtonImage.Pc_PreVisualizaBotao;
Begin
  //Define a altura do Botão
  E_Label.Top := 16;
  E_Label.Left := 6;
  E_Label.Height := StrToIntDef(E_Altura.text,50);
  E_Label.Width := StrToIntDef(E_Largura.text,50);

  //Define a Largura do Botão

  Sb_Amostra.Top := 16;
  Sb_Amostra.Left := E_Label.Width + 10;
  Sb_Amostra.Height := StrToIntDef(E_Altura.text,50);
  Sb_Amostra.Width := StrToIntDef(E_Largura.text,50);

  if (trim(E_Label.Text) <> '') then
    Sb_Amostra.Caption := E_Label.Text
  else
    Sb_Amostra.Caption := '';
end;

end.
