unit reg_order_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_Base, Vcl.Menus, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.UITypes,
  ControllerItensNFL, ControllerPedido, ControllerCtrlEstoque;

type
  TRegOrderLog = class(TFr_Base)
    GroupBox1: TGroupBox;
    L_Pedido: TLabel;
    L_BuscaFantasia: TLabel;
    L_BuscaRazao: TLabel;
    RG_Situacao: TRadioGroup;
    E_Pedido: TMaskEdit;
    Rg_Tipo: TRadioGroup;
    E_Data_Ini: TDateTimePicker;
    E_Data_Fim: TDateTimePicker;
    ChBx_Periodo: TCheckBox;
    ChBx_Bloqueados: TCheckBox;
    E_BuscaRazao: TMaskEdit;
    E_BuscaFantasia: TMaskEdit;
    DBG_Pesquisa: TDBGrid;
    Label12: TLabel;
    DBG_Itens: TDBGrid;
    Panel1: TPanel;
    SB_Buscar: TSpeedButton;
    SB_Sair: TSpeedButton;
    SB_Excluir: TSpeedButton;
    SB_Retonar: TSpeedButton;
    sb_autorizaPedido: TSpeedButton;
    Sb_Desbloqueia: TSpeedButton;
    memDetalhesPedido: TFDMemTable;
    dsDetalhesPedido: TDataSource;
    memPedido: TFDMemTable;
    dsPedido: TDataSource;
    memPedidoPED_NUMERO: TIntegerField;
    memPedidoFPT_DESCRICAO: TStringField;
    memPedidoPED_DATA: TDateField;
    memPedidoEMP_NOME: TStringField;
    memPedidoUSU_NOME: TStringField;
    memPedidoPED_DT_ALTERA: TDateTimeField;
    memDetalhesPedidoPRO_DESCRICAO: TStringField;
    memDetalhesPedidoITF_QTDE: TCurrencyField;
    memDetalhesPedidoITF_VL_UNIT: TCurrencyField;
    memDetalhesPedidoITF_VL_SUBTOTAL: TCurrencyField;
    memPedidoPED_CODIGO: TIntegerField;
    memDetalhesPedidoPRO_CODIGOFAB: TStringField;
    memPedidoPED_FATURADO: TStringField;
    memPedidoPED_APROVADO: TStringField;
    memPedidoPED_TIPO: TIntegerField;
    procedure SB_BuscarClick(Sender: TObject);
    procedure dsPedidoDataChange(Sender: TObject; Field: TField);
    procedure Sb_DesbloqueiaClick(Sender: TObject);
    procedure sb_autorizaPedidoClick(Sender: TObject);
    procedure SB_ExcluirClick(Sender: TObject);
    procedure SB_RetonarClick(Sender: TObject);
    procedure memPedidoAfterScroll(DataSet: TDataSet);
  protected
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
  private
    { Private declarations }
    Order : TControllerPedido;
    ItensNFL : TControllerItensNFL;
    CtrlEstoque : TControllerCtrlEstoque;

    procedure carregarGridPedidos;
    procedure carregarGridDetalhesPedidos(iCodigoPedido: integer);
  public
    { Public declarations }
  end;

var
  RegOrderLog: TRegOrderLog;

implementation

uses UN_MSG, env, Un_stored_procedures, un_sistema;

{$R *.dfm}

{ TRegOrderLog }

procedure TRegOrderLog.CriarVariaveis;
begin
  inherited;
  Order := TControllerPedido.create(self);
  ItensNFL := TControllerItensNFL.create(self);
  CtrlEstoque := TControllerCtrlEstoque.create(self);
end;

procedure TRegOrderLog.dsPedidoDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if not memPedido.IsEmpty then
  begin
    carregarGridDetalhesPedidos(memPedido.FieldByName('PED_CODIGO').AsInteger);
    SB_Excluir.Enabled := memPedido.FieldByName('PED_FATURADO').AsAnsiString = 'A';
    SB_Retonar.Enabled := memPedido.FieldByName('PED_FATURADO').AsAnsiString = 'A';
    Sb_Desbloqueia.Enabled := memPedido.RecordCount > 0;
  end;
end;

procedure TRegOrderLog.FinalizaVariaveis;
begin
  inherited;
  Order.DisposeOf;
  ItensNFL.DisposeOf;
  CtrlEstoque.DisposeOf;
end;

procedure TRegOrderLog.IniciaVariaveis;
begin
  carregarGridPedidos;
 inherited;
end;

procedure TRegOrderLog.memPedidoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  sb_autorizaPedido.Enabled := (memPedido.FieldByName('PED_FATURADO').AsAnsiString = SIGLA_N)
                              and (memPedido.FieldByName('PED_APROVADO').AsAnsiString <> SIGLA_S ) ;
end;

procedure TRegOrderLog.sb_autorizaPedidoClick(Sender: TObject);
begin
  if memPedido.IsEmpty then
    exit;

  If (MessageDlg('Autorizar Pedido ? ', mtConfirmation, [mbYes,mbNo],0)) = idyes then
  begin
    Order.Registro.Codigo := memPedido.FieldByName('PED_CODIGO').AsInteger;
    Order.getbyId;

    Order.pC_AutorizarPedido;

    Pc_Log_Sistema(Gb_CodMha,
                   Gb_Cd_Usuario,
                   Now,
                   'RegOrder', //'Fr_Pedido_Vda',
                   memPedido.FieldByName('PED_CODIGO').AsInteger,
                   'Liberação Pedido',
                   'Autorizar Pedido Com Restrições Financeiras');

    SB_Buscar.Click;
  end;
end;

procedure TRegOrderLog.SB_BuscarClick(Sender: TObject);
begin
  inherited;
  memDetalhesPedido.Active := False;
  carregarGridPedidos;
end;

procedure TRegOrderLog.Sb_DesbloqueiaClick(Sender: TObject);
begin
  if memPedido.IsEmpty then
    exit;

  Order.Registro.Codigo := memPedido.FieldByName('PED_CODIGO').AsInteger;
  Order.getbyId;
  if Order.exist then
  begin
    if (Order.Registro.EmUso.Length >0) then
    Begin
      if (MensagemPadrao(' Mensagem de Confirmação',
                         ' Este pedido foi ou está bloqueado no computador ' + Order.Registro.EmUso + '. '+ EOLN +
                         ' Deseja liberar o pedido, Sobre o risco de criar duplicidade na edição do pedido? '+EOLN ,
                         ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
      begin
        Order.LiberaEmUso;
        Pc_Log_Sistema(Gb_CodMha,Gb_Cd_Usuario, (Now), 'Log Pedido',memPedido.FieldByName('PED_CODIGO').AsInteger,'Desbloquear','Pedido Desbloqueado');
      end;
    end
    else
    Begin
      MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Pedido não Bloqueado.'+EOLN,
                     ['OK'],[bEscape],mpErro);
    end;
  end;
end;

procedure TRegOrderLog.SB_ExcluirClick(Sender: TObject);
Var
  Lc_Cd_Pedido : Integer;
begin
  if memPedido.IsEmpty then
    exit;

  if Gb_Nivel = 1 then
  Begin
    if (MensagemPadrao('Mensagem de Confirmação',
                       'Excluir '+ memPedido.FieldByName('PED_CODIGO').AsString +' de seus arquivos.'+EOLN+EOLN+
                       'Confirmar a exclusão ?',
                      ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
    begin
      Lc_Cd_Pedido := memPedido.FieldByName('PED_CODIGO').AsInteger;
      Pc_Log_Sistema(Gb_CodMha,GB_Cd_Usuario,Now,'Log de Pedido',memPedido.FieldByName('PED_CODIGO').AsInteger,
                     'Excluir Pedido','Pedido Nº '+ memPedido.FieldByName('PED_NUMERO').AsString +' excluido definitivamente' );

      Order.Registro.Codigo := memPedido.FieldByName('PED_CODIGO').AsInteger;
      Order.getbyId;
      Order.Delete;

      Pc_Excluir_Extintores(Lc_Cd_Pedido);
    end;
  end
  else
  Begin
    MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'As exclusões definitivas são permitidas apenas' + EOLN +
                   'para usuários administradores.' + EOLN,
                   ['OK'], [bEscape], mpAlerta);
  end;
end;

procedure TRegOrderLog.SB_RetonarClick(Sender: TObject);
begin
  if memPedido.IsEmpty then
    exit;

  if (MensagemPadrao('Mensagem de Confirmação',
                     'Ativar o Pedido '+memPedido.FieldByName('PED_CODIGO').AsString +' para seus arquivos.'+EOLN+EOLN+
                     'Confirmar a Ativação ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clBtnFace) = mrBotao1) then
  begin
    try
      Order.Registro.Codigo := memPedido.FieldByName('PED_CODIGO').AsInteger;
      Order.getbyId;
      Order.Retonar;

      if (memPedido.FieldByName('PED_TIPO').AsInteger = 1) then
      Begin
        while not memDetalhesPedido.Eof do
        Begin
          with CtrlEstoque.Registro do
          Begin
            Codigo      := 0;
            Terminal    := GB_TERMINAL;
            Vinculo     := 'P';
            Ordem       := memPedido.FieldByName('PED_CODIGO').AsInteger;
            Item        := memDetalhesPedido.FieldByname('ITF_CODIGO').AsInteger;
            Estoque     := memDetalhesPedido.FieldByname('ITF_CODEST').AsInteger;
            operacao    := Sigla_S;
            Produto     := memDetalhesPedido.FieldByname('ITF_CODPRO').AsInteger;
            Quantidade  := memDetalhesPedido.FieldByname('ITF_QTDE').AsFloat;
            Data        := DAte;
            case memPedido.FieldByName('PED_TIPO').AsInteger of
              1:Tipo := 'Venda';
              2:Tipo := 'Compra';
              3:Tipo := 'Ajuste';
              4:Tipo := 'Venda';
              5:Tipo := 'Consignação';
            end;
            UpdateAt    := Now;
          End;
          CtrlEstoque.Registra;
          memDetalhesPedido.Next;
        end;
      end;
      SB_Buscar.Click;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a operação.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;
end;

procedure TRegOrderLog.carregarGridPedidos;
Var
  i : Integer;
begin
  Order.Clear;

  if ChBx_Periodo.Checked then
  begin
    Order.Parametros.FieldName.DataIni := E_Data_Ini.Date;
    Order.Parametros.FieldName.DataFim := E_Data_Fim.Date;
  end;

  Order.Parametros.FieldName.Numero := StrToIntDef(E_Pedido.Text, 0);

  Order.Parametros.FieldName.EMP_NOME := E_BuscaRazao.Text;
  Order.Parametros.FieldName.EMP_FANTASIA := E_BuscaFantasia.Text;

  case RG_Situacao.ItemIndex of
    0: Order.Parametros.FieldName.Faturado := 'A';
    1: Order.Parametros.FieldName.Faturado := Sigla_n;
    2: Order.Parametros.FieldName.Faturado := Sigla_S;
  end;

  case Rg_Tipo.ItemIndex of
    0: Order.Parametros.FieldName.Tipo := 1;
    1: Order.Parametros.FieldName.Tipo := 2;
    2: Order.Parametros.FieldName.Tipo := 3;
  end;

  if ChBx_Bloqueados.Checked then
    Order.Parametros.FieldName.EmUso := Sigla_S;

  Order.Search;

  if not memPedido.Active then
    memPedido.CreateDataSet;

  memPedido.EmptyDataSet;
  memPedido.DisableControls;

  for i := 0 to Pred(Order.Lista.Count) do
    memPedido.AppendRecord([
      Order.Lista[i].Numero,
      Order.Lista[i].FPT_DESCRICAO,
      Order.Lista[i].Data,
      Order.Lista[i].EMP_NOME,
      Order.Lista[i].USU_NOME,
      Order.Lista[i].DataAlteracao,
      Order.Lista[i].Codigo,
      Order.Lista[i].Faturado,
      Order.Lista[i].Aprovado,
      Order.Lista[i].Tipo
      ]);

  memPedido.EnableControls;
  memPedido.First;
end;

procedure TRegOrderLog.carregarGridDetalhesPedidos(iCodigoPedido: integer);
Var
  i : Integer;
begin
  ItensNFL.Clear;

  ItensNFL.Parametros.FieldName.CodigoPedido := iCodigoPedido;
  ItensNFL.Parametros.FieldName.CodigoEstabelecimento := Gb_CodMha;

  ItensNFL.Search;

  if not memDetalhesPedido.Active then
    memDetalhesPedido.CreateDataSet;

  memDetalhesPedido.EmptyDataSet;
  memDetalhesPedido.DisableControls;

  for i := 0 to Pred(ItensNFL.Lista.Count) do
    memDetalhesPedido.AppendRecord([
      ItensNFL.Lista[i].CodigoFabrica,
      ItensNFL.Lista[i].DescricaoProduto,
      ItensNFL.Lista[i].Quantidade,
      ItensNFL.Lista[i].ValorUnitario,
      ItensNFL.Lista[i].SubTotal]);

  memDetalhesPedido.EnableControls;
  memDetalhesPedido.First;
end;

end.
