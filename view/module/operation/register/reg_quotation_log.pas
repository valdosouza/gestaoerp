unit reg_quotation_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, ControllerCotacao, Datasnap.DBClient, ControllerItensCtc,
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
    procedure ds_searchDataChange(Sender: TObject; Field: TField);
  protected
    {procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;}
  private
    { Private declarations }
    cotacao : TControllerCotacao;
    ItensCtc : TControllerItensCtc;

    procedure carregarCotacao;
    procedure carregarItensCotacao(CTC_CODIGO: integer);
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

procedure TRegQuotationLog.ds_searchDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if mem_search.IsEmpty then
    exit;

  carregarItensCotacao(mem_search.FieldByName('CTC_CODIGO').AsInteger);
  SB_Retonar.Enabled := mem_search.FieldByName('CTC_STATUS').AsString = 'A';
  Sb_Desbloqueia.Enabled := mem_search.RecordCount > 0;
end;

procedure TRegQuotationLog.FormDestroy(Sender: TObject);
begin
  inherited;
  cotacao.DisposeOf;
  ItensCtc.DisposeOf;
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
  ItensCtc := TControllerItensCtc.create(self);

  E_Data_Ini.Date := Date;
  E_Data_Fim.Date := Date;
end;

procedure TRegQuotationLog.SB_BuscarClick(Sender: TObject);
begin
  carregarCotacao;
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

  {procedure TFr_Log_Cotacao.Sb_DesbloqueiaClick(Sender: TObject);
  Var
    Lc_cotacao : TControllerCotacao;
  begin
    try
      Lc_cotacao := TControllerCotacao.create(Self);
      Lc_cotacao.Registro.Codigo := TB_cotacao.FieldByName('CTC_CODIGO').AsInteger;
      Lc_cotacao.getbyId;
      if Lc_cotacao.exist then
      begin
        if (Lc_cotacao.Registro.EmUso.Length >0) then
        Begin
          if (MensagemPadrao(' Mensagem de Confirmação',
                             ' Este pedido foi ou está bloqueado no computador ' + Lc_cotacao.Registro.EmUso + '. '+ EOLN +
                             ' Deseja liberar o pedido, Sobre o risco de criar duplicidade na edição do pedido? '+EOLN ,
                             ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
          begin
            //Cria a Sql para a atualização
            Lc_cotacao.LiberaEmUso;
            Pc_Log_Sistema(Gb_CodMha,Gb_Cd_Usuario, (Now), 'Log Pedido',TB_COTACAO.FieldByName('CTC_CODIGO').AsInteger,'Desbloquear','Orçamento Desbloqueado');
          end;
        end
        else
        Begin
          MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                         'Orçamento não Bloqueado.'+EOLN,
                         ['OK'],[bEscape],mpErro);
        end;
      end;
    finally
      Lc_cotacao.DisposeOf;
    end;
  end;}
end;

procedure TRegQuotationLog.SB_RetonarClick(Sender: TObject);
begin
  inherited;

  if mem_search.IsEmpty then
    exit;

  if (MensagemPadrao('Mensagem de Confirmação',
                     'Ativar o Orçamento '+mem_search.FieldByName('CTC_CODIGO').AsString +' para seus arquivos.'+EOLN+EOLN+
                     'Confirmar a Ativação ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    try
      cotacao.atualiza_retornar(mem_search.FieldByName('CTC_CODIGO').AsInteger);
      carregarCotacao;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a operação.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;

{procedure TFr_Log_Cotacao.SB_RetonarClick(Sender: TObject);
begin

  if (MensagemPadrao('Mensagem de Confirmação',
                     'Ativar o Orçamento '+TB_COTACAO.FieldByName('CTC_CODIGO').AsAnsiString +' para seus arquivos.'+EOLN+EOLN+
                     'Confirmar a Ativação ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
    begin
    try
      TB_COTACAO.Edit;
      TB_COTACAO.FieldByName('CTC_DATA').AsDateTime := Date;
      TB_COTACAO.FieldByName('CTC_STATUS').AsAnsiString := 'N';
      TB_COTACAO.Post;
      IF DM.IB_Transacao.InTransaction THEN DM.IB_Transacao.CommitRetaining;
      Pc_Buscar;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a operação.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
      DM.IB_Transacao.RollbackRetaining;
    end;
  end;
end;}
end;

procedure TRegQuotationLog.carregarCotacao;
var
  i: Integer;
begin
  cotacao.Clear;

  cotacao.Parametros.FieldName.Bloqueados := ChBx_Bloqueados.Checked;
  cotacao.Parametros.FieldName.Numero := E_Orcamento.Text;
  cotacao.Parametros.FieldName.Fantasia := E_BuscaFantasia.Text;
  cotacao.Parametros.FieldName.Periodo := ChBx_Periodo.Checked;
  cotacao.Parametros.FieldName.DataInicial := E_Data_Ini.Date;
  cotacao.Parametros.FieldName.DataFinal := E_Data_Fim.Date;
  cotacao.Parametros.FieldName.Status := IntToStr(RG_Situacao.ItemIndex);

  cotacao.Search;

  if not mem_search.Active then
    mem_search.CreateDataSet;

  mem_search.EmptyDataSet;

  mem_search.DisableControls;

  for i := 0 to Pred(cotacao.Lista.Count) do
    mem_search.AppendRecord([cotacao.Lista[i].Codigo, cotacao.Lista[i].Numero,
      cotacao.Lista[i].FPT_DESCRICAO, cotacao.Lista[i].Data, cotacao.Lista[i].Fantasia, cotacao.Lista[i].Status]);

  mem_search.EnableControls;

  inherited;
end;

procedure TRegQuotationLog.carregarItensCotacao(CTC_CODIGO: integer);
var
  i: Integer;
begin
  ItensCtc.Clear;

  ItensCtc.Parametros.FieldName.CodCTC := CTC_CODIGO;
  ItensCtc.Search;

  if not mem_searchItens.Active then
    mem_searchItens.CreateDataSet;

  mem_searchItens.EmptyDataSet;

  mem_searchItens.DisableControls;

  for i := 0 to Pred(ItensCtc.Lista.Count) do
    mem_searchItens.AppendRecord([ItensCtc.Lista[i].CodigoFabrica, ItensCtc.Lista[i].Descricao,
      ItensCtc.Lista[i].Qtde, ItensCtc.Lista[i].ValorUnitario, ItensCtc.Lista[i].SubTotal]);

  mem_searchItens.EnableControls;

  inherited;
end;

procedure TRegQuotationLog.ChBx_PeriodoClick(Sender: TObject);
begin
  inherited;
  E_Data_Ini.Enabled := ChBx_Periodo.Checked;
  E_Data_Fim.Enabled := ChBx_Periodo.Checked;
end;

end.
