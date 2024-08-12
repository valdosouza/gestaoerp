unit reg_config_tag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  base_registry, ControllerCfgEtiqueta;

type
  TRegConfigTag = class(TBaseRegistry)
    Panel1: TPanel;
    Lb_Codigo: TLabel;
    Lb_Descricao: TLabel;
    E_Descricao: TEdit;
    GroupBox2: TGroupBox;
    Lb_Superior: TLabel;
    Lb_Inferior: TLabel;
    Lb_Direita: TLabel;
    Lb_Esquerda: TLabel;
    E_Superior: TEdit;
    E_Inferior: TEdit;
    E_Direita: TEdit;
    E_Esquerda: TEdit;
    GroupBox3: TGroupBox;
    Lb_Alt_Etiq: TLabel;
    Lb_Lar_Etiq: TLabel;
    Lb_Type_e_Size_Fonte: TLabel;
    Lb_N_Coluna: TLabel;
    Lb_Dist_Coluna: TLabel;
    E_Alt_Etiq: TEdit;
    E_Lar_Etiq: TEdit;
    E_N_Coluna: TEdit;
    E_TypeFonte: TEdit;
    E_SizeFonte: TEdit;
    E_Dist_Coluna: TEdit;
    GroupBox4: TGroupBox;
    Lb_Pg_Altura: TLabel;
    L_Pg_Largura: TLabel;
    E_Pg_Altura: TEdit;
    E_Pg_Largura: TEdit;
    E_Codigo: TEdit;
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
    cfgEtiqueta : TControllerCfgEtiqueta;
  end;

var
  RegConfigTag: TRegConfigTag;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegConfigTag.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegConfigTag.CriarVariaveis;
begin
  inherited;
  cfgEtiqueta := TControllerCfgEtiqueta.create(self);
end;

procedure TRegConfigTag.Delete;
begin
  cfgEtiqueta.delete;
  inherited;
end;

procedure TRegConfigTag.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cfgEtiqueta);
end;

procedure TRegConfigTag.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    cfgEtiqueta.Registro.Codigo := Self.CodigoRegistro;
    cfgEtiqueta.getbyId;
  End;
  inherited;
end;

procedure TRegConfigTag.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegConfigTag.Save;
begin
  with cfgEtiqueta do
  Begin
    Registro.Descricao := E_Descricao.Text;

    Registro.PgAltura := StrToFloatDef(E_Pg_Altura.Text, 0);
    Registro.PgLargura := StrToFloatDef(E_Pg_Largura.Text, 0);
    Registro.Superior := StrToFloatDef(E_Superior.Text, 0);
    Registro.Inferior := StrToFloatDef(E_Inferior.Text, 0);
    Registro.Esquerda := StrToFloatDef(E_Esquerda.Text, 0);
    Registro.Direita := StrToFloatDef(E_Direita.Text, 0);
    Registro.EtAltura := StrToFloatDef(E_Alt_Etiq.Text, 0);
    Registro.EtLargura := StrToFloatDef(E_Lar_Etiq.Text, 0);
    Registro.DisColuna := StrToFloatDef(E_Dist_Coluna.Text, 0);
    Registro.NrColuna := StrToFloatDef(E_N_Coluna.Text, 0);
    Registro.TypeFonte := E_TypeFonte.Text;
    Registro.SizeFonte := StrToIntDef(E_SizeFonte.Text, 0);

    salva;
  End;
  CodigoRegistro := cfgEtiqueta.Registro.Codigo;
  inherited;
end;

procedure TRegConfigTag.ShowData;
begin
  with cfgEtiqueta do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_Pg_Altura.Text := FloatToStrF(Registro.PgAltura, ffFixed, 10, 2);
    E_Pg_Largura.Text := FloatToStrF(Registro.PgLargura, ffFixed, 10, 2);
    E_Superior.Text := FloatToStrF(Registro.Superior, ffFixed, 10, 2);
    E_Inferior.Text := FloatToStrF(Registro.Inferior, ffFixed, 10, 2);
    E_Esquerda.Text := FloatToStrF(Registro.Esquerda, ffFixed, 10, 2);
    E_Direita.Text := FloatToStrF(Registro.Direita, ffFixed, 10, 2);
    E_Alt_Etiq.Text := FloatToStrF(Registro.EtAltura, ffFixed, 10, 2);
    E_Lar_Etiq.Text := FloatToStrF(Registro.EtLargura, ffFixed, 10, 2);
    E_Dist_Coluna.Text := FloatToStrF(Registro.DisColuna, ffFixed, 10, 2);
    E_N_Coluna.Text := FloatToStrF(Registro.NrColuna, ffFixed, 10, 2);
    E_TypeFonte.Text := Registro.TypeFonte;
    E_SizeFonte.Text := FloatToStrF(Registro.SizeFonte, ffFixed, 10, 2);
  End;
  inherited;
end;

procedure TRegConfigTag.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegConfigTag.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegConfigTag.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(LB_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;
end;

end.
