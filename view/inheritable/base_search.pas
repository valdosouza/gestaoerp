unit base_search;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Un_base, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, STQuery,Un_DM, System.UITypes;

type
  TBaseSearch = class(TFr_Base)
    Pnl_Fundo: TPanel;
    Pnl_Parametros: TPanel;
    ds_search: TDataSource;
    cds_search: TClientDataSet;
    Sb_Sair_0: TSpeedButton;
    SB_Visualizar: TSpeedButton;
    SB_Buscar: TSpeedButton;
    SB_Cadastrar: TSpeedButton;
    Lb_ResultadoPesquisa: TLabel;
    DBG_Pesquisa: TDBGrid;
    pnl_pesq_right: TPanel;
    procedure Sb_Sair_0Click(Sender: TObject);
    procedure SB_VisualizarClick(Sender: TObject);
    procedure SB_BuscarClick(Sender: TObject);
    procedure SB_CadastrarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBG_PesquisaDblClick(Sender: TObject);
    procedure DBG_PesquisaTitleClick(Column: TColumn);

  private

  protected
    FSelecionar: Boolean;
    FSelecionado: Boolean;
    procedure openRegister(pCodigo:Integer);virtual;
    procedure setFSelecionar(const Value: Boolean);
    procedure setFSelecionado(const Value: Boolean);
    //Start
    procedure ImagemBotao;Override;
    procedure CriarVariaveis;Override;
    procedure IniciaVariaveis;Override;
    procedure FormataTela;Override;
    //Search operations
    function validateGetView:Boolean;Virtual;
    procedure GetView;Virtual;
    procedure Search;Virtual;
    procedure totalizer;Virtual;
    procedure SetRegister;Virtual;
    procedure returnRegister;Virtual;
    //TEclas
    procedure execShorCutKeyF2;Override;
    procedure execShorCutKeyF7;Override;
    procedure execShorCutKeyF8;Override;
    procedure execShorCutEsc;Override;

  public
    property Selecionar : Boolean read FSelecionar write setFSelecionar;
    property Selecionado : Boolean read FSelecionado write setFSelecionado;
  end;

var
  BaseSearch: TBaseSearch;

implementation

{$R *.dfm}

uses Un_Msg;

procedure TBaseSearch.CriarVariaveis;
begin
  inherited;
  FSelecionar := False;
end;

procedure TBaseSearch.DBG_PesquisaDblClick(Sender: TObject);
begin
  SB_VisualizarClick(Self);
end;

procedure TBaseSearch.DBG_PesquisaTitleClick(Column: TColumn);
var
   i: Integer;
begin
   // apply grid formatting changes here e.g. title styling
  with DBG_Pesquisa do
    for i := 0 to Columns.Count - 1 do
      Columns[i].Title.Font.Style := Columns[i].Title.Font.Style - [fsBold];
   Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
  cds_search.IndexFieldNames := Column.FieldName;
end;

procedure TBaseSearch.execShorCutEsc;
begin
  Close;
end;

procedure TBaseSearch.execShorCutKeyF2;
begin
  if SB_Cadastrar.Enabled then SB_CadastrarClick(Self);
end;

procedure TBaseSearch.execShorCutKeyF7;
begin
  if SB_Buscar.Enabled then SB_BuscarClick(Self);
end;

procedure TBaseSearch.execShorCutKeyF8;
begin
  inherited;
  if SB_visualizar.Enabled then SB_visualizarClick(Self);
end;

procedure TBaseSearch.FormataTela;
begin
  //pode ser implementada nas descendencias
end;

procedure TBaseSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (shift = []) then
  begin
    case Key of
      VK_F2:execShorCutKeyF2;
      VK_F7: execShorCutKeyF7;
      VK_F8: execShorCutKeyF8;
      VK_Escape: execShorCutEsc;
    end;
  end;
end;

procedure TBaseSearch.GetView;
begin
  //será implementada nas descendencias
end;

procedure TBaseSearch.Search;
begin
  Lb_ResultadoPesquisa.Caption := concat('Resultado da pesquisa : ', IntToStr(cds_search.RecordCount),'(s) registros');
end;


procedure TBaseSearch.setFSelecionado(const Value: Boolean);
begin
  FSelecionado := Value;
end;

procedure TBaseSearch.setFSelecionar(const Value: Boolean);
begin
  FSelecionar := Value;
end;

procedure TBaseSearch.ImagemBotao;
begin
  CarregaImagemBotao(SB_Cadastrar,'CADASTRAR');
  CarregaImagemBotao(SB_Buscar,'BUSCAR');
  if FSelecionar then
  Begin
    SB_Cadastrar.Visible := False;
    CarregaImagemBotao(SB_Visualizar,'CONFIRMAR');
    SB_Visualizar.Caption:= 'Selecionar - F8';
  End
  else
  Begin
    SB_Cadastrar.Visible := True;
    CarregaImagemBotao(SB_Visualizar,'VISUALIZAR');
    SB_Visualizar.Caption:= 'Visualizar - F8';
  End;
  CarregaImagemBotao(Sb_Sair_0,'SAIR');
end;

procedure TBaseSearch.SetRegister;
begin
  //será implementada nas descendencias
end;

procedure TBaseSearch.totalizer;
begin
  //pode ser implementada nas descendencias
end;

function TBaseSearch.validateGetView: Boolean;
begin
  Result := True;
  if not cds_search.Active then
  Begin
    MensagemPararExecucao('Nenhuma busca foi efetuada');
    Result := False;
    exit;
  end;

  if cds_search.RecordCount = 0 then
  Begin
    MensagemPararExecucao('Não há registros para visualizar.');
    Result := False;
    exit;
  end;
  FSelecionado := True;
end;

procedure TBaseSearch.IniciaVariaveis;
begin
  inherited;
  if FSelecionar then
  Begin
    SB_Cadastrar.Visible := False;
    SB_Visualizar.Caption:= 'Selecionar - F8';
  End
  else
  Begin
    SB_Cadastrar.Visible := True;
    SB_Visualizar.Caption:= 'Visualizar - F8';
  End;
  cds_search.Close;
end;

procedure TBaseSearch.openRegister(pCodigo: Integer);
begin
//
end;

procedure TBaseSearch.returnRegister;
begin
  //será implementada nas descendencias
end;

procedure TBaseSearch.Sb_Sair_0Click(Sender: TObject);
begin
  FSelecionado := False;
  Close;
end;

procedure TBaseSearch.SB_CadastrarClick(Sender: TObject);
begin
  SetRegister;
end;

procedure TBaseSearch.SB_BuscarClick(Sender: TObject);
begin
  Search;
  totalizer;
end;

procedure TBaseSearch.SB_VisualizarClick(Sender: TObject);
begin
  if validateGetView then
  Begin
    if FSelecionar then
    Begin
      returnRegister;
      Self.Close
    End
    else
      GetView;
  End;
end;

end.

