unit Un_Fm_ListaMultiEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IBX.IBCustomDataSet,
  STQuery, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.DBCtrls, STDatabase, IBX.IBDatabase, STTransaction,
  IBX.IBQuery;

type
  TFm_ListaMultiEmpresa = class(TFrame)
    Grb_MnhaEmpresa: TGroupBox;
    chbx_Empresas: TCheckBox;
    Dblcb_Mha_Empresa: TDBLookupComboBox;
    Qr_ListaEstabelecimento: TSTQuery;
    Ds_ListaEstabelecimento: TDataSource;
    IBT_Estabelecimento: TSTTransaction;
    procedure chbx_EmpresasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar(Pc_Order:String);
    Procedure HabilitarMultiEmpresa;
  end;

implementation

{$R *.dfm}

uses UN_TabelasEmListas, UN_Sistema, Un_Regra_Negocio, Un_DM, Un_Principal,env;

procedure TFm_ListaMultiEmpresa.Listar(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaEstabelecimento do
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
                 ' EMP_CONSUMIDOR '+
                 'FROM TB_EMPRESA '+
                  'WHERE (EMP_ATIVA = ''S'') and (EMP_TIPO = ''0'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

Procedure TFm_ListaMultiEmpresa.HabilitarMultiEmpresa;
Var
  Lc_Nivel : Integer;
begin
  IF chbx_Empresas.Checked then
  Begin
    Dblcb_Mha_Empresa.KeyValue := Null;
    Dblcb_Mha_Empresa.Enabled := False;
  end
  else
  Begin
    Listar('EMP_NOME');
    Dblcb_Mha_Empresa.Enabled := True;
    Dblcb_Mha_Empresa.KeyValue := Gb_CodMha;
  End;
end;

procedure TFm_ListaMultiEmpresa.chbx_EmpresasClick(Sender: TObject);
begin
  HabilitarMultiEmpresa;
end;

end.
