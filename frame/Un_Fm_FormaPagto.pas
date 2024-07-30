
unit Un_Fm_FormaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, IBX.IBCustomDataSet, STQuery, Un_DM, Vcl.ExtCtrls,
  STDatabase, IBX.IBDatabase, STTransaction, IBX.IBQuery ;

type
  TFm_FormaPagto = class(TFrame)
    DBLCB_FormaPagto: TDBLookupComboBox;
    Lb_FormaPagamento: TLabel;
    SB_FormaPag: TSpeedButton;
    Qr_ListaFormPagto: TSTQuery;
    Ds_ListaFormPagto: TDataSource;
    pnl_Forma: TPanel;
    IB_Local: TSTTransaction;
    procedure SB_FormaPagClick(Sender: TObject);
    procedure DBLCB_FormaPagtoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FFinalidade : Integer;
  public
    { Public declarations }
    procedure Pc_Listar(Finalidade:Integer;Pc_Bloqueio:Boolean;Pc_Cd_Cliente:Integer);
  end;

implementation

{$R *.dfm}

uses UN_FormaPagto;



{ TFm_FormaPagto }

procedure TFm_FormaPagto.DBLCB_FormaPagtoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete  :
    begin
      DBLCB_FormaPagto.KeyValue:=Null;
    end;
  end;
end;

procedure TFm_FormaPagto.Pc_Listar(Finalidade:Integer;Pc_Bloqueio:Boolean;Pc_Cd_Cliente:Integer);
begin
  FFinalidade := Finalidade;
  with Qr_ListaFormPagto do
  Begin
    Active:=false;
    SQL.Clear;
    SQL.Add('SELECT * FROM TB_FORMAPAGTO '+
            'WHERE (FPT_ATIVO = ''S'')    ');

    IF (Pc_Cd_Cliente > 0) THEN
    Begin
      if (Pc_Bloqueio)  then
      BEGIN
        SQL.Add(' AND ( fpt_bloquea <> ''S'' ) '+
                ' AND ( FPT_DESCRICAO <> ''CARTEIRA'' )' );
      END
      else
      BEGIN
        SQL.Add(concat(
               ' AND (                                       ',
               '        (FPT_DESCRICAO <> ''CARTEIRA'') or   ',
               '        (FPT_CODIGO IN (                     ',
               '              SELECT EMP_CODFPG              ',
               '              FROM TB_EMPRESA                ',
               '              WHERE EMP_CODIGO =:EMP_CODIGO  ',
               '            )                                ',
               '        )                                    ',
               '     )                                       '
        ));
      end;
    end;

    case Finalidade of
      0:SQL.Add(' AND ( ( FPT_FINALIDADE =:FPT_FINALIDADE ) or (FPT_FINALIDADE = 3) ) ');
      1:SQL.Add(' AND ( ( FPT_FINALIDADE =:FPT_FINALIDADE ) or (FPT_FINALIDADE = 3) ) ');
      2:SQL.Add(' AND ( FPT_FINALIDADE <>:FPT_FINALIDADE ) ');
    end;
    SQL.Add(' ORDER BY FPT_DESCRICAO');

    //Passagem de Parametros

    IF (Pc_Cd_Cliente > 0) and (not Pc_Bloqueio ) THEN
      ParamByName('EMP_CODIGO').AsInteger := Pc_cd_Cliente;

    if Finalidade < 3 then
      ParamByName('FPT_FINALIDADE').AsInteger := Finalidade ;

    Active:=true;
    FetchAll;
  End;
end;

procedure TFm_FormaPagto.SB_FormaPagClick(Sender: TObject);
Var
  Lc_Form : TFr_FormaPagto;
begin
  Try
    Lc_Form := TFr_FormaPagto.Create(nil);
    if Trim(DBLCB_FormaPagto.Text)<>'' THEN
      Lc_Form.It_Cd_FormaPAgto := DBLCB_FormaPagto.KeyValue;
    Lc_Form.ShowModal;
    Pc_Listar(FFinalidade,False,0);
    DBLCB_FormaPagto.KeyValue := Lc_Form.It_Cd_FormaPAgto;
  Finally
    Lc_Form.DisposeOf;
  End;

end;

end.
