unit reg_customer_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerCustomerOrigin;

type
  TRegCustomerOrigin = class(TBaseRegistry)
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
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
    CustomerOrigin : TControllerCustomerOrigin;
  end;

var
  RegCustomerOrigin: TRegCustomerOrigin;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegCustomerOrigin.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCustomerOrigin.ClearAllFields;
begin
  inherited;
  CustomerOrigin.clear;
end;

procedure TRegCustomerOrigin.CriarVariaveis;
begin
  inherited;
  CustomerOrigin := TControllerCustomerOrigin.create(self);
end;

procedure TRegCustomerOrigin.Delete;
begin
  CustomerOrigin.delete;
  inherited;
end;

procedure TRegCustomerOrigin.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(CustomerOrigin);
end;

procedure TRegCustomerOrigin.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    CustomerOrigin.Registro.Codigo := Self.CodigoRegistro;
    CustomerOrigin.getbyId;
  End;
  inherited;
end;

procedure TRegCustomerOrigin.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCustomerOrigin.Save;
begin
  with CustomerOrigin do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := CustomerOrigin.Registro.Codigo;
  inherited;
end;

procedure TRegCustomerOrigin.ShowData;
begin
  with CustomerOrigin do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegCustomerOrigin.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegCustomerOrigin.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegCustomerOrigin.ValidateSave: boolean;
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
