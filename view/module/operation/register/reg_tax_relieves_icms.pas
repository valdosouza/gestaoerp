unit reg_tax_relieves_icms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerTaxRelievesIcms;

type
  TRegTaxRelievesIcms = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
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
    TaxRelievesIcms : TControllerTaxRelievesIcms;
  end;

var
  RegTaxRelievesIcms: TRegTaxRelievesIcms;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegTaxRelievesIcms.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxRelievesIcms.ClearAllFields;
begin
  inherited;
  TaxRelievesIcms.clear;
end;

procedure TRegTaxRelievesIcms.CriarVariaveis;
begin
  inherited;
  TaxRelievesIcms := TControllerTaxRelievesIcms.create(self);
end;

procedure TRegTaxRelievesIcms.Delete;
begin
  TaxRelievesIcms.delete;
  inherited;
end;

procedure TRegTaxRelievesIcms.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(TaxRelievesIcms);
end;

procedure TRegTaxRelievesIcms.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    TaxRelievesIcms.Registro.Codigo := Self.CodigoRegistro;
    TaxRelievesIcms.getbyId;
  End;
  inherited;
end;

procedure TRegTaxRelievesIcms.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegTaxRelievesIcms.Save;
begin
  with TaxRelievesIcms do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := TaxRelievesIcms.Registro.Codigo;
  inherited;
end;

procedure TRegTaxRelievesIcms.ShowData;
begin
  with TaxRelievesIcms do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegTaxRelievesIcms.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegTaxRelievesIcms.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxRelievesIcms.ValidateSave: boolean;
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
