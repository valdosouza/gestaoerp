unit sea_job_position;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Vcl.StdCtrls,
  Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, ControllerCargo;

type
  TSeaJobPosition = class(TBaseSearch)
    Lb_Descricao: TLabel;
    E_Descricao: TEdit;
    cds_searchCodigo: TIntegerField;
    cds_searchDescricao: TStringField;
  private

  protected
    procedure openRegister(pCodigo:Integer);override;
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure Search;Override;
    procedure GetView;Override;
    procedure SetRegister;Override;
  public
    { Public declarations }
    JobPosition : TControllerCargo;
  end;

var
  SeaJobPosition: TSeaJobPosition;

implementation

{$R *.dfm}

uses reg_job_position;

{ TSeaJobPosition }

procedure TSeaJobPosition.CriarVariaveis;
begin
  inherited;
  JobPosition := TControllerCargo.create(self);
end;

procedure TSeaJobPosition.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(JobPosition);
end;

procedure TSeaJobPosition.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaJobPosition.openRegister(pCodigo: Integer);
var
  Lc_form : TRegJobPosition;
begin
  Lc_form := TRegJobPosition.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaJobPosition.Search;
Var
  I : Integer;
begin
  JobPosition.Clear;
  if E_Descricao.Text <> '' then
    JobPosition.Parametros.FieldName.Descricao := E_Descricao.Text;

  JobPosition.Search;

  if not cds_search.Active then cds_search.CreateDataSet;
  cds_search.EmptyDataSet;
  for I := 0 to JobPosition.Lista.Count -1 do
  Begin
    cds_search.Append;
    cds_searchCodigo.AsInteger := JobPosition.Lista[I].Codigo;
    cds_searchDescricao.AsString := JobPosition.Lista[I].Descricao;
  End;
  inherited;
end;

procedure TSeaJobPosition.SetRegister;
begin
  openRegister(0);
end;


end.
