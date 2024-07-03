unit reg_job_position;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Buttons, Vcl.ExtCtrls,ControllerCargo;

type
  TRegJobPosition = class(TBaseRegistry)
    Label1: TLabel;
    E_Descricao: TEdit;
    E_ID: TEdit;
    Label2: TLabel;
  private
    { Private declarations }
  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;
    procedure ShowData;Override;
    procedure ShowNoData;Override;

    //inserir
    function ValidaInsert():boolean;Override;
    procedure Insert;Override;
    //Editar
    function ValidateChange():boolean;Override;
    procedure Change;Override;
    //Deletar
    function ValidateDelete():boolean;Override;
    procedure Delete;Override;
    //Salvar
    function ValidateSave():boolean;Override;
    procedure Save;Override;
    //Cancelar
    function ValidateCancel():boolean;Override;
    procedure Cancel;Override;

  public
    JobPosition : TControllerCargo;
  end;

var
  RegJobPosition: TRegJobPosition;

implementation

{$R *.dfm}

uses UN_MSG;

{ TRegJobPosition }

procedure TRegJobPosition.Cancel;
begin
  inherited;
end;

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
  inherited;
  JobPosition.delete;
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

procedure TRegJobPosition.setPerfil;
begin
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

function TRegJobPosition.ValidaInsert: boolean;
begin
  Result := True;
end;

function TRegJobPosition.ValidateCancel: boolean;
begin
  Result := True;
end;

function TRegJobPosition.ValidateChange: boolean;
begin
  Result := True;
end;

function TRegJobPosition.ValidateDelete: boolean;
begin
  Result := True;
  //quando a pergunta esta dentro da validação verifica-se o botão da negativa
  if (MensagemPadrao('Mensagem de Confirmação',
                     'Deseja delete este item?'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                      ['Não','Sim'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;

end;

function TRegJobPosition.ValidateSave: boolean;
begin
  Result := True;
  if Trim( E_Descricao.Text)='' then
  begin
    MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo descrição não informado.'+EOLN+
                   'Preencha para continuar.'+EOLN,
                  ['OK'],[bEscape],mpErro);
    result:=False;
    E_Descricao.SetFocus;
    Exit;
  end;

end;

end.
