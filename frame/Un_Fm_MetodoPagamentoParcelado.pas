unit Un_Fm_MetodoPagamentoParcelado;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_MetodoPagamento, Vcl.ComCtrls,
  Data.DB, IBX.IBCustomDataSet, STQuery, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Un_Fm_FormaPagto;

type
  TFm_MetodoPagamentoParcelado = class(TFm_MetodoPagamento)
    Label1: TLabel;
    pnl_data: TPanel;
    E_Data: TDateTimePicker;
    procedure E_DataExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fm_MetodoPagamentoParcelado: TFm_MetodoPagamentoParcelado;

implementation

{$R *.dfm}

procedure TFm_MetodoPagamentoParcelado.E_DataExit(Sender: TObject);
begin
  inherited;
  Fm_FormaPagto.DBLCB_FormaPagto.SetFocus;
end;

end.
