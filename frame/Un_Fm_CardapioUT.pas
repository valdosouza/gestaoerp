unit Un_Fm_CardapioUT;
//Cada produto criado teré apenas um tamanho em lista simples
interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_CardapioPanel, Vcl.Grids,
  ControllerPreco, Un_Principal,env, Un_Crp_Itens, Vcl.Menus;

type
  TFm_CardapioUT = class(TFrame)
    Fm_Cardapio: TFm_CardapioPanel;
    procedure IniciaVariaveis;
    procedure AbreListaSabor;
    procedure MontaGradeSabor;
    procedure PreencheGradesabor;
    procedure InsereSabor;
    function ValidaAlteraSabor:Boolean;
    procedure AlteraSabor;
    procedure Fm_CardapioPanel1Sb_InsereClick(Sender: TObject);
    procedure Fm_CardapioStrGrd_ListaDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Fm_CardapioStrGrd_ListaSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure Fm_CardapioSb_InsereClick(Sender: TObject);
    procedure Fm_CardapioSb_AlteraClick(Sender: TObject);
    procedure Fm_CardapioSb_ExcluirClick(Sender: TObject);
    procedure Fm_CardapioSb_Botao1Click(Sender: TObject);
    procedure Fm_CardapioSb_Botao2Click(Sender: TObject);
    procedure Fm_CardapioSb_Botao3Click(Sender: TObject);
  private
    { Private declarations }
    function ValidaInsereRecheio:Boolean;
  public
    { Public declarations }
    Grupo : Integer;
    SubGrupo : Integer;
    MedidaEspecial : String;
    Function ValidaExcluiSabor:boolean;
    procedure ExcluiSabor;
    procedure AtualizaPreco;
  end;

implementation

{$R *.dfm}

uses Un_CardapioProduto, Un_Regra_Negocio, UN_Sistema, ControllerCardapio,
  Un_Msg, Un_Fm_CardapioMT;

procedure TFm_CardapiouT.IniciaVariaveis;
begin
  with Fm_Cardapio do
  Begin
    AbreListaSabor;
    MontaGradeSabor;
    PreencheGradeSabor;
  End;
end;


procedure TFm_CardapioUT.InsereSabor;
Var
  Form : TFr_CardapioProduto;
begin
  Try
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'I';
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := '';
      Cardapio.Registro.CodigoGrupo := GRupo;
      Cardapio.Registro.CodigoSubGrupo := SubGrupo;
      Cardapio.Registro.MedidaComercial := 0;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;

end;

procedure TFm_CardapioUT.AbreListaSabor;
begin
  with Fm_Cardapio.Qr_Sabor do
  Begin
    Active := False;
    ParamByName('SBG_CODIGO').AsInteger := SubGrupo;
    Active := True;
  end;
end;

procedure TFm_CardapioUT.MontaGradeSabor;
Var
  I:Integer;
begin
  with  Fm_Cardapio.StrGrd_Lista,Fm_Cardapio.Qr_Sabor do
  Begin
    ColWidths[0] := 17;
    ColWidths[1] := 70;
    ColWidths[2] := 260;
    ColWidths[3] := 140;
    ColWidths[4] := 140;
    Cols[1].Add('Código');
    Cols[2].Add('Descrição');
    Cols[3].Add('Preço Normal');
    Cols[4].Add('Preço Promoção');
  end;
end;

procedure TFm_CardapioUT.PreencheGradesabor;
Var
  I : Integer;
  Lc_registro : Integer;
begin
  Pc_LimpaStringGrid(Fm_Cardapio.StrGrd_Lista);
  with  Fm_Cardapio.StrGrd_Lista,Fm_Cardapio.Qr_Sabor do
  Begin
    I := 1;
    First;
    ColCount := 5;
    Lc_registro := 0;
    First;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      //codigo do produto
      Cells[1,I] := FieldByName('PRO_CODIGO').AsString;
      //Descrição da produto
      Cells[2,I] := FieldByName('PRO_DESCRICAO').AsString;
      //Preço Normal
      Cells[3,I] := FloatToStrF( FieldByName('PRO_VL_NORMAL').AsFloat,ffFixed,10,2);
      //Preço Promoção
      Cells[4,I] := FloatToStrF( FieldByName('PRO_VL_PROMOCAO').AsFloat,ffFixed,10,2);
      Inc(I);
      Next;
    end;
  end;
end;

procedure TFm_CardapioUT.AlteraSabor;
Var
  Form : TFr_CardapioProduto;
begin
  TRy
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'U';
      Cardapio.Registro.CodigoEstabelecimento := Gb_CodMha;
      with Fm_Cardapio.StrGrd_Lista do
      Begin
        Cardapio.Registro.Codigo := StrToIntDef( Cells[1,Row],0);
        Cardapio.Registro.Descricao := '';
        Cardapio.PrecoNormal := StrToFloatDef(Cells[3,Row] , 0);
        Cardapio.PrecoPromocao := StrToFloatDef(Cells[4,Row] , 0);
      End;
      Cardapio.Registro.CodigoGrupo := GRupo;
      Cardapio.Registro.CodigoSubGrupo := SubGrupo;
      Cardapio.Registro.MedidaComercial := 0;
      Cardapio.getbyId;
      Cardapio.Old_Descricao := Cardapio.Registro.Descricao;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;

end;


function TFm_CardapioUT.ValidaAlteraSabor: Boolean;
begin
  Result := True;
  with Fm_Cardapio do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
end;


procedure TFm_CardapioUT.Fm_CardapioPanel1Sb_InsereClick(Sender: TObject);
begin
  InsereSabor;
end;

procedure TFm_CardapioUT.Fm_CardapioSb_AlteraClick(Sender: TObject);
begin
  if ValidaAlteraSabor then
  Begin
    AlteraSabor;
    AbreListaSabor;
    PreencheGradeSabor;
  End;
end;

procedure TFm_CardapioUT.AtualizaPreco;
Var
  I : Integer;
  Lc_Preco : TControllerPreco;
begin
  Try
    Lc_Preco := TControllerPreco.Create(Self);
    with Fm_Cardapio.StrGrd_Lista do
    Begin
      for I := 1 to (RowCount - 1) do
      Begin
        if StrToIntDef( Cells[1,I],0) > 0 then
        Begin
          //Normal
          Lc_Preco.Clear;
          Lc_Preco.Registro.CodigoTabela := 1;
          Lc_Preco.Registro.CodigoProduto := StrToIntDef(Cells[1,I],0);
          Lc_Preco.Registro.Valor := StrToFloatDef(Cells[3,I],0);
          Lc_Preco.salva;
          //Promoção
          Lc_Preco.Clear;
          Lc_Preco.Registro.CodigoTabela := 2;
          Lc_Preco.Registro.CodigoProduto := StrToIntDef(Cells[1,I],0);
          Lc_Preco.Registro.Valor :=  StrToFloatDef(Cells[4,I],0);
          Lc_Preco.salva;
        End;
      End;
    End;
  Finally
    FreeAndNil(Lc_Preco);
  End;
end;

procedure TFm_CardapioUT.Fm_CardapioSb_Botao1Click(Sender: TObject);
begin
  AtualizaPreco;
  AbreListaSabor;
  PreencheGradeSabor;

end;

procedure TFm_CardapioUT.Fm_CardapioSb_Botao2Click(Sender: TObject);
var
  Lc_Form: TFr_Crp_Itens;
Begin
  if ValidaInsereRecheio then
  Begin
    Try
      Lc_Form := TFr_Crp_Itens.Create(Self);
      with Lc_Form,Fm_Cardapio do
      Begin
        Lc_Form.CodigoGrupo           := Fm_Cardapio.GRupo;
        CardapioItens.Registro.Sabor  := StrGrd_Lista.Cells[1,StrGrd_Lista.Row];
        Caption := 'Recheio(s) para o Sabor - ' + CardapioItens.Registro.Sabor;
        CardapioItens.Registro.Tipo   := 'P';
        E_Vl_Extra.Text               := '0,00';
        E_Vl_Extra.ReadOnly           := True;
        E_Vl_Extra.TabStop            := False;
        ShowModal;
      End;
    Finally
      FreeAndNil(Lc_Form);
    End;
  End;


end;

procedure TFm_CardapioUT.Fm_CardapioSb_Botao3Click(Sender: TObject);
var
  Lc_Form: TFr_Crp_Itens;
Begin
  if ValidaInsereRecheio then
  Begin
    Try
      Lc_Form := TFr_Crp_Itens.Create(nil);
      with Lc_Form,Fm_Cardapio do
      Begin
        CardapioItens.Registro.Sabor := 'TODOS';
        Caption := 'Opções de recheio(s) para o todos Sabores ';
        CardapioItens.Registro.Tipo := 'O';
        E_Vl_Extra.Text := '0,00';
        E_Vl_Extra.ReadOnly := False;
        E_Vl_Extra.TabStop := True;
        ShowModal;
      End;
    Finally
      Lc_Form.DisposeOf;
    End;
  End;
end;

Function TFm_CardapioUT.ValidaExcluiSabor:Boolean;
Begin
  Result := True;
  with Fm_Cardapio do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
End;

function TFm_CardapioUT.ValidaInsereRecheio: Boolean;
begin
  Result := True;
  with Fm_Cardapio do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;

end;

procedure TFm_CardapioUT.ExcluiSabor;
Var
  Lc_Produto : String;
  Cardapio : TControllerCardapio;
begin
  Lc_Produto := Fm_Cardapio.StrGrd_Lista.Cells[2,Fm_Cardapio.StrGrd_Lista.Row];
  if (MensagemPadrao('Mensagem de Confirmação',
                     'Excluir ' + Lc_Produto + ' de seus arquivos.' + EOLN + EOLN +
                     'Confirmar a exclusão ?',
                     ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clRed) = mrBotao1) then
  Begin
    Cardapio := TControllerCardapio.create(Self);
    with Cardapio, Fm_Cardapio do
    Begin
      Registro.Codigo := StrToIntDef( StrGrd_Lista.Cells[1,StrGrd_Lista.Row],0);
      Registro.CodigoEstabelecimento := Gb_CodMha;
      if not movimentacao then
      Begin
        //Estoque
        Estoque.Registro.Codigo := Registro.Codigo;
        Estoque.Registro.CodigoEstoque := Gb_CodMha;
        Estoque.delete;
        //Preco - Tabela 1
        Preco.Registro.CodigoTabela := 1;
        Preco.Registro.CodigoProduto := Registro.Codigo;
        Preco.delete;
        //Preco - Tabela 2
        Preco.Registro.CodigoTabela := 2;
        Preco.Registro.CodigoProduto := Registro.Codigo;
        Preco.delete;
        //Deleta o Produto do cardapio
        Cardapio.delete;
      End
      else
      Begin
        MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       ' Este Produto tem movimentação ' + EOLN +
                       ' e não pode ser excluido.' + EOLN,
                       ['OK'], [bEscape], mpAlerta);
      End;
    End;
    FreeAndNil(Cardapio);
  End;

end;

procedure TFm_CardapioUT.Fm_CardapioSb_ExcluirClick(Sender: TObject);
begin
  if ValidaExcluiSabor then
  Begin
    ExcluiSabor;
    AbreListaSabor;
    PreencheGradeSabor;
  End;
end;

procedure TFm_CardapioUT.Fm_CardapioSb_InsereClick(Sender: TObject);
begin
  InsereSabor;
  AbreListaSabor;
  PreencheGradeSabor;
end;

procedure TFm_CardapioUT.Fm_CardapioStrGrd_ListaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Fm_Cardapio.StrGrd_Lista do
  Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    Begin
      Canvas.Font.Color:= clBlack;
      Canvas.Brush.Color:= clCream;
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := Cells[acol, ARow];
      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);
      { Calcula a posição horizontal do início do texto }
      if  (ACol < 3)  then { esquerda }
        X := Rect.Left + 2
      else if  (ACol = 0) then { Centro }
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
      else { Direita }
        X := Rect.Right - LarguraTexto - 2;
      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;
end;

procedure TFm_CardapioUT.Fm_CardapioStrGrd_ListaSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
Var
   Lc_Lista : TStringGrid;
begin
  Lc_Lista := TStringGrid.Create(Self);
  Lc_Lista := TStringGrid(sender);
  if ACol < 3 then
    Lc_Lista.Options := Lc_Lista.Options - [goEditing]
  else
    Lc_Lista.Options := Lc_Lista.Options + [goEditing];
end;

end.
