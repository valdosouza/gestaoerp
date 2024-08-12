unit reg_subgroup_menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.Buttons, System.StrUtils,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, base_registry, ControllerSubGrupos;

type
  TRegSubgroupMenu = class(TBaseRegistry)
    pnl_fundos: TPanel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    L_Impressora: TLabel;
    L_Abas: TLabel;
    L_Descricao: TLabel;
    Lb_Codigo: TLabel;
    cb_Impressora: TComboBox;
    E_Abas: TEdit;
    ChBx_Ativo: TCheckBox;
  private
    procedure MontaComboBox;
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
    subGrupos : TControllerSubGrupos;
    CodigoGrupo : Integer;
  end;

var
  RegSubgroupMenu: TRegSubgroupMenu;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegSubgroupMenu.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegSubgroupMenu.CriarVariaveis;
begin
  inherited;
  subGrupos := TControllerSubGrupos.create(self);
end;

procedure TRegSubgroupMenu.Delete;
begin
  subGrupos.delete;
  inherited;
end;

procedure TRegSubgroupMenu.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(subGrupos);
end;

procedure TRegSubgroupMenu.IniciaVariaveis;
begin
  MontaComboBox;
  if Self.CodigoRegistro > 0 then
  Begin
    subGrupos.Registro.Codigo := Self.CodigoRegistro;
    subGrupos.getbyId;
  End;
  inherited;
end;

procedure TRegSubgroupMenu.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegSubgroupMenu.Save;
begin
  with subGrupos do
  Begin
    Registro.Grupo := CodigoGrupo;

    Registro.Descricao := E_Descricao.Text;
    Registro.Abas := E_Abas.Text;

    registro.Impressora := impressora.getCodigoLista(cb_Impressora.Text);
    Registro.Ativos := IfThen(ChBx_Ativo.Checked, SIM, NAO);

    salva;
  End;
  CodigoRegistro := subGrupos.Registro.Codigo;
  inherited;
end;

procedure TRegSubgroupMenu.ShowData;
var Lc_Aux: string;
begin
  with subGrupos do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;

    Lc_Aux := impressora.getDescLista(Registro.Impressora);
    cb_Impressora.ItemIndex := cb_Impressora.Items.IndexOf(Lc_Aux);

    if Registro.Ativos = SIM then
      ChBx_Ativo.Checked := True
    else
      ChBx_Ativo.Checked := False;
  End;
  inherited;
end;

procedure TRegSubgroupMenu.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegSubgroupMenu.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegSubgroupMenu.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Trim(E_Abas.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Abas.Caption);
    Result := False;
    E_Abas.SetFocus;
    Exit;
  end;
end;

procedure TRegSubgroupMenu.MontaComboBox;
var
  i : Integer;
begin
  with subGrupos do
  Begin
    impressora.search;
    cb_Impressora.Items.Clear;
    for i := 0 to Pred(impressora.lista.Count) do
      cb_Impressora.Items.Add(impressora.lista[I].Descricao);
  End;
end;

end.
