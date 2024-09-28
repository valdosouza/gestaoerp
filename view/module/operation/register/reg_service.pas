unit reg_service;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Classes,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  QEdit_Setes, System.StrUtils, base_registry, ControllerService,
  ControllerCategory, ControllerGrupos, ControllerSubGrupos, ControllerMedida,
  ControllerPreco, sea_measure, controllerItensNFL,      //Data.DB, un_dm,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Data.DB;

type
  TRegService = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_PrecoCusto: TLabel;
    L_Grupo: TLabel;
    L_SubGrupo: TLabel;
    SB_Grupos: TSpeedButton;
    L_Aq_Margem: TLabel;
    L_Medida: TLabel;
    L_Vl_Venda: TLabel;
    Sb_Medida: TSpeedButton;
    L_Aq_Comissao: TLabel;
    E_Descricao: TEdit;
    E_Codigo: TEdit;
    DBLCB_Grupo: TComboBox;
    DBLCB_SubGrupo: TComboBox;
    E_Aq_Margem: TEdit_Setes;
    E_Vl_Venda: TEdit_Setes;
    DBLCB_Medida: TComboBox;
    e_aq_comissao: TEdit_Setes;
    ChBx_ativo: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ME_Observ: TMemo;
    tbs_Internet: TTabSheet;
    Panel2: TPanel;
    L_Cadastro: TLabel;
    Sb_Category: TSpeedButton;
    Trw_Cadastro: TTreeView;
    E_PrecoCusto: TEdit_Setes;
    memCategory: TFDMemTable;
    memCategorycodigo: TIntegerField;
    memCategorydescricao: TStringField;
    memCategoryposicao: TStringField;
    procedure Sb_MedidaClick(Sender: TObject);
    procedure SB_GruposClick(Sender: TObject);
    procedure Sb_CategoryClick(Sender: TObject);
    procedure SB_alterarClick(Sender: TObject);
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
    service : TControllerService;
    category : TControllerCategory;
    grupo : TControllerGrupos;
    subgrupo : TControllerSubGrupos;
    medida: TControllerMedida;
    preco: TControllerPreco;
    itensNFL: TControllerItensNFL;

    procedure MontarComboBoxGrupo;
    procedure MontarComboBoxSubGrupo;
    procedure MontarComboBoxMedida;
    procedure CarregarCategoria;
    procedure Pc_MostraPreco(Pc_Cd_Servico: Integer);
    procedure Pc_AtualizaPreco(Pc_Cd_Servico: Integer);

    function Fc_NivelHierarquico(const fc_s: String): integer;
    procedure Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv: TTreeView; Pc_Pai: TTreeNode);
    function Fc_PosicionaNoCategoria(Fc_Tipo: Byte; Fc_Tree: TTreeView;
      Fc_Value: Integer; Fc_Visible: Boolean): TTreeNode;
  end;

var
  RegService: TRegService;

implementation

uses UN_MSG, env, sea_category;

{$R *.dfm}

procedure TRegService.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegService.ClearAllFields;
begin
  inherited;
  service.clear;
end;

procedure TRegService.CriarVariaveis;
begin
  inherited;
  service := TControllerservice.create(self);
  category := TControllerCategory.create(self);
  grupo := TControllerGrupos.create(self);
  subGrupo := TControllerSubGrupos.create(self);
  medida := TControllerMedida.create(self);
  preco := TControllerPreco.create(self);
  itensNFL := TControllerItensNFL.create(self);
end;

procedure TRegService.Delete;
begin
  IF itensNFL.Fc_ValidaExclusao(Self.CodigoRegistro) then
  Begin
    preco.Registro.CodigoTabela := 1;
    preco.Registro.CodigoProduto := Self.CodigoRegistro;
    preco.getbyId;
    preco.delete;

    service.delete;
    End;
  inherited;
end;

procedure TRegService.FinalizaVariaveis;
begin
  inherited;
  service.DisposeOf;
  category.DisposeOf;
  grupo.DisposeOf;
  subGrupo.DisposeOf;
  medida.DisposeOf;
  preco.DisposeOf;
  itensNFL.DisposeOf;
end;

procedure TRegService.IniciaVariaveis;
begin
  MontarComboBoxGrupo;
  MontarComboBoxSubGrupo;
  MontarComboBoxMedida;

  if Self.CodigoRegistro > 0 then
  Begin
    Pc_MostraPreco(Self.CodigoRegistro);
    service.Registro.Codigo := Self.CodigoRegistro;
    service.getbyId;
  End;

  CarregarCategoria;

  inherited;
end;

procedure TRegService.Insert;
begin
  inherited;
  E_Descricao.SetFocus;

  e_aq_comissao.Text := '0,00';
  E_PrecoCusto.Text := '0,00';
  E_Aq_Margem.Text := '0,00';
  e_vl_venda.Text := '0,00';
  ChBx_ativo.checked := True;
end;

procedure TRegService.Sb_CategoryClick(Sender: TObject);
var
  Lc_form : TSeaCategory;
begin
  Lc_form := TSeaCategory.Create(self);
  Try
    Lc_form.CodigoRegistro := 1;//editar
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TRegService.CarregarCategoria;
Var
  i : Integer;
begin
  category.Search;

  for i:= Trw_Cadastro.Items.Count - 1 downto 0 do
    Trw_Cadastro.Items.Item[i].Delete;

  //DM.qr_category.Active := False;
  //DM.qr_category.Active := True;

  category.Clear;
  category.Search;

  //institute adicionar
  if not memCategory.Active then
    memCategory.CreateDataSet;
  memCategory.EmptyDataSet;
  memCategory.DisableControls;
  for i := 0 to Pred(category.Lista.Count) do
    memCategory.AppendRecord([category.Lista[i].Codigo, category.Lista[i].Descricao, category.Lista[i].Posicao]);
  memCategory.EnableControls;
  memCategory.First;

  Pc_PreencherTreeView(memCategory, Trw_Cadastro, nil);
  //Pc_PreencherTreeView(DM.qr_category, Trw_Cadastro, nil);

  Fc_PosicionaNoCategoria(1,Trw_Cadastro,service.registro.categoria, TRUE);

  Trw_Cadastro.Enabled := True;
end;

procedure TRegService.Pc_PreencherTreeView(Pc_Query : TDataset; Pc_tv : TTreeView; Pc_Pai : TTreeNode );
var
  Lc_NivelAtual, Lc_NovoNivel, Lc_I : Byte;
  Lc_Descricao : String;
  Lc_NovoNo : TTreeNode;
begin
  Lc_NovoNo := nil;
  Lc_NivelAtual := Fc_NivelHierarquico( Pc_Query.FieldByName('Posicao').AsString ); //Pc_Query.Fields[3].AsAnsiString - category.lista[0].Posicao
  repeat
    Lc_Descricao :=  Pc_Query.FieldByName('Descricao').AsString; //Pc_Query.Fields[2].AsAnsiString - category.lista[i].Descricao
    Lc_NovoNivel := Fc_NivelHierarquico( Pc_Query.FieldByName('Posicao').AsString );  //Pc_Query.Fields[3].AsAnsiString - category.lista[i].Posicao
    if Lc_NovoNivel = Lc_NivelAtual then
    begin
      Lc_NovoNo := Pc_tv.Items.AddChild( Pc_Pai, lc_Descricao );
      Lc_NovoNo.ImageIndex := Pc_Query.FieldByName('Codigo').AsInteger;   //Pc_Query.Fields[0].AsInteger - category.lista[i].Codigo;
      Lc_NovoNo.SelectedIndex := Lc_NivelAtual * 2;
    end
    else
    begin
      if ( Lc_NovoNivel < Lc_NivelAtual ) then
      begin
        for Lc_I := 1 to Lc_NivelAtual - Lc_NovoNivel do
          Pc_Pai := Pc_Pai.Parent
      end
      else
      begin
        Pc_Pai := Lc_NovoNo;
      end;
      Pc_PreencherTreeView( Pc_Query, Pc_tv, Pc_Pai );
    end;
    Pc_Query.Next;
    Application.ProcessMessages;
  until Pc_Query.EOF;
end;

function TRegService.Fc_NivelHierarquico( const fc_s : String ) : integer;
Var
  Lc_Teste : integer;
begin
  Lc_Teste :=Length( StringReplace( fc_s, '.', '', [rfReplaceAll]));
  Result := Length( fc_s )- Lc_Teste ;
end;

Function TRegService.Fc_PosicionaNoCategoria (Fc_Tipo: Byte;Fc_Tree : TTreeView; Fc_Value:Integer; Fc_Visible: Boolean): TTreeNode;
var
  Node: TTreeNode;
begin
  Result := nil;
  if Fc_Tree.Items.Count = 0 then
    Exit;

  Node := Fc_Tree.Items[0];
  while Node <> nil do
  begin
    if (Fc_Value = Node.ImageIndex)  then
    begin
      Result := Node;
      if Visible then
      begin
        Result.MakeVisible;
        Result.Selected := True;
      end;
      if Fc_Tipo > 0 then
        Break;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TRegService.Save;
begin
  with service do
  Begin
    Registro.Descricao := E_Descricao.Text;

    Registro.CodigoEmbalagem := 1;
    Registro.CodigoMarca := 1;
    Registro.CodigoEstabelecimento := Gb_CodMha;
    Registro.FinalidadeTributacao := '6';
    Registro.CodigoNCM := '00';
    Registro.Origem := '0';
    Registro.SubsTrib := 'N';

    if Trw_Cadastro.Selected.ImageIndex > 0 then
      Registro.Categoria := Trw_Cadastro.Selected.ImageIndex;

    Registro.CodigoGrupo := Grupo.getCodigoLista(DBLCB_Grupo.Text);
    Registro.CodigoSubGrupo := SubGrupo.getCodigoLista(DBLCB_SubGrupo.Text);
    Registro.MedidaComercial := Medida.getCodigoLista(DBLCB_Medida.Text);
    Registro.ValorCusto := StrToFloatDef(E_PrecoCusto.Text,0);
    Registro.Detalhes := ME_Observ.Text;
    Registro.Ativo := IfThen(ChBx_ativo.Checked, SIGLA_S, SIGLA_N);

    salva;
  End;
  CodigoRegistro := service.Registro.Codigo;
  Pc_AtualizaPreco(CodigoRegistro);
  inherited;
end;

procedure TRegService.SB_alterarClick(Sender: TObject);
begin
  inherited;
  Trw_Cadastro.Enabled := True;
end;

procedure TRegService.SB_GruposClick(Sender: TObject);
begin
{
procedure TFr_Servico.SB_GruposClick(Sender: TObject);
Var
  Lc_Form : TFr_Grupos;
begin
  try
    Lc_Form := TFr_Grupos.Create(nil);
    Lc_Form.ShowModal;
  finally
    DM.Qr_Grupo.Active := False;
    DM.Qr_SubGrupo.Active := False;
    DM.Qr_Grupo.Active := True;
    DM.Qr_SubGrupo.Active := True;
    Tb_Cadastro.FieldByName('PRO_CODGRP').AsInteger := Lc_Form.It_CD_Grupo;
    Tb_Cadastro.FieldByName('PRO_CODSBG').AsInteger := Lc_Form.It_CD_SubGrupo;
    DBLCB_Grupo.KeyValue := Lc_Form.It_CD_Grupo;
    DBLCB_SubGrupo.KeyValue := Lc_Form.It_CD_SubGrupo;
    DBLCB_SubGrupo.SetFocus;
    Lc_Form.disposeOf;
  end;
end;
}
end;

procedure TRegService.Sb_MedidaClick(Sender: TObject);
Var
  Lc_Form : TSeaMeasure;
  Lc_Aux: string;
begin
    Lc_Form := TSeaMeasure.Create(nil);
  Try
    if (Trim(DBLCB_Medida.Text) <> EmptyStr) then
    begin
      Lc_Form.E_BuscaCodigo.Text := IntToStr(Medida.getCodigoLista(DBLCB_Medida.Text));
      Lc_Form.E_BuscaDescricao.Text := DBLCB_Medida.Text;
      Lc_Form.SearchMeasure;
    end;
    Lc_Form.ShowModal;
  Finally
    if Lc_Form.cds_searchcodigo.AsInteger > 0 then
    begin
      Lc_Aux := medida.getDescricaoLista(Lc_Form.cds_searchcodigo.AsInteger);
      DBLCB_Medida.ItemIndex := DBLCB_Medida.Items.IndexOf(Lc_Aux);
    end;
    Lc_Form.disposeOf;
  End;
end;

procedure TRegService.ShowData;
Var
  Lc_Aux : String;
begin
  with service do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;

    Lc_Aux := grupo.getDescricaoLista(Registro.CodigoGrupo);
    DBLCB_Grupo.ItemIndex := DBLCB_Grupo.Items.IndexOf(Lc_Aux);

    Lc_Aux := subgrupo.getDescricaoLista(Registro.CodigoSubgrupo);
    DBLCB_SubGrupo.ItemIndex := DBLCB_SubGrupo.Items.IndexOf(Lc_Aux);

    Lc_Aux := medida.getDescricaoLista(Registro.MedidaComercial);
    DBLCB_Medida.ItemIndex := DBLCB_Medida.Items.IndexOf(Lc_Aux);

    E_PrecoCusto.Text := FloatToStrF(Registro.ValorCusto, ffFixed, 10, 2);

    ME_Observ.Text := Registro.Detalhes;

    if Registro.Ativo = SIGLA_S then
      ChBx_ativo.Checked := True
    else
      ChBx_ativo.Checked := False;
  End;
  inherited;
  Trw_Cadastro.Enabled := True;
end;

procedure TRegService.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegService.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegService.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if TRIM(DBLCB_Grupo.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Grupo.Caption);
    Result := False;
    DBLCB_Grupo.SetFocus;
    Exit;
  end;

  if TRIM(DBLCB_SubGrupo.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_SubGrupo.Caption);
    Result := False;
    DBLCB_SubGrupo.SetFocus;
    Exit;
  end;

  if TRIM(DBLCB_Medida.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Medida.Caption);
    Result := False;
    DBLCB_Medida.SetFocus;
    Exit;
  end;

  if not Assigned(Trw_Cadastro.Selected) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Cadastro.Caption);
    Result := False;
    Exit;
  end;
end;

procedure TRegService.MontarComboBoxGrupo;
var
  i : Integer;
begin
  with grupo do
  Begin
    search;

    DBLCB_Grupo.Items.Clear;
    for i := 0 to Pred(lista.Count) do
      DBLCB_Grupo.Items.Add(lista[I].Descricao);
  End;
end;

procedure TRegService.MontarComboBoxSubGrupo;
var
  i : Integer;
begin
  with subgrupo do
  Begin
    search;

    DBLCB_SubGrupo.Items.Clear;
    for i := 0 to Pred(lista.Count) do
      DBLCB_SubGrupo.Items.Add(lista[I].Descricao);
  End;
end;

procedure TRegService.MontarComboBoxMedida;
var
  i : Integer;
begin
  with medida do
  Begin
    search;

    DBLCB_Medida.Items.Clear;
    for i := 0 to Pred(lista.Count) do
      DBLCB_Medida.Items.Add(lista[I].Descricao);
  End;
end;

Procedure TRegService.Pc_MostraPreco(Pc_Cd_Servico: Integer);
begin
  e_aq_comissao.Text := '0,00';
  e_Aq_Margem.Text := '0,00';
  e_vl_venda.Text := '0,00';

  with Preco do
  begin
    Clear;
    Parametros.FieldName.CodigoTabela := 1;
    Parametros.FieldName.CodigoProduto := Pc_Cd_Servico;
    Search;
    if Lista.Count > 0 then
    begin
      e_aq_comissao.Text := FloatToStrF(Lista[0].AliComissao, ffFixed, 10, 2);
      e_Aq_Margem.Text := FloatToStrF(Lista[0].MargemLucro, ffFixed, 10, 2);
      e_vl_venda.Text := FloatToStrF(Lista[0].Valor, ffFixed, 10, 2);
    end;
  end;
end;

procedure TRegService.Pc_AtualizaPreco(Pc_Cd_Servico: Integer);
Begin
  with Preco do
  begin
    Clear;
    Registro.CodigoTabela := 1;
    Registro.CodigoProduto := Pc_Cd_Servico;
    Registro.Valor := StrToFloatDef(e_vl_venda.Text, 0);
    Registro.AliComissao := StrToFloatDef(e_aq_comissao.Text, 0);
    Registro.MargemLucro := StrToFloatDef(E_Aq_Margem.Text, 0);
    salva;
  end;
end;

end.
