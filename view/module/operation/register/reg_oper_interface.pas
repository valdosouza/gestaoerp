unit reg_oper_interface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, controllerOperInterface;

type
  TRegOperInterface = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    Sb_Path_Botao: TSpeedButton;
    L_Path_Imagem: TLabel;
    Sb_Carrega: TSpeedButton;
    Sb_Descarrega: TSpeedButton;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Path_Imagem: TEdit;
    GroupBox1: TGroupBox;
    Sb_Amostra: TSpeedButton;
    OpenDialogo: TOpenDialog;
    procedure Sb_Path_BotaoClick(Sender: TObject);
    procedure Sb_DescarregaClick(Sender: TObject);
    procedure Sb_CarregaClick(Sender: TObject);
    procedure SB_gravarClick(Sender: TObject);
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

    procedure Pc_carregaImagem;
    procedure Pc_DescarregaImagem;
    procedure Pc_MontaImagemBotao;
  private
    operInterface : TcontrollerOperInterface;
  end;

var
  RegOperInterface: TRegOperInterface;

implementation

uses UN_MSG, UN_Sistema;

{$R *.dfm}

procedure TRegOperInterface.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegOperInterface.ClearAllFields;
begin
  inherited;
  operInterface.clear;
end;

procedure TRegOperInterface.CriarVariaveis;
begin
  inherited;
  operInterface := TcontrollerOperInterface.create(self);
end;

procedure TRegOperInterface.Delete;
begin
  operInterface.delete;
  inherited;
end;

procedure TRegOperInterface.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(operInterface);
end;

procedure TRegOperInterface.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    operInterface.Registro.Codigo := Self.CodigoRegistro;
    operInterface.getbyId;
  End;
  inherited;
end;

procedure TRegOperInterface.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegOperInterface.Save;
begin
  with operInterface do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.PathImagem := E_Path_Imagem.Text;
    salva;
  End;
  CodigoRegistro := operInterface.Registro.Codigo;
  inherited;
end;

procedure TRegOperInterface.Sb_CarregaClick(Sender: TObject);
begin
  inherited;
  Pc_CarregaImagem;
end;

procedure TRegOperInterface.Sb_DescarregaClick(Sender: TObject);
begin
  inherited;
  Pc_DescarregaImagem;
end;

procedure TRegOperInterface.Pc_carregaImagem;
begin
  IF E_Path_Imagem.Text <> EmptyStr THEN
    Begin
    Sb_Amostra.Glyph.LoadFromFile(E_Path_Imagem.Text);
    Sb_Amostra.Caption := UCWord(E_Descricao.Text);
    end
  else
  Begin
  MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Informe um caminho valido para a imagem.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpErro);
  end;
end;

procedure TRegOperInterface.Pc_DescarregaImagem;
begin
  Sb_Amostra.Glyph.FreeImage;
end;

procedure TRegOperInterface.Pc_MontaImagemBotao;
var
  St_Image:TStream;
  Jp_IMage: TBitmap;
Begin
  Jp_IMage := nil;
  //St_Image := Tb_Oper_Interface.CreateBlobStream(Tb_Oper_Interface.FieldByName('OPF_IMAGEM'),bmRead);
  if St_Image.Size > 0 then
  begin
    Jp_IMage := TBitmap.Create;
    Jp_IMage.LoadFromStream(St_Image);
    Sb_Amostra.Glyph :=Jp_IMage;
  end
  else
  Begin
    Pc_CarregaImagem;
  end;
end;

procedure TRegOperInterface.SB_gravarClick(Sender: TObject);
begin
  inherited;
////  if Trim(E_Path_Imagem.Text) <> '' then
//    Tb_Oper_Interface.FieldByName('OPF_IMAGEM').LoadFromFile(E_Path_Imagem.Text);
end;

procedure TRegOperInterface.Sb_Path_BotaoClick(Sender: TObject);
begin
  inherited;
  if OpenDialogo.Execute then
    E_Path_Imagem.Text := OpenDialogo.FileName;
end;

procedure TRegOperInterface.ShowData;
begin
  with operInterface do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
//    E_Path_Imagem.Text  := Registro.Imagem;
    //Image1.Picture.LoadFromFile(Registro.Imagem);
  End;
  inherited;
end;

procedure TRegOperInterface.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegOperInterface.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegOperInterface.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if (E_Path_Imagem.Text <> '') then
  Begin
    if not FileExists(E_Path_Imagem.Text) then
    begin
      TMsgSetes.ErroCampo(L_Path_Imagem.Caption, 'Arquivo informado não encontrado.');
      Result := False;
      E_Path_Imagem.SetFocus;
      Exit;
    end;
  End;
end;

end.
