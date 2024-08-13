unit reg_printers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, System.StrUtils,
  base_registry, ControllerImpressora;

type
  TRegPrinters = class(TBaseRegistry)
    SeaPrinters: TPanel;
    L_Descricao: TLabel;
    L_Caminho: TLabel;
    L_Salto: TLabel;
    L_Vias: TLabel;
    L_Colunas: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Caminho: TEdit;
    Ch_Tipo: TCheckBox;
    E_Salto: TEdit;
    E_Vias: TEdit;
    E_Colunas: TEdit;
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
    impressora : TControllerImpressora;
  end;

var
  RegPrinters: TRegPrinters;

implementation

{$R *.dfm}

uses UN_MSG, env;

{ TRegJobPosition }

procedure TRegPrinters.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegPrinters.CriarVariaveis;
begin
  inherited;
  impressora := TControllerImpressora.create(self);
end;

procedure TRegPrinters.Delete;
begin
  impressora.delete;
  inherited;
end;

procedure TRegPrinters.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(impressora);
end;

procedure TRegPrinters.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    impressora.Registro.Codigo := Self.CodigoRegistro;
    impressora.getbyId;
  End;
  inherited;
end;

procedure TRegPrinters.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegPrinters.Save;
begin
  with impressora do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Caminho := E_Caminho.Text;
    Registro.Salto := StrToIntDef(E_Salto.Text, 0);
    Registro.Vias := StrToIntDef(E_Vias.Text, 0);
    Registro.Colunas := StrToIntDef(E_Colunas.Text, 0);
    Registro.Modelo := IfThen(Ch_Tipo.Checked, SIM, NAO);
    salva;
  End;
  CodigoRegistro := impressora.Registro.Codigo;
  inherited;
end;

procedure TRegPrinters.ShowData;
begin
  with impressora do
  Begin
    E_Descricao.Text  := Registro.Descricao;
    E_Caminho.Text := Registro.Caminho;
    E_Salto.Text := IntToStr(Registro.Salto);
    E_Vias.Text := IntToStr(Registro.Vias);
    E_Colunas.Text := IntToStr(Registro.Colunas);

    if Registro.Modelo = SIM then
      Ch_Tipo.Checked := True
    else
      Ch_Tipo.Checked := False;
  End;
  inherited;
end;

procedure TRegPrinters.ShowNoData;
begin
  E_Descricao.clear;
end;

function TRegPrinters.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegPrinters.ValidateSave: boolean;
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
