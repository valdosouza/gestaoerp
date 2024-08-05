unit reg_city;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  base_registry, ControllerCidade;

type
  TRegCity = class(TBaseRegistry)
    E_Codigo: TEdit;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    L_UF: TLabel;
    CB_UF: TComboBox;
    E_IBGE: TEdit;
    L_IBGE: TLabel;
    E_AliquotaISS: TEdit;
    L_AliquotaISS: TLabel;
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
    cidade : TControllerCidade;
  end;

var
  RegCity: TRegCity;

implementation

uses UN_MSG;

{$R *.dfm}

{ TRegCity }

procedure TRegCity.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegCity.CriarVariaveis;
begin
  inherited;
  cidade := TControllerCidade.create(self);
end;

procedure TRegCity.Delete;
begin
  cidade.delete;
  inherited;
end;

procedure TRegCity.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cidade);
end;

procedure TRegCity.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    cidade.Registro.Codigo := Self.CodigoRegistro;
    cidade.getbyId;
  End;
  inherited;
end;

procedure TRegCity.Insert;
begin
  inherited;
  CB_UF.ItemIndex := -1;
  E_Descricao.SetFocus;
end;

procedure TRegCity.Save;
begin
  with cidade do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Estado := CB_UF.Text;
    Registro.IBGE := StrToIntDef(E_IBGE.Text, 0);
    Registro.AliqISS := StrToFloatDef(E_AliquotaISS.Text, 0);
    salva;
  End;
  CodigoRegistro := cidade.Registro.Codigo;
  inherited;
end;

procedure TRegCity.ShowData;
begin
  with cidade do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    CB_UF.ItemIndex := CB_UF.Items.IndexOf(Registro.Estado);
    E_IBGE.Text := Registro.IBGE.ToString;
    E_AliquotaISS.Text := FloatToStrF(Registro.AliqISS, ffFixed, 10, 2);
  End;
  inherited;
end;

procedure TRegCity.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegCity.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegCity.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if CB_UF.Text = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_UF.Caption);
    Result := False;
    CB_UF.SetFocus;
    Exit;
  end;

  if (Trim(E_IBGE.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_IBGE.Caption);
    Result := False;
    CB_UF.SetFocus;
    Exit;
  end;
end;

end.
