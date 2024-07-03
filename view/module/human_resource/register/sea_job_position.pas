unit sea_job_position;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Vcl.StdCtrls,
  Datasnap.Provider, Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, ControllerCargo, reg_job_position;

type
  TSeaJobPosition = class(TBaseSearch)
    Label1: TLabel;
    E_Descricao: TEdit;
    cds_searchCodigo: TIntegerField;
    cds_searchDescricao: TStringField;
  private
  protected
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure FinalizaVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    procedure Search;Override;
    procedure SelectSql;Override;
    procedure SetParameters;Override;
    function validateGetView:Boolean;Override;
    procedure GetView;Override;
    procedure SetRegister;Override;
    procedure returnRegister;Override;

  public
    { Public declarations }
    JobPosition : TControllerCargo;
  end;

var
  SeaJobPosition: TSeaJobPosition;

implementation

{$R *.dfm}

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

procedure TSeaJobPosition.FormataTela;
begin
  inherited;

end;

procedure TSeaJobPosition.GetView;
begin
  inherited;

end;

procedure TSeaJobPosition.ImagemBotao;
begin
  inherited;

end;

procedure TSeaJobPosition.IniciaVariaveis;
begin
  inherited;

end;

procedure TSeaJobPosition.returnRegister;
begin
  inherited;

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
end;

procedure TSeaJobPosition.SelectSql;
begin
  inherited;

end;

procedure TSeaJobPosition.SetParameters;
begin
  inherited;

end;

procedure TSeaJobPosition.SetRegister;
var
  Lc_form : TRegJobPosition;
begin
  Try
    Lc_form := TRegJobPosition.Create(self);
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

function TSeaJobPosition.validateGetView: Boolean;
var
  Lc_form : TRegJobPosition;
begin
  Try
    Lc_form := TRegJobPosition.Create(self);
    Lc_form.CodigoRegistro := cds_searchCodigo.AsInteger;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;

end;

end.
