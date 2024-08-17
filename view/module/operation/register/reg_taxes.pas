unit reg_taxes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.ComCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, System.StrUtils,
  base_registry, ControllerImpostos, Vcl.Mask, QEdit_Setes;

type
  TRegTaxes = class(TBaseRegistry)
    Panel2: TPanel;
    L_Aq_Pis: TLabel;
    L_Aq_Cofins: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Irpj: TLabel;
    L_Aq_Icms: TLabel;
    E_Aq_Pis: TEdit_Setes;
    E_Aq_Cofins: TEdit_Setes;
    E_Aq_CSLL: TEdit_Setes;
    E_Aq_Irpj: TEdit_Setes;
    E_Aq_Icms: TEdit_Setes;
  private
  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
    impostos : TControllerImpostos;
  end;

var
  RegTaxes: TRegTaxes;

implementation

{$R *.dfm}

{ TRegTaxes }

procedure TRegTaxes.Change;
begin
  inherited;
  E_Aq_Icms.SetFocus;
end;

procedure TRegTaxes.ClearAllFields;
begin
  inherited;
  impostos.Clear;
end;

procedure TRegTaxes.CriarVariaveis;
begin
  inherited;
  impostos := TControllerImpostos.create(self);
end;

procedure TRegTaxes.Delete;
begin
  impostos.delete;
  inherited;
end;

procedure TRegTaxes.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(impostos);
end;

procedure TRegTaxes.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    impostos.Registro.Codigo := Self.CodigoRegistro;
    impostos.getbyId;
  End;
  inherited;
end;

procedure TRegTaxes.Insert;
begin
  inherited;
  E_Aq_Icms.SetFocus;
end;

procedure TRegTaxes.Save;
begin
  with impostos do
  Begin
    registro.Icms := StrToFloatDef(E_Aq_Icms.Text, 0);
    registro.ContSocial := StrToFloatDef(E_Aq_CSLL.Text, 0);
    registro.pis := StrToFloatDef(E_Aq_Pis.Text, 0);
    registro.Irpj := StrToFloatDef(E_Aq_Irpj.Text, 0);
    registro.Cofins := StrToFloatDef(E_Aq_Cofins.Text, 0);
    salva;
  End;
  CodigoRegistro := impostos.Registro.Codigo;
  inherited;
end;

function TRegTaxes.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegTaxes.ValidateSave: boolean;
begin
  Result := True;
end;

end.
