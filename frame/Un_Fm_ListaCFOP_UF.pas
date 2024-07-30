unit Un_Fm_ListaCFOP_UF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Fm_ListaEstados,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, IBX.IBCustomDataSet,
  STQuery, STDatabase, IBX.IBDatabase, STTransaction, IBX.IBQuery;

type
  TFm_ListaCFOP_UF = class(TFrame)
    RG_Tipo_S_E: TRadioGroup;
    Label25: TLabel;
    Dblcb_Lista: TDBLookupComboBox;
    Fm_ListaBuscaEstado: TFm_ListaEstados;
    Qr_Filtra_CFOP: TSTQuery;
    Ds_Filtra_CFOP: TDataSource;
    IBT_Lista: TSTTransaction;
    procedure RG_Tipo_S_EClick(Sender: TObject);
    procedure Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Fm_ListaBuscaEstadoDBLCB_UFExit(Sender: TObject);
  private
    FEstabelecimento: Integer;
    { Private declarations }
    procedure VerificaParametros;
    procedure Filtra_CFOP(Pc_Sentido: String; Pc_Alcada: String);
    procedure setFEstabelecimento(const Value: Integer);
  public
    { Public declarations }
    procedure Listar;
    property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;
  end;

implementation

{$R *.dfm}

uses UN_Sistema;

procedure TFm_ListaCFOP_UF.Dblcb_ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    case Key of
      VK_delete:
      begin
        Dblcb_Lista.KeyValue := Null;
      end;
    end;
end;

procedure TFm_ListaCFOP_UF.Filtra_CFOP(Pc_Sentido, Pc_Alcada: String);
begin
  with Qr_Filtra_CFOP do
  Begin
    Active := False;
    ParamByName('NAT_SENTIDO').AsString := Pc_Sentido;
    ParamByName('NAT_ALCADA').AsString := Pc_Alcada;
    Active := True;
    FetchAll;
  End;
end;

procedure TFm_ListaCFOP_UF.Fm_ListaBuscaEstadoDBLCB_UFExit(Sender: TObject);
begin
  VerificaParametros;
end;

procedure TFm_ListaCFOP_UF.Listar;
begin
  Fm_ListaBuscaEstado.Pc_Listar;
  Fm_ListaBuscaEstado.DBLCB_UF.KeyValue := Fc_Estado(Festabelecimento,'S');
  Filtra_CFOP('S','E');

end;

procedure TFm_ListaCFOP_UF.RG_Tipo_S_EClick(Sender: TObject);
begin
  VerificaParametros;
end;

procedure TFm_ListaCFOP_UF.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TFm_ListaCFOP_UF.VerificaParametros;
begin
  if RG_Tipo_S_E.ItemIndex = 0 then
  Begin
    if (Fm_ListaBuscaEstado.DBLCB_UF.Text = '') then
      Filtra_CFOP('S','N')
    else
    if (Fm_ListaBuscaEstado.DBLCB_UF.KeyValue = Fc_Estado(Festabelecimento,'S')) then
      Filtra_CFOP('S','E')
    else
    if (Fm_ListaBuscaEstado.DBLCB_UF.Text = 'EX') then
      Filtra_CFOP('S','X')
    else
      Filtra_CFOP('S','N');
  end
  else
  Begin
    if (Fm_ListaBuscaEstado.DBLCB_UF.Text = '') then
      Filtra_CFOP('E','N')
    else
    if (Fm_ListaBuscaEstado.DBLCB_UF.KeyValue = Fc_Estado(Festabelecimento,'S')) then
      Filtra_CFOP('E','E')
    else
    if (Fm_ListaBuscaEstado.DBLCB_UF.Text = 'EX') then
      Filtra_CFOP('E','X')
    else
      Filtra_CFOP('E','N');
  end
end;

end.
