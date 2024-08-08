unit reg_kind_profitability;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  base_registry, ControllerKindLucratividade;

type
  TRegKindProfitability = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
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
    KindLucratividade : TControllerKindLucratividade;
  end;

var
  RegKindProfitability: TRegKindProfitability;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegKindProfitability.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegKindProfitability.CriarVariaveis;
begin
  inherited;
  KindLucratividade := TControllerKindLucratividade.create(self);
end;

procedure TRegKindProfitability.Delete;
begin
  KindLucratividade.delete;
  inherited;
end;

procedure TRegKindProfitability.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(KindLucratividade);
end;

procedure TRegKindProfitability.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    KindLucratividade.Registro.Codigo := Self.CodigoRegistro;
    KindLucratividade.getbyId;
  End;
  inherited;
end;

procedure TRegKindProfitability.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegKindProfitability.Save;
begin
  with KindLucratividade do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := KindLucratividade.Registro.Codigo;
  inherited;
end;

procedure TRegKindProfitability.ShowData;
begin
  with KindLucratividade do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegKindProfitability.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegKindProfitability.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegKindProfitability.ValidateSave: boolean;
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
