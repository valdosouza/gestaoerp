unit sea_interface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerInterface, base_search;

type
  TSeaInterface = class(TBaseSearch)
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
  public
    cInterface : TControllerInterface;
  end;

var
  SeaInterface: TSeaInterface;

implementation

uses reg_interface;

{$R *.dfm}

procedure TSeaInterface.CriarVariaveis;
begin
  inherited;
  cInterface := TControllerInterface.create(self);
end;

procedure TSeaInterface.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(cInterface);
end;

procedure TSeaInterface.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaInterface.openRegister(pCodigo: Integer);
var
  Lc_form : TRegInterface;
begin
  Lc_form := TRegInterface.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaInterface.Search;
var
  i: Integer;
begin
  cInterface.Clear;

  cInterface.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  cInterface.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  cInterface.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(cInterface.Lista.Count) do
    cds_search.AppendRecord([cInterface.Lista[i].Codigo, cInterface.Lista[i].Descricao]);

  cds_search.EnableControls;
  cds_search.First;
  inherited;
end;

procedure TSeaInterface.SetRegister;
begin
  openRegister(0);
end;


end.
