unit un_fm_billing_portfolio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, STQuery, Vcl.DBCtrls,base_frame_list, Vcl.ExtCtrls;

type
  TFmBillingPortfolio = class(TBaseFrameList)
    procedure Sb_CarteiraClick(Sender: TObject);
  private
    FCodigoBanco: Integer;
    function ValidaAberturaTela:boolean;
    procedure AberturaTela;
    procedure setFCodigoBanco(const Value: Integer);
  public
    procedure Listar;
    property CodigoBanco : Integer read FCodigoBanco write setFCodigoBanco;
  end;

implementation

uses
  reg_billing_portfolio, un_msg;

{$R *.dfm}

procedure TFmBillingPortfolio.AberturaTela;
var
  Lc_Form : TRegBillingPortfolio;
Begin
  Lc_form := TRegBillingPortfolio.Create(Self);
  try
    Lc_form.CarteiraCobranca.Registro.CodigoBanco := FCodigoBanco;
    Lc_form.CodigoRegistro := 0;
    if Dblcb_Lista.Text <> EmptyStr then
    Begin
      Lc_form.CodigoRegistro := Dblcb_Lista.KeyValue;
    End;
    Lc_form.ShowModal;
    Listar;
    Dblcb_Lista.KeyValue := Lc_form.CodigoRegistro;
  finally
    FreeAndNil(Lc_form);
  end;
end;

procedure TFmBillingPortfolio.Listar;
begin
  with Qr_Lista do
  Begin
    Active := False;
    SQL.Clear;
    sql.Add(concat(
            'SELECT * ',
            'FROM TB_CARTEIRA_COBRANCA ',
            'WHERE CTR_CODBCO=:CTR_CODBCO '
    ));
    ParamByName('CTR_CODBCO').AsInteger := FCodigoBanco;
    Active := True;
  End;
end;

procedure TFmBillingPortfolio.Sb_CarteiraClick(Sender: TObject);
begin
  if ValidaAberturaTela then
    AberturaTela;
end;

procedure TFmBillingPortfolio.setFCodigoBanco(const Value: Integer);
begin
  FCodigoBanco := Value;
end;

function TFmBillingPortfolio.ValidaAberturaTela: boolean;
begin
  Result := True;
  if FCodigoBanco = 0 then
  Begin
    TMsgSetes.ValidaPreenchimentoCampo('Por favor Informe uma conta Corrente');
    Result := False;
    exit;
  End;
end;

end.
