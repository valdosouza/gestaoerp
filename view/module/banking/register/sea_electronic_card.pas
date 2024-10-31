unit sea_electronic_card;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, ControllerCartaoEletronico;

type
  TSeaEletronicCard = class(TBaseSearch)
    gbxOpcoesFiltro: TGroupBox;
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    L_Codigo: TLabel;
    E_Codigo: TEdit;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    EletronicCard : TControllerCartaoEletronico;
  end;

var
  SeaEletronicCard: TSeaEletronicCard;

implementation

uses reg_electronic_card;

{$R *.dfm}

procedure TSeaEletronicCard.CriarVariaveis;
begin
  inherited;
  EletronicCard := TControllerCartaoEletronico.create(self);
end;

procedure TSeaEletronicCard.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(EletronicCard);
end;

procedure TSeaEletronicCard.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
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
var
  i: Integer;
begin
  EletronicCard.Clear;

  EletronicCard.Parametros.FieldName.Codigo := StrToIntDef(E_Codigo.Text, 0);
  EletronicCard.Parametros.FieldName.Descricao := E_Descricao.Text;

  EletronicCard.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(EletronicCard.Lista.Count) do
    cds_search.AppendRecord([EletronicCard.Lista[i].Codigo, EletronicCard.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaEletronicCard.SetRegister;
begin
  openRegister(0);
end;

end.
