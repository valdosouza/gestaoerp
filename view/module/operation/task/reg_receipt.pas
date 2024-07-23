unit reg_receipt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_registry, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,ControllerRecibo;

type
  TRegReceipt = class(TBaseRegistry)
    Panel1: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label28: TLabel;
    Label2: TLabel;
    E_Numero: TEdit;
    E_Vl_Recibo: TEdit;
    E_Emitente: TEdit;
    E_Sacado: TEdit;
    E_Referencia: TMemo;
    Tpk_Data: TDateTimePicker;
  private
    Recibo : TControllerRecibo;

  protected
    //Variaveis
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure setPerfil;Override;

    procedure ShowData;override;
    procedure ShowNoData;override;
    //inserir
    procedure Insert;override;
    //Editar
    function ValidateChange():boolean;override;
    procedure Change;override;
    //Deletar
    function ValidateDelete():boolean;override;
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

uses un_msg;

{ TRegReceipt }

procedure TRegReceipt.Change;
begin
  inherited;

end;

procedure TRegReceipt.CriarVariaveis;
begin
  inherited;
  Recibo := TControllerRecibo.create(Self);
end;

procedure TRegReceipt.Delete;
begin
  inherited;

end;


procedure TRegReceipt.FinalizaVariaveis;
begin
  FreeAndNil(Recibo);
  inherited;
end;

procedure TRegReceipt.IniciaVariaveis;
begin
  inherited;

end;

procedure TRegReceipt.Insert;
begin
  E_Sacado.Enabled:= true;
  Tpk_Data.Date:= Now;
  E_Numero.SetFocus;
end;

procedure TRegReceipt.Save;
begin
  inherited;

end;

procedure TRegReceipt.setPerfil;
begin
  inherited;

end;

procedure TRegReceipt.ShowData;
begin
  inherited;

end;

procedure TRegReceipt.ShowNoData;
begin
  inherited;

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

function TRegReceipt.ValidateDelete: boolean;
begin

end;

function TRegReceipt.ValidateSave: boolean;
begin

end;

end.
