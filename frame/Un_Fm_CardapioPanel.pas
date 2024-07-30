unit Un_Fm_CardapioPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Data.DB, IBX.IBCustomDataSet, STQuery, Vcl.Menus, IBX.IBQuery;

type
  TFm_CardapioPanel = class(TFrame)
    Panel4: TPanel;
    Sb_Insere: TSpeedButton;
    Sb_Altera: TSpeedButton;
    Sb_Excluir: TSpeedButton;
    StrGrd_Lista: TStringGrid;
    Qr_Sabor: TSTQuery;
    Sb_Botao1: TSpeedButton;
    Sb_Botao2: TSpeedButton;
    Sb_Botao3: TSpeedButton;
    popMenuTamanho: TPopupMenu;
    procedure StrGrd_ListaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
    Grupo : Integer;
    SubGrupo  : Integer;
    function ValidaExistenciaRegistro(StrGrid:TStringGrid):Boolean;
  end;

implementation

{$R *.dfm}

uses Un_DM, Un_Msg, Un_CardapioProduto;

{ TFm_CardapioPanel }

procedure TFm_CardapioPanel.StrGrd_ListaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
   LarguraTexto, AlturaTexto, X, Y: integer;
   Texto: string;
   Lc_Lista : TStringGrid;
   Lc_Valor : Real;
begin
  with StrGrd_Lista do
  Begin
    if (arow > 0) and (acol > 0) then // testa se não é a primeira linha (fixa)
    Begin
      if (Rect.Top = TStringGrid(Lc_Lista).CellRect( aCol ,TStringGrid(Lc_Lista).Row).Top) or( gdSelected in State)  then
      begin
        Canvas.FillRect(Rect);
        Lc_Lista.Canvas.Font.Color := clBlack;
        Canvas.Brush.Color := clNavy;
      end
      else
      Begin
        Lc_Lista.Canvas.Font.Color := clBlack;
        Lc_Lista.Canvas.Brush.Color := clCream;
      end;
    end;
    Canvas.FillRect(Rect); // redesenha a celula
    Canvas.TextOut(Rect.Left + 2, Rect.Top, Cells[acol, arow]); // reimprime o texto.
    // Pega o texto da célula
    if (arow > 0) and (acol > 1) then
    Begin
      Lc_Valor := StrToFloatDef(Lc_Lista.Cells[acol, ARow],0);
      Texto :=  FloatToStrF(Lc_Valor,ffFixed,10,2) +  ' ';
    end
    else
    Begin
      Texto := Lc_Lista.Cells[acol, ARow] +  ' ';
    end;

    // Calcura largura e altura (em pontos) do texto
    LarguraTexto := Lc_Lista.Canvas.TextWidth(Texto);
    AlturaTexto := Lc_Lista.Canvas.TextHeight(Texto);

    { Calcula a posição horizontal do início do texto }
    if  (ACol = 1) then { esquerda }
      X := Rect.Left + 2
    else if  (ACol = 0) then { Centro }
      X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
    else { Direita }
      X := Rect.Right - LarguraTexto - 2;

    // Calcula a posição vertical do início do texto para
    //  que seja impresso no centro (verticalmente) da célula
    Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
    // Pinta o texto
    Canvas.TextRect(Rect, X, Y, Texto);
  End;
end;

function TFm_CardapioPanel.ValidaExistenciaRegistro(StrGrid:TStringGrid): Boolean;
Var
  Tamanho : Integer;
begin
  Result := True;
  Tamanho := Length( Trim( StrGrid.Cells[1,StrGrid.Row] ) );
  if Tamanho = 0 then
  Begin
    MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   ' Não há registro para continuar.' + EOLN +
                   ' Verifique e tente novamente.' + EOLN,
                    ['OK'], [bEscape], mpAlerta);
    REsult := False;
    exit;
  end;
end;

end.
