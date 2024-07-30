unit Un_Fm_MetodoPagamento;

interface


uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  Data.DB, IBX.IBCustomDataSet, STQuery, Vcl.ExtCtrls, Un_Fm_FormaPagto;

type
  TFm_MetodoPagamento = class(TFrame)
    Panel1: TPanel;
    Lb_Inf_Valor: TLabel;
    E_valor: TEdit;
    Cb_Parcela: TComboBox;
    Lb_Parcela: TLabel;
    Fm_FormaPagto: TFm_FormaPagto;
    pnl_Valor: TPanel;
    pnl_parcela: TPanel;
    procedure Fm_FormaPagtoDBLCB_FormaPagtoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ValorTotal : REal;
    procedure Pc_MontaListaParcelas;
  end;

implementation

{$R *.dfm}

procedure TFm_MetodoPagamento.Fm_FormaPagtoDBLCB_FormaPagtoExit(
  Sender: TObject);
begin
  Pc_MontaListaParcelas;
end;

procedure TFm_MetodoPagamento.Pc_MontaListaParcelas;
Var
  I:Integer;
begin
  if not Fm_FormaPagto.Qr_ListaFormPagto.Active then
    Fm_FormaPagto.Qr_ListaFormPagto.Active := True;
  with Fm_FormaPagto.Qr_ListaFormPagto do
  Begin
    Cb_Parcela.Clear;
    for I := 1 to FieldByName('FPT_PARCELAS').AsInteger do
      Cb_Parcela.Items.Add( IntToStr( I ) );
    Cb_Parcela.ItemIndex := 0;
  End;
  //DEsabilitado não sei como controlar
  //if Self.Visible then if E_valor.CanFocus then E_valor.SetFocus;
end;

end.
