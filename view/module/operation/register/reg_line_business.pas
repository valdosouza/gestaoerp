unit reg_line_business;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerLineBusiness;

type
  TRegLineBusiness = class(TBaseRegistry)
    E_Descricao: TEdit;
    E_Codigo: TEdit;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
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
    LineBusiness : TControllerLineBusiness;
  end;
var
  RegLineBusiness: TRegLineBusiness;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegLineBusiness.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegLineBusiness.ClearAllFields;
begin
  inherited;
  LineBusiness.clear;
end;

procedure TRegLineBusiness.CriarVariaveis;
begin
  inherited;
  LineBusiness := TControllerLineBusiness.create(self);
end;

procedure TRegLineBusiness.Delete;
begin
  LineBusiness.delete;
  inherited;
end;

procedure TRegLineBusiness.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(LineBusiness);
end;

procedure TRegLineBusiness.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    LineBusiness.Registro.Codigo := Self.CodigoRegistro;
    LineBusiness.getbyId;
  End;
  inherited;
end;

procedure TRegLineBusiness.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegLineBusiness.Save;
begin
  with LineBusiness do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := LineBusiness.Registro.Codigo;
  inherited;
end;

procedure TRegLineBusiness.ShowData;
begin
  with LineBusiness do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegLineBusiness.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegLineBusiness.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegLineBusiness.ValidateSave: boolean;
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
