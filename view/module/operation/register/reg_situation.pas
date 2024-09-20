unit reg_situation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerSituation;

type
  TRegSituation = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Situacao: TLabel;
    L_Color: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    cbx_situacao: TComboBox;
    Cb_Color: TColorBox;
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
    situation : TControllerSituation;
  end;

var
  RegSituation: TRegSituation;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegSituation.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegSituation.ClearAllFields;
begin
  inherited;
  situation.Clear;
end;

procedure TRegSituation.CriarVariaveis;
begin
  inherited;
  situation := TControllerSituation.create(self);
end;

procedure TRegSituation.Delete;
begin
  situation.delete;
  inherited;
end;

procedure TRegSituation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(situation);
end;

procedure TRegSituation.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    situation.Registro.Codigo := Self.CodigoRegistro;
    situation.getbyId;
  End;
  inherited;
end;

procedure TRegSituation.Insert;
begin
  inherited;
  cbx_situacao.ItemIndex := -1;
  E_Descricao.SetFocus;
end;

procedure TRegSituation.Save;
begin
  with situation do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Modulo := IntToStr(cbx_situacao.ItemIndex + 1);
    Registro.Color := ColorToString(Cb_Color.Selected);
    salva;
  End;
  CodigoRegistro := situation.Registro.Codigo;
  inherited;
end;

procedure TRegSituation.ShowData;
begin
  with situation do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    cbx_situacao.ItemIndex := StrToInt(Registro.Modulo);
    Cb_Color.Selected := StringToColor(Registro.Color);
  End;
  inherited;
end;

procedure TRegSituation.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegSituation.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegSituation.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if Trim(cbx_situacao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao.Caption);
    Result := False;
    cbx_situacao.SetFocus;
    Exit;
  end;
end;

end.
