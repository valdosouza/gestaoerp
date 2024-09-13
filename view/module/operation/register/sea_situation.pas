unit sea_situation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, ControllerSituation;

type
  TSeaSituation = class(TBaseSearch)
    GroupBox2: TGroupBox;
    L_BuscaDescricao: TLabel;
    L_BuscaCodigo: TLabel;
    L_BuscaModulos: TLabel;
    E_BuscaDescricao: TEdit;
    E_BuscaCodigo: TEdit;
    Cb_BuscaModulos: TComboBox;
    cds_searchcodigo: TIntegerField;
    cds_searchDescricao: TStringField;
    cds_searchColor: TStringField;
    procedure DBG_PesquisaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  protected
    procedure openRegister(pCodigo: Integer);Override;
    procedure CriarVariaveis; override;
    procedure FinalizaVariaveis; override;
    procedure Search; override;
    procedure GetView; override;
    procedure SetRegister; override;
  private
    situation : TControllerSituation;
  end;

var
  SeaSituation: TSeaSituation;

implementation

uses reg_situation;

{$R *.dfm}

procedure TSeaSituation.CriarVariaveis;
begin
  inherited;
  situation := TControllerSituation.create(self);
end;

procedure TSeaSituation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(situation);
end;

procedure TSeaSituation.GetView;
begin
  openRegister(cds_searchCodigo.AsInteger);
end;

procedure TSeaSituation.openRegister(pCodigo: Integer);
var
  Lc_form : TRegSituation;
begin
  Lc_form := TRegSituation.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;

procedure TSeaSituation.Search;
var
  i: Integer;
begin
  situation.Clear;

  situation.Parametros.FieldName.Codigo := StrToIntDef(E_BuscaCodigo.Text, 0);
  situation.Parametros.FieldName.Descricao := E_BuscaDescricao.Text;
  if (Cb_BuscaModulos.ItemIndex + 1) > 0 then
    situation.Parametros.FieldName.Modulo := IntToStr(Cb_BuscaModulos.ItemIndex + 1);

  situation.Search;

  if not cds_search.Active then
    cds_search.CreateDataSet;

  cds_search.EmptyDataSet;

  cds_search.DisableControls;

  for i := 0 to Pred(situation.Lista.Count) do
    cds_search.AppendRecord([situation.Lista[i].Codigo, situation.Lista[i].Descricao, situation.Lista[i].Color]);

  cds_search.EnableControls;

  inherited;
end;

procedure TSeaSituation.SetRegister;
begin
  openRegister(0);
end;

procedure TSeaSituation.DBG_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Lc_cor : TColor;
begin
  if Column.Field = cds_search.FieldByName('Color') then
  Begin
    if cds_search.FieldByName('Color').AsString <> EmptyStr then
    Begin
      Lc_cor := StringToColor(cds_search.FieldByName('Color').AsString);
      Dbg_Pesquisa.Canvas.Font.Color := Lc_cor;
      Dbg_Pesquisa.Canvas.Brush.Color := Lc_cor;
    End;
    Dbg_Pesquisa.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;
end;

{procedure TFr_Situacao.Dbg_PesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Lc_cor : TColor;
begin
  if Column.Field = Ds_Pesquisa.DataSet. FieldByName('SIT_COLOR') then
  Begin
    if Ds_Pesquisa.DataSet.FieldByName('SIT_COLOR').AsString <> '' then
    Begin
      Lc_cor := StringToColor(Ds_Pesquisa.DataSet.FieldByName('SIT_COLOR').AsString);
      if Lc_cor = clBlack then
      Begin
        Dbg_Pesquisa.Canvas.Font.Color := clCream;
      End
      else
      Begin
        Dbg_Pesquisa.Canvas.Font.Color := Lc_cor;
        Dbg_Pesquisa.Canvas.Brush.Color := Lc_cor;
      End;

    End;
    Dbg_Pesquisa.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;
end;}

end.
