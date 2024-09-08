unit sea_cfop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, ControllerNatureza;

type
  TSeaCfop = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCFOP: TLabel;
    E_BuscaDescricao: TMaskEdit;
    E_BuscaCFOP: TMaskEdit;
    Rg_Busca_Sentido: TRadioGroup;
    Rg_busca_Alcada: TRadioGroup;
    Rg_Busca_ativo: TRadioGroup;
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
    natureza : TControllerNatureza;
  end;

var
  SeaPrinters: TSeaCfop;

implementation

{$R *.dfm}

{ TSeaCfop }

uses reg_printers;

procedure TSeaCfop.CriarVariaveis;
begin
  inherited;
  natureza := TControllerNatureza.create(self);
end;

procedure TSeaCfop.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(natureza);
end;

procedure TSeaCfop.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaCfop.openRegister(pCodigo: Integer);
var
  Lc_form : TRegPrinters;
begin
  Lc_form := TRegPrinters.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaCfop.Search;
var
  i: Integer;
begin
  natureza.Clear;

  natureza.Parametros.FieldName.Descricao := E_Descricao.Text;

  natureza.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(natureza.Lista.Count) do
    cds_search.AppendRecord([natureza.Lista[I].Codigo, natureza.Lista[I].Descricao]);

  inherited;
end;

procedure TSeaCfop.SetRegister;
begin
  openRegister(0);
end;
