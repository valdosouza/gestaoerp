unit sea_receipt;
     
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, base_search, Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Mask,ControllerRecibo;

type
  TSeaReceipt = class(TBaseSearch)
    GroupBox4: TGroupBox;
    cds_searchrec_numero: TStringField;
    cds_searchrec_data: TDateField;
    cds_searchrec_emitente: TStringField;
    cds_searchrec_sacado: TStringField;
    cds_searchrec_valor: TFloatField;
    Label50: TLabel;
    Label51: TLabel;
    E_Valor: TEdit;
    E_Numero: TEdit;
    Chkx_Periodo: TCheckBox;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    e_nome: TEdit;
    chck_Emitente: TCheckBox;
    chck_buscaSacado: TCheckBox;
    cds_searchrec_codigo: TIntegerField;
    cds_searchrec_obs: TStringField;
  private
    Recibo : TControllerRecibo;
  protected
    procedure openRegister(pCodigo:Integer);override;
    //Start
    procedure CriarVariaveis;Override;
    procedure finalizaVariaveis;override;
    procedure FormataTela;Override;
    //Search operations
    procedure GetView;Override;
    procedure Search;Override;
    procedure SetRegister;Override;
  public

  end;

var
  SeaRecives: TSeaReceipt;

implementation

{$R *.dfm}

uses reg_receipt;

{ TSeaReceipt }

procedure TSeaReceipt.CriarVariaveis;
begin
  inherited;
  Recibo := TControllerRecibo.Create(Self);
end;

procedure TSeaReceipt.finalizaVariaveis;
begin
  inherited;
  FreeAndNil(Recibo);
end;

procedure TSeaReceipt.FormataTela;
begin
  inherited;

end;

procedure TSeaReceipt.GetView;
begin
  openRegister(cds_searchrec_codigo.AsInteger);
end;


procedure TSeaReceipt.openRegister(pCodigo: Integer);
var
  Lc_form : TRegReceipt;
begin
    Lc_form := TRegReceipt.Create(self);
  Try
    Lc_form.CodigoRegistro := pCodigo;
    Lc_form.ShowModal;
  Finally
    FreeAndNil(Lc_form);
  End;
end;


procedure TSeaReceipt.Search;
Var
  I : Integer;
begin
  Recibo.Clear;
  with Recibo.Parametros do
  Begin
    Periodo := Chkx_Periodo.Checked;
    DataInicial := E_Data_Ini.DateTime;
    DataFinal := E_Data_Fim.DateTime;
    FieldName.Numero := StrToIntDef(E_Numero.text,0);
    FieldName.Emitente := '';
    if chck_Emitente.Checked then
      FieldName.Emitente := e_nome.Text;
    FieldName.Sacado := '';
    if chck_buscaSacado.Checked then
      FieldName.Sacado := e_nome.Text;
    FieldName.Valor := StrToFloatDef(E_Valor.Text,0);
  End;
  Recibo.search;
  if not cds_search.Active then cds_search.CreateDataSet;
  cds_search.EmptyDataSet;
  for I := 0 to Recibo.Lista.Count -1 do
  Begin
    cds_search.Append;
    cds_searchrec_codigo.AsInteger  := Recibo.Lista[I].Codigo;
    cds_searchrec_numero.AsInteger  := Recibo.Lista[I].Numero;
    cds_searchrec_data.AsDateTime   := Recibo.Lista[I].Data;
    cds_searchrec_emitente.AsString := Recibo.Lista[I].Emitente;
    cds_searchrec_sacado.AsString   := Recibo.Lista[I].Sacado;
    cds_searchrec_valor.AsFloat     := Recibo.Lista[I].Valor;
    cds_searchrec_obs.AsString      := Recibo.Lista[I].Referencia;
    cds_search.Post;
  End;
  inherited;
end;


procedure TSeaReceipt.SetRegister;
begin
  openRegister(0);
end;


end.
