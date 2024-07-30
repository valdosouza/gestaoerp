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
  //openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaElectronicSlip.openRegister(pCodigo: Integer);
//var
  //Lc_form : TRegPrinters;
begin
  {Lc_form := TRegPrinters.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;   }
end;

procedure TSeaElectronicSlip.Search;
var
  i: Integer;
begin
  boletoEletronico.Clear;

  //boletoEletronico.Parametros.FieldName.Descricao := E_Descricao.Text;

  boletoEletronico.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(boletoEletronico.Lista.Count) do
    cds_search.AppendRecord([boletoEletronico.Lista[I].Codigo]);

  inherited;
end;

procedure TSeaElectronicSlip.SetRegister;
begin
  openRegister(0);
end;

end.
