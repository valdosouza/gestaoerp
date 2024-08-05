unit Un_Fm_ListaContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Data.DB, IBX.IBCustomDataSet, STQuery, IBX.IBQuery,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFm_ListaContaBancaria = class(TFrame)
    L_ContaBancaria: TLabel;
    Sb_ContaBancaria: TSpeedButton;
    DBLCB_ContaBancaria: TDBLookupComboBox;
    Qr_ContaBancaria: TSTQuery;
    Ds_ContaBancaria: TDataSource;
    procedure Sb_ContaBancariaClick(Sender: TObject);
    procedure DBLCB_ContaBancariaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar;
  end;

implementation

{$R *.dfm}

//uses UN_Sistema, RN_Permissao, Un_Regra_Negocio, Un_ContaBancaria,Un_DM, Un_Principal, env;

uses UN_Sistema, RN_Permissao, Un_Regra_Negocio, sea_banking_account, Un_DM, env;


procedure TFm_ListaContaBancaria.Listar;
begin
  with Qr_ContaBancaria do
  Begin
    Active := False;
    ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;
    Active := True;
    fetchall;
  End;

end;

procedure TFm_ListaContaBancaria.DBLCB_ContaBancariaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete : DBLCB_ContaBancaria.KeyValue:=Null;
  end;
end;

procedure TFm_ListaContaBancaria.Sb_ContaBancariaClick(Sender: TObject);
Var
  Lc_Form : TSeaBankingAccount;
  //Lc_Form : TFr_ContaBancaria;
begin
  {if Fc_VerificaPermissao('Fr_ContaBancaria','Contas','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TFr_ContaBancaria.Create(Self);
    if Trim(DBLCB_ContaBancaria.Text)<> '' then
      Lc_Form.It_Cd_Cadastro := DBLCB_ContaBancaria.KeyValue;
    Lc_Form.ShowModal;
    AtivaLista;
    DBLCB_ContaBancaria.KeyValue := Lc_Form.It_Cd_Cadastro;
    FreeAndNil(Lc_Form);
  End; }
  Lc_form := TSeaBankingAccount.Create(Self);
  try
    Lc_form.ShowModal;
    //DBLCB_ContaBancaria.KeyValue := Lc_Form.It_Cd_Cadastro;
  finally
    FreeAndNil(Lc_form);
  end;
end;

end.
