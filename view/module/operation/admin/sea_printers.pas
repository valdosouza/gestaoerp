unit sea_printers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  ControllerImpressora, base_search;

type
  TSeaPrinters = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_Descricao: TLabel;
    E_Descricao: TEdit;
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
    impressora : TControllerImpressora;
  end;

var
  SeaPrinters: TSeaPrinters;

implementation

{$R *.dfm}

{ TSeaPrinters }

uses reg_printers;

procedure TSeaPrinters.CriarVariaveis;
begin
  inherited;
  impressora := TControllerImpressora.create(self);
end;

procedure TSeaPrinters.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(impressora);
end;

procedure TSeaPrinters.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaPrinters.openRegister(pCodigo: Integer);
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

procedure TSeaPrinters.Search;
var
  i: Integer;
begin
  impressora.Clear;

  impressora.Parametros.FieldName.Descricao := E_Descricao.Text;

  impressora.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  for i := 0 to Pred(impressora.Lista.Count) do
    cds_search.AppendRecord([impressora.Lista[I].Codigo, impressora.Lista[I].Descricao]);

  inherited;
end;

procedure TSeaPrinters.SetRegister;
begin
  openRegister(0);
end;

end.
