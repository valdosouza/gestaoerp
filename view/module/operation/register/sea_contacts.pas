unit sea_contacts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, ControllerContato;

type
  TSeaContacts = class(TBaseSearch)
    GroupBox1: TGroupBox;
    E_BuscaCargo: TEdit;
    Label1: TLabel;
    E_BuscaContato: TEdit;
    Label2: TLabel;
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
    contato : TControllerContato;
  end;

var
  SeaContacts: TSeaContacts;

implementation

uses reg_contacts;

{$R *.dfm}

procedure TSeaContacts.CriarVariaveis;
begin
  inherited;
  contato := TControllerContato.create(self);
end;

procedure TSeaContacts.FinalizaVariaveis;
begin
  inherited;
  contato.DisposeOf;
end;

procedure TSeaContacts.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaContacts.openRegister(pCodigo: Integer);
var
  Lc_form : TRegContacts;
begin
  Lc_form := TRegContacts.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaContacts.Search;
var
  i: Integer;
begin
  contato.Clear;

//  contato.Parametros.FieldName.Codigo := E_BuscaContato.Text;
  //contato.Parametros.FieldName.CRG_DESCRICAO := E_BuscaCargo.Text;

  contato.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(contato.Lista.Count) do
    cds_search.AppendRecord([contato.Lista[i].Codigo, contato.Lista[i].Nome]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaContacts.SetRegister;
begin
  openRegister(0);
end;

end.
