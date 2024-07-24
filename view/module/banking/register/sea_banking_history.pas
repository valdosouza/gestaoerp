unit sea_banking_history;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  ControllerHistoricoBancario;

type
  TSeaBankingHistory = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Descricao: TLabel;
    L_Codigo: TLabel;
    E_Descricao: TEdit;
    E_Codigo: TEdit;
    DBGrid2: TDBGrid;
    cds_searchCodigo: TIntegerField;
    cds_searchdescricao: TStringField;
  private
    Historico : TControllerHistoricoBancario;
  protected
    procedure openRegister(pCodigo:Integer);override;
    //Start
    procedure CriarVariaveis;Override;
    procedure finalizaVariaveis;override;
    procedure FormataTela;Override;
    procedure GetView;Override;
    procedure Search;Override;
    procedure SetRegister;Override;

  public
    { Public declarations }
  end;

var
  SeaBankingHistory: TSeaBankingHistory;

implementation

{$R *.dfm}

uses reg_banking_history;

{ TSeaBankingHistory }

procedure TSeaBankingHistory.CriarVariaveis;
begin
  inherited;
  Historico := TControllerHistoricoBancario.Create(Self);
end;

procedure TSeaBankingHistory.finalizaVariaveis;
begin
  inherited;
  FreeAndNil(Historico);
end;

procedure TSeaBankingHistory.FormataTela;
begin
  inherited;

end;

procedure TSeaBankingHistory.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaBankingHistory.openRegister(pCodigo: Integer);
var
  Lc_form : TRegBankingHistory;
begin
  Lc_form := TRegBankingHistory.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;

end;

procedure TSeaBankingHistory.Search;
Var
  I : Integer;
begin
  Historico.Clear;
  with Historico.Parametros do
  Begin
    FieldName.Codigo := StrToIntDef(E_Codigo.Text,0);
    FieldName.Descricao := E_Descricao.Text;
  End;
  Historico.search;
  if not cds_search.Active then cds_search.CreateDataSet;
  cds_search.EmptyDataSet;
  for I := 0 to Historico.Lista.Count -1 do
  Begin
    cds_search.Append;
    cds_searchcodigo.AsInteger    := Historico.Lista[I].Codigo;
    cds_searchdescricao.AsString  := Historico.Lista[I].Descricao;
    cds_search.Post;
  End;
  inherited;
end;

procedure TSeaBankingHistory.SetRegister;
begin
  openRegister(0);
end;

end.
