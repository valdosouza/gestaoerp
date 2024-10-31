unit sea_customer_origin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, ControllerCustomerOrigin;

type
  TSeaCustomerOrigin = class(TBaseSearch)
    L_BuscaCodigo: TLabel;
    E_BuscaCodigo: TEdit;
    L_BuscaDescricao: TLabel;
    E_BuscaDescricao: TEdit;
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    CustomerOrigin : TControllerCustomerOrigin;
  end;

var
  SeaCustomerOrigin: TSeaCustomerOrigin;

implementation

uses reg_Customer_Origin;

{$R *.dfm}

{ TSeaCustomerOrigin }

procedure TSeaCustomerOrigin.CriarVariaveis;
begin
  inherited;
  CustomerOrigin := TControllerCustomerOrigin.create(self);
end;

procedure TSeaCustomerOrigin.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(CustomerOrigin);
end;

procedure TSeaCustomerOrigin.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaCustomerOrigin.openRegister(pCodigo: Integer);
var
  Lc_form : TRegCustomerOrigin;
begin
  Lc_form := TRegCustomerOrigin.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCustomerOrigin.Search;
var
  i: Integer;
begin
  CustomerOrigin.Clear;

  CustomerOrigin.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  CustomerOrigin.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  CustomerOrigin.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(CustomerOrigin.Lista.Count) do
    cds_search.AppendRecord([CustomerOrigin.Lista[i].Codigo, CustomerOrigin.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaCustomerOrigin.SetRegister;
begin
  openRegister(0);
end;

end.
