unit Un_Fm_ListaHistoricoBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_DM, Data.DB,
  IBX.IBCustomDataSet, STQuery, Vcl.DBCtrls, Vcl.Buttons, Vcl.StdCtrls,
  IBX.IBQuery;

type
  TFm_ListaHistoricoBancario = class(TFrame)
    Label26: TLabel;
    Sb_Historico: TSpeedButton;
    DBLCB_Historico: TDBLookupComboBox;
    Qr_HistBancario: TSTQuery;
    Ds_HistBancario: TDataSource;
    procedure Sb_HistoricoClick(Sender: TObject);
    procedure DBLCB_HistoricoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtivaLista;
  end;

implementation

{$R *.dfm}

uses Un_HistBancario;

procedure TFm_ListaHistoricoBancario.AtivaLista;
begin
  Qr_HistBancario.Active := False;
  Qr_HistBancario.Active := True;
  Qr_HistBancario.FetchAll;
end;

procedure TFm_ListaHistoricoBancario.DBLCB_HistoricoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  case Key of
    VK_delete : DBLCB_Historico.KeyValue := Null;
  end;

end;

procedure TFm_ListaHistoricoBancario.Sb_HistoricoClick(Sender: TObject);
Var
  Lc_Form : TFr_HistBancario;
begin
  Lc_Form := TFr_HistBancario.Create(Self);
  Lc_Form.ShowModal;
  AtivaLista;
  DBLCB_Historico.KeyValue := Lc_Form.It_cd_Cadastro;
  FreeAndNil(Lc_Form);
end;

end.
