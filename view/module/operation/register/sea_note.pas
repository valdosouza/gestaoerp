unit sea_note;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerObservacao, base_search;

type
  TSeaNote = class(TBaseSearch)
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
    observacao : TControllerObservacao;
  end;

var
  SeaNote: TSeaNote;

implementation

uses reg_note;

{$R *.dfm}

procedure TSeaNote.CriarVariaveis;
begin
  inherited;
  observacao := TControllerObservacao.create(self);
end;

procedure TSeaNote.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(observacao);
end;

procedure TSeaNote.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaNote.openRegister(pCodigo: Integer);
var
  Lc_form : TRegNote;
begin
  Lc_form := TRegNote.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaNote.Search;
var
  i: Integer;
begin
  observacao.Clear;

  observacao.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  observacao.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  observacao.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(observacao.Lista.Count) do
    cds_search.AppendRecord([observacao.Lista[i].Codigo, observacao.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaNote.SetRegister;
begin
  openRegister(0);
end;

end.
