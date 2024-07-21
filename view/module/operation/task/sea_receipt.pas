unit sea_receipt;
     
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask;

type
  TSeaReceipt = class(TBaseSearch)
    GroupBox4: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    E_BuscaValor: TMaskEdit;
    E_BuscaNumero: TMaskEdit;
    chck_dataBusca: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    e_nomebusca: TEdit;
    chck_buscaEmitente: TCheckBox;
    chck_buscaSacado: TCheckBox;
  private
  protected
    procedure openRegister(pCodigo:Integer);override;
  public
    { Public declarations }
  end;

var
  SeaRecives: TSeaReceipt;

implementation

{$R *.dfm}

uses reg_receipt;

{ TSeaReceipt }

procedure TSeaReceipt.openRegister(pCodigo: Integer);
var
  Lc_form : TRegReceipt;
begin
    Lc_form := TRegReceipt.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;

end;

end.
