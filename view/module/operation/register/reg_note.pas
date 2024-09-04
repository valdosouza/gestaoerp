unit reg_note;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, base_registry, ControllerObservacao;

type
  TRegNote = class(TBaseRegistry)
    Panel1: TPanel;
    L_Name: TLabel;
    L_Descricao: TLabel;
    L_Diferido: TLabel;
    Label4: TLabel;
    L_TipoObs: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    DBCB_Diferido: TComboBox;
    Cb_Tipo_Obs: TComboBox;
    MM_Detalhe: TMemo;
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
    observacao : TControllerObservacao;
  end;

var
  RegNote: TRegNote;

implementation

uses UN_MSG, ENV;

{$R *.dfm}

procedure TRegNote.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegNote.ClearAllFields;
begin
  inherited;
  observacao.clear;
end;

procedure TRegNote.CriarVariaveis;
begin
  inherited;
  observacao := TControllerObservacao.create(self);
end;

procedure TRegNote.Delete;
begin
  observacao.delete;
  inherited;
end;

procedure TRegNote.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(observacao);
end;

procedure TRegNote.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    observacao.Registro.Codigo := Self.CodigoRegistro;
    observacao.getbyId;
  End;
  inherited;
end;

procedure TRegNote.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegNote.Save;
begin
  with observacao do
  Begin
    Registro.Descricao := E_Descricao.Text;

    Registro.Difer := DBCB_Diferido.Text;

    Registro.Detalhes := Copy(MM_Detalhe.Lines[0],1,50);

    Registro.Geral := Cb_Tipo_Obs.Text;

    Registro.Geral := IntToStr(Cb_Tipo_Obs.ItemIndex);

    Registro.CodMha := Gb_CodMha;

    salva;
  End;
  CodigoRegistro := observacao.Registro.Codigo;
  inherited;
end;

procedure TRegNote.ShowData;
begin
  with observacao do
  Begin
    E_Codigo.Text := Registro.Codigo.ToString;
    E_Descricao.Text := Registro.Descricao;

    if Registro.Difer = 'SIM' then
      DBCB_Diferido.ItemIndex := 1
    else
      DBCB_Diferido.ItemIndex := 0;

    MM_Detalhe.Text := Registro.Detalhes;
    Cb_Tipo_Obs.Text := Registro.Geral;

    Cb_Tipo_Obs.ItemIndex := StrToInt(Registro.Geral);
  End;
  inherited;
end;

procedure TRegNote.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegNote.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegNote.ValidateSave: boolean;
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
