unit sea_banking_history;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaBankingHistory = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Label28: TLabel;
    Label3: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    DBGrid2: TDBGrid;
  private
  protected
    procedure openRegister(pCodigo:Integer);override;
  public
    { Public declarations }
  end;

var
  SeaBankingHistory: TSeaBankingHistory;

implementation

{$R *.dfm}

uses reg_banking_history;

{ TSeaBankingHistory }

procedure TSeaBankingHistory.openRegister(pCodigo: Integer);
var
  Lc_form : TRegBankingHistory;
begin
  Lc_form := TRegBankingHistory.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;

end;

end.
