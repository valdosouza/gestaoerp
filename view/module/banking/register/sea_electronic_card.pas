unit sea_electronic_card;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSeaEletronicCard = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Label28: TLabel;
    Label3: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
  private
  protected
    procedure openRegister(pCodigo:Integer);override;
  public
    { Public declarations }
  end;

var
  SeaEletronicCard: TSeaEletronicCard;

implementation

{$R *.dfm}

uses reg_electronic_card;

{ TSeaEletronicCard }

procedure TSeaEletronicCard.openRegister(pCodigo: Integer);
var
  Lc_form : TRegElectronicCard;
begin
  Lc_form := TRegElectronicCard.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;

end;

end.
