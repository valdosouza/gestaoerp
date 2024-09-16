unit reg_tax_mode_det_bc_icms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerTaxModeDetBcIcms;

type
  TRegTaxModeDetBcIcms = class(TBaseRegistry)
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
    TaxModeDetBcIcms : TControllerTaxModeDetBcIcms;
  end;

var
  RegTaxModeDetBcIcms: TRegTaxModeDetBcIcms;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegTaxModeDetBcIcms.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxModeDetBcIcms.ClearAllFields;
begin
  inherited;
  TaxModeDetBcIcms.clear;
end;

procedure TRegTaxModeDetBcIcms.CriarVariaveis;
begin
  inherited;
  TaxModeDetBcIcms := TControllerTaxModeDetBcIcms.create(self);
end;

procedure TRegTaxModeDetBcIcms.Delete;
begin
  TaxModeDetBcIcms.delete;
  inherited;
end;

procedure TRegTaxModeDetBcIcms.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxModeDetBcIcms);
end;

procedure TRegTaxModeDetBcIcms.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    TaxModeDetBcIcms.Registro.Codigo := Self.CodigoRegistro;
    TaxModeDetBcIcms.getbyId;
  End;
  inherited;
end;

procedure TRegTaxModeDetBcIcms.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxModeDetBcIcms.Save;
begin
  with TaxModeDetBcIcms do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := TaxModeDetBcIcms.Registro.Codigo;
  inherited;
end;

procedure TRegTaxModeDetBcIcms.ShowData;
begin
  with TaxModeDetBcIcms do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegTaxModeDetBcIcms.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegTaxModeDetBcIcms.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxModeDetBcIcms.ValidateSave: boolean;
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
