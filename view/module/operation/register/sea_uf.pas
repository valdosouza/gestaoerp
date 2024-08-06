unit sea_uf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerUF, base_search;

type
  TSeaUf = class(TBaseSearch)
    GroupBox2: TGroupBox;
    Lb_BuscaDescricao: TLabel;
    Lb_BuscaCodigo: TLabel;
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
    uf : TControllerUF;
  end;

var
  SeaUf: TSeaUf;

implementation

uses Reg_uf;

{$R *.dfm}

{ TSeaPackage }

procedure TSeaUf.CriarVariaveis;
begin
  inherited;
  uf := TControllerUF.create(self);
end;

procedure TSeaUf.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(uf);
end;

procedure TSeaUf.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaUf.openRegister(pCodigo: Integer);
var
  Lc_form : TReguf;
begin
  Lc_form := TReguf.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaUf.Search;
var
  i: Integer;
begin
  uf.Clear;

  uf.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  uf.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  uf.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(uf.Lista.Count) do
    cds_search.AppendRecord([uf.Lista[i].Codigo, uf.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaUf.SetRegister;
begin
  openRegister(0);
end;

end.
