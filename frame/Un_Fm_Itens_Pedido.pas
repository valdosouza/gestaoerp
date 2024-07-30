unit Un_Fm_Itens_Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.Menus, System.Math, Un_Ctrl_Lote_Saida,
  IBX.IBQuery;

type
  TFm_Itens_Pedido = class(TFrame)
    StrGrd_Itens_Pedido: TStringGrid;
    Qr_ItensNota: TSTQuery;
    PopupMenu1: TPopupMenu;
    CadastrodeProdutos1: TMenuItem;
    Qr_ItensNotaITF_CODIGO: TIntegerField;
    Qr_ItensNotaITF_CODPRO: TIntegerField;
    Qr_ItensNotaPRO_CODIGOFAB: TIBStringField;
    Qr_ItensNotaPRO_CODIGONCM: TIBStringField;
    Qr_ItensNotaPRO_DESCRICAO: TIBStringField;
    Qr_ItensNotaIAV_DESCRICAO: TIBStringField;
    Qr_ItensNotaEMB_ABREVIATURA: TIBStringField;
    Qr_ItensNotaITF_QTDE: TIBBCDField;
    Qr_ItensNotaITF_VL_CUSTO: TFMTBCDField;
    Qr_ItensNotaITF_VL_UNIT: TFMTBCDField;
    Qr_ItensNotaITF_AQ_COM: TIBBCDField;
    Qr_ItensNotaMED_ABREVIATURA: TIBStringField;
    Qr_ItensNotaIAV_UNIDADE: TIBStringField;
    Qr_ItensNotaITF_AQ_DESC: TIBBCDField;
    Qr_ItensNotaITF_VL_DESC: TIBBCDField;
    Qr_ItensNotaPRO_VL_CUSTOMED: TFMTBCDField;
    Qr_ItensNotaITF_VL_IPI: TFMTBCDField;
    Qr_ItensNotaITF_VL_SUBTOTAL: TFloatField;
    Qr_ItensNotaITF_VL_TOTAL: TFloatField;
    RegistraNmerodolote1: TMenuItem;
    procedure StrGrd_Itens_PedidoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CadastrodeProdutos1Click(Sender: TObject);
    procedure Qr_ItensNotaCalcFields(DataSet: TDataSet);

  private
    { Private declarations }

  public
    { Public declarations }
    It_cd_Pedido : Integer;
    It_Tp_Operacao : String;
    procedure Pc_FormataTela;
    procedure Pc_AtivaTabela;
    procedure Pc_PreencheGrade;
  end;

implementation

{$R *.dfm}

uses Un_Produtos, RN_Permissao, Un_Regra_Negocio, UN_Principal,env;

{ TFrame1 }

procedure TFm_Itens_Pedido.CadastrodeProdutos1Click(Sender: TObject);
Var
  Lc_Form : TFr_Produtos;
begin
  if Fc_VerificaPermissao('Fr_Produtos','Cadastro de Produtos','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Produtos.Create(nil);
      Lc_Form.Produto.Registro.Codigo := StrToIntDef(StrGrd_Itens_Pedido.Cells[2,StrGrd_Itens_Pedido.Row],0);
      Lc_Form.ShowModal;
      Pc_LimpaStringGrid(StrGrd_Itens_Pedido);
      Pc_AtivaTabela;
      Pc_PreencheGrade;
    Finally
      Lc_Form.disposeOf;
    End;

  end;

end;

procedure TFm_Itens_Pedido.Pc_AtivaTabela;
begin
  with Qr_ItensNota do
  Begin
    Active := False;
    ParamByName('PED_CODIGO').AsInteger := It_cd_Pedido;
    ParamByName('ITF_OPER').AsString := It_Tp_Operacao;
    Active := True;
    FetchAll;
  End;
end;

procedure TFm_Itens_Pedido.Pc_FormataTela;
Var
  Lc_I : Integer;
begin
  //Colunas Fixas
  with StrGrd_Itens_Pedido,Qr_ItensNota do
  Begin
    //Coluna Fixa
    ColWidths[0]:=17;
    //ITF_CODIGO,
    ColWidths[1]:=-1;
    Cols[1].Add('Cód. Item');
    //ITF_CODPRO,
    ColWidths[2]:=-1;
    Cols[2].Add('Cód. Produto');
    //PRO_CODIGOFAB,
    ColWidths[3]:=80;
    Cols[3].Add('Cód. Fábrica');
    //PRO_CODIGONCM,
    ColWidths[4]:=80;
    Cols[4].Add('Cód. NCM');
    //PRO_DESCRICAO,
    ColWidths[5]:=200;
    Cols[5].Add('Descrição');
    //IAV_DESCRICAO,
    ColWidths[6]:=200;
    Cols[6].Add('Descrição');
    //EMB_ABREVIATURA,
    ColWidths[7]:=70;
    Cols[7].Add('Embalagem');
    //ITF_QTDE,
    ColWidths[8]:=70;
    Cols[8].Add('Qtde');
    //ITF_VL_CUSTO,
    ColWidths[9]:=90;
    Cols[9].Add('VL. Custo');
    //ITF_VL_UNIT,
    ColWidths[10]:=90;
    Cols[10].Add('VL Unitário');
    //ITF_AQ_COM,
    ColWidths[11]:=90;
    Cols[11].Add('Aliq. Com.');
    //MED_ABREVIATURA,
    ColWidths[12]:=70;
    Cols[12].Add('Unidade');
    //IAV_UNIDADE,
    ColWidths[13]:=70;
    Cols[13].Add('Unidade');
    //ITF_AQ_DESC,
    ColWidths[14]:=90;
    Cols[14].Add('Aliq Desc;');
    //ITF_VL_DESC,
    ColWidths[15]:=90;
    Cols[15].Add('VL Desc.');
    //PRO_VL_CUSTOMED,
    ColWidths[16]:=90;
    Cols[16].Add('VL Custo MÉdio');
    //ITF_VL_IPI,
    ColWidths[17]:=90;
    Cols[17].Add('VL IPI');
    //ITF_VL_SUBTOTAL,
    ColWidths[18]:=90;
    Cols[18].Add('SubTotal');
    //ITF_VL_TOTAL
    ColWidths[19]:=90;
    Cols[19].Add('Valor Total');
  end;
end;

procedure TFm_Itens_Pedido.Pc_PreencheGrade;
Var
  Lc_registro,Lc_I : Integer;
begin
  with StrGrd_Itens_Pedido,Qr_ItensNota do
  Begin
    RowCount := 2;
    First;
    Lc_registro := 1;
    while not Eof do
    Begin
      //Coluna Fixa
      RowCount := Lc_registro  + 1;
      //ITF_CODIGO,
      Cells[1,Lc_registro] := Qr_ItensNota.FieldByName('ITF_CODIGO').AsString;
      //ITF_CODPRO,
      Cells[2,Lc_registro] := FieldByName('ITF_CODPRO').AsString;
      //PRO_CODIGOFAB
      Cells[3,Lc_registro] := FieldByName('PRO_CODIGOFAB').AsString;
      //PRO_CODIGONCM
      Cells[4,Lc_registro] := FieldByName('PRO_CODIGONCM').AsString;
      if (Trim(FieldByName('IAV_DESCRICAO').AsString) <> '') then
      Begin
        //IAV_DESCRICAO
        ColWidths[6]:=200;
        Cells[6,Lc_registro] := FieldByName('IAV_DESCRICAO').AsString;
        //IAV_UNIDADE
        Cells[13,Lc_registro] := FieldByName('IAV_UNIDADE').AsString;
        ColWidths[5] := -1;
        ColWidths[12] := -1;
      End
      else
      Begin
        //PRO_DESCRICAO
        ColWidths[5]:=200;
        Cells[5,Lc_registro] := FieldByName('PRO_DESCRICAO').AsString;
        //MED_ABREVIATURA
        Cells[12,Lc_registro] := FieldByName('MED_ABREVIATURA').AsString;
        ColWidths[6] := -1;
        ColWidths[13] := -1;
      End;
      //EMB_ABREVIATURA
      Cells[7,Lc_registro] := FieldByName('EMB_ABREVIATURA').AsString;
      //ITF_QTDE
      Cells[8,Lc_registro] := formatFloat('#,##0.00####', FieldByName('ITF_QTDE').AsFloat);
      //ITF_VL_CUSTO
      Cells[9,Lc_registro] :=  FloatToStrF( FieldByName('ITF_VL_CUSTO').Asfloat,ffNumber,10,2);
      //ITF_VL_UNIT
      Cells[10,Lc_registro] := formatFloat('#,##0.00####', FieldByName('ITF_VL_UNIT').AsFloat);
      //ITF_AQ_COM
      Cells[11,Lc_registro] := FloatToStrF( FieldByName('ITF_AQ_COM').Asfloat,ffNumber,10,2);
      //ITF_AQ_DESC
      Cells[14,Lc_registro] := FloatToStrF( FieldByName('ITF_AQ_DESC').Asfloat,ffNumber,10,2);
      //ITF_VL_DESC
      Cells[15,Lc_registro] := FloatToStrF( FieldByName('ITF_VL_DESC').Asfloat,ffNumber,10,2);
      //PRO_VL_CUSTOMED
      Cells[16,Lc_registro] := FloatToStrF( FieldByName('PRO_VL_CUSTOMED').Asfloat,ffNumber,10,2);
      //ITF_VL_IPI
      Cells[17,Lc_registro] := FloatToStrF( FieldByName('ITF_VL_IPI').Asfloat,ffNumber,10,2);
      //ITF_VL_SUBTOTAL
      Cells[18,Lc_registro] := FloatToStrF( FieldByName('ITF_VL_SUBTOTAL').Asfloat,ffNumber,10,2);
      //ITF_VL_TOTAL
      Cells[19,Lc_registro] := FloatToStrF( FieldByName('ITF_VL_TOTAL').Asfloat,ffNumber,10,2);
      Next;
      inc(Lc_registro);
    end;
    Repaint;
  end;
end;

procedure TFm_Itens_Pedido.Qr_ItensNotaCalcFields(DataSet: TDataSet);
Var
  LcValor : Real;
begin
  with Qr_ItensNota do
  Begin
    LcValor := FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat;
    LcValor := RoundTo( LcValor ,-2);
    FieldByName('ITF_VL_SUBTOTAL').AsFloat :=
      StrToFloatDef(FloatToStrF( LcValor , ffFixed, 10, 2),0);

    FieldByName('ITF_VL_TOTAL').AsFloat :=
      FieldByName('ITF_VL_SUBTOTAL').AsFloat - FieldByName('ITF_VL_DESC').AsFloat;
  End;
end;

procedure TFm_Itens_Pedido.StrGrd_Itens_PedidoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with StrGrd_Itens_Pedido,Qr_ItensNota do
  Begin
    If (arow > 0) and (acol >0) then // testa se não é a primeira linha (fixa)
    Begin
      if (Cells[2,ARow] = '') then
      Begin
        Canvas.Font.Color:= clBlack;
        Canvas.Brush.Color:= clCream;
      end
      else
      Begin
        Canvas.Font.Color:= clBlack;
        Canvas.Brush.Color:= clMoneyGreen;
      end;
      Canvas.FillRect(Rect); // redesenha a celula
      Canvas.TextOut(Rect.Left+2,Rect.Top,Cells[acol,arow]); // reimprime o texto.
      // Pega o texto da célula
      Texto := Cells[acol, ARow];
      //{ Calcura largura e altura (em pontos) do texto
      LarguraTexto := Canvas.TextWidth(Texto);
      AlturaTexto := Canvas.TextHeight(Texto);
      // Calcula a posição horizontal do início do texto
      { Calcula a posição horizontal do início do texto }
      if  (ACol < 8) then { esquerda }
        X := Rect.Left + 2
      else if  (ACol = 0) then { Centro }
        X := Rect.Left + (Rect.Right - Rect.Left) div 2 -
          LarguraTexto div 2
      else { Direita }
        X := Rect.Right - LarguraTexto - 2;

      // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
      Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
      Canvas.TextRect(Rect, X, Y, Texto);
    end;
  end;

end;

end.
