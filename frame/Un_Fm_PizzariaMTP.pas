unit Un_Fm_PizzariaMTP;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,STQuery;

type
  TFm_PizzariaMTP = class(TFrame)
    Panel1: TPanel;
    Pnl_Composicao: TPanel;
    Lista: TListBox;
    Label1: TLabel;
    Str_Composicao: TStringGrid;
    E_Qtde: TEdit;
    Label2: TLabel;
    UpDown1: TUpDown;
    E_VL_Unitario: TEdit;
    Label3: TLabel;
    Sb_Limpa: TSpeedButton;
    Sb_Recheio: TSpeedButton;
    Sb_Confirma: TSpeedButton;
    procedure ListaDblClick(Sender: TObject);
    procedure ListaKeyPress(Sender: TObject; var Key: Char);
    procedure Str_ComposicaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_LimpaClick(Sender: TObject);
    procedure Sb_RecheioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigoPedido : Integer;
    CodigoGrupo : Integer;
    CodigoSubGrupo : Integer;
    MedidaEspecial : String;
    CalculoPizza : String;

    procedure IniciaVariaveis;
    function Fc_GrupoAgrupado():Boolean;
    procedure Pc_MontaComposicao;
    procedure Pc_CriaAreaListaComposicao;
    procedure Pc_CriaAreaComposicao(Sender: TObject);
    procedure Pc_MostraValorComposicao(Sender: TObject);
    procedure Pc_MostraRecheioComposicao;
    procedure Pc_ConfirmaItemComposicao;
  end;

implementation

{$R *.dfm}

uses Un_DM, Un_Msg, Un_Regra_Negocio, Un_PizzariaRecheios, RN_Pizzaria,
  RN_Itens_Vda_Avulso, RI_MovimentoFinanceiro;

procedure TFm_PizzariaMTP.Pc_CriaAreaComposicao(Sender: TObject);
Var
  Lc_Qry_Medidas : TSTQuery;
  Lc_Medida : TRadioButton;
  Lc_I, Lc_J :Integer;
Begin
  //Cria os Radios das medidas
  Lc_Qry_Medidas := TSTQuery.Create(Self);
  with Lc_Qry_Medidas do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := True;
    SQL.Add('SELECT DISTINCT MED_ABREVIATURA '+
            'FROM TB_PRODUTO '+
            '  INNER JOIN TB_MEDIDA '+
            '  ON (MED_CODIGO = PRO_CODMED) '+
            '  INNER JOIN TB_GRUPOS '+
            '  on (GRP_CODIGO = PRO_CODGRP) '+
            'WHERE (PRO_TIPO = ''A'') AND (GRP_CODIGO=:GRP_CODIGO) and med_sequencia is not null '+
            ' AND (PRO_ATIVO = ''S'') '+
            'ORDER BY MED_SEQUENCIA, MED_ABREVIATURA ');
    ParamByName('GRP_CODIGO').AsInteger := CodigoGRupo;
    Active := true;
    FetchAll;
    first;
    Lc_I := 0;
    while not eof do
    Begin
      Lc_Medida := TRadioButton.Create(Pnl_Composicao);
      with Lc_Medida do
      Begin
        Parent := Pnl_Composicao;
        Name := 'Rd_' +FieldByName('MED_ABREVIATURA').AsString;
        Tag := (Lc_I + 1) * 3; // Este é o indice da Coluna para pegar o valor da Pizza
        Top := 22;
        Width := 77;
        Left := 7 + (84 * Lc_I);
        Width := 77;
        Caption := FieldByName('MED_ABREVIATURA').AsString;
        Font.Size := 10;
        Font.Name :=  'MS Sans Serif';
        Font.Color := clNavy;
        OnClick := Pc_MostraValorComposicao;
      end;
      next;
      Inc(Lc_I);
    end;
  end;
  with Str_Composicao do
  Begin
    ColCount := (Lc_I * 3) + 3;
    ColWidths[0] := 390;
    For Lc_J := 1 to Lc_I do
      ColWidths[Lc_J] := 50;
  End;
  Lc_Qry_Medidas.Close;
  FreeAndNil(Lc_Qry_Medidas);
End;

procedure TFm_PizzariaMTP.Pc_MostraValorComposicao(Sender: TObject);
Var
  Lc_Radio : TRadioButton;
  Lc_Valor : Real;
  Lc_SomaValor : Real;
  Lc_I,Lc_J : Integer;
Begin
  //Sequencia de Comando para encontrar a StringString
  Lc_Radio := TRadioButton(Sender);
  with Str_Composicao do
  Begin
    //Registra na Grid qual tamanho foi clicado
    Lc_Valor := 0;
    Lc_J := 0;
    if CalculoPizza = '1' then
    Begin
      //Calcula pela Media dos Valores
      For Lc_I := 0 to Str_Composicao.RowCount do
      Begin
        Cells[ColCount,Lc_I] := FloatToStrF((Lc_Radio.tag-3)+1,ffFixed,10,0);
        if (StrToFloatDef(Cells[Lc_Radio.tag,Lc_I],0) > 0) then
        Begin
          Lc_Valor := Lc_Valor + StrToFloatDef(Cells[Lc_Radio.tag,Lc_I],0);
          inc(Lc_J);
        end;
      end;
      if (Lc_J > 0) and (Lc_Valor > 0)then
        E_VL_Unitario.Text := FloatToStrF(Lc_Valor/Lc_J,ffFixed,10,2)
      else
        E_VL_Unitario.Text := '0,00';
    end
    else
    Begin
      //Calculo pelo Maior Valor
      For Lc_I := 0 to RowCount do
      Begin
        Cells[ColCount,Lc_I] := FloatToStrF((Lc_Radio.tag-3)+1,ffFixed,10,0);
        if (StrToFloatDef(Cells[Lc_Radio.tag,Lc_I],0) > Lc_Valor) then
          Lc_Valor := StrToFloatDef(Cells[Lc_Radio.tag,Lc_I],0);
      end;
      E_VL_Unitario.Text := FloatToStrF(Lc_Valor,ffFixed,10,2);
    end;
  End;

end;

procedure TFm_PizzariaMTP.Sb_LimpaClick(Sender: TObject);
Var
  Lc_I,Lc_J : Integer;
Begin
  with Str_Composicao do
  Begin
    For Lc_I := 0 to RowCount - 1 do
      For Lc_J := 0 to ColCount do
        Cells[Lc_J,Lc_I] := '';
    RowCount := 4;
  End;
end;

procedure TFm_PizzariaMTP.Sb_RecheioClick(Sender: TObject);
begin
  Pc_MostraRecheioComposicao;
end;

procedure TFm_PizzariaMTP.Str_ComposicaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = []) and ( Key = VK_delete ) then
  Begin
    Del_Linha_StringGrid(TStringGrid(Sender),TStringGrid(Sender).Row,4);
  end;
end;

procedure TFm_PizzariaMTP.Pc_CriaAreaListaComposicao;
Var
  Lc_Qry : TSTQuery;
Begin
  //Cria os Botoes
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := Dm.IB_Transacao;
    ForcedRefresh := True;
    if not Fc_GrupoAgrupado then
    Begin
      SQL.Add('SELECT DISTINCT PRO_DESCRICAO '+
              'FROM TB_PRODUTO tb_produto '+
              'WHERE PRO_CODSBG=:SBG_CODIGO AND PRO_ATIVO=''S'' '+
              'ORDER BY PRO_DESCRICAO ');
      ParamByName('SBG_CODIGO').AsInteger := CodigoSubGrupo;
    end
    else
    Begin
      SQL.Add('SELECT DISTINCT PRO_DESCRICAO '+
              'FROM TB_PRODUTO tb_produto '+
              'WHERE PRO_CODGRP=:GRP_CODIGO AND PRO_ATIVO=''S'' '+
              'ORDER BY PRO_DESCRICAO ');
      ParamByName('GRP_CODIGO').AsInteger := CodigoGrupo;
    end;
    Active := true;
    FetchAll;
    first;
    if recordCount > 0 then
    Begin
      Lista.Clear;
      while not Eof do
      begin
        Lista.Items.Add(FieldByName('PRO_DESCRICAO').AsString);
        next;
      end;
      Lista.ItemIndex := 0;
      Lista.Selected[0]:= True;
    end;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


function TFm_PizzariaMTP.Fc_GrupoAgrupado():Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := TSTQuery.Create(Self);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    Sql.Add('SELECT GRP_AGRUPAR FROM TB_GRUPOS WHERE GRP_CODIGO =:GRP_CODIGO');
    parambyname('GRP_CODIGO').AsInteger := CodigoGrupo;
    active := True;
    Fetchall;
    Result := FieldByName('GRP_AGRUPAR').asString = 'S';
  End;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
End;


procedure TFm_PizzariaMTP.IniciaVariaveis;
begin
  Pc_CriaAreaListaComposicao;
  Pc_CriaAreaComposicao(Self);
end;

procedure TFm_PizzariaMTP.ListaDblClick(Sender: TObject);
begin
  Pc_MontaComposicao;
end;

procedure TFm_PizzariaMTP.ListaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then Pc_MontaComposicao;
end;

procedure TFm_PizzariaMTP.Pc_MontaComposicao;
Var
  Lc_Radio : TRadioButton;
  Lc_I,Lc_J : Integer;
  Lc_Produto : String;
  Lc_Qry : TSTQuery;
  Lc_Nr_Sabores : Integer;
  Lc_Agrupado : Boolean;
Begin
  Lc_Agrupado := Fc_GrupoAgrupado;

  Lc_Radio := TRadioButton.Create(Self);
  Lc_Radio := TRadioButton(Fc_LocalizaComponente(pnl_Composicao,TRadioButton));

  //Verifica numero de Sabores
  Lc_Nr_Sabores := 0;
  For Lc_I := 0 to Str_Composicao.RowCount do
  Begin
    if trim(Str_Composicao.Cells[0,Lc_I])<> '' then
      inc(Lc_Nr_Sabores);
  end;

  if Lc_Nr_Sabores = 4 then
  Begin
    MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Número de Sabores para a composição foi atingido.' + EOLN +
                   'Não é possível carregar mais este sabor.'+ EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Lc_Produto := Trim( Lista.Items.Strings[Lista.itemIndex]);
  For Lc_I := 0 to Str_Composicao.RowCount do
  Begin
    if trim(Str_Composicao.Cells[0,Lc_I])= '' then
    Begin
      Str_Composicao.Cells[0,Lc_I] := Lc_Produto;
      //Preencher os Valores
      Lc_Qry := TSTQuery.Create(Self);
      with Lc_Qry, Str_Composicao do
      Begin
        Database := DM.IBD_Gestao;
        Transaction := DM.IB_Transacao;
        SQL.Clear;
        SQL.Add('SELECT distinct PRO_CODIGO,MED_ABREVIATURA, tb_normal.PRC_VL_VDA PRO_VL_NORMAL, tb_promocao.PRC_VL_VDA PRO_VL_PROMOCAO,PRO_CAMPANHA '+
                'FROM tb_medida '+
                '   INNER JOIN tb_produto '+
                '   ON (tb_medida.med_codigo =tb_produto.PRO_CODMED) '+
                '   INNER JOIN tb_preco tb_normal '+
                '   ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_normal.PRC_CODTPR = 1)) '+
                '   INNER JOIN tb_preco tb_promocao '+
                '   ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_promocao.prc_codtpr = 2)) ');
        if Lc_Agrupado then
          SQL.Add('WHERE (PRO_CODGRP=:GRP_CODIGO) ')
        else
          SQL.Add('WHERE (PRO_CODSBG=:SBG_CODIGO) ');

        SQL.Add(' AND (PRO_ATIVO=''S'') AND (PRO_DESCRICAO=:PRO_DESCRICAO)  and med_sequencia is not null '+
                  'ORDER BY MED_SEQUENCIA,MED_DESCRICAO ');
        ParamByName('PRO_DESCRICAO').AsString := Lc_Produto;
        if Lc_Agrupado then
          ParamByName('GRP_CODIGO').AsInteger := CodigoGrupo
        else
          ParamByName('SBG_CODIGO').AsInteger := CodigoSubGrupo;
        Active := True;
        First;

        Lc_J := 0;
        while not eof do
        Begin
          Cells[Lc_J + 1 ,Lc_I] := FieldByname('PRO_CODIGO').AsString;
          Cells[Lc_J + 2 ,Lc_I] := FieldByname('MED_ABREVIATURA').AsString;
          if (FieldByname('PRO_CAMPANHA').AsString = 'N') then
            Cells[Lc_J + 3,Lc_I] := FloatToStrF(FieldByname('PRO_VL_NORMAL').AsFloat,ffFixed,10,2)
          else
            Cells[Lc_J + 3,Lc_I] := FloatToStrF(FieldByname('PRO_VL_PROMOCAO').AsFloat,ffFixed,10,2);
          Lc_J := Lc_J + 3;
          next;
        end;
      end;
      Lc_Qry.Close;
      FreeAndNil(Lc_Qry);
      Break;
    end;
  end;
  Lc_Radio.Checked := False;
  Lc_Radio.Checked := True;
end;

procedure TFm_PizzariaMTP.Pc_MostraRecheioComposicao;
Var
  Lc_Fr_Recheio : TFr_PizzariaRecheios;
  Lc_I : Integer;
  Lc_Coluna : Integer;
  Lc_Obs : TStringList;
  Lc_Aux : String;
  Lc_Valor : Real;
Begin
  if (Str_Composicao.Cells[0,Str_Composicao.Row]<> '') then
  Begin
    Lc_Fr_Recheio := TFr_PizzariaRecheios.Create(Self);
    with Lc_Fr_Recheio do
    Begin
      It_Ds_Sabor := Str_Composicao.Cells[0,Str_Composicao.Row];
      ShowModal;
      if (It_Confirma) then
      Begin
        Lc_Obs := TStringList.Create;
        if Trim(E_OpcaoLivre.Text)<> '' then
          Lc_Obs.Append(E_OpcaoLivre.Text);
        Lc_Coluna := (Str_Composicao.ColCount - 1);
        Lc_Valor := 0;
        For Lc_I:= 1 to (StrGrd_Recheio.RowCount - 1) do
        Begin
          if (StrGrd_Recheio.Cells[2,Lc_I] = '') and (StrGrd_Recheio.Cells[5,Lc_I] = 'Padrão') then
            Lc_Obs.Append('S/' + StrGrd_Recheio.Cells[4,Lc_I])
          else
          if (StrGrd_Recheio.Cells[2,Lc_I] = 'X') and (StrGrd_Recheio.Cells[5,Lc_I] = 'Opcional') then
          Begin
            Lc_Obs.Append('C/' + StrGrd_Recheio.Cells[4,Lc_I]);
            Lc_Valor := Lc_Valor  + StrToFloatDef(StrGrd_Recheio.Cells[7,Lc_I],0);
          End;
        end;
        //Preenche a Grid da composição
        if (Lc_Obs.Count > 0) then
        Begin
          For Lc_I:= 0 to (Lc_Obs.Count-1) do
          Begin
            if (Lc_I = 0) then
              Lc_Aux := Trim( Lc_Obs.Strings[lc_I] )
            else
              Lc_Aux := Trim( Lc_Aux + '|' + Lc_Obs.Strings[lc_I] );
          end;
          Str_Composicao.Cells[(Str_Composicao.ColCount-2),Str_Composicao.Row] := Lc_Aux;
          Str_Composicao.Cells[(Str_Composicao.ColCount-1),Str_Composicao.Row] := FloatToStr(Lc_Valor);
        end;
      end;
    end;
    FreeAndNil(Lc_Fr_Recheio);
  end
  else
  Begin
    MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Por favor escolha um sabor primeiro.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                  ['OK'],[bEscape],mpAlerta);
  end;

end;


procedure TFm_PizzariaMTP.Pc_ConfirmaItemComposicao;
Var
  Lc_I,Lc_J,Lc_Nr_Sabores : Integer;
  Lc_Qtde,Lc_Vl_Unit : Real;
  Lc_Ind_Tamanho : Integer;
  Lc_Mostra_Valor : Boolean;
  Lc_Nr_Item : Integer;
  Lc_Valor : Real;
Begin
  //Verifica numero de Sabores
  Lc_Nr_Sabores := 0;
  For Lc_I := 0 to Str_Composicao.RowCount do
  Begin
    if trim(Str_Composicao.Cells[0,Lc_I])<> '' then
      inc(Lc_Nr_Sabores);
  end;

  if Lc_Nr_Sabores = 0 then
  Begin
    MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'Por favor monte a composição antes de Continuar.' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Lc_Vl_Unit := StrToFloatDef(E_VL_Unitario.Text,0);
  if (Lc_Vl_Unit = 0 ) then
  Begin
    MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'O valor Unitário deve ser maior do que 0(Zero).' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  Lc_Qtde := StrToFloatDef(E_Qtde.Text,0);
  if (Lc_Qtde = 0) then
  Begin
    MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'A quantidade deve ser maior do que 0(Zero).' + EOLN + EOLN,
                   ['OK'], [bEscape], mpAlerta);
    Exit;
  end;

  //Pega os Valores dos adicionais da pizza
  Lc_Valor := 0;
  For Lc_I := 0 to Str_Composicao.RowCount do
    Lc_Valor := Lc_Valor + StrToFloatDef(Str_Composicao.Cells[(Str_Composicao.Colcount-1),Lc_I],0);
  //Adiciona ao valor unitario
  Lc_Vl_Unit := Lc_Vl_Unit + Lc_Valor;
  //FAz a inclusão dos itens
  Lc_Nr_Item := Fc_GeraProximoNrItem(CodigoPedido);
  For Lc_I := 0 to Str_Composicao.RowCount do
  Begin
    if trim(Str_Composicao.Cells[0,Lc_I])<> '' then
    Begin
      Lc_Ind_Tamanho := StrToIntdef(Str_Composicao.Cells[Str_Composicao.ColCount,Lc_I],0);
      //Só mostra o Valor no ultimo sabor
      Lc_Mostra_Valor := (Lc_Nr_Sabores = (Lc_I + 1));
      Pc_GravaItemVenda( codigoPedido,
                        Lc_Nr_Item,
                        StrToIntdef(Str_Composicao.Cells[(Lc_Ind_Tamanho),Lc_I],0),//produto
                        0,
                        0,//Subgrupo
                        Str_Composicao.Cells[Lc_Ind_Tamanho+1,Lc_I] + ' - ' + Str_Composicao.Cells[0,Lc_I] + '/' + IntToStr(Lc_Nr_Sabores), //produto e medida
                        Copy(Str_Composicao.Cells[(Str_Composicao.Colcount-2),Lc_I],1,100),
                        'N',
                        Lc_Qtde,
                        Lc_VL_Unit,
                        0,
                        Gb_Datacaixa,
                        Lc_Nr_Sabores,
                        Lc_VL_Unit,
                        Lc_Mostra_Valor);

    end;
  end;
  //Limpa oscampos
  For Lc_I := 0 to Str_Composicao.RowCount do
    For Lc_J := 0 to Str_Composicao.ColCount do
      Str_Composicao.Cells[Lc_J,Lc_I] := '';
  Str_Composicao.RowCount := 4;
end;

end.
