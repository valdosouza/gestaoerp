unit reg_tax_mode_det_bc_icms_st;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerTaxModeDetBcIcmsSt;

type
  TRegTaxModeDetBcIcmsSt = class(TBaseRegistry)
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
    TaxModeDetBcIcmsSt : TControllerTaxModeDetBcIcmsSt;
  end;

var
  RegTaxModeDetBcIcmsSt: TRegTaxModeDetBcIcmsSt;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegTaxModeDetBcIcmsSt.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxModeDetBcIcmsSt.ClearAllFields;
begin
  inherited;
  TaxModeDetBcIcmsSt.clear;
end;

procedure TRegTaxModeDetBcIcmsSt.CriarVariaveis;
begin
  inherited;
  TaxModeDetBcIcmsSt := TControllerTaxModeDetBcIcmsSt.create(self);
end;

procedure TRegTaxModeDetBcIcmsSt.Delete;
begin
  TaxModeDetBcIcmsSt.delete;
  inherited;
end;

procedure TRegTaxModeDetBcIcmsSt.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxModeDetBcIcmsSt);
end;

procedure TRegTaxModeDetBcIcmsSt.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    TaxModeDetBcIcmsSt.Registro.Codigo := Self.CodigoRegistro;
    TaxModeDetBcIcmsSt.getbyId;
  End;
  inherited;
end;

procedure TRegTaxModeDetBcIcmsSt.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxModeDetBcIcmsSt.Save;
begin
  with TaxModeDetBcIcmsSt do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := TaxModeDetBcIcmsSt.Registro.Codigo;
  inherited;
end;

procedure TRegTaxModeDetBcIcmsSt.ShowData;
begin
  with TaxModeDetBcIcmsSt do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegTaxModeDetBcIcmsSt.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegTaxModeDetBcIcmsSt.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxModeDetBcIcmsSt.ValidateSave: boolean;
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
