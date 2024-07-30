unit reg_receipt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,ControllerRecibo;

type
  TRegReceipt = class(TBaseRegistry)
    Panel1: TPanel;
    L_Numero: TLabel;
    L_Data: TLabel;
    L_Emitente: TLabel;
    L_Vl_Recibo: TLabel;
    L_Sacado: TLabel;
    L_Referencia: TLabel;
    E_Numero: TEdit;
    E_Vl_Recibo: TEdit;
    E_Emitente: TEdit;
    E_Sacado: TEdit;
    E_Referencia: TMemo;
    E_Data: TDateTimePicker;
    procedure E_Vl_ReciboExit(Sender: TObject);
  private
    Recibo : TControllerRecibo;
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
    function ValidateChange():boolean;override;
    procedure Change;override;
    //Deletar
    procedure Delete;override;
    //Salvar
    function ValidateSave():boolean;override;
    procedure Save;override;

  public

  end;

var
  RegReceipt: TRegReceipt;

implementation

{$R *.dfm}

uses un_msg, env;

{ TRegReceipt }

procedure TRegReceipt.Change;
begin
  inherited;
  E_Numero.SetFocus;
end;

procedure TRegReceipt.CriarVariaveis;
begin
  inherited;
  Recibo := TControllerRecibo.create(Self);
end;

procedure TRegReceipt.Delete;
begin
  Recibo.Delete;
end;

procedure TRegReceipt.E_Vl_ReciboExit(Sender: TObject);
Var
  Lc_valor : Real;
begin
  inherited;
  Lc_valor := StrToFloatDef(TEdit(sender).Text,0);
  TEdit(sender).Text := FloatToStrF(Lc_valor,ffNumber,10,2);
end;

procedure TRegReceipt.FinalizaVariaveis;
begin
  FreeAndNil(Recibo);
  inherited;
end;

procedure TRegReceipt.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    Recibo.Registro.Codigo := Self.CodigoRegistro;
    Recibo.Registro.Estabelecimento := Gb_CodMha;
    Recibo.getbyId;
  End;
  inherited;
end;

procedure TRegReceipt.Insert;
begin
  E_Sacado.Enabled:= true;
  E_Data.Date:= Now;
  E_Numero.SetFocus;
end;

procedure TRegReceipt.Save;
begin
  with Recibo do
  Begin
    Registro.Numero := StrToIntDef(E_Numero.Text,0);
    Registro.Valor := StrToFloatDef(E_Vl_Recibo.Text,0);
    Registro.Data:= E_Data.DateTime;
    Registro.Sacado := E_Sacado.Text;
    Registro.referencia := E_Referencia.Text;
    Registro.Emitente := E_Emitente.Text;
  End;
  Recibo.salva;
  CodigoRegistro := Recibo.Registro.Codigo;
end;

procedure TRegReceipt.setPerfil;
begin
  inherited;

end;

procedure TRegReceipt.ShowData;
begin
  with Recibo do
  Begin
    E_Numero.Text     := Registro.Numero.ToString;
    E_Vl_Recibo.Text  := FloatToStrF(Registro.Valor,ffFixed,10,2);
    E_Data.DateTime   := Registro.Data;
    E_Sacado.Text     := Registro.Sacado;
    E_Referencia.Text := Registro.referencia;
    E_Emitente.Text   := Registro.Emitente;
  End;

end;


function TRegReceipt.ValidateChange: boolean;
begin
  Result := True;
  if ( Recibo.Registro.CodigoQuitacao > 0 ) then
  begin
    MensagemPararExecucao('Recibo com vínculo no financeiro.' + EOLN +
                          'Não é possível a alteração deste recibo.');
    exit;
  end;
  inherited;
end;


function TRegReceipt.ValidateSave: boolean;
begin
  Result:=TRUE;
  Recibo.Registro.Estabelecimento := Gb_CodMha;
  Recibo.Registro.Numero := StrToIntDef(E_Numero.Text,0);
  if Recibo.VerificaNumRecibo then
  begin
    MensagemPararExecucao(' Número de Recibo já existe.' + EOLN +
                          ' Digite outro número para o Recibo.');
    Result:=false;
    exit;
  end;

  if StrToFloatDef(E_Vl_Recibo.Text,0) = 0 then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Vl_Recibo.Caption);
    Result:=false;
    exit;
  end;

  if TRim(E_Sacado.Text) = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Sacado.Caption);
    Result:=false;
    exit;
  end;

  if TRim(E_Emitente.Text) = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Emitente.Caption);
    Result:=false;
    exit;
  end;

  if TRim(E_Referencia.Text) = EmptyStr then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Referencia.Caption);
    Result:=false;
    exit;
  end;

end;

end.
