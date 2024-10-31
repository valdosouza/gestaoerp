unit reg_stocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, ControllerEstoques,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, STQuery;

type
  TRegStocks = class(TBaseRegistry)
    ChBx_Estoque: TCheckBox;
    E_Codigo: TEdit;
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
    Sb_Iten_Estoque: TSpeedButton;
    STQuery1: TSTQuery;
    procedure Sb_Iten_EstoqueClick(Sender: TObject);
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
    procedure EditionControl; override;
  private
    stocks : TControllerEstoques;
  end;

var
  RegStocks: TRegStocks;

implementation

uses UN_MSG, env;

{$R *.dfm}

procedure TRegstocks.Change;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegstocks.ClearAllFields;
begin
  inherited;
  stocks.clear;
end;

procedure TRegstocks.CriarVariaveis;
begin
  inherited;
  stocks := TControllerEstoques.create(self);
end;

procedure TRegstocks.Delete;
begin
  stocks.delete;
  inherited;
end;

procedure TRegStocks.EditionControl;
begin
  inherited;
  Sb_Iten_Estoque.Enabled := SB_Alterar.Enabled;
end;

procedure TRegstocks.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(stocks);
end;

procedure TRegstocks.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    stocks.Registro.Codigo := Self.CodigoRegistro;
    stocks.getbyId;
  End;
  inherited;
end;

procedure TRegstocks.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegstocks.Save;
begin
  with stocks do
  Begin
    Registro.Descricao := E_Descricao.Text;

    salva;
  End;
  CodigoRegistro := stocks.Registro.Codigo;
  inherited;
end;

procedure TRegstocks.ShowData;
begin
  with stocks do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
 End;
  inherited;
end;

procedure TRegstocks.ShowNoData;
begin
  E_Codigo.clear;
  E_Descricao.clear;
end;

function TRegstocks.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

function TRegstocks.ValidateSave: boolean;
begin
  Result := True;

  if Trim(E_Descricao.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Descricao.Caption);
    Result := False;
    E_Descricao.SetFocus;
    Exit;
  end;

  if ChBx_Estoque.Checked then
  Begin
    stocks.Registro.Codigo := stocks.Registro.Codigo;
    stocks.Registro.Estabelecimento := Gb_CodMha;
    if stocks.IsPrincipal then
    begin
      MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                     'Um outro estoque principal foi definido.'+EOLN+
                     'Redefina quem será o estoque principal antes de continuar.'+EOLN,
                      ['OK'],[bEscape],mpErro);
      Result:=false;
      ChBx_Estoque.Checked := FAlse;
      Exit;
    end;
  End;
end;

procedure TRegStocks.Sb_Iten_EstoqueClick(Sender: TObject);
begin
  inherited;

  if Self.CodigoRegistro > 0 then
  begin
    if (MensagemPadrao(TITULO_CONFIRMACAO,
                       'Criar um Estoque para todos os produtos Registrados.'+EOLN+EOLN+
                       'Confirmar a operação ?',
                      [SIM,NAO],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
      try
        stocks.Pc_CriaRegistroEstoque(Self.CodigoRegistro);
      except
        MensagemPadrao(TITULO_ERRO,ATENCAO+EOLN+EOLN+
                       'Um erro impossibilitou a operação.'+EOLN+
                       'Entre em contato com o suporte técnico.'+EOLN, ['OK'],[bEscape],mpErro);
      end;
    end;
  end;
end;

end.
