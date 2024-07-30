unit Un_Fm_ListaTabelaPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.Buttons, Vcl.DBCtrls, Vcl.StdCtrls,
  IBX.IBQuery;

type
  TFm_ListaTabelaPreco = class(TFrame)
    Label53: TLabel;
    Dblcb_Lista: TDBLookupComboBox;
    Sb_Preco: TSpeedButton;
    Qr_Tabelas: TSTQuery;
    Ds_Tabelas: TDataSource;
    procedure Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Sb_PrecoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Listar(ExcetoCodigo:Integer);
  end;

implementation

{$R *.dfm}

uses Un_DM,Un_Tabela_Preco, RN_Permissao, UN_Principal,env;

{ TFm_ListaTabelaPreco }

procedure TFm_ListaTabelaPreco.Dblcb_ListaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Lista.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaTabelaPreco.Listar(ExcetoCodigo:Integer);
begin
  with Qr_Tabelas do
  Begin
    Active := False;
    sql.Clear;
    sql.Add('select * from TB_TABELA_PRECO '+
            'where (TPR_CODIGO <> 2) AND ( TPR_ATIVA = ''S'') ');
    if ( ExcetoCodigo > 0 ) then
      sql.Add(' AND (TPR_CODIGO <>:TPR_CODIGO) ');

    sql.Add(' ORDER BY TPR_NOME ');

    if ( ExcetoCodigo > 0 ) then
      ParamByName('TPR_CODIGO').AsInteger := ExcetoCodigo;

    Active := True;
    FetchAll;
    Dblcb_Lista.KeyValue := FieldByName('TPR_CODIGO').AsInteger;
  End;
end;

procedure TFm_ListaTabelaPreco.Sb_PrecoClick(Sender: TObject);
Var
  Lc_Form : TFr_Tabela_Preco;
begin
  if Fc_VerificaPermissao('Fr_Tabela_Preco','Tabelas de Preço','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Try
      Lc_Form := TFr_Tabela_Preco.Create(self);
      Lc_Form.ShowModal;
    Finally
      Lc_Form.disposeOf;
      Listar(0);
    End;
  End;
end;

end.
