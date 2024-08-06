unit reg_uf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, base_registry, Controlleruf;

type
  TRegUf = class(TBaseRegistry)
    pnl_fundos: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    L_Sigla: TLabel;
    L_Sub_Tributario: TLabel;
    L_Aliq_Interna: TLabel;
    L_Aliq_Interstadual: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    E_Sigla: TEdit;
    E_Sub_tributario: TEdit;
    E_Aliq_Interna: TEdit;
    E_Aliq_Interestadual: TEdit;
    Pg_Itens: TPageControl;
    tbs_st: TTabSheet;
    Pnl_ST: TPanel;
    Sb_Ins_Ncm: TSpeedButton;
    Sb_Exc_Ncm: TSpeedButton;
    Sb_Grv_Ncm: TSpeedButton;
    tbs_FCP: TTabSheet;
    Pnl_FCP: TPanel;
    Sb_Ins_Fcp: TSpeedButton;
    Sb_Exc_Fcp: TSpeedButton;
    Sb_Grv_Fcp: TSpeedButton;
    Dbg_ST: TDBGrid;
    Dbg_Fcp: TDBGrid;
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
    uf : TControllerUf;
  end;

var
  RegUf: TRegUf;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegUf.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegUf.CriarVariaveis;
begin
  inherited;
  uf := TControllerUf.create(self);
end;

procedure TRegUf.Delete;
begin
  uf.delete;
  inherited;
end;

procedure TRegUf.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(uf);
end;

procedure TRegUf.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    uf.Registro.Codigo := Self.CodigoRegistro;
    uf.getbyId;
  End;
  inherited;
end;

procedure TRegUf.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegUf.Save;
begin
  with uf do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Sigla := E_Sigla.Text;
    registro.AliquotaInterna := StrToFloatDef(E_Aliq_Interna.Text , 0);
    registro.AliquotaInterEstadual := StrToFloatDef(E_Aliq_Interestadual.Text , 0);
    registro.IncricaoSubstituto := E_Sub_tributario.Text;

    salva;
  End;
  CodigoRegistro := uf.Registro.Codigo;
  inherited;
end;

procedure TRegUf.ShowData;
begin
  with uf do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    E_Sigla.Text  := Registro.Sigla;
    E_Aliq_Interna.Text := FloatToStrF(Registro.AliquotaInterna, ffFixed, 10, 2);
    E_Aliq_Interestadual.Text := FloatToStrF(Registro.AliquotaInterEstadual, ffFixed, 10, 2);
    E_Sub_tributario.Text := registro.IncricaoSubstituto;
  End;
  inherited;
end;

procedure TRegUf.ShowNoData;
begin
  //E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegUf.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegUf.ValidateSave: boolean;
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
