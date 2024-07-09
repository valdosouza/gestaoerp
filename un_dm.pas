unit un_dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, STDatabase, STTransaction, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Comp.UI, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, STStoredProc,
  FireDAC.Comp.DataSet, STQuery;

type
  TDM = class(TDataModule)
    IBD_Gestao: TSTDatabase;
    IB_Transacao: TSTTransaction;
    WaitCursor: TFDGUIxWaitCursor;
    DriverLink: TFDPhysFBDriverLink;
    Qr_Cargo: TSTQuery;
    Qr_Grupo: TSTQuery;
    Qr_SubGrupo: TSTQuery;
    Ds_Grupo: TDataSource;
    Ds_SubGrupo: TDataSource;
    Qr_Observacao: TSTQuery;
    Qr_Empresas: TSTQuery;
    Qr_Prazo: TSTQuery;
    Qr_Endereco: TSTQuery;
    Qr_Impostos: TSTQuery;
    Sp_Balancete: TSTStoredProc;
    Qr_Colaborador: TSTQuery;
    Qr_MarcaVeiculo: TSTQuery;
    Qr_Modelo: TSTQuery;
    Ds_MarcaVeiculo: TDataSource;
    Ds_Modelo: TDataSource;
    Qr_Tp_Veiculo: TSTQuery;
    Qr_MarcaProduto: TSTQuery;
    Qr_ListaUsuario: TSTQuery;
    Qr_Cartao: TSTQuery;
    Qr_Situacao: TSTQuery;
    Qr_UF: TSTQuery;
    Qr_Pais: TSTQuery;
    Qr_Cidades: TSTQuery;
    Ds_UF: TDataSource;
    Ds_Cidades: TDataSource;
    ds_Pais: TDataSource;
    Qr_Estoques: TSTQuery;
    Ds_Estoques: TDataSource;
    Ds_Tabelas: TDataSource;
    Qr_Impressora: TSTQuery;
    Qr_Embalagem: TSTQuery;
    Ds_Embalagem: TDataSource;
    Ds_marcaProduto: TDataSource;
    Qr_Tp_Extintor: TSTQuery;
    Qr_Nvl_Manut: TSTQuery;
    Qr_Filtra_CFOP: TSTQuery;
    Qr_Modal_Frete: TSTQuery;
    Sp_Financeiro: TSTStoredProc;
    Qr_Color: TSTQuery;
    Ds_Color: TDataSource;
    Sp_NotaFiscal: TSTStoredProc;
    Sp_Itens_Nfl: TSTStoredProc;
    Sp_Itens_CTC: TSTStoredProc;
    Qr_ImagenBotao: TSTQuery;
    Sp_Comissao: TSTStoredProc;
    qr_trib_pis: TSTQuery;
    ds_trib_pis: TDataSource;
    Qr_Uf_Mva_NCM: TSTQuery;
    Qr_Especie_Doc_Cobranca: TSTQuery;
    Qr_Carteira_Cobranca: TSTQuery;
    Qr_Negocio: TSTQuery;
    Ds_Negocio: TDataSource;
    Qr_Ext_ListaTipoExtintor: TSTQuery;
    Ds_Ext_ListaTipoExtintor: TDataSource;
    Qr_Ext_LocalExtintor: TSTQuery;
    Ds_Ext_LocalExtintor: TDataSource;
    Qr_Ext_Nivel_Manutencao: TSTQuery;
    Ds_Ext_Nivel_Manutencao: TDataSource;
    Qr_Ext_EnsaiadoPor: TSTQuery;
    Ds_Ext_EnsaiadoPor: TDataSource;
    Qr_Ext_Tecnico_Insp: TSTQuery;
    Ds_Ext_Tecnico_Insp: TDataSource;
    Qr_Ext_Motivo: TSTQuery;
    Ds_Ext_Motivo: TDataSource;
    Qr_Revestimento: TSTQuery;
    Ds_Revestimento: TDataSource;
    qr_category: TSTQuery;
    ds_category: TDataSource;
    Qr_Carteiras: TSTQuery;
    Ds_Carteiras: TDataSource;
    Ds_Endereco: TDataSource;
    Qr_Estabelecimento: TSTQuery;
    Qr_Nf_Eletronica: TSTQuery;
    Qr_Ext_TipoExtintor: TSTQuery;
    Ds_Colaborador: TDataSource;
    Qr_Ext_ListaGrandezas: TSTQuery;
    Ds_Ext_ListaGrandezas: TDataSource;
    Qr_Ext_ListaAgenteExtintor: TSTQuery;
    Ds_Ext_ListaAgenteExtintor: TDataSource;
    Qr_Ext_ListaCapacidadeExtintor: TSTQuery;
    Ds_Ext_ListaCapacidadeExtintor: TDataSource;
    Qr_GeneratorBcoDestino: TSTQuery;
    Sp_Itens_NflBcoDestino: TSTStoredProc;
    Qr_Acao_EstoqueBcoDestino: TSTQuery;
    Qr_Insere_EstoqueBcoDestino: TSTQuery;
    Qr_Transportadora: TSTQuery;
    Ds_Natureza: TDataSource;
    Qr_Tabelas: TSTQuery;
    Ds_Ext_Tecnico_Manu: TDataSource;
    Qr_Ext_Tecnico_Manu: TSTQuery;
    Qr_Crud: TSTQuery;
    IBT_Crud: TSTTransaction;
    Ds_TPV_Veiculo: TDataSource;
    IBT_Estoque: TSTTransaction;
    IBT_Financeiro: TSTTransaction;
    IBT_Atualiza: TSTTransaction;
    IBT_Consulta: TSTTransaction;
    IBT_Generator: TSTTransaction;
    IBT_GeneratorBcoDestino: TSTTransaction;
    IBT_ConsultaBcoDestino: TSTTransaction;
    IBT_EstoqueBcoDestino: TSTTransaction;
    IBT_Faturamento: TSTTransaction;
    IBT_Listas: TSTTransaction;
    IBT_Servidor: TSTTransaction;
    IBT_Report: TSTTransaction;
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    procedure DatabaseConnect;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DatabaseConnect;
Var
  LcServer, LcPort, LcDatabase,LcUserName,LcPassword : String;
begin
  LcServer   := 'NOTEVALDO';
  LcPort     := '3060';
  LcDatabase := 'D:\Modelos\erp\Database\IBGCOM.FDB';
  LcUserName := 'sysdba';
  LcPassword := 'masterkey';

  DM.IBD_Gestao.Close;
  DM.IBD_Gestao.DatabaseName := Concat(LcServer,'/',LcPort,LcDatabase);
  {
  DM.IBD_Gestao.Params.Clear;
  DM.IBD_Gestao.Params.Add('Protocol=TCPIP');
  DM.IBD_Gestao.Params.Add('Server='+LcServer);
  DM.IBD_Gestao.Params.Add('Database='+LcDatabase);
  DM.IBD_Gestao.Params.Add('User_Name='+LcUsername);
  DM.IBD_Gestao.Params.Add('Password='+LcPassword);
  DM.IBD_Gestao.Params.Add('DriverID=FB');
  DM.IBD_Gestao.Params.Add('Port=3350');
  }

  //Rodrigo Prado - teste 2 - com branch e pullrequest
  DM.IBD_Gestao.Connected := True;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  DatabaseConnect;
end;

end.
