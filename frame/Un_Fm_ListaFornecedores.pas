unit Un_Fm_ListaFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_ListaEmpresas, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,RN_Empresa,RN_Fornecedor, Data.DB,
  STQuery, Vcl.ExtCtrls;

type
  TFm_ListaFornecedores = class(TFm_ListaEmpresas)
    Qr_ListaEmpresa: TSTQuery;
    Ds_ListaEmpresa: TDataSource;
    procedure SB_ClienteClick(Sender: TObject);
    procedure E_Cd_EmpresaExit(Sender: TObject);
    procedure Sb_Pesq_ClienteClick(Sender: TObject);
    procedure ChBx_NomeClick(Sender: TObject);
    procedure ChBx_FantasiaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListaFornecedores(Pc_Order:String);
  end;

var
  Fm_ListaFornecedores: TFm_ListaFornecedores;

implementation

{$R *.dfm}

uses UN_TabelasEmListas;

{ TFm_ListaFornecedores }

procedure TFm_ListaFornecedores.ChBx_FantasiaClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_FANTASIA',ChBx_Fantasia,ChBx_Nome,DBLCB_Empresa)
end;

procedure TFm_ListaFornecedores.ChBx_NomeClick(Sender: TObject);
begin
  Pc_ListaFornecedorDbLookUpComboBox('EMP_NOME',ChBx_Nome,ChBx_Fantasia,DBLCB_Empresa)
end;

procedure TFm_ListaFornecedores.E_Cd_EmpresaExit(Sender: TObject);
begin
  Dblcb_Empresa.KeyValue := StrToIntDef(E_Cd_Empresa.Text,0);
  If Dblcb_Empresa.CanFocus then Dblcb_Empresa.SetFocus;
end;

procedure TFm_ListaFornecedores.ListaFornecedores(Pc_Order: String);
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
                 ' EMP_DT_FUNDA, '+
                 ' EMP_TIPO, '+
                 ' EMP_EMAIL, '+
                 ' EMP_DT_CADASTRO, '+
                 ' EMP_VL_CRED '+
                 'FROM TB_EMPRESA '+
                 ' INNER JOIN TB_FORNECEDOR '+
                 ' ON (FOR_CODEMP = EMP_CODIGO) '+
                  'WHERE (FOR_ATIVO = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;


end;

procedure TFm_ListaFornecedores.SB_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  If trim(DBLCB_Empresa.Text) <> '' then
  Begin
    Lc_Retorno := Fc_AbreTelaFornecedor(DBLCB_Empresa.KeyValue);
    if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
    begin
      E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
      DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
    end;
  end;

end;

procedure TFm_ListaFornecedores.Sb_Pesq_ClienteClick(Sender: TObject);
Var
  Lc_Retorno :TRetornoDados;
begin
  Lc_Retorno := Fc_AbreTelaPesqEmpresa(2,0);
  if Trim(Lc_Retorno.It_Dados[1,0]) <> '' then
  begin
    E_Cd_Empresa.Text := Lc_Retorno.It_Dados[1,0];
    DBLCB_Empresa.KeyValue := StrToIntDef(Lc_Retorno.It_Dados[1,0],0);
  end;

end;

end.
