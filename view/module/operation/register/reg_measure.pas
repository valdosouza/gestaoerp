unit reg_measure;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerMedida;

type
  TRegMeasure = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Abreviatura: TLabel;
    L_Escala: TLabel;
    L_Proporcao: TLabel;
    L_MedidaGrupo: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Abreviatura: TEdit;
    E_Escala: TEdit;
    E_Proporcao: TEdit;
    E_MedidaGRupo: TEdit;
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
  public
    medida : TControllerMedida;
  end;

var
  RegMeasure: TRegMeasure;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegMeasure.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegMeasure.ClearAllFields;
begin
  inherited;
  medida.clear;
end;

procedure TRegMeasure.CriarVariaveis;
begin
  inherited;
  medida := TControllermedida.create(self);
end;

procedure TRegMeasure.Delete;
begin
  medida.delete;
  inherited;
end;

procedure TRegMeasure.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(medida);
end;

procedure TRegMeasure.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    medida.Registro.Codigo := Self.CodigoRegistro;
    medida.getbyId;
  End;
  inherited;
end;

procedure TRegMeasure.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegMeasure.Save;
begin
  with medida do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Abreviatura := E_Abreviatura.Text;
    Registro.Escala := StrToFloatDef(E_Escala.Text, 0);
    Registro.Proporcao := StrToFloatDef(E_Proporcao.Text, 0);
    Registro.MedidaCardapio := E_MedidaGrupo.Text;

    salva;
  End;
  CodigoRegistro := medida.Registro.Codigo;
  inherited;
end;

procedure TRegMeasure.ShowData;
begin
  with medida do
  Begin
    E_Codigo.Text := Registro.Codigo.ToString;
    E_Descricao.Text := Registro.Descricao;
    E_Abreviatura.Text := Registro.Abreviatura;
    E_Escala.Text := FloatToStrF(Registro.Escala, ffFixed, 10, 2);
    E_Proporcao.Text := FloatToStrF(Registro.Proporcao, ffFixed, 10, 2);
    E_MedidaGRupo.Text := Registro.MedidaCardapio;
  End;
  inherited;
end;

procedure TRegMeasure.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegMeasure.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegMeasure.ValidateSave: boolean;
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
