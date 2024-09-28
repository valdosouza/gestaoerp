unit reg_coating;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerCoating;

type
  TRegCoating = class(TBaseRegistry)
    E_Descricao: TEdit;
    L_Descricao: TLabel;
    Lb_Codigo: TLabel;
    E_Codigo: TEdit;
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
    coating : TControllerCoating;
  end;
var
  RegCoating: TRegCoating;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegCoating.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCoating.ClearAllFields;
begin
  inherited;
  coating.clear;
end;

procedure TRegCoating.CriarVariaveis;
begin
  inherited;
  coating := TControllercoating.create(self);
end;

procedure TRegCoating.Delete;
begin
  coating.delete;
  inherited;
end;

procedure TRegCoating.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(coating);
end;

procedure TRegCoating.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    coating.Registro.Codigo := Self.CodigoRegistro;
    coating.getbyId;
  End;
  inherited;
end;

procedure TRegCoating.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCoating.Save;
begin
  with coating do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := coating.Registro.Codigo;
  inherited;
end;

procedure TRegCoating.ShowData;
begin
  with coating do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegCoating.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegCoating.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegCoating.ValidateSave: boolean;
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
