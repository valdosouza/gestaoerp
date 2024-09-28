unit reg_subgroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerSubGrupos;

type
  TRegSubgroup = class(TBaseRegistry)
    pnl_fundos: TPanel;
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
    SubGroup : TControllerSubGrupos;
  end;

var
  RegSubgroup: TRegSubgroup;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegSubGroup.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegSubGroup.ClearAllFields;
begin
  inherited;
  SubGroup.clear;
end;

procedure TRegSubGroup.CriarVariaveis;
begin
  inherited;
  SubGroup := TControllerSubGrupos.create(self);
end;

procedure TRegSubGroup.Delete;
begin
  SubGroup.delete;
  inherited;
end;

procedure TRegSubGroup.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(SubGroup);
end;

procedure TRegSubGroup.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    SubGroup.Registro.Codigo := Self.CodigoRegistro;
    SubGroup.getbyId;
  End;
  inherited;
end;

procedure TRegSubGroup.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegSubGroup.Save;
begin
  with SubGroup do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Grupo := 1; //Modificar
    salva;
  End;
  CodigoRegistro := SubGroup.Registro.Codigo;
  inherited;
end;

procedure TRegSubGroup.ShowData;
begin
  with SubGroup do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegSubGroup.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegSubGroup.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegSubGroup.ValidateSave: boolean;
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
