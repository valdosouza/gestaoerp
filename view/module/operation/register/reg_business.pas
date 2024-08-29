unit reg_business;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons, System.StrUtils,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerNegocio;

type
  TRegBusiness = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    ChBx_Exclusivo: TCheckBox;
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
    negocio : TControllerNegocio;
  end;

var
  RegBusiness: TRegBusiness;

implementation

{$R *.dfm}

uses UN_MSG, env;

{ TRegJobPosition }

procedure TRegBusiness.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegBusiness.ClearAllFields;
begin
  inherited;
  negocio.Clear;
end;

procedure TRegBusiness.CriarVariaveis;
begin
  inherited;
  negocio := TControllerNegocio.create(self);
end;

procedure TRegBusiness.Delete;
begin
  negocio.delete;
  inherited;
end;

procedure TRegBusiness.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(negocio);
end;

procedure TRegBusiness.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    negocio.Registro.Codigo := Self.CodigoRegistro;
    negocio.getbyId;
  End;
  inherited;
end;

procedure TRegBusiness.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegBusiness.Save;
begin
  with negocio do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Exclusivo := IfThen(ChBx_Exclusivo.Checked, SIGLA_S, SIGLA_N);
    salva;
  End;
  CodigoRegistro := negocio.Registro.Codigo;
  inherited;
end;

procedure TRegBusiness.ShowData;
begin
  with negocio do
  Begin
    E_Descricao.Text  := Registro.Descricao;
    if Registro.Exclusivo = SIGLA_S then
      ChBx_Exclusivo.Checked := True
    else
      ChBx_Exclusivo.Checked := False;
  End;
  inherited;
end;

procedure TRegBusiness.ShowNoData;
begin
  E_Descricao.clear;
end;

function TRegBusiness.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegBusiness.ValidateSave: boolean;
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
