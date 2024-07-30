unit Un_Fm_ListaEstoques;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  Data.DB, IBX.IBCustomDataSet, STQuery,  Vcl.Buttons, IBX.IBQuery;

type
  TFm_ListaEstoques = class(TFrame)
    Dblcb_Estoque: TDBLookupComboBox;
    Label1: TLabel;
    Qr_Estoques: TSTQuery;
    Ds_Estoques: TDataSource;
    ChBx_Estoques: TCheckBox;
    Qr_EstoquesETS_CODMHA: TIntegerField;
    Qr_EstoquesETS_CODIGO: TIntegerField;
    Qr_EstoquesETS_DESCRICAO: TIBStringField;
    Qr_EstoquesETS_PRINCIPAL: TIBStringField;
    Sb_Cadastro: TSpeedButton;

    procedure ChBx_EstoquesClick(Sender: TObject);
    procedure Sb_CadastroClick(Sender: TObject);
    procedure Dblcb_EstoqueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    CodigoVendedor : Integer;
    procedure AtivaLista(institution:Integer);
    procedure ListarEstoqueVendedores;
  end;

implementation

{$R *.dfm}

uses Un_DM, UN_Sistema, Un_Estoques, RN_Permissao,Un_Principal,env;

{ TFrame1 }

procedure TFm_ListaEstoques.AtivaLista(institution:Integer);
begin
  with Qr_Estoques do
  Begin
    Active := False;
    sql.Clear;
    sql.Add('SELECT ETS_CODMHA, ETS_CODIGO, ETS_DESCRICAO, ETS_PRINCIPAL '+
            'FROM TB_ESTOQUES '+
            'WHERE ETS_CODIGO IS NOT NULL');
    if (institution > 0 ) then
      sql.Add('AND ETS_CODMHA = :ETS_CODMHA ');
    sql.Add(' ORDER BY ETS_PRINCIPAL DESC, ETS_DESCRICAO ASC');
    if (institution > 0 ) then
      ParamByName('ETS_CODMHA').AsInteger := institution;
    Active := True;
    FetchAll;
    Dblcb_Estoque.KeyValue := FieldByName('ETS_CODIGO').AsInteger;
  End;
end;

procedure TFm_ListaEstoques.ChBx_EstoquesClick(Sender: TObject);
begin
  IF ChBx_Estoques.Checked then
  Begin
    DBLCB_Estoque.KeyValue := Null;
    DBLCB_Estoque.Enabled := False;
  end
  else
  Begin
    DBLCB_Estoque.Enabled := True;
    AtivaLista(Gb_CodMha);
    DBLCB_Estoque.KeyValue := Qr_EstoquesETS_CODIGO.AsInteger;
  end;
end;

procedure TFm_ListaEstoques.Dblcb_EstoqueKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Estoque.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaEstoques.ListarEstoqueVendedores;
begin
  with Qr_Estoques do
  Begin
    Active := False;
    sql.Clear;
    sql.Add(concat(
              'SELECT ETS_CODMHA, ETS_CODIGO, ETS_DESCRICAO, ETS_PRINCIPAL, shs.tb_salesman_id ',
              'FROM TB_ESTOQUES e ',
              '   LEFT OUTER JOIN tb_salesman_has_stock shs ',
              '   ON (shs.tb_stock_id = e.ets_codigo) ',
              'WHERE ( ETS_CODIGO IS NOT NULL ) ',
              'and e.ets_principal = ''N'' ',
              'and ( (shs.tb_salesman_id is null) or  (shs.tb_salesman_id = 0) or (shs.tb_salesman_id =:tb_salesman_id ) ) ',
              'ORDER BY ETS_PRINCIPAL DESC, ETS_DESCRICAO ASC '
    ));
    ParamByName('tb_salesman_id').AsInteger := CodigoVendedor;
    Active := True;
    FetchAll;
    Dblcb_Estoque.KeyValue := FieldByName('ETS_CODIGO').AsInteger;
  End;

end;

procedure TFm_ListaEstoques.Sb_CadastroClick(Sender: TObject);
Var
  Lc_Form : TFr_Estoques;
begin
  if Fc_VerificaPermissao('Fr_Estoques','Cadastro de Estoques','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    Lc_Form := TFr_Estoques.Create(Self);
    Lc_Form.ShowModal;
    if CodigoVendedor > 0 then
      ListarEstoqueVendedores
    else
      AtivaLista(Gb_CodMha);
    Lc_Form.DisposeOf;
  End;
end;

end.
