unit reg_tax_icms_nr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerTaxIcmsNr;

type
  TRegTaxIcmsNr = class(TBaseRegistry)
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
    TaxIcmsNr : TControllerTaxIcmsNr;
  end;

var
  RegTaxIcmsNr: TRegTaxIcmsNr;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegTaxIcmsNr.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxIcmsNr.ClearAllFields;
begin
  inherited;
  TaxIcmsNr.clear;
end;

procedure TRegTaxIcmsNr.CriarVariaveis;
begin
  inherited;
  TaxIcmsNr := TControllerTaxIcmsNr.create(self);
end;

procedure TRegTaxIcmsNr.Delete;
begin
  TaxIcmsNr.delete;
  inherited;
end;

procedure TRegTaxIcmsNr.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxIcmsNr);
end;

procedure TRegTaxIcmsNr.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    TaxIcmsNr.Registro.Codigo := Self.CodigoRegistro;
    TaxIcmsNr.getbyId;
  End;
  inherited;
end;

procedure TRegTaxIcmsNr.Insert;
begin
  inherited;
  E_Grupo.SetFocus;
end;

procedure TRegTaxIcmsNr.Save;
begin
  with TaxIcmsNr do
  Begin
    Registro.Grupo := E_Grupo.Text;
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := TaxIcmsNr.Registro.Codigo;
  inherited;
end;

procedure TRegTaxIcmsNr.ShowData;
begin
  with TaxIcmsNr do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Grupo.Text  := Registro.Grupo;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegTaxIcmsNr.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegTaxIcmsNr.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxIcmsNr.ValidateSave: boolean;
begin
  Result := True;
  if Trim(E_Grupo.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Grupo.Caption);
    Result := False;
    E_Grupo.SetFocus;
    Exit;
  end;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
