unit Un_Fm_CardapioMTS;
//Cada produto poderá ter multiplos tamanhos,
//mas sem propagar a criação de produtos conforme os tamanhos
interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_CardapioMT, Data.DB,
  Vcl.Menus,ControllerMedida;

type
  TFm_CardapioMTS = class(TFrame)
    Fm_CardapioMT: TFm_CardapioMT;
    procedure IniciaVariaveis;
    procedure AbreListaTamanho;
    procedure Fm_TamahoSb_AlteraClick(Sender: TObject);
    procedure Fm_TamahoSb_InsereClick(Sender: TObject);
    procedure Fm_TamanhoSb_Botao1Click(Sender: TObject);
    procedure Fm_CardapioMTPg_GeralChange(Sender: TObject);
    procedure Fm_SaborSb_Botao1Click(Sender: TObject);
    procedure Fm_TamanhoSb_Botao2Click(Sender: TObject);
    procedure Fm_SaborStrGrd_ListaClick(Sender: TObject);
    procedure Fm_SaborSb_AlteraClick(Sender: TObject);
    procedure Fm_SaborSb_ExcluirClick(Sender: TObject);
    procedure Fm_SaborSb_InsereClick(Sender: TObject);
    procedure Fm_TamanhoSb_ExcluirClick(Sender: TObject);
    procedure Fm_TamanhoStrGrd_ListaSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure DesativarTamanho1Click(Sender: TObject);
    procedure Fm_CardapioMTMnuAlteraGrupoClick(Sender: TObject);

  private
    { Private declarations }

    procedure InsereSabor;

    Function ValidaAlteraSabor:Boolean;
    procedure AlteraSabor;

    Function ValidaExcluiSabor:Boolean;
    procedure ExcluiSabor;

    Procedure InsereTamanho;

    Function ValidaAlteraTamanho:Boolean;
    procedure AlteraTamanho;

    Function ValidaExcluiTamanho:Boolean;
    procedure ExcluiTamanho;

    procedure ListaTamanhoVazia;
  public
    { Public declarations }
    procedure AtualizaPrecoTamanhoMultiplo;
    function ValidaAdicionaBotao:Boolean;
    procedure ChamaFormBotao;
    procedure AdiconaBotao(Produto:String;
                           GRupo,
                           SubGRupo,
                           Botao,
                           Sequencia:Integer);
    procedure AdiconaBotaoByTamanho;
  end;

implementation

{$R *.dfm}

uses Un_Msg, ControllerCardapio, Un_Botao, Un_CardapioProduto;

{ TFm_CardapioMTS }

procedure TFm_CardapioMTS.InsereSabor;
Var
  Form : TFr_CardapioProduto;
begin
  Form  := TFr_CardapioProduto.Create(self);
  with Form do
  Begin
    TipoOperacao := 'IMTS-S';
    Cardapio.Registro.Codigo := 0;
    Cardapio.Registro.Descricao := '';
    Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
    Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
    Cardapio.Registro.MedidaComercial := 0;
    ShowModal;
  End;
  FreeAndNil(Form);
End;

Function TFm_CardapioMTS.ValidaAlteraSabor:Boolean;
Begin
  Result := True;
  with Fm_CardapioMT.Fm_Sabor do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
End;

procedure TFm_CardapioMTS.AlteraSabor;
Var
  Form : TFr_CardapioProduto;
begin
  Try
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'UMTS-S';
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := Fm_CardapioMT.fm_Sabor.StrGrd_Lista.Cells[2,Fm_CardapioMT.Fm_Sabor.StrGrd_Lista.Row];
      Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
      Cardapio.Registro.MedidaComercial := 0;
      Cardapio.Old_Descricao := Cardapio.Registro.Descricao;
      Cardapio.getbyDG;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;

End;

Function TFm_CardapioMTS.ValidaExcluiSabor:Boolean;
Begin
  Result := True;
  with Fm_CardapioMT.Fm_Sabor do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;

End;

procedure TFm_CardapioMTS.ExcluiSabor;
Begin

End;

Procedure TFm_CardapioMTS.InsereTamanho;
Var
  Form : TFr_CardapioProduto;
  Lc_Medida : Integer;
begin
  tRY
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'IMTS-T';
      Cardapio.Registro.Descricao := fm_CardapioMT.Fm_Sabor.StrGrd_Lista.Cells[2,fm_CardapioMT.Fm_Sabor.StrGrd_Lista.Row];
      Cardapio.Registro.CodigoGrupo := fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := fm_CardapioMT.SubGrupo;
      Lc_Medida := StrToIntDef( fm_CardapioMT.Fm_Tamanho.StrGrd_Lista.Cells[1,fm_CardapioMT.Fm_Tamanho.StrGrd_Lista.Row] , 0);
      Cardapio.Registro.MedidaComercial := Lc_Medida;
      Cardapio.Old_Descricao := Cardapio.Registro.Descricao;
      Cardapio.getByDMG;
      //Zera o codigo para que na gravação o sistema saiba que deve inserir
      Cardapio.Registro.Codigo := 0;
      ShowModal;
    End;
  finally
    FreeAndNil(Form);
  end;

end;

Function TFm_CardapioMTS.ValidaAlteraTamanho:Boolean;
Begin
  Result := True;
  if not FM_CardapioMT.ValidaAlteraTamanho then
  Begin
    Result := False;
    Exit;
  End;
End;

procedure TFm_CardapioMTS.AlteraTamanho;
Var
  Form : TFr_CardapioProduto;
  Lc_Medida  : Integer;
begin
  Try
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'UMTS-T';
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := Fm_CardapioMT.Fm_Sabor.StrGrd_Lista.Cells[2,Fm_CardapioMT.Fm_Sabor.StrGrd_Lista.Row];
      Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
      Lc_Medida := StrToIntDef( Fm_CardapioMT.Fm_Tamanho.StrGrd_Lista.Cells[1,Fm_CardapioMT.Fm_Tamanho.StrGrd_Lista.Row] , 0);
      Cardapio.Registro.MedidaComercial := Lc_Medida;
      Cardapio.Old_Descricao := Cardapio.Registro.Descricao;
      Cardapio.getByDMG;
      ShowModal;
      AbreListaTamanho;
    End;
  Finally
    FreeAndNil(Form);
  End;

end;

Function TFm_CardapioMTS.ValidaExcluiTamanho:Boolean;
Begin
  Result := True;
  with Fm_CardapioMT.Fm_Tamanho do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
End;

procedure TFm_CardapioMTS.ExcluiTamanho;
Begin


End;

procedure TFm_CardapioMTS.AbreListaTamanho;
begin
  with Fm_CardapioMT.Qr_Tamanho do
  Begin
    SQL.Clear;
    Active := False;
    SQL.Add('SELECT distinct MED_SEQUENCIA,MED_CODIGO, MED_DESCRICAO,tb_normal.PRC_VL_VDA PRO_VL_NORMAL, tb_promocao.PRC_VL_VDA PRO_VL_PROMOCAO '+
            'FROM tb_medida '+
            '   INNER JOIN tb_produto '+
            '   ON (tb_medida.med_codigo =tb_produto.PRO_CODMED) '+
            '   INNER JOIN tb_preco tb_normal '+
            '   ON ((tb_normal.prc_codpro = tb_produto.pro_codigo) and (tb_normal.PRC_CODTPR = 1)) '+
            '   INNER JOIN tb_preco tb_promocao '+
            '   ON ((tb_promocao.prc_codpro = tb_produto.pro_codigo) and (tb_promocao.prc_codtpr = 2)) '+
            'WHERE MED_ESPECIAL = :MED_ESPECIAL AND PRO_CODSBG=:SBG_CODIGO AND PRO_ATIVO=''S'' '+
            ' and MED_ATIVO = ''S'' '+
            '      AND (PRO_DESCRICAO=:PRO_DESCRICAO) '+
           'ORDER BY MED_SEQUENCIA,MED_DESCRICAO ');

    with Fm_CardapioMT.Fm_Sabor.StrGrd_Lista do
    Begin
     ParamByName('PRO_DESCRICAO').AsString := Cells[2,Row];
    End;
    ParamByName('SBG_CODIGO').AsInteger := Fm_CardapioMT.Subgrupo;
    ParamByName('MED_ESPECIAL').AsString := Fm_CardapioMT.MedidaEspecial;
    Active := True;
    FetchAll;
  End;
end;


procedure TFm_CardapioMTS.Fm_CardapioMTMnuAlteraGrupoClick(Sender: TObject);
begin
  Fm_CardapioMT.MnuAlteraGrupoClick(Sender);

end;

procedure TFm_CardapioMTS.Fm_CardapioMTPg_GeralChange(Sender: TObject);
Var
  Produto : String;
begin
  with Fm_CardapioMT do
  Begin
    tbs_Tamanho.Caption := 'TAMANHO';
    if ( Pg_Geral.ActivePage = tbs_Tamanho ) then
    Begin
      Produto := Fm_Sabor.StrGrd_Lista.Cells[2,Fm_Sabor.StrGrd_Lista.Row];
      if Length( Trim( Produto ) ) > 0 then
      Begin
        tbs_Tamanho.Caption := 'TAMANHO - ' + Produto;
        AbreListaTamanho;
        PreencheGradeTamanho;
      End
      else
      Begin
        MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       ' Por favor Selecione um produto da Lista.' + EOLN +
                       ' Verifique e tente novamente.' + EOLN,
                        ['OK'], [bEscape], mpAlerta);
        Pg_Geral.ActivePage := tbs_SAbor;
      End;
    End;
  End;
end;

procedure TFm_CardapioMTS.ListaTamanhoVazia;
Begin
  with Fm_CardapioMT do
  Begin
    if not Fm_Tamanho.ValidaExistenciaRegistro(Fm_Tamanho.StrGrd_Lista) then
    Begin
      tbs_Tamanho.Caption := 'TAMANHO';
      Pg_Geral.ActivePageIndex := 0;
      AbreListaSabor;
      PreencheGradeSabor;
    End;
  End;
end;

procedure TFm_CardapioMTS.Fm_SaborSb_AlteraClick(Sender: TObject);
begin
  if ValidaAlteraSabor then
  Begin
    AlteraSabor;
    Fm_CardapioMT.AbreListaSabor;
    Fm_CardapioMT.PreencheGradeSabor;
    ListaTamanhoVazia;
  End;
end;

procedure TFm_CardapioMTS.Fm_SaborSb_Botao1Click(Sender: TObject);
begin
  if ValidaAdicionaBotao then
  Begin
    ChamaFormBotao;
  End;
end;

procedure TFm_CardapioMTS.Fm_SaborSb_ExcluirClick(Sender: TObject);
begin
  if ValidaExcluiSabor then
  Begin
    ExcluiSabor;
    Fm_CardapioMT.AbreListaSabor;
    Fm_CardapioMT.PreencheGradeSabor;
  End;
end;

procedure TFm_CardapioMTS.Fm_SaborSb_InsereClick(Sender: TObject);
begin
  InsereSabor;
  Fm_CardapioMT.AbreListaSabor;
  Fm_CardapioMT.PreencheGradesabor;
end;

procedure TFm_CardapioMTS.Fm_SaborStrGrd_ListaClick(Sender: TObject);
begin
  with Fm_CardapioMT do
  Begin
    AbreListaTamanho;
    PreencheGradeTamanho;
  End;
end;

procedure TFm_CardapioMTS.Fm_TamahoSb_AlteraClick(Sender: TObject);
begin
  if ValidaAlteraTamanho then
  Begin
    AlteraTamanho;
    AbreListaTamanho;
    Fm_CardapioMT.PreencheGradeTamanho;
    ListaTamanhoVazia;
    AdiconaBotaoByTamanho
  end;
end;

procedure TFm_CardapioMTS.Fm_TamahoSb_InsereClick(Sender: TObject);
begin
  InsereTamanho;
  AbreListaTamanho;
  Fm_CardapioMT.PreencheGradeTamanho;
  AdiconaBotaoByTamanho;
end;

function TFm_CardapioMTS.ValidaAdicionaBotao: Boolean;
begin
  Result := True;
  with Fm_CardapioMT.Fm_Sabor do
  Begin
    if not ValidaExistenciaRegistro(StrGrd_Lista) then
    Begin
      Result := False;
      Exit;
    End;
  End;
end;

procedure TFm_CardapioMTS.AdiconaBotao(Produto:String;
                              GRupo,
                              SubGRupo,
                              Botao,
                              Sequencia:Integer);
Var
  Lc_Cardapio : TControllerCardapio;
begin
  Try
    Lc_Cardapio := TControllerCardapio.create(nil);
    Lc_Cardapio.Registro.Descricao := Produto;
    Lc_Cardapio.Registro.CodigoGrupo := Grupo;
    Lc_Cardapio.Registro.CodigoSubgrupo := SubGrupo;
    Lc_Cardapio.AtualizaBotaoSabor(botao,Sequencia);
  Finally
    Lc_Cardapio.DisposeOf;
  End;
end;

procedure TFm_CardapioMTS.AdiconaBotaoByTamanho;
Var
  Lc_Cardapio : TControllerCardapio;
  Produto : String;
begin
  Try
    with Fm_CardapioMT do
    Begin
      Produto := Fm_Sabor.StrGrd_Lista.Cells[2,Fm_Sabor.StrGrd_Lista.Row];
      Lc_Cardapio := TControllerCardapio.create(Self);
      Lc_Cardapio.InsereAutoBotaoNoSubgrupo(
                                  Produto,
                                  Subgrupo);
    End;
  Finally
    FreeAndNil(Lc_Cardapio);
  End;
end;

procedure TFm_CardapioMTS.AtualizaPrecoTamanhoMultiplo;
Var
  I : Integer;
  Lc_Cardapio : TControllerCardapio;
  Lc_Produto : String;
begin
  Lc_Cardapio := TControllerCardapio.Create(self);
  with Fm_CardapioMT do
  Begin
    with Fm_Sabor.StrGrd_Lista do
    Begin
      Lc_Produto := Cells[2,row]
    End;

    with Fm_Tamanho.StrGrd_Lista do
    Begin
      for I := 1 to (RowCount - 1) do
      Begin
        if StrToIntDef( Cells[1,I],0) > 0 then
        Begin
          Lc_Cardapio.Registro.Descricao := Lc_Produto;
          Lc_Cardapio.Registro.CodigoSubgrupo := SubGrupo;
          Lc_Cardapio.Registro.MedidaComercial := StrtoIntDef(Cells[1,I],0);
          Lc_Cardapio.PrecoNormal   := StrToFloatDef(Cells[5,I],0);
          Lc_Cardapio.PrecoPromocao := StrToFloatDef(Cells[6,I],0);
          Lc_Cardapio.AtualizaPrecoTamanhoMultiploSimples;
        End;
      End;
    End;
  End;
end;

procedure TFm_CardapioMTS.ChamaFormBotao;
Var
  Lc_Produto : String;
  Form : TFr_Botao;
begin
  Try
    Form := TFr_Botao.create(Self);
    with Form do
    Begin
      ShowModal;
      if (Form.It_Cd_Botao > 0) then
      Begin
        with Fm_CardapioMT do
        Begin
          Lc_Produto := Fm_Sabor.StrGrd_Lista.Cells[2,Fm_Sabor.StrGrd_Lista.row];
          if (MensagemPadrao('Mensagem de Confirmação',
                           'Atribuir este botão ao item ' + Lc_Produto + '.' + EOLN + EOLN +
                           'Confirmar a operação ?',
                            ['Sim', 'Não'], [bEscape, bNormal], mpConfirmacao, clBtnFace) = mrBotao1) then
          Begin
            AdiconaBotao(Lc_Produto,
                              GRupo,
                              SubGRupo,
                              Form.It_Cd_Botao,
                              Form.It_Sequencia)
          End;
        End;
      End;
    End;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TFm_CardapioMTS.DesativarTamanho1Click(Sender: TObject);
Var
  LcMedida : TControllerMedida;
begin
  if (MensagemPadrao('Mensagem de Confirmação',
                     'Desseja Desativar este tamanho? Isso vai desativar todos os Produtos Relacionados.'+EOLN+EOLN+
                     'Confirmar a Desativar ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      LcMedida := TControllerMedida.create(nil);
      LcMedida.Registro.Codigo := StrToIntDef(Fm_CardapioMT.Fm_Tamanho.StrGrd_Lista.Cells[1,Fm_CardapioMT.Fm_Tamanho.StrGrd_Lista.row],0);
      LcMedida.Registro.Ativo := 'N';
      LcMedida.AtivarDesativar;
    finally
      AbreListaTamanho;
      Fm_CardapioMT.PreencheGradeTamanho;
      LcMedida.Disposeof;
    end;
  end;
end;

procedure TFm_CardapioMTS.Fm_TamanhoSb_Botao1Click(Sender: TObject);
begin
  AtualizaPrecoTamanhoMultiplo;
  AbreListaTamanho;
  Fm_CardapioMT.PreencheGradeTamanho;
end;

procedure TFm_CardapioMTS.Fm_TamanhoSb_Botao2Click(Sender: TObject);
begin
  Fm_CardapioMT.OrdenaSequenciaTamanho;
  AbreListaTamanho;
  Fm_CardapioMT.PreencheGradeTamanho;
end;

procedure TFm_CardapioMTS.Fm_TamanhoSb_ExcluirClick(Sender: TObject);
begin
  if ValidaExcluiTamanho then
  Begin
    ExcluiTamanho;
    AbreListaTamanho;
    Fm_CardapioMT.PreencheGradeTamanho;
  End;
end;

procedure TFm_CardapioMTS.Fm_TamanhoStrGrd_ListaSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  Fm_CardapioMT.Fm_TamanhoStrGrd_ListaSelectCell(Sender, ACol, ARow,
  CanSelect);

end;

procedure TFm_CardapioMTS.IniciaVariaveis;
begin
  with Fm_CardapioMT do
  Begin
    MontaGradeSabor;
    AbreListaSabor;
    PreencheGradeSabor;
    MontaGradeTamanho;
  End;
end;



end.
