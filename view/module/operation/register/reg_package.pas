unit reg_package;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  base_registry, ControllerEmbalagem;

type
  TRegPackage = class(TBaseRegistry)
    pnl_fundos: TPanel;
    Lb_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Abreviatura: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Abreviatura: TEdit;
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
    embalagem : TControllerEmbalagem;
  end;

var
  RegPackage: TRegPackage;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegPackage.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegPackage.CriarVariaveis;
begin
  inherited;
  embalagem := TControllerEmbalagem.create(self);
end;

procedure TRegPackage.Delete;
begin
  embalagem.delete;
  inherited;
end;

procedure TRegPackage.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(embalagem);
end;

procedure TRegPackage.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    embalagem.Registro.Codigo := Self.CodigoRegistro;
    embalagem.getbyId;
  End;
  inherited;
end;

procedure TRegPackage.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegPackage.Save;
begin
  with embalagem do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Abreviatura := E_Abreviatura.Text;
    salva;
  End;
  CodigoRegistro := embalagem.Registro.Codigo;
  inherited;
end;

procedure TRegPackage.ShowData;
begin
  with embalagem do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_Abreviatura.Text  := Registro.Abreviatura;
  End;
  inherited;
end;

procedure TRegPackage.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegPackage.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegPackage.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Trim(E_Abreviatura.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Abreviatura.Caption);
    Result := False;
    E_Abreviatura.SetFocus;
    Exit;
  end;
end;

end.
