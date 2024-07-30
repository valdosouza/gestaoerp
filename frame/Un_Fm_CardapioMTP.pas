unit Un_Fm_CardapioMTP;
//Cada produto criado ("P") propagara a criação de outros produtos conforme tamanhos vinculados ao grupo
interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Un_Fm_CardapioMT, Vcl.Menus,ControllerMedida;

type
  TFm_CardapioMTP = class(TFrame)
    Fm_CardapioMT: TFm_CardapioMT;
    DesativarTamanho1: TMenuItem;

    procedure IniciaVariaveis;

    procedure Fm_TamahoSb_InsereClick(Sender: TObject);
    procedure Fm_TamahoSb_AlteraClick(Sender: TObject);
    procedure Fm_TamanhoSb_Botao1Click(Sender: TObject);
    procedure Fm_TamanhoSb_Botao2Click(Sender: TObject);
    procedure Fm_SaborSb_Botao1Click(Sender: TObject);
    procedure Fm_CardapioMTtbs_TamanhoShow(Sender: TObject);
    procedure Fm_SaborStrGrd_ListaClick(Sender: TObject);
    procedure Fm_SaborSb_AlteraClick(Sender: TObject);
    procedure Fm_SaborSb_InsereClick(Sender: TObject);
    procedure Fm_SaborSb_Botao2Click(Sender: TObject);
    procedure Fm_SaborSb_ExcluirClick(Sender: TObject);
    procedure Fm_TamanhoSb_ExcluirClick(Sender: TObject);
    procedure Fm_TamanhoStrGrd_ListaSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure DesativarTamanho1Click(Sender: TObject);
  private
    { Private declarations }

    procedure InsereSabor;
    Function ValidaAlteraSabor:Boolean;
    procedure AlteraSabor;

    Function ValidaExcluiSabor:Boolean;
    procedure ExcluiSabor;

    Procedure InsereTamanho;

    Procedure AbreListaTamanho;

    Function ValidaAlteraTamanho:Boolean;
    procedure AlteraTamanho;

    Function ValidaExcluiTamanho:Boolean;
    procedure ExcluiTamanho;

  public
    { Public declarations }
    procedure AtualizaPrecoTamanhoMultiplo;
    function ValidaInsereRecheio:Boolean;
  end;

implementation

{$R *.dfm}

uses Un_CardapioTamanho, ControllerCardapio, Un_Crp_Itens, Un_CardapioProduto,
  Un_Msg;

procedure TFm_CardapioMTP.InsereSabor;
Var
  Form : TFr_CardapioProduto;
begin
  Try
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'IMTP';
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := '';
      Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
      Cardapio.Registro.MedidaComercial := 0;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;

End;

Function TFm_CardapioMTP.ValidaAlteraSabor:Boolean;
Begin
  Result := True;
  if not Fm_CardapioMT.ValidaAlteraSabor then
  Begin
    Result := False;
    Exit;
  End;
End;

procedure TFm_CardapioMTP.AlteraSabor;
Var
  Form : TFr_CardapioProduto;
begin
  Try
    Form  := TFr_CardapioProduto.Create(self);
    with Form do
    Begin
      TipoOperacao := 'UMTP';
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := Fm_CardapioMT.fm_Sabor.StrGrd_Lista.Cells[2,Fm_CardapioMT.Fm_Sabor.StrGrd_Lista.Row];
      Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
      Cardapio.Registro.MedidaComercial := 0;
      Cardapio.getbyDG;
      Cardapio.Old_Descricao := Cardapio.Registro.Descricao;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;

End;

Function TFm_CardapioMTP.ValidaExcluiSabor:Boolean;
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

procedure TFm_CardapioMTP.ExcluiSabor;
Begin

End;

Procedure TFm_CardapioMTP.InsereTamanho;
Var
  Form : TFr_CardapioTamanho;
begin
  Try
    Form  := TFr_CardapioTamanho.Create(self);
    with Form do
    Begin
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := '';
      Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
      Cardapio.Registro.MedidaComercial := 0;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;
End;

procedure TFm_CardapioMTP.AbreListaTamanho;
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
                 'ORDER BY MED_SEQUENCIA,MED_DESCRICAO ');
    ParamByName('SBG_CODIGO').AsInteger := Fm_CardapioMT.Subgrupo;
    ParamByName('MED_ESPECIAL').AsString := Fm_CardapioMT.MedidaEspecial;
    Active := True;
    FetchAll;
  End;
end;

Function TFm_CardapioMTP.ValidaAlteraTamanho:Boolean;
Begin
  Result := True;
  if not FM_CardapioMT.ValidaAlteraTamanho then
  Begin
    Result := False;
    Exit;
  End;
End;

procedure TFm_CardapioMTP.AlteraTamanho;
Var
  Form : TFr_CardapioTamanho;
  Lc_Medida : Integer;
begin
  Try
    Form  := TFr_CardapioTamanho.Create(self);
    with Form do
    Begin
      Cardapio.Registro.Codigo := 0;
      Cardapio.Registro.Descricao := '';
      Cardapio.Registro.CodigoGrupo := Fm_CardapioMT.GRupo;
      Cardapio.Registro.CodigoSubGrupo := Fm_CardapioMT.SubGrupo;
      Lc_Medida := StrToIntDef( FM_CardapioMT.Fm_Tamanho.StrGrd_Lista.Cells[1,FM_CardapioMT.Fm_Tamanho.StrGrd_Lista.Row] , 0);
      Cardapio.Registro.MedidaComercial := Lc_Medida;
      ShowModal;
    End;
  Finally
    FreeAndNil(Form);
  End;
End;

Function TFm_CardapioMTP.ValidaExcluiTamanho:Boolean;
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

procedure TFm_CardapioMTP.ExcluiTamanho;
Begin

End;


procedure TFm_CardapioMTP.IniciaVariaveis;
begin
  with Fm_CardapioMT do
  Begin
    MontaGradeSabor;
    AbreListaSabor;
    PreencheGradeSabor;
    MontaGradeTamanho;
    AbreListaTamanho;
    PreencheGradeTamanho;
  End;
end;

function TFm_CardapioMTP.ValidaInsereRecheio:Boolean;
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

procedure TFm_CardapioMTP.Fm_CardapioMTtbs_TamanhoShow(Sender: TObject);
begin
  with Fm_CardapioMT do
  Begin
    AbreListaTamanho;
    PreencheGradeTamanho;
  End;
end;

procedure TFm_CardapioMTP.Fm_SaborSb_AlteraClick(Sender: TObject);
begin
  if ValidaAlteraSabor then
  Begin
    AlteraSabor;
    Fm_CardapioMT.AbreListaSabor;
    Fm_CardapioMT.PreencheGradesabor;
  End;
end;

procedure TFm_CardapioMTP.Fm_SaborSb_Botao1Click(Sender: TObject);
var
  Lc_Form: TFr_Crp_Itens;
Begin
  if ValidaInsereRecheio then
  Begin
    Try
      Lc_Form := TFr_Crp_Itens.Create(nil);
      with Lc_Form,Fm_CardapioMT.Fm_Sabor do
      Begin
        Lc_Form.CodigoGrupo           := Fm_CardapioMT.GRupo;
        CardapioItens.Registro.Sabor  := StrGrd_Lista.Cells[2,StrGrd_Lista.Row];
        Caption := 'Recheio(s) para o Sabor - ' + CardapioItens.Registro.Sabor;
        CardapioItens.Registro.Tipo   := 'P';
        E_Vl_Extra.Text               := '0,00';
        E_Vl_Extra.ReadOnly           := True;
        E_Vl_Extra.TabStop            := False;
        ShowModal;
      End;
    Finally
      Lc_Form.disposeOf;
    End;
  End;
end;

procedure TFm_CardapioMTP.Fm_SaborSb_Botao2Click(Sender: TObject);
var
  Lc_Form: TFr_Crp_Itens;
Begin
  if ValidaInsereRecheio then
  Begin
    Try
      Lc_Form := TFr_Crp_Itens.Create(Self);
      with Lc_Form,Fm_CardapioMT.Fm_Sabor do
      Begin
        Lc_Form.CodigoGrupo           := Fm_CardapioMT.GRupo;
        CardapioItens.Registro.Sabor  := 'TODOS';
        Caption := 'Opções de recheio(s) para o todos Sabores ';
        CardapioItens.Registro.Tipo   := 'O';
        E_Vl_Extra.Text               := '0,00';
        E_Vl_Extra.ReadOnly           := False;
        E_Vl_Extra.TabStop            := True;
        ShowModal;
      End;
    Finally
      FreeAndNil(Lc_Form);
    End;
  End;

end;

procedure TFm_CardapioMTP.Fm_SaborSb_ExcluirClick(Sender: TObject);
begin
  if ValidaExcluiSabor then
  Begin
    ExcluiSabor;
    Fm_CardapioMT.AbreListaSabor;
    Fm_CardapioMT.PreencheGradesabor;
  End;
end;

procedure TFm_CardapioMTP.Fm_SaborSb_InsereClick(Sender: TObject);
begin
  InsereSabor;
  Fm_CardapioMT.AbreListaSabor;
  Fm_CardapioMT.PreencheGradesabor;
end;

procedure TFm_CardapioMTP.Fm_SaborStrGrd_ListaClick(Sender: TObject);
begin
  with Fm_CardapioMT do
  Begin
    AbreListaTamanho;
    PreencheGradeTamanho;
  End;
end;

procedure TFm_CardapioMTP.Fm_TamahoSb_AlteraClick(Sender: TObject);
begin
  if ValidaAlteraTamanho then
  Begin
    AlteraTamanho;
    AbreListaTamanho;
    Fm_CardapioMT.PreencheGradeTamanho;
  End;
end;

procedure TFm_CardapioMTP.Fm_TamahoSb_InsereClick(Sender: TObject);
begin
  InsereTamanho;
  AbreListaTamanho;
  Fm_CardapioMT.PreencheGradeTamanho;
end;

procedure TFm_CardapioMTP.AtualizaPrecoTamanhoMultiplo;
Var
  I : Integer;
  Lc_Cardapio : TControllerCardapio;
begin
  Try
    Lc_Cardapio := TControllerCardapio.Create(self);
    with Fm_CardapioMT.Fm_Tamanho.StrGrd_Lista do
    Begin
      for I := 1 to (RowCount - 1) do
      Begin
        if StrToIntDef( Cells[1,I],0) > 0 then
        Begin
          Lc_Cardapio.Registro.CodigoSubgrupo := Fm_CardapioMT.SubGrupo;
          Lc_Cardapio.Registro.MedidaComercial := StrtoIntDef(Cells[1,I],0);
          Lc_Cardapio.PrecoNormal   := StrToFloatDef(Cells[5,I],0);
          Lc_Cardapio.PrecoPromocao := StrToFloatDef(Cells[6,I],0);
          Lc_Cardapio.AtualizaPrecoTamanhoMultiplo;
        End;
      End;
    End;
  Finally
    FReeAndNil(Lc_Cardapio);
  End;
end;

procedure TFm_CardapioMTP.DesativarTamanho1Click(Sender: TObject);
Var
  LcMedida : TControllerMedida;
begin
  if (MensagemPadrao('Mensagem de Confirmação',
                     'Desseja Desativar esta medida? Isso vai desativar todos os Produtos Relacionados.'+EOLN+EOLN+
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

procedure TFm_CardapioMTP.Fm_TamanhoSb_Botao1Click(Sender: TObject);
begin
  AtualizaPrecoTamanhoMultiplo;
  AbreListaTamanho;
  Fm_CardapioMT.PreencheGradeTamanho;
end;

procedure TFm_CardapioMTP.Fm_TamanhoSb_Botao2Click(Sender: TObject);
begin
  Fm_CardapioMT.OrdenaSequenciaTamanho;
  AbreListaTamanho;
  Fm_CardapioMT.PreencheGradeTamanho;
end;

procedure TFm_CardapioMTP.Fm_TamanhoSb_ExcluirClick(Sender: TObject);
begin
  if ValidaExcluiTamanho then
  Begin
    ExcluiTamanho;
    AbreListaTamanho;
    Fm_CardapioMT.PreencheGradeTamanho;
  End;
end;

procedure TFm_CardapioMTP.Fm_TamanhoStrGrd_ListaSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  Fm_CardapioMT.Fm_TamanhoStrGrd_ListaSelectCell(Sender, ACol, ARow,
  CanSelect);

end;

end.
