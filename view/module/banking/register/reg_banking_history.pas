unit reg_banking_history;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,ControllerHistoricoBancario;

type
  TRegBankingHistory = class(TBaseRegistry)
    L_Codigo: TLabel;
    L_Descricao: TLabel;
    E_Codigo: TEdit;
    E_Descricao: TEdit;
  private
    Historico : TControllerHistoricoBancario;
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure ShowData;override;
    //inserir
    procedure Insert;override;
    //Editar

    procedure Change;override;
    //Deletar
    procedure Delete;override;
    //Salvar
    function ValidateSave():boolean;override;
    procedure Save;override;

  public
    { Public declarations }
  end;

var
  RegBankingHistory: TRegBankingHistory;

implementation

{$R *.dfm}

uses un_msg;

{ TRegBankingHistory }

procedure TRegBankingHistory.Change;
begin
  E_Descricao.SetFocus;
end;

procedure TRegBankingHistory.CriarVariaveis;
begin
  inherited;
  Historico := TControllerHistoricoBancario.Create(Self);
end;

procedure TRegBankingHistory.Delete;
begin
  Historico.delete;
end;

procedure TRegBankingHistory.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(Historico);
end;

procedure TRegBankingHistory.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    Historico.Registro.Codigo := Self.CodigoRegistro;
    Historico.getbyId;
  End;
  inherited;
end;

procedure TRegBankingHistory.Insert;
begin
  inherited;
  E_Descricao.SetFocus;
end;

procedure TRegBankingHistory.Save;
begin
  with Historico do
  Begin
    Registro.Descricao := E_Descricao.Text;
  End;
  Historico.save;
  CodigoRegistro := Historico.Registro.Codigo;
end;

procedure TRegBankingHistory.setPerfil;
begin
  inherited;

end;

procedure TRegBankingHistory.ShowData;
begin
  with Historico do
  Begin
    E_Codigo.Text     := Registro.Codigo.ToString;
    E_Descricao.Text  := Registro.Descricao;
  End;
end;


function TRegBankingHistory.ValidateSave: boolean;
begin
  result := True;
  if trim(E_Descricao.Text) = EmptyStr then
  Begin
    MensagemValidaPreenchimentoCampo(L_Descricao.Caption);
    result:=False;
    E_Descricao.SetFocus;
    Exit;
  end;

end;

end.
