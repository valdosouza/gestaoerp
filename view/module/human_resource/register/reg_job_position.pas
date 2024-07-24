unit reg_job_position;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  base_registry, ControllerCargo;

type
  TRegJobPosition = class(TBaseRegistry)
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    E_ID: TEdit;
    L_ID: TLabel;
  private
    { Private declarations }
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
    JobPosition : TControllerCargo;
  end;

var
  RegJobPosition: TRegJobPosition;

implementation

{$R *.dfm}

uses UN_MSG;

{ TRegJobPosition }

procedure TRegJobPosition.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegJobPosition.CriarVariaveis;
begin
  inherited;
  JobPosition := TControllerCargo.create(self);
end;

procedure TRegJobPosition.Delete;
begin
  JobPosition.delete;
  inherited;
end;

procedure TRegJobPosition.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(JobPosition);
end;

procedure TRegJobPosition.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    JobPosition.Registro.Codigo := Self.CodigoRegistro;
    JobPosition.getbyId;
  End;
  inherited;
end;

procedure TRegJobPosition.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegJobPosition.Save;
begin
  with JobPosition do
  Begin
    Registro.Descricao := E_Descricao.Text;
    salva;
  End;
  CodigoRegistro := JobPosition.Registro.Codigo;
  inherited;
end;

procedure TRegJobPosition.ShowData;
begin
  with JobPosition do
  Begin
    E_ID.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
  inherited;
end;

procedure TRegJobPosition.ShowNoData;
begin
  E_ID.clear;
  E_Descricao.clear;
end;

function TRegJobPosition.ValidateDelete: boolean;
begin
  Result := True;
  if (MensagemExcluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegJobPosition.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    MensagemValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
