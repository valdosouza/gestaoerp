unit sea_printers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaPrinters = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Label28: TLabel;
    E_BuscaImpressora: TEdit;
  private
  protected
    procedure openRegister(pCodigo:Integer);override;
  public
    { Public declarations }
  end;

var
  SeaPrinters: TSeaPrinters;

implementation

{$R *.dfm}

{ TSeaPrinters }

uses reg_printers;

procedure TSeaPrinters.openRegister(pCodigo: Integer);
var
  Lc_form : TRegPrinters;
begin
  Try
    Lc_form := TRegPrinters.Create(self);
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;


end;

end.
