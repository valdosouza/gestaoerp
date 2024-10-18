unit reg_dead_line;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ControllerDeadLine, base_registry,
  Vcl.Mask, QEdit_Setes, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls;

type
  TRegDeadLine = class(TBaseRegistry)
    Lb_Codigo: TLabel;
    E_Codigo: TEdit;
    L_Descricao: TLabel;
    L_VL_MMINIMO: TLabel;
    E_VL_MMINIMO: TEdit_Setes;
    E_Nr_Parcelas: TMaskEdit;
    L_Nr_Parcelas: TLabel;
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
    deadline : TControllerdeadline;

    function ExtrairDescricao(sEntrada: string): string;
    function ExtrairParcelas(sEntrada: string): string;
  end;
var
  RegDeadLine: TRegDeadLine;

implementation

uses UN_MSG, un_sistema;

{$R *.dfm}

procedure TRegdeadline.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegdeadline.ClearAllFields;
begin
  inherited;
  deadline.clear;
end;

procedure TRegdeadline.CriarVariaveis;
begin
  inherited;
  deadline := TControllerdeadline.create(self);
end;

procedure TRegdeadline.Delete;
begin
  deadline.delete;
  inherited;
end;

procedure TRegdeadline.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(deadline);
end;

procedure TRegdeadline.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    deadline.Registro.Codigo := Self.CodigoRegistro;
    deadline.getbyId;
  End;
  inherited;
end;

procedure TRegdeadline.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegdeadline.Save;
begin
  with deadline do
  Begin
    Registro.Descricao :=  E_Nr_Parcelas.Text + ' - ' + E_Descricao.Text;
    Registro.ValorMinimo := StrToFloatDef(E_VL_MMINIMO.Text,0);
    salva;
  End;
  CodigoRegistro := deadline.Registro.Codigo;
  inherited;
end;

procedure TRegdeadline.ShowData;
begin
  with deadline do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;

    E_Nr_Parcelas.Text := ExtrairParcelas(Registro.Descricao);

    E_Descricao.Text := ExtrairDescricao(Registro.Descricao);

    E_VL_MMINIMO.Text  := FloatToStrF(Registro.ValorMinimo, ffFixed, 10, 2);
  End;
  inherited;
end;

procedure TRegdeadline.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegdeadline.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegdeadline.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Nr_Parcelas.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Nr_Parcelas.Caption);
    Result := False;
    E_Nr_Parcelas.SetFocus;
    Exit;
  end;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

function TRegdeadline.ExtrairParcelas(sEntrada: string): string;
var
  iPosicao: Integer;
begin
  iPosicao := Pos(' - ', sEntrada);

  if iPosicao > 0 then
    Result := Trim(Copy(sEntrada, 1, iPosicao - 1))
  else
    Result := EmptyStr;
end;

function TRegdeadline.ExtrairDescricao(sEntrada: string): string;
var
  iPosicao: Integer;
begin
  iPosicao := Pos(' - ', sEntrada);

  if iPosicao > 0 then
    Result := Trim(Copy(sEntrada, iPosicao + 3, Length(sEntrada) - iPosicao - 2))
  else
    Result := EmptyStr;
end;

end.
