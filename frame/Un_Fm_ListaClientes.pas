unit Un_Fm_ListaClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_ListaEmpresas, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Data.DB, IBX.IBCustomDataSet, STQuery,
  RN_Empresa, RN_cliente, Vcl.ExtCtrls, Un_Cliente, IBX.IBQuery;

type
  TFm_ListaClientes = class(TFm_ListaEmpresas)
    Qr_ListaEmpresa: TSTQuery;
    Ds_ListaEmpresa: TDataSource;
    procedure E_Cd_EmpresaExit(Sender: TObject);
    procedure DBLCB_EmpresaExit(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
    procedure Sb_Pesq_EmpresaClick(Sender: TObject);
    procedure SB_EmpresasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListaClientes(Pc_Order:String);
  end;

var
  Fm_ListaClientes: TFm_ListaClientes;

implementation

{$R *.dfm}

procedure TFm_ListaClientes.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFm_ListaClientes.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaClienteDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFm_ListaClientes.DBLCB_EmpresaExit(Sender: TObject);
begin
  If trim(Dblcb_Empresa.Text) <> '' THEN
    E_Cd_Empresa.Text := IntToStr(Dblcb_Empresa.KeyValue)
  else
    E_Cd_Empresa.Clear;
end;

procedure TFm_ListaClientes.E_Cd_EmpresaExit(Sender: TObject);
begin
  Dblcb_Empresa.KeyValue := StrToIntDef(E_Cd_Empresa.Text,0);
  If Dblcb_Empresa.CanFocus then Dblcb_Empresa.SetFocus;
end;

procedure TFm_ListaClientes.ListaClientes(Pc_Order: String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaEmpresa do
  Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR, '+
                 ' EMP_TIPO, '+
                 ' EMP_EMAIL, '+
                 ' EMP_DT_CADASTRO, '+
                 ' EMP_VL_CRED, '+
                 ' EMP_FORMDATA, '+
                 ' EMP_FORMDATA_E, '+
                 ' EMP_FORMDATA_C, '+
                 ' EMP_STCRED '+
                 'FROM TB_EMPRESA '+
                 ' INNER JOIN TB_CLIENTE '+
                 ' ON (CLI_CODEMP = EMP_CODIGO) '+
                  'WHERE (CLI_ATIVO = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;

end;

procedure TFm_ListaClientes.SB_EmpresasClick(Sender: TObject);
Var
  Lc_Form : TFr_Cliente;
Begin
  if DBLCB_Empresa.Text <> '' then
  Begin
    Try
      Lc_Form := TFr_Cliente.Create(nil);
      Lc_Form.it_Menu := 'Clientes';
      Lc_Form.Empresa.Registro.Codigo := DBLCB_Empresa.KeyValue;
      Lc_Form.ShowModal;
      ListaClientes('EMP_NOME');
    Finally
      Lc_Form.DisposeOf;
    End;
  End;

end;

procedure TFm_ListaClientes.Sb_Pesq_EmpresaClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(1,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;
end;

end.
