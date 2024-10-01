unit sea_dead_line;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, ControllerDeadLine;

type
  TSeaDeadLine = class(TBaseSearch)
    Lb_Codigo: TLabel;
    E_BuscaCodigo: TEdit;
    Lb_Descricao: TLabel;
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
    deadline : TControllerDeadLine;
  end;

var
  SeaDeadLine: TSeaDeadLine;

implementation

uses reg_dead_line;

{$R *.dfm}

procedure TSeadeadline.CriarVariaveis;
begin
  inherited;
  deadline := TControllerdeadline.create(self);
end;

procedure TSeadeadline.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(deadline);
end;

procedure TSeadeadline.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeadeadline.openRegister(pCodigo: Integer);
var
  Lc_form : TRegdeadline;
begin
  Lc_form := TRegdeadline.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeadeadline.Search;
var
  i: Integer;
begin
  deadline.Clear;

  deadline.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  deadline.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  deadline.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(deadline.Lista.Count) do
    cds_search.AppendRecord([deadline.Lista[i].Codigo, deadline.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeadeadline.SetRegister;
begin
  openRegister(0);
end;

end.
