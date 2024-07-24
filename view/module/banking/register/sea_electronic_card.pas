unit sea_electronic_card;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerCartaoEletronico,prm_electronic_card;

type
  TSeaEletronicCard = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Descricao: TLabel;
    L_Codigo: TLabel;
    E_Descricao: TEdit;
    E_Codigo: TEdit;
  private
    Cartao : TControllerCartaoEletronico;
    FParametros: TPrmElectronicCard;
    procedure setFParametros(const Value: TPrmElectronicCard);
  protected
    procedure openRegister(pCodigo:Integer);override;
    //Start
    procedure CriarVariaveis;Override;
    procedure finalizaVariaveis;override;
    procedure FormataTela;Override;
    //Search operations
    procedure GetView;Override;
    procedure Search;Override;
    procedure SetRegister;Override;

  public
    property Parametros : TPrmElectronicCard read FParametros write setFParametros;
  end;

var
  SeaEletronicCard: TSeaEletronicCard;

implementation

{$R *.dfm}

uses reg_electronic_card;

{ TSeaEletronicCard }

procedure TSeaEletronicCard.CriarVariaveis;
begin
  inherited;
  Cartao := TControllerCartaoEletronico.Create(self);
end;

procedure TSeaEletronicCard.finalizaVariaveis;
begin
  inherited;
  FreeAndNil(Cartao);
end;

procedure TSeaEletronicCard.FormataTela;
begin
  inherited;

end;

procedure TSeaEletronicCard.GetView;
begin
  inherited;

end;

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

procedure TSeaEletronicCard.Search;
begin
  inherited;

end;

procedure TSeaEletronicCard.setFParametros(const Value: TPrmElectronicCard);
begin
  FParametros := Value;
end;

procedure TSeaEletronicCard.SetRegister;
begin
  inherited;

end;

end.
