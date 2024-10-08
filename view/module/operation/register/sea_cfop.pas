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
    Rg_busca_Alcada: TRadioGroup;
    Rg_Busca_ativo: TRadioGroup;
    cds_searchcodigo: TIntegerField;
    cds_searchdescricao: TStringField;
    cds_searchCfop: TStringField;
    cds_searchAtivo: TStringField;
    cds_searchAlcada: TStringField;
    cds_searchSentido: TStringField;
    Rg_Busca_Sentido: TRadioGroup;
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

uses reg_cfop, env;

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
  Lc_form : TRegCfop;
begin
  Lc_form := TRegCfop.Create(self);
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
  with natureza do
  begin
    Clear;

    Parametros.FieldName.Cfop := E_BuscaCFOP.Text;
    Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

    if Rg_Busca_Sentido.ItemIndex = 0 then
      Parametros.FieldName.Sentido := SENTIDO_ENTRADA
    else
      Parametros.FieldName.Sentido := SENTIDO_SAIDA;

    case Rg_busca_Alcada.ItemIndex of
      0: Parametros.FieldName.Alcada := ALCADA_ESTADUAL;
      1: Parametros.FieldName.Alcada := ALCADA_NACIONAL;
      2: Parametros.FieldName.Alcada := ALCADA_EXTERIOR;
    end;

    case Rg_Busca_ativo.ItemIndex of
      0: Parametros.FieldName.Ativo := SIGLA_S;
      1: Parametros.FieldName.Ativo := SIGLA_N;
    end;

    Search;

    if not cds_search.Active then
      cds_search.CreateDataSet;

    cds_search.EmptyDataSet;

    cds_search.DisableControls;

    for i := 0 to Pred(Lista.Count) do
      cds_search.AppendRecord([Lista[i].Codigo, Lista[i].Descricao, Lista[i].Cfop,
        Lista[i].Sentido, Lista[i].Alcada, Lista[i].Ativo]);

    cds_search.EnableControls;
  end;

  inherited;
end;

procedure TSeaCfop.SetRegister;
begin
  openRegister(0);
end;

end.
