unit sea_button_image;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, ControllerBotao;

type
  TSeaButtonImage = class(TBaseSearch)
    E_BuscaCodigo: TEdit;
    L_buscaCodigo: TLabel;
    L_BuscaDescricao: TLabel;
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
    botao : TControllerBotao;
  end;

var
  SeaButtonImage: TSeaButtonImage;

implementation

uses reg_button_image;

{$R *.dfm}

procedure TSeaButtonImage.CriarVariaveis;
begin
  inherited;
  botao := TControllerbotao.create(self);
end;

procedure TSeaButtonImage.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(botao);
end;

procedure TSeaButtonImage.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaButtonImage.openRegister(pCodigo: Integer);
var
  Lc_form : TRegButtonImage;
begin
  Lc_form := TRegButtonImage.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaButtonImage.Search;
var
  i: Integer;
begin
  botao.Clear;

  botao.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  botao.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;

  botao.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(botao.Lista.Count) do
    cds_search.AppendRecord([botao.Lista[i].Codigo, botao.Lista[i].Descricao]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaButtonImage.SetRegister;
begin
  openRegister(0);
end;

end.
