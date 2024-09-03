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
    procedure SaveInterface;
    procedure SaveInterfaceHasPrivilege;
  public
    cInterface : TControllerInterface;
  end;

var
  RegInterface: TRegInterface;

implementation

uses UN_MSG, UnFunctions,env;

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

    cInterface.itensIfc.Parametros.FieldName.CodigoIfc := cInterface.Registro.Codigo;
    cInterface.itensIfc.search;
    
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
begin
  SaveInterface;
  SaveInterfaceHasPrivilege;
  CodigoRegistro := cInterface.Registro.Codigo;
  inherited;
end;

procedure TRegInterface.SaveInterface;
begin
  cInterface.Registro.Descricao := E_Descricao.Text;
  cInterface.Registro.FrName := E_FormName.Text;
  cInterface.Registro.CodMnu := cInterface.menus.getCodigoLista(cb_Menu.Text);
  cInterface.Registro.Sistema := IfThen(rgSistema.ItemIndex = 0, SIGLA_S, SIGLA_N);
  cInterface.salva;
end;

procedure TRegInterface.SaveInterfaceHasPrivilege;
var
  I : Integer;
Begin
  for I := 0 to Pred(ChkBx_Permissao.Count) do
  begin
    cInterface.itensIfc.registro.Codigo    := 0;
    cInterface.itensIfc.registro.CodigoIfc := cInterface.Registro.Codigo;
    cInterface.itensIfc.registro.CodigoOpf := StrToIntDef(Copy(ChkBx_Permissao.Items.Strings[I],1,2),0);
    if ChkBx_Permissao.Checked[I] then   
      cInterface.itensIfc.Insert
    else  
      cInterface.itensIfc.Delete
  end;
end;

procedure TRegInterface.ShowData;
Var
  Lc_Aux : String;
  Lc_I: Integer;
  Lc_CodigoOper : Integer;
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

  if (cInterface.itensIfc.Lista.Count > 0) then
  Begin
    for  Lc_I := 0 to ChkBx_Permissao.Count -1 do
    begin
      Lc_CodigoOper := StrToIntDef(Copy(ChkBx_Permissao.Items.Strings[Lc_I],1,2),0);
      ChkBx_Permissao.Checked[Lc_I] := cInterface.itensIfc.AchaOperacao(Lc_CodigoOper);
    end;
  End;
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

begin
  with cInterface do
  Begin
    operInterface.search;
    ChkBx_Permissao.Items.Clear;
    for i := 0 to Pred(operInterface.lista.Count) do
    begin
      Lc_Descricao := StrZero(operInterface.lista[I].Codigo, 2,0) + ' - ' +  operInterface.lista[I].Descricao;
      ChkBx_Permissao.Items.Add(Lc_Descricao);

    end;
  End;
end;

end.
