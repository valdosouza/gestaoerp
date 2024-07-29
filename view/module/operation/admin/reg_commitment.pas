unit reg_commitment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.ComCtrls, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls, System.StrUtils,
  base_registry, ControllerAgenda;

type
  TRegCommitment = class(TBaseRegistry)
    M_Descricao: TMemo;
    E_Data: TDateTimePicker;
    L_Data: TLabel;
    L_Hora: TLabel;
    E_Hora: TDateTimePicker;
    CB_Usuario: TComboBox;
    L_Usuario: TLabel;
    L_Descricao: TLabel;
    Ch_Avisar: TCheckBox;
  private
    procedure MontaComboBoxBanco;
  protected
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  public
    agenda : TControllerAgenda;
  end;

var
  RegCommitment: TRegCommitment;

implementation

uses UN_MSG, env;

{$R *.dfm}

{ TRegCommitment }

procedure TRegCommitment.Change;
begin
  inherited;
  E_Data.SetFocus;
end;

procedure TRegCommitment.CriarVariaveis;
begin
  inherited;
  agenda := TControllerAgenda.create(self);
end;

procedure TRegCommitment.Delete;
begin
  agenda.delete;
  inherited;
end;

procedure TRegCommitment.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(agenda);
end;

procedure TRegCommitment.IniciaVariaveis;
begin
  MontaComboBoxBanco;
  if Self.CodigoRegistro > 0 then
  Begin
    agenda.Registro.Codigo := Self.CodigoRegistro;
    agenda.getbyId;
  End;
  inherited;
end;

procedure TRegCommitment.Insert;
begin
  inherited;
  E_Data.DateTime := Date;
  E_Hora.DateTime := Time;
  CB_Usuario.SetFocus;
end;

procedure TRegCommitment.MontaComboBoxBanco;
var
  i : Integer;
begin
  with agenda do
  Begin
    Usuario.search;
    CB_Usuario.Items.Clear;
    for i := 0 to Pred(Usuario.lista.Count) do
      CB_Usuario.Items.Add(Usuario.lista[I].Nome);
  End;
end;

procedure TRegCommitment.Save;
begin
  with agenda do
  Begin
    registro.Data := E_Data.DateTime;
    registro.Dia := E_Data.DateTime;
    registro.Hora := Copy(TimeToStr(E_Hora.Time),1,5);
    registro.ParaCodusu := Usuario.getCodigoLista(CB_Usuario.Text);
    Registro.Compromisso := M_Descricao.Text;
    registro.DecoDusu := Gb_Cd_Usuario;
    registro.Avisar := IfThen(Ch_Avisar.Checked, SIM, NAO);
    salva;
  End;
  CodigoRegistro := agenda.Registro.Codigo;
  inherited;
end;

function TRegCommitment.ValidateDelete: boolean;
begin
  Result := True;
  if (TMsg.Excluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;
end;

function TRegCommitment.ValidateSave: boolean;
begin
  Result := True;

  if Trim(CB_Usuario.Text) = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Usuario.Caption);
    Result := False;
    CB_Usuario.SetFocus;
    Exit;
  end;

  if Trim(M_Descricao.Text) = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    M_Descricao.SetFocus;
    Exit;
  end;
end;

end.
