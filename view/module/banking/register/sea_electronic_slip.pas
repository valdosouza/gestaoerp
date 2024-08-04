unit sea_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  ControllerBoletoEletronico, base_search;

type
  TSeaElectronicSlip = class(TBaseSearch)
    Grp_Parametros: TGroupBox;
    Lb_BuscaBanco: TLabel;
    E_BuscaBanco: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchnumerobanco: TStringField;
    cds_searchagencia: TStringField;
    cds_searchcontacorrente: TStringField;
    cds_searchcarteira: TStringField;
    cds_searchdesccarteira: TStringField;
  private
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  public
    { Public declarations }
    boletoEletronico : TControllerBoletoEletronico;
  end;

var
  SeaElectronicSlip: TSeaElectronicSlip;

implementation

uses reg_electronic_slip;

{$R *.dfm}

procedure TSeaElectronicSlip.CriarVariaveis;
begin
  inherited;
  boletoEletronico := TControllerBoletoEletronico.create(self);
end;

procedure TSeaElectronicSlip.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(boletoEletronico);
end;

procedure TSeaElectronicSlip.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaElectronicSlip.openRegister(pCodigo: Integer);
var
  Lc_form : TRegElectronicSlip;
begin
  Lc_form := TRegElectronicSlip.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaElectronicSlip.Search;
var
  i: Integer;
begin
  boletoEletronico.Clear;

  boletoEletronico.Parametros.FieldName.NomeBanco := E_BuscaBanco.Text;

  boletoEletronico.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(boletoEletronico.Lista.Count) do
    cds_search.AppendRecord([
      boletoEletronico.Lista[I].Codigo, boletoEletronico.Lista[I].NumeroBanco, boletoEletronico.Lista[I].Agencia,
      boletoEletronico.Lista[I].Conta, boletoEletronico.Lista[I].Carteira, boletoEletronico.Lista[I].DescricaoCarteira
    ]);

  inherited;
end;

procedure TSeaElectronicSlip.SetRegister;
begin
  openRegister(0);
end;

end.
