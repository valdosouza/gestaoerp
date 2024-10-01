unit reg_tax_icms_sn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, controllertaxicmssn;

type
  TRegTaxIcmsSn = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Grupo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Grupo: TEdit;
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
    taxicmssn : TControllertaxicmssn;
  end;
var
  Regtaxicmssn: TRegtaxicmssn;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegtaxicmssn.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegtaxicmssn.ClearAllFields;
begin
  inherited;
  taxicmssn.clear;
end;

procedure TRegtaxicmssn.CriarVariaveis;
begin
  inherited;
  taxicmssn := TControllertaxicmssn.create(self);
end;

procedure TRegtaxicmssn.Delete;
begin
  taxicmssn.delete;
  inherited;
end;

procedure TRegtaxicmssn.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxicmssn);
end;

procedure TRegtaxicmssn.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    taxicmssn.Registro.Codigo := Self.CodigoRegistro;
    taxicmssn.getbyId;
  End;
  inherited;
end;

procedure TRegtaxicmssn.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegtaxicmssn.Save;
begin
  with taxicmssn do
  Begin
    registro.Grupo := E_Grupo.Text;
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := taxicmssn.Registro.Codigo;
  inherited;
end;

procedure TRegtaxicmssn.ShowData;
begin
  with taxicmssn do
  Begin
    E_Codigo.Text := Registro.Codigo.ToString;
    E_Grupo.Text  := Registro.Grupo;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegtaxicmssn.ShowNoData;
begin
  E_Codigo.clear;
  E_Grupo.clear;
  E_Descricao.clear;
end;

function TRegtaxicmssn.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegtaxicmssn.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
