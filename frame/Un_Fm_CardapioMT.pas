unit Un_Fm_CardapioMT;
//Cardapio Multiplos Tamanhos
interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons,Vcl.Grids,
  Vcl.ExtCtrls, Un_Fm_CardapioPanel, Data.DB, STQuery,
  Vcl.StdCtrls, Un_Fm_ListaGrupoSubGrupo, Vcl.Menus,ControllerMedida,
FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_CardapioMT = class(TFrame)
    Pg_Geral: TPageControl;
    tbs_SAbor: TTabSheet;
    tbs_Tamanho: TTabSheet;
    Qr_Tamanho: TSTQuery;
    Pnl_GrupoSubgrupo: TPanel;
    Label1: TLabel;
    Sb_Confirma: TButton;
    Sb_Cancela: TButton;
    Qr_UpdateSubgrupo: TSTQuery;
    procedure AbreListaSabor;
    procedure MontaGradeSabor;
    procedure PreencheGradesabor;
    //procedure AbreListaTamanho; Implemetando no Frame Posterior
    procedure MontaGradeTamanho;
    procedure PreencheGradeTamanho;

    procedure Fm_TamanhoStrGrd_ListaDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Fm_TamanhoStrGrd_ListaSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure Sb_ConfirmaClick(Sender: TObject);
    procedure Sb_CancelaClick(Sender: TObject);
    procedure tbs_SAborShow(Sender: TObject);
    procedure MnuAlteraGrupoClick(Sender: TObject);  private
    { Private declarations }
  public
    { Public declarations }
    Grupo : Integer;
    SubGrupo : Integer;
    MedidaEspecial : String; //Mesmo nome do Grupo do Cardapio

    function ValidaAlteraSabor:Boolean;

    function ValidaAlteraTamanho:Boolean;

    function ValidaExcluiSaborBySabor:Boolean;

    function ValidaExcluiTamanho:Boolean;

    procedure OrdenaSequenciaTamanho;
  end;

implementation

{$R *.dfm}

uses Un_CardapioProduto, Un_CardapioTamanho, Un_DM, Un_Regra_Negocio,
  ControllerCardapio, Un_Msg;

{ TFm_CardapioMT }


procedure TFm_CardapioMT.AbreListaSabor;
begin
  with Fm_Sabor.Qr_Sabor do
  Begin
    Active := False;
    ParamByName('SBG_CODIGO').AsInteger := SubGrupo;
    Active := True;
  end;
end;

procedure TFm_CardapioMT.MnuAlteraGrupoClick(Sender: TObject);
begin
  Fm_ListaGrupoSubGrupo.Listar(True);
  Fm_ListaGrupoSubGrupo.DBLCB_Grupo.KeyValue := GRupo;
  Fm_ListaGrupoSubGrupo.DBLCB_Grupo.Enabled := false;
  Fm_ListaGrupoSubGrupo.DBLCB_SubGrupo.KeyValue := SubGrupo;
  Pnl_GrupoSubgrupo.Visible := True;
  Fm_Sabor.Panel4.Enabled := False;
end;

procedure TFm_CardapioMT.MontaGradeSabor;
Var
  I:Integer;
begin
  with  Fm_Sabor.StrGrd_Lista do
  Begin
    Font.Size := 12;
    ColCount := 6;
    Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goTabs];
    DefaultRowHeight := 22;
    ColWidths[0] := 17;
    ColWidths[1] := 70;
    ColWidths[2] := 530;
    ColWidths[3] := -1;
    ColWidths[4] := -1;
    Cols[0].Add('');
    Cols[1].Add('Código');
    Cols[2].Add('Descrição');
    Cols[3].Add('COD. GRUPO');
    Cols[4].Add('COD SUBG');
  end;
End;

procedure TFm_CardapioMT.PreencheGradesabor;
Var
  I : Integer;
  Lc_registro : Integer;
begin
  Pc_LimpaStringGrid(Fm_Sabor.StrGrd_Lista);
  with  Fm_Sabor.StrGrd_Lista,Fm_Sabor.Qr_Sabor do
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
      //cODIGO
      Cells[1,I] := FieldByName('PRO_CODIGO').AsString;
      //Descricao
      Cells[2,I] := FieldByName('PRO_DESCRICAO').AsString;
      //Codigo Grupo
      Cells[3,I] := FieldByName('PRO_CODGRP').AsString;
      //Codigo SubGRupo
      Cells[4,I] := FieldByName('PRO_CODSBG').AsString;
      Inc(I);
      Next;
    end;
  end;
End;

procedure TFm_CardapioMT.MontaGradeTamanho;
Var
  I:Integer;
begin
  with  Fm_Tamanho.StrGrd_Lista,Qr_Tamanho do
  Begin
    Font.Size := 10;
    ColCount := 7;
    Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goTabs];
    DefaultRowHeight := 22;
    ColWidths[0] := 17;
    ColWidths[1] := -1;
    ColWidths[2] := 40;
    ColWidths[3] := 70;
    ColWidths[4] := 190;
    ColWidths[5] := 145;
    ColWidths[6] := 145;
    Cols[1].Add('COD.');
    Cols[2].Add('SEQ.');
    Cols[3].Add('Código');
    Cols[4].Add('Descrição');
    Cols[5].Add('Preço Normal');
    Cols[6].Add('Preço Promoção');
  end;
End;

procedure TFm_CardapioMT.PreencheGradeTamanho;
Var
  I : Integer;
  Lc_registro : Integer;
begin
  Pc_LimpaStringGrid(Fm_Tamanho.StrGrd_Lista);
  with  Fm_Tamanho.StrGrd_Lista,Qr_Tamanho do
  Begin
    I := 1;
    First;
    ColCount := 7;
    Lc_registro := 0;
    First;
    while not Eof do
    Begin
      Lc_registro := Lc_registro + 1;
      RowCount := Lc_registro + 1;
      //codigo da medida
      Cells[1,I] := FieldByName('MED_CODIGO').AsString;
      //Sequencia da Medida
      Cells[2,I] := FieldByName('MED_SEQUENCIA').AsString;
      //Codigo da Medida - Visivel
      Cells[3,I] := FieldByName('MED_CODIGO').AsString;
      //Descrição da medida
      Cells[4,I] := FieldByName('MED_DESCRICAO').AsString;
      //Preço Normal
      Cells[5,I] := FloatToStrF( FieldByName('PRO_VL_NORMAL').AsFloat,ffFixed,10,2);
      //Preço Promoção
      Cells[6,I] := FloatToStrF( FieldByName('PRO_VL_PROMOCAO').AsFloat,ffFixed,10,2);
      Inc(I);
      Next;
    end;
  end
End;


procedure TFm_CardapioMT.Sb_CancelaClick(Sender: TObject);
begin
  Pnl_GrupoSubgrupo.Visible := False;
  Fm_Sabor.Panel4.Enabled := True;
end;

procedure TFm_CardapioMT.Sb_ConfirmaClick(Sender: TObject);
begin
  with Qr_UpdateSubgrupo do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    ParamByName('new_Subgrupo').AsInteger := Fm_ListaGrupoSubGrupo.DBLCB_SubGrupo.KeyValue;
    ParamByName('pro_descricao').AsString := fm_Sabor.StrGrd_Lista.Cells[2,Fm_Sabor.StrGrd_Lista.Row];
    ParamByName('grp_codigo').AsInteger := GRupo;
    ParamByName('old_Subgrupo').AsInteger := SubGrupo;
    ExecSQL;
    if Transaction.InTransaction then Transaction.Commit;
  End;
  AbreListaSabor;
  PreencheGradesabor;
  Pnl_GrupoSubgrupo.Visible := False;
  Fm_Sabor.Panel4.Enabled := True;
end;

procedure TFm_CardapioMT.tbs_SAborShow(Sender: TObject);
begin
  AbreListaSabor;
  PreencheGradesabor;
end;

procedure TFm_CardapioMT.OrdenaSequenciaTamanho;
Var
  Qr_Atualiza : TSTQuery;
  I : Integer;
begin
  try
    Qr_Atualiza := TSTQuery.Create(Self);
    with Qr_Atualiza do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IBT_Crud;
      ForcedRefresh := True;
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_MEDIDA SET '+
              'MED_SEQUENCIA =:MED_SEQUENCIA '+
              'WHERE ( MED_CODIGO =:MED_CODIGO )');

      with Fm_Tamanho.StrGrd_Lista do
      Begin
        For I := 1 to RowCount - 1 do
        Begin
          if not Transaction.InTransaction then Transaction.StartTransaction;
          Active := False;
          ParamByName('MED_CODIGO').AsInteger := StrtoIntDef(Cells[1,I],0);
          ParamByName('MED_SEQUENCIA').AsInteger := StrtoIntDef(Cells[2,I],0);
          ExecSQL;
          if Transaction.InTransaction then Transaction.Commit;
        End;
      end;
    end;
  finally
    Qr_Atualiza.Close;
  end;
end;

procedure TFm_CardapioMT.Fm_TamanhoStrGrd_ListaDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
  LarguraTexto, AlturaTexto, X, Y: integer;
  Texto: string;
begin
  with Fm_Tamanho.StrGrd_Lista do
  Begin
    if (ACol = 1)and(ARow>0) Then
    begin
      if (Cells[3,ARow] <> '') then
      Begin
      if (Cells[2,ARow] = 'X') then
        DrawFrameControl(Canvas.Handle, Rect,DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED) // Desenha o CheckBox desmarcado
      else
        DrawFrameControl(Canvas.Handle, Rect,   DFC_BUTTON, DFCS_BUTTONCHECK); // Desenha o CheckBox marcado
      end;
    end
    else
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
        if  (ACol > 1) and (ACol < 5) then { esquerda }
          X := Rect.Left + 2
        else if  (ACol = 1) then { Centro }
          X := Rect.Left + (Rect.Right - Rect.Left) div 2 - LarguraTexto div 2
        else { Direita }
          X := Rect.Right - LarguraTexto - 2;
        // Calcula a posição vertical do início do texto para que seja impresso no centro (verticalmente) da célula
        Y := Rect.Top + (Rect.Bottom - Rect.Top) div 2 - AlturaTexto div 2;
        Canvas.TextRect(Rect, X, Y, Texto);
      end;
    end;
  end;
end;



procedure TFm_CardapioMT.Fm_TamanhoStrGrd_ListaSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol = 3 then
    TStringGrid(sender).Options := TStringGrid(sender).Options - [goEditing]
  else
    TStringGrid(sender).Options := TStringGrid(sender).Options + [goEditing];
end;


function TFm_CardapioMT.ValidaAlteraSabor:Boolean;
Begin
  Result := True;
  with Fm_Sabor do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
End;


function TFm_CardapioMT.ValidaAlteraTamanho:Boolean;
Begin
  Result := True;
  with Fm_Tamanho do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
End;

function TFm_CardapioMT.ValidaExcluiSaborBySabor: Boolean;
begin
  Result := True;
  with Fm_Sabor do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
end;


function TFm_CardapioMT.ValidaExcluiTamanho: Boolean;
begin
  Result := True;
  with Fm_Tamanho do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;

end;



end.
