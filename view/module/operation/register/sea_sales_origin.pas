unit sea_sales_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, controllersalesorigin;

type
  TSeaSalesOrigin = class(TBaseSearch)
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    GroupBox1: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    salesorigin : Tcontrollersalesorigin;
  end;

var
  SeaSalesOrigin: TSeaSalesOrigin;

implementation

uses reg_sales_origin;

{$R *.dfm}

{ TSeaSalesOrigin }

procedure TSeaSalesOrigin.CriarVariaveis;
begin
  inherited;
  salesorigin := TControllersalesorigin.create(self);
end;

procedure TSeaSalesOrigin.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(salesorigin);
end;

procedure TSeaSalesOrigin.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaSalesOrigin.openRegister(pCodigo: Integer);
var
  Lc_form : TRegSalesOrigin;
begin
  Lc_form := TRegSalesOrigin.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaSalesOrigin.Search;
var
  i: Integer;
begin
  salesorigin.Clear;

  salesorigin.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  salesorigin.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  salesorigin.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(salesorigin.Lista.Count) do
    cds_search.AppendRecord([salesorigin.Lista[i].Codigo, salesorigin.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaSalesOrigin.SetRegister;
begin
  openRegister(0);
end;

end.
