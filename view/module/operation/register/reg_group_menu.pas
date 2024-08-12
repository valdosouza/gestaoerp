unit reg_group_menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.Buttons, System.StrUtils,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, base_registry, ControllerGrupos,
  Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TRegGroupMenu = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Descricao: TLabel;
    Lb_Desconto: TLabel;
    Lb_Sequencia: TLabel;
    E_Descricao: TEdit;
    E_Vl_Desconto: TEdit;
    DBRG_Tamanhos: TRadioGroup;
    DBRG_Interface: TRadioGroup;
    DBRG_Composicao: TRadioGroup;
    ChBx_Propag_Tamanho: TCheckBox;
    ChBx_Agrupar_Abas: TCheckBox;
    E_Sequencia: TEdit;
    ChBx_Ativo: TCheckBox;
    ChBx_show_menu: TCheckBox;
    Chbx_Ifood: TCheckBox;
    pnlGrid: TPanel;
    Sb_SubGrupos: TSpeedButton;
    DBGrid1: TDBGrid;
    cds_subgrupo: TClientDataSet;
    cds_subgrupocodigo: TIntegerField;
    cds_subgrupodescricao: TStringField;
    cds_subgrupodescricao_subgrupo: TStringField;
    ds_subgrupo: TDataSource;
    procedure DBRG_ComposicaoClick(Sender: TObject);
    procedure Sb_SubGruposClick(Sender: TObject);
  private
    procedure AtivarDesativarProdutos;
    procedure MontarGrid(pCodigo: integer);
  protected
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
  public
    grupos : TControllerGrupos;
  end;

var
  RegGroupMenu: TRegGroupMenu;

implementation

uses UN_MSG, reg_subgroup_menu;

{$R *.dfm}

procedure TRegGroupMenu.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegGroupMenu.CriarVariaveis;
begin
  inherited;
  grupos := TControllerGrupos.create(self);
end;

procedure TRegGroupMenu.DBRG_ComposicaoClick(Sender: TObject);
begin
  inherited;
  if DBRG_Composicao.ItemIndex = 1 then
  Begin
    DBRG_Interface.ItemIndex := 0;
    DBRG_Interface.Enabled := False;
  end
  else
  Begin
    DBRG_Interface.Enabled := True;
  end;
end;

procedure TRegGroupMenu.Delete;
begin
  grupos.delete;
  inherited;
end;

procedure TRegGroupMenu.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(grupos);
end;

procedure TRegGroupMenu.IniciaVariaveis;
begin
  MontarGrid(Self.CodigoRegistro);
  if Self.CodigoRegistro > 0 then
  Begin
    grupos.Registro.Codigo := Self.CodigoRegistro;
    grupos.getbyId;
  End;
  inherited;
end;

procedure TRegGroupMenu.Insert;
begin
  inherited;
  grupos.clear;
  E_Descricao.SetFocus;
end;

procedure TRegGroupMenu.Save;
begin
  with grupos do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.ValorDesconto := StrToFloatDef(E_Vl_Desconto.Text, 0);
    Registro.Composicao := IntToStr(DBRG_Composicao.ItemIndex);
    Registro.ControleInterface := IntToStr(DBRG_Interface.ItemIndex);
    Registro.Tamanhos := IfThen(DBRG_Tamanhos.ItemIndex =  0, SIM, NAO);
    Registro.IfoodAtivo := IfThen(Chbx_Ifood.Checked, SIM, NAO);
    Registro.PropagaTamanho := IfThen(ChBx_Propag_Tamanho.Checked, SIM, NAO);
    Registro.Agrupar := IfThen(ChBx_Agrupar_Abas.Checked, SIM, NAO);
    Registro.ShowMenu := IfThen(ChBx_show_menu.Checked, SIM, NAO);
    Registro.Ativo := IfThen(ChBx_Ativo.Checked, SIM, NAO);
    salva;
  End;
  AtivarDesativarProdutos;
  CodigoRegistro := grupos.Registro.Codigo;
  inherited;
end;

procedure TRegGroupMenu.Sb_SubGruposClick(Sender: TObject);
var
  Lc_form : TRegSubgroupMenu;
begin
  Lc_form := TRegSubgroupMenu.Create(self);
  Try
    Lc_form.CodigoGrupo := self.CodigoRegistro;
    Lc_form.ShowModal;
    MontarGrid(self.CodigoRegistro);
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TRegGroupMenu.ShowData;
begin
  with grupos do
  Begin
    E_Descricao.Text  := Registro.Descricao;
    E_Vl_Desconto.Text := FloatToStrF(Registro.ValorDesconto, ffFixed, 10, 2);

    if Registro.Composicao <> EmptyStr then
      DBRG_Composicao.ItemIndex := StrToInt(Registro.Composicao);

    if Registro.ControleInterface <> EmptyStr then
      DBRG_Interface.ItemIndex := StrToInt(Registro.ControleInterface);

    if Registro.Tamanhos = SIM then
      DBRG_Tamanhos.ItemIndex := 0
    else
      DBRG_Tamanhos.ItemIndex := 1;

    if Registro.IfoodAtivo = SIM then
      Chbx_Ifood.Checked := True
    else
      Chbx_Ifood.Checked := False;

    if Registro.PropagaTamanho = SIM then
      ChBx_Propag_Tamanho.Checked := True
    else
      ChBx_Propag_Tamanho.Checked := False;

    if Registro.Agrupar = SIM then
      ChBx_Agrupar_Abas.Checked := True
    else
      ChBx_Agrupar_Abas.Checked := False;

    if Registro.ShowMenu = SIM then
      ChBx_show_menu.Checked := True
    else
      ChBx_show_menu.Checked := False;

    if Registro.Ativo = SIM then
      ChBx_Ativo.Checked := True
    else
      ChBx_Ativo.Checked := False;
  End;
  inherited;
end;

procedure TRegGroupMenu.ShowNoData;
begin
  E_Descricao.clear;
end;

function TRegGroupMenu.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegGroupMenu.ValidateSave: boolean;
Var
  Lc_Cd_Grupo : Integer;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(Lb_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  //Verifica se um grupo com a mesma descrição existe
  Lc_Cd_Grupo := grupos.Fc_GrupoExiste(grupos.Registro.Codigo, E_Descricao.Text);

  if (Lc_Cd_Grupo > 0) then
  Begin
    if (Mensagem('Mensagem de Confirmação',
                       'Já existe um grupo com esta descrição.' + EOLN + EOLN +
                       'Deseja visualizar este registro ?',
                       ['Sim', 'Não'], [bNormal,bEscape], mpConfirmacao, clBtnFace) = mrBotao1) then
    Begin
      grupos.Registro.Codigo := Lc_Cd_Grupo;
      grupos.getbyId;
      ShowData;
      Result:=false;
      exit;
    end
    else
    Begin
      Mensagem('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Altere a descrição para continuar.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
      Result:=false;
      exit;
    end;
  end;
end;

procedure TRegGroupMenu.AtivarDesativarProdutos;
Var
  LcGRupo : TControllerGrupos;
begin
  LcGRupo := TControllerGrupos.create(Nil);
  try
    LcGRupo.AtivarDesativarProdutos( grupos.Registro.Codigo, grupos.Registro.Ativo = SIM);
  finally
    LcGrupo.DisposeOf;
  end;
end;

procedure TRegGroupMenu.MontarGrid(pCodigo: integer);
var
  i : Integer;
begin
  if pCodigo > 0 then
  begin
    with Grupos do
    begin
      SubGrupo.Clear;

      SubGrupo.Parametros.FieldName.Grupo := pCodigo;

      SubGrupo.Search;

      if not cds_subgrupo.Active then
        cds_subgrupo.CreateDataSet;

      cds_subgrupo.EmptyDataSet;

      cds_subgrupo.DisableControls;

      for i := 0 to Pred(SubGrupo.Lista.Count) do
        cds_subgrupo.AppendRecord([SubGrupo.Lista[i].Codigo, SubGrupo.Lista[i].Grupo, SubGrupo.Lista[i].Descricao]);

      cds_subgrupo.EnableControls;
    end;
  end;
end;

end.
