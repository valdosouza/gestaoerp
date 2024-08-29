unit reg_vehicle_model;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Buttons, Vcl.ExtCtrls, base_registry, ControllerVehicleModel;

type
  TRegVehicleModel = class(TBaseRegistry)
    Panel1: TPanel;
    L_Descricao: TLabel;
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
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
    procedure ShowData; Override;
  public
    vehicleModel : TControllerVehicleModel;
    CodigoMarca: integer;
  end;

var
  RegVehicleModel: TRegVehicleModel;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegVehicleModel.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleModel.ClearAllFields;
begin
  inherited;
  vehicleModel.Clear;
end;

procedure TRegVehicleModel.CriarVariaveis;
begin
  inherited;
  vehicleModel := TControllerVehicleModel.create(self);
end;

procedure TRegVehicleModel.Delete;
begin
  vehicleModel.delete;
  inherited;
end;

procedure TRegVehicleModel.FinalizaVariaveis;
begin
  inherited;
  vehicleModel.DisposeOf;
end;

procedure TRegVehicleModel.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    vehicleModel.Registro.Codigo := Self.CodigoRegistro;
    vehicleModel.getbyId;
  End;
  inherited;
end;

procedure TRegVehicleModel.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegVehicleModel.Save;
begin
  with vehicleModel do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.CodigoMarca := CodigoMarca;
    salva;
  End;
  CodigoRegistro := vehicleModel.Registro.Codigo;
  inherited;
end;

procedure TRegVehicleModel.ShowData;
var Lc_Aux: string;
begin
  with vehicleModel do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

function TRegVehicleModel.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegVehicleModel.ValidateSave: boolean;
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
