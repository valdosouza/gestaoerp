unit UN_MSG;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, FavoritoButtons;

{Definicao dos tipos}
type
  TMsgPadrao = (mpAlerta, mpErro, mpConfirmacao, mpInformacao);
  TMsgEscape = (bEscape,bNormal);

const
  EOLN=chr(13)+chr(10);   //Usado para fazer fim de linha nos quadros de mensagens
  mrBotao1 = 0;
  mrBotao2 = 1;
  mrBotao3 = 2;
  mrBotao4 = 3;
  mrBotao5 = 4;
  mrBotao6 = 5;

  SIM = 'S';
  NAO = 'N';

  OPCOES_SIM = 'SIM';
  OPCOES_NAO = 'NÃO';
  OPCOES_OK = 'OK';

  TITULO_ERRO = 'Mensagem de erro';
  TITULO_CONFIRMACAO = 'Mensagem de Confirmação';

  function Mensagem(const Titulo, Msg: string;
                        Opcoes : array of string;
                        BotaoEscape : array of TMsgEscape;
                        TipoPadrao : TMsgPadrao;
                        Lc_Cor : TColor = clBtnFace) : Integer;

  function MensagemPararExecucao(info:String): Integer;
  function MensagemcConfirmaAcao(info:String): Integer;

  type
    TFormMsg = class(TForm)
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
    private
      procedure Pc_Aciona_Escolha(Sender: TObject);
    public
  end;

  TMsg = class
  public
    class function ValidaPreenchimentoCampo(Campo: String): Integer;
    class function ErroCampo(Campo,info: String): Integer;
    class function Excluir: Integer;
  end;

Var
  It_Cd_Escolha : Integer;
implementation


// Mensagem Padrao  - Utilizado para calcular o tamanho padrao de um caracter
function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

{Mensagem Padrao - Retorna o maior de dois valores}
function Max(I, J: Integer): Integer;
begin
  if I > J then Result := I else Result := J;
end;

procedure TFormMsg.Pc_Aciona_Escolha(Sender: TObject);
begin
  It_Cd_Escolha := TBitBtn(Sender).Tag;
  Close;
end;


procedure TFormMsg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TFormMsg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
  begin
    It_Cd_Escolha := -1;
    Close;
  end;
end;

function MensagemValidaPreenchimentoCampo(Campo: String): Integer;
var
  Msg: String;
begin
  Msg :=  'A T E N Ç Ã O!' + EOLN + EOLN +
          'O Campo "'+Campo+'" não foi informado.' + EOLN +
          'Preencha para continuar.' + EOLN;
  Result := Mensagem(TITULO_ERRO, Msg, [OPCOES_OK],[bEscape], mpAlerta, clBtnFace);
end;

function MensagemErroCampo(Campo,info: String): Integer;
var
  Msg: String;
begin
  Msg := 'A T E N Ç Ã O!' + EOLN + EOLN +
         'Verifique o Campo "'+Campo+'".' + EOLN +
         info + EOLN +
         'Preencha para continuar.' + EOLN;
  Result := Mensagem(TITULO_ERRO, Msg, [OPCOES_OK],[bEscape], mpErro, clRed);
end;

function MensagemExcluir(): Integer;
var
  Msg: String;
begin
  Msg := 'Deseja excluir este item?' + EOLN + EOLN +
         'Confirmar a exclusão?';
  Result := Mensagem(TITULO_CONFIRMACAO, Msg, [OPCOES_SIM, OPCOES_NAO],[bEscape, bNormal], mpConfirmacao, clRed);
end;

function MensagemPararExecucao(info:String): Integer;
var
  Msg: String;
begin
  Msg := 'A T E N Ç Ã O!' + EOLN + EOLN +
          info + EOLN +
          'Verifique antes de continuar.' + EOLN;
  Result := Mensagem( TITULO_ERRO, Msg, [OPCOES_OK],[bEscape], mpAlerta, clBtnFace);
end;

function MensagemcConfirmaAcao(info:String): Integer;
var
  Msg: String;
begin
  Msg := 'C O N F I R M A Ç Ã O!' + EOLN + EOLN +
          info + EOLN;
  Result := Mensagem( TITULO_ERRO, Msg, [SIM,NAO],[bNormal, bEscape], mpAlerta, clBtnFace);
end;

function Mensagem(const Titulo, Msg: string;
                        Opcoes : array of string;
                        BotaoEscape : array of TMsgEscape; TipoPadrao : TMsgPadrao;
                        Lc_Cor : TColor = clBtnFace) : Integer;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 18;
  mcButtonSpacing = 4;
  EOLN=chr(13)+chr(10);   //Usado para fazer fim de linha nos quadros de mensagens
  IconIDs: array[TMsgPadrao] of PChar = (IDI_EXCLAMATION, IDI_HAND, IDI_QUESTION, IDI_ASTERISK);
var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X: Integer;
  IconID: PChar;
  TextRect: TRect;
  Lc_Idx : Integer;
  MaiorTamanho : Integer;
  Formulario : TFormMsg;
  Lc_OldCursor : TCursor;  {Formato do cursor antes de chamar a mensagem}
begin
  {Muda do cursor que esta no momento para o cursor Default}
  Lc_OldCursor := Screen.Cursor;
  Screen.Cursor := crDefault;
  Formulario := TFormMsg.CreateNew(Application);
  Try
    {Ajusta os parametros do formulario que acabou de ser criado!}
    with Formulario do
    begin
      FormStyle     := fsStayOnTop;
      OnKeyPress    := FormKeyPress;
      OnClose       := FormClose;
      BorderStyle   := bsDialog;
      BorderIcons   := [];
      Canvas.Font   := Font;
      DialogUnits   := GetAveCharSize(Canvas);
      HorzMargin    := MulDiv(mcHorzMargin, DialogUnits.X, 4);
      VertMargin    := MulDiv(mcVertMargin, DialogUnits.Y, 8);
      HorzSpacing   := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
      VertSpacing   := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
      ButtonHeight  := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
      ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
      Position := poScreenCenter;
      KeyPreview := True;
      //Muda o estilo da fonte para bold, apenas para realizar os cálculos
      Font.Style := [fsBold];
      Color      := Lc_Cor;
      Font.Color := clBlack;
      case Color of
        clBtnFace: Font.Color := clBlack;
        clRed    : Font.Color := clWhite;
        clGreen  : Font.Color := clWhite;
        clBlue   : Font.Color := clYellow;
        clBlack  : Font.Color := clYellow;
        clTeal   : Font.Color := clYellow;
        clWhite  : Font.Color := clnavy;
        clInfoBk : Font.Color := clnavy;
        clYellow : Font.Color := clnavy;
        clNavy   : Font.Color := clYellow;
      end;
      SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
      DrawText(Canvas.Handle, PChar(Msg), -1, TextRect, DT_CALCRECT or DT_WORDBREAK);
      Font.Style := [];

      IconID := IconIDs[TipoPadrao];
      IconTextWidth  := TextRect.Right;
      IconTextHeight := TextRect.Bottom;
      if IconID <> nil then
      begin
        Inc(IconTextWidth, 48 + HorzSpacing);
        if IconTextHeight < 48 then
          IconTextHeight := 48;
      end;

      MaiorTamanho := 0;
      ButtonCount := 0;
      for Lc_Idx := 0 to High(Opcoes) do
      begin
        if Canvas.TextWidth(Opcoes[Lc_Idx]) > MaiorTamanho then
          MaiorTamanho := Canvas.TextWidth(Opcoes[Lc_Idx]);
        ButtonCount := ButtonCount + 1;
      end;
      {Calcula a largura do botao}
      if MaiorTamanho < mcButtonWidth then
        MaiorTamanho := mcButtonWidth;
      repeat
        MaiorTamanho := MaiorTamanho - 10;
        ButtonWidth := MulDiv(MaiorTamanho, DialogUnits.X, 4);
        if ButtonWidth = 0 then ButtonWidth := 50;

        ButtonGroupWidth := 0;
        if ButtonCount <> 0 then
          ButtonGroupWidth := ButtonWidth * ButtonCount + ButtonSpacing * (ButtonCount - 1);
      until ButtonGroupWidth <= 600;

      {Define o tamanho do formulario}
      ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
      ClientHeight := IconTextHeight + ButtonHeight + VertSpacing + VertMargin * 2;

      {Mostra o titulo no formulario}
      Caption := Titulo;

      {Coloca a imagem no formulario}
      if IconID <> nil then
      begin
        with TImage.Create(Formulario) do
        begin
          Name := 'Image';
          Parent := Formulario;
          Picture.Icon.Handle := LoadIcon(0, IconID);
          SetBounds(HorzMargin, VertMargin, 48, 48);
        end;
      end;

      {Escreve a mensagem no formulário}
      with TLabel.Create(Formulario) do
      begin
        Name := 'Message';
        Parent := Formulario;
        AutoSize := True;
        WordWrap := True;
        Caption := Msg;
        Font.Style := [fsBold];   //Ajusta a fonte para bold, pode vazar para fora
        BoundsRect := TextRect;
        SetBounds(IconTextWidth - TextRect.Right + HorzMargin, VertMargin,
        TextRect.Right, TextRect.Bottom);
      end;

      {Coloca os botoes no formulario}
      X := (ClientWidth - ButtonGroupWidth) div 2;
      for Lc_Idx := 0 to High(Opcoes) do
      begin
        with TBitBtn.Create(Formulario) do
        begin
          Parent := Formulario;
          ParentBackground := False;
          ParentColor := False;
          ParentFont := False;
          Font.Style := [];
          Font.Color :=clBlack;
          if (copy(Opcoes[Lc_Idx],1,5) = 'https') then
          Begin
            //Glyph := Fr_Principal.Img_Youtube.Picture.Bitmap;
          end
          else
          Begin
            Caption := Opcoes[Lc_Idx];
          end;
          Tag := Lc_Idx;
          OnClick := Pc_Aciona_Escolha;

          if (BotaoEscape[Lc_Idx] = bEscape) then
          begin
            TabOrder := 0;
          end;
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing, ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);
        end;
      end;
    end;

    Formulario.ShowModal;
    Result :=It_Cd_Escolha;
  finally
    {Retorna ao cursor que estava anteriormente}
    Screen.Cursor := Lc_OldCursor;
    //libera o formulario
    Formulario.disposeOf;;
  end;
end;

{ TMsg }

class function TMsg.ValidaPreenchimentoCampo(Campo: String): Integer;
var
  Msg: String;
begin
  Msg :=  'A T E N Ç Ã O!' + EOLN + EOLN +
          'O Campo "'+Campo+'" não foi informado.' + EOLN +
          'Preencha para continuar.' + EOLN;
  Result := Mensagem(TITULO_ERRO, Msg, [OPCOES_OK],[bEscape], mpAlerta, clBtnFace);
end;

class function TMsg.ErroCampo(Campo,info: String): Integer;
var
  Msg: String;
begin
  Msg := 'A T E N Ç Ã O!' + EOLN + EOLN +
         'Verifique o Campo "'+Campo+'".' + EOLN +
         info + EOLN +
         'Preencha para continuar.' + EOLN;
  Result := Mensagem(TITULO_ERRO, Msg, [OPCOES_OK], [bEscape], mpErro, clRed);
end;

class function TMsg.Excluir: Integer;
var
  Msg: String;
begin
  Msg := 'Deseja excluir este item?' + EOLN + EOLN +
         'Confirmar a exclusão?';
  Result := Mensagem(TITULO_CONFIRMACAO, Msg, [OPCOES_NAO, OPCOES_SIM], [bEscape, bNormal], mpConfirmacao, clRed);
end;

end.
