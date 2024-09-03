unit sea_oper_interface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, controllerOperInterface;

type
  TSeaOperInterface = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
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
    operInterface : TcontrollerOperInterface;
  end;

var
  SeaOperInterface: TSeaOperInterface;

implementation

uses reg_oper_interface;

{$R *.dfm}

procedure TSeaOperInterface.CriarVariaveis;
begin
  inherited;
  operInterface := TcontrollerOperInterface.create(self);
end;

procedure TSeaOperInterface.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(operInterface);
end;

procedure TSeaOperInterface.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaOperInterface.openRegister(pCodigo: Integer);
var
  Lc_form : TRegOperInterface;
begin
  Lc_form := TRegOperInterface.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaOperInterface.Search;
var
  i: Integer;
begin
  operInterface.Clear;

  operInterface.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  operInterface.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  operInterface.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(operInterface.Lista.Count) do
    cds_search.AppendRecord([operInterface.Lista[i].Codigo, operInterface.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaOperInterface.SetRegister;
begin
  openRegister(0);
end;

end.
