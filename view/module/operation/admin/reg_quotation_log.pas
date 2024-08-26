unit reg_quotation_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, ControllerCotacao, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TRegQuotationLog = class(TFr_Base)
    GroupBox1: TGroupBox;
    L_Orcamento: TLabel;
    L_BuscaFantasia: TLabel;
    RG_Situacao: TRadioGroup;
    E_Orcamento: TMaskEdit;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    ChBx_Bloqueados: TCheckBox;
    E_BuscaFantasia: TMaskEdit;
    DBG_Pesquisa: TDBGrid;
    Label12: TLabel;
    DBG_Itens: TDBGrid;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    SB_Sair: TSpeedButton;
    SB_Retonar: TSpeedButton;
    Sb_Desbloqueia: TSpeedButton;
    ds_search: TDataSource;
    mem_searchItens: TFDMemTable;
    ds_searchItens: TDataSource;
    mem_search: TFDMemTable;
    mem_searchCTC_NUMERO: TStringField;
    mem_searchFPT_DESCRICAO: TStringField;
    mem_searchCTC_DATA: TDateField;
    mem_searchCTC_FANTASIA: TStringField;
    mem_searchItensPRO_CODIGOFAB: TStringField;
    mem_searchItensICT_DESCRICAO: TStringField;
    mem_searchItensICT_QTDE: TFloatField;
    mem_searchItensICT_VL_UNIT: TFloatField;
    mem_searchItensICT_VL_SUBTOTAL: TCurrencyField;
    mem_searchCTC_CODIGO: TIntegerField;
    mem_searchCTC_STATUS: TStringField;
    procedure SB_BuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);
    procedure DBG_ItensTitleClick(Column: TColumn);
    procedure Sb_DesbloqueiaClick(Sender: TObject);
    procedure SB_RetonarClick(Sender: TObject);
    procedure ChBx_PeriodoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mem_searchAfterScroll(DataSet: TDataSet);
    procedure SB_SairClick(Sender: TObject);
  protected
  private
    { Private declarations }
    cotacao : TControllerCotacao;

    procedure carregarCotacao;
    procedure carregarItensCotacao;
  public

  end;

var
  RegQuotationLog: TRegQuotationLog;

implementation

uses UN_Sistema, UN_MSG, Un_stored_procedures, env;

{$R *.dfm}

procedure TRegQuotationLog.DBG_ItensTitleClick(Column: TColumn);
begin
  inherited;
  Pc_Pintar_Grid_Ordenar(DBG_Itens, Column);
end;

procedure TRegQuotationLog.DBG_PesquisaTitleClick(Column: TColumn);
begin
  inherited;
  Pc_Pintar_Grid_Ordenar(DBG_Pesquisa, Column);
end;

procedure TRegQuotationLog.FormDestroy(Sender: TObject);
begin
  inherited;
  cotacao.DisposeOf;
end;

procedure TRegQuotationLog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  {if shift = [] then
  begin
    case Key of
      VK_F5  : if SB_Retonar.Enabled then SB_RetonarClick(Sender);
      VK_F7  : if SB_Buscar.Enabled then SB_BuscarClick(Sender);
      VK_Escape : if SB_Sair.Enabled then SB_SairClick(Sender);
    end;
  end;   }
end;

procedure TRegQuotationLog.FormShow(Sender: TObject);
begin
  inherited;
  cotacao := TControllerCotacao.create(self);

  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
end;

procedure TRegQuotationLog.mem_searchAfterScroll(DataSet: TDataSet);
begin
  carregarItensCotacao;
  SB_Retonar.Enabled :=  ( mem_searchCTC_STATUS.AsString = 'A' );
  Sb_Desbloqueia.Enabled := mem_search.RecordCount >0;

end;

procedure TRegQuotationLog.SB_BuscarClick(Sender: TObject);
begin
  carregarCotacao;
  if True then

  carregarItensCotacao;
end;

procedure TRegQuotationLog.Sb_DesbloqueiaClick(Sender: TObject);
begin
  inherited;
  if mem_search.IsEmpty then
    exit;
  cotacao.Registro.Codigo := mem_search.FieldByName('CTC_CODIGO').AsInteger;
  cotacao.getbyId;
  if cotacao.exist then
  begin
    if (cotacao.Registro.EmUso.Length > 0) then
    Begin
      if (MensagemPadrao(' Mensagem de Confirmação',
                         ' Este pedido foi ou está bloqueado no computador ' + cotacao.Registro.EmUso + '. '+ EOLN +
                         ' Deseja liberar o pedido, Sobre o risco de criar duplicidade na edição do pedido? '+EOLN ,
                         ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
        //Cria a Sql para a atualização
        cotacao.LiberaEmUso;
        Pc_Log_Sistema(Gb_CodMha, Gb_Cd_Usuario, (Now), 'Log Pedido', mem_search.FieldByName('CTC_CODIGO').AsInteger, 'Desbloquear','Orçamento Desbloqueado');
      end;
    end
    else
    Begin
      MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Orçamento não Bloqueado.'+EOLN,
                     ['OK'],[bEscape],mpErro);
    end;
  end;
end;

procedure TRegQuotationLog.SB_RetonarClick(Sender: TObject);
begin
  if mem_search.IsEmpty then
    exit;

  if (MensagemPadrao('Mensagem de Confirmação',
                     'Ativar o Orçamento '+mem_search.FieldByName('CTC_CODIGO').AsString +' para seus arquivos.'+EOLN+EOLN+
                     'Confirmar a Ativação ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    try
      cotacao.Registro.Codigo := mem_search.FieldByName('CTC_CODIGO').AsInteger;
      cotacao.UndoDelete;
      carregarCotacao;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a operação.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;
end;

procedure TRegQuotationLog.SB_SairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TRegQuotationLog.carregarCotacao;
var
  i: Integer;
begin
  cotacao.Clear;
  cotacao.Parametros.Periodo := ChBx_Periodo.Checked;
  cotacao.Parametros.DataInicial := E_Data_Ini.Date;
  cotacao.Parametros.DataFinal := E_Data_Fim.Date;
  cotacao.Parametros.Bloqueado := ChBx_Bloqueados.Checked;
  cotacao.Parametros.FieldName.Numero := E_Orcamento.Text;
  cotacao.Parametros.FieldName.Fantasia := E_BuscaFantasia.Text;
  case RG_Situacao.ItemIndex of
    0:cotacao.Parametros.FieldName.Status := 'A';
    1:cotacao.Parametros.FieldName.Status := 'N';
  end;
  IntToStr(RG_Situacao.ItemIndex);

  cotacao.Search;

  if not mem_search.Active then
    mem_search.CreateDataSet;

  mem_search.EmptyDataSet;

  mem_search.DisableControls;

  for i := 0 to Pred(cotacao.Lista.Count) do
    mem_search.AppendRecord([cotacao.Lista[i].Codigo, cotacao.Lista[i].Numero,
      cotacao.Lista[i].FormaPAgamento, cotacao.Lista[i].Data, cotacao.Lista[i].Fantasia, cotacao.Lista[i].Status]);
  mem_search.First;
  mem_search.EnableControls;

end;

procedure TRegQuotationLog.carregarItensCotacao;
var
  i: Integer;
begin
  with cotacao do
  Begin
    Itens.Clear;

    Itens.Parametros.FieldName.Cotacao := mem_searchCTC_CODIGO.AsInteger;
    Itens.Search;

    if not mem_searchItens.Active then
      mem_searchItens.CreateDataSet;

    mem_searchItens.EmptyDataSet;

    mem_searchItens.DisableControls;

    for i := 0 to Pred(Itens.Lista.Count) do
      mem_searchItens.AppendRecord([Itens.Lista[i].CodigoFabrica, Itens.Lista[i].Descricao,
        Itens.Lista[i].Quantidade, Itens.Lista[i].ValorUnitario, Itens.Lista[i].SubTotal]);

    mem_searchItens.EnableControls;

    inherited;
  End;
end;

procedure TRegQuotationLog.ChBx_PeriodoClick(Sender: TObject);
begin
  inherited;
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

end.
