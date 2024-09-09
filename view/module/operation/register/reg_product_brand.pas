unit reg_product_brand;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, ControllerMarcaProduto,
  Un_Fm_ListaEmpresas, Un_Fm_ListaFornecedores;

type
  TRegProductBrand = class(TBaseRegistry)
    Panel1: TPanel;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
    Fm_ListaFornecedores1: TFm_ListaFornecedores;
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
    marcaProduto : TControllerMarcaProduto;
  end;

var
  RegProductBrand: TRegProductBrand;

implementation

uses UN_MSG;

{$R *.dfm}

procedure TRegProductBrand.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegProductBrand.ClearAllFields;
begin
  inherited;
  marcaProduto.clear;
end;

procedure TRegProductBrand.CriarVariaveis;
begin
  inherited;
  marcaProduto := TControllerMarcaProduto.create(self);
end;

procedure TRegProductBrand.Delete;
begin
  marcaProduto.delete;
  inherited;
end;

procedure TRegProductBrand.FinalizaVariaveis;
begin
  inherited;
  marcaProduto.DisposeOf;
end;

procedure TRegProductBrand.IniciaVariaveis;
begin
  Fm_ListaFornecedores1.ListaFornecedores(EmptyStr);
  if Self.CodigoRegistro > 0 then
  Begin
    marcaProduto.Registro.Codigo := Self.CodigoRegistro;
    marcaProduto.getbyId;
  End;
  inherited;
end;

procedure TRegProductBrand.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegProductBrand.Save;
begin
  with marcaProduto do
  Begin
    Registro.Descricao := E_Descricao.Text;
    Registro.Fabrica    := Fm_ListaFornecedores1.DBLCB_Empresa.KeyValue;
    salva;
  End;
  CodigoRegistro := marcaProduto.Registro.Codigo;
  inherited;
end;

procedure TRegProductBrand.ShowData;
var Lc_Aux: string;
begin
  with marcaProduto do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
    Fm_ListaFornecedores1.DBLCB_Empresa.KeyValue := Registro.Fabrica;
  End;
  inherited;
end;

procedure TRegProductBrand.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegProductBrand.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegProductBrand.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  {marcaProduto.registro.Descricao := E_Descricao.Text;
  marcaProduto.getbyDescricao;
  if marcaProduto.exist then
  Begin
    MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Marca já registrada.'+EOLN+
                   'Verifique ou altere a descrição.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    Result:=false;
    E_Descricao.SetFocus;
    exit;
  End; }
end;

end.
