unit reg_vehicle_kind;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerVehicleKind;

type
  TRegVehicleKind = class(TBaseRegistry)
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
    vehicleKind : TControllerVehicleKind;
  end;
var
  RegVehicleKind: TRegVehicleKind;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegVehicleKind.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleKind.ClearAllFields;
begin
  inherited;
  vehicleKind.Clear;
end;

procedure TRegVehicleKind.CriarVariaveis;
begin
  inherited;
  vehicleKind := TControllerVehicleKind.create(self);
end;

procedure TRegVehicleKind.Delete;
begin
  RegVehicleKind.delete;
  inherited;
end;

procedure TRegVehicleKind.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(vehicleKind);
end;

procedure TRegVehicleKind.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    vehicleKind.Registro.Codigo := Self.CodigoRegistro;
    vehicleKind.getbyId;
  End;
  inherited;
end;

procedure TRegVehicleKind.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleKind.Save;
begin
  with vehicleKind do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := vehicleKind.Registro.Codigo;
  inherited;
end;

procedure TRegVehicleKind.ShowData;
begin
  with vehicleKind do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegVehicleKind.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegVehicleKind.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegVehicleKind.ValidateSave: boolean;
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
