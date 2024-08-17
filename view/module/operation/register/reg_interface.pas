unit reg_interface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Mask, System.StrUtils,
  base_registry, ControllerInterface;

type
  TRegInterface = class(TBaseRegistry)
    Pn_Fundo: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_FormName: TLabel;
    L_Menu: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    GroupBox1: TGroupBox;
    ChkBx_Permissao: TCheckListBox;
    rgSistema: TRadioGroup;
    E_FormName: TEdit;
    cb_Menu: TComboBox;
  private
    procedure MontaComboBox;
    procedure MontaCheckListBox;
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
  public
    cInterface : TControllerInterface;
  end;

var
  RegInterface: TRegInterface;

implementation

uses UN_MSG, env;

{$R *.dfm}

procedure TRegInterface.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegInterface.ClearAllFields;
begin
  inherited;
  cInterface.Clear;
end;

procedure TRegInterface.CriarVariaveis;
begin
  inherited;
  cInterface := TControllerInterface.create(self);
end;

procedure TRegInterface.Delete;
begin
  cInterface.delete;
  inherited;
end;

procedure TRegInterface.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cInterface);
end;

procedure TRegInterface.IniciaVariaveis;
begin
  MontaComboBox;
  MontaCheckListBox;
  if Self.CodigoRegistro > 0 then
  Begin
    cInterface.Registro.Codigo := Self.CodigoRegistro;
    cInterface.getbyId;
  End;
  inherited;
end;

procedure TRegInterface.Insert;
var
  Lc_I: Integer;
begin
  inherited;
  for  Lc_I := 0 to Pred(ChkBx_Permissao.Count) do
    ChkBx_Permissao.Checked[Lc_I] := False;
  E_Descricao.SetFocus;
end;

procedure TRegInterface.Save;
var
  Lc_I, Lc_Codigo: Integer;
begin
  CodigoRegistro := cInterface.Registro.Codigo;
  cInterface.Registro.Descricao := E_Descricao.Text;
  cInterface.Registro.FrName := E_FormName.Text;
  cInterface.Registro.CodMnu := cInterface.menus.getCodigoLista(cb_Menu.Text);
  cInterface.Registro.Sistema := IfThen(rgSistema.ItemIndex = 0, SIGLA_S, SIGLA_N);

  for Lc_I := 0 to Pred(ChkBx_Permissao.Count) do
  begin
    Lc_Codigo := StrToIntDef(Copy(ChkBx_Permissao.Items.Strings[Lc_I],1,2),0);
    cInterface.itensIfc.registro.Codigo := CodigoRegistro;
    cInterface.itensIfc.registro.CodigoIfc := CodigoRegistro;
    cInterface.itensIfc.registro.CodigoOpf := Lc_Codigo;
    if ChkBx_Permissao.Checked[Lc_I] then   //tanto edição, como insert... esta falhando
      cInterface.itensIfc.Delete
    else
    begin
      if CodigoRegistro = 0 then
        cInterface.itensIfc.salva
      else
        cInterface.itensIfc.Replace;
    end;

  end;
  cInterface.salva;
  inherited;
end;

procedure TRegInterface.ShowData;
Var
  Lc_Aux : String;
  Lc_I: Integer;
  Lc_Codigo: Integer;
begin
  E_Codigo.Text     := cInterface.Registro.Codigo.ToString;
  E_Descricao.Text  := cInterface.Registro.Descricao;
  E_FormName.Text := cInterface.Registro.FrName;
  Lc_Aux := cInterface.menus.getDescLista(cInterface.Registro.CodMnu);
  cb_Menu.ItemIndex := cb_Menu.Items.IndexOf(Lc_Aux);

  if cInterface.Registro.Sistema = SIGLA_S then
    rgSistema.ItemIndex := 0
  else
    rgSistema.ItemIndex := 1;

  for  Lc_I := 0 to ChkBx_Permissao.Count -1 do
  begin
    Lc_Codigo := StrToIntDef(Copy(ChkBx_Permissao.Items.Strings[Lc_I],1,2),0);
    ChkBx_Permissao.Checked[Lc_I] := cInterface.itensIfc.AchaOperacao(cInterface.Registro.Codigo, Lc_Codigo);
  end;
  inherited;
end;

procedure TRegInterface.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegInterface.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegInterface.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Trim(E_FormName.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(l_FormName.Caption);
    Result := False;
    E_FormName.SetFocus;
    Exit;
  end;
end;

procedure TRegInterface.MontaComboBox;
var
  i : Integer;
begin
  with cInterface do
  Begin
    menus.search;
    cb_Menu.Items.Clear;
    for i := 0 to Pred(menus.lista.Count) do
      cb_Menu.Items.Add(menus.lista[I].Descricao);
  End;
end;

procedure TRegInterface.MontaCheckListBox;
var
  i : Integer;
  Lc_Descricao: string;

  function AdicionarZerosEsquerda(Numero: Integer; TotalDigitos: Integer): String;
  begin
    Result := Format('%.*d', [TotalDigitos, Numero]);
  end;

begin
  with cInterface do
  Begin
    operInterface.search;
    ChkBx_Permissao.Items.Clear;

    for i := 0 to Pred(operInterface.lista.Count) do
    begin
      Lc_Descricao := AdicionarZerosEsquerda(operInterface.lista[I].Codigo, 2) + '-' +  operInterface.lista[I].Descricao;

      ChkBx_Permissao.Items.Add(Lc_Descricao);
    end;
  End;
end;

end.
