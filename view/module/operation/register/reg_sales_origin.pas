unit reg_sales_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, controllersalesorigin;

type
  TRegSalesOrigin = class(TBaseRegistry)
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    L_Descricao: TLabel;
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
    salesOrigin : TControllersalesOrigin;
  end;
var
  RegsalesOrigin: TRegsalesOrigin;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegsalesOrigin.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegsalesOrigin.ClearAllFields;
begin
  inherited;
  salesOrigin.clear;
end;

procedure TRegsalesOrigin.CriarVariaveis;
begin
  inherited;
  salesOrigin := TControllersalesOrigin.create(self);
end;

procedure TRegsalesOrigin.Delete;
begin
  salesOrigin.delete;
  inherited;
end;

procedure TRegsalesOrigin.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(salesOrigin);
end;

procedure TRegsalesOrigin.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    salesOrigin.Registro.Codigo := Self.CodigoRegistro;
    salesOrigin.getbyId;
  End;
  inherited;
end;

procedure TRegsalesOrigin.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegsalesOrigin.Save;
begin
  with salesOrigin do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := salesOrigin.Registro.Codigo;
  inherited;
end;

procedure TRegsalesOrigin.ShowData;
begin
  with salesOrigin do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegsalesOrigin.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegsalesOrigin.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegsalesOrigin.ValidateSave: boolean;
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
