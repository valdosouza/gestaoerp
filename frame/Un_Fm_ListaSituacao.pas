unit Un_Fm_ListaSituacao;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons,
  STDatabase, IBX.IBDatabase, STTransaction, IBX.IBQuery;

type
  TFm_ListaSituacao = class(TFrame)
    Label14: TLabel;
    DBLCB_Situacao: TDBLookupComboBox;
    Qr_Situacao: TSTQuery;
    Ds_Situacao: TDataSource;
    Sb_Cadastro: TSpeedButton;
    IBT_Frame: TSTTransaction;
    procedure Sb_CadastroClick(Sender: TObject);
    procedure DBLCB_SituacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FEtapa: Integer;
    FModulo: Integer;
    procedure setFEtapa(const Value: Integer);
    procedure setFModulo(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property Modulo : Integer read FModulo write setFModulo;
    property Etapa : Integer read FEtapa write setFEtapa;
    procedure Listar;
  end;

implementation

{$R *.dfm}

uses Un_DM,un_situacao, RN_Permissao, UN_Principal, env;

{ TFm_ListaSituacao }

procedure TFm_ListaSituacao.DBLCB_SituacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        DBLCB_Situacao.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaSituacao.Listar;
begin
  with Qr_Situacao do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Transaction.commit;
    Active := False;
    sql.Clear;
    sql.Add('SELECT * '+
            'FROM TB_SITUACAO '+
            'WHERE SIT_MODULO=:SIT_MODULO ');
    case FEtapa of
      1:Begin
          sql.Add('ORDER BY SIT_DESCRICAO');
        End;
      2:Begin
          sql.Add(' AND ((SIT_FLAG01 IS NULL) or  (SIT_FLAG01 <>'''' )) '+
                  'ORDER BY SIT_FLAG01 ');
        End;
    end;
    if FModulo = 0 then FModulo := 1;
    
    ParamByName('SIT_MODULO').AsInteger := FModulo;
    Active := True;
    FetchAll;
  End;
end;

procedure TFm_ListaSituacao.Sb_CadastroClick(Sender: TObject);
Var
  Lc_Form : TFr_Situacao;
begin
  if Fc_VerificaPermissao('Fr_Situacao','Cadastro do Situação','VISUALIZAR',GB_Cd_Usuario,'S') then
  Begin
    try
    Lc_Form := TFr_Situacao.Create(nil);
    Lc_Form.ShowModal;
    finally
      Listar;
      DBLCB_Situacao.KeyValue := Lc_Form.CodigoRegistro;
      Lc_Form.DisposeOf
    end;
  End;
end;

procedure TFm_ListaSituacao.setFEtapa(const Value: Integer);
begin
  FEtapa := Value;
end;

procedure TFm_ListaSituacao.setFModulo(const Value: Integer);
begin
  FModulo := Value;
end;

end.
