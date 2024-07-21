unit UN_TabelasEmListas;

interface

uses
  STDatabase, Data.DB, STDataSet, Classes,
  STQuery, IBX.IBDatabase, STTransaction, IBX.IBCustomDataSet, IBX.IBQuery,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  main;

type

  TDM_ListaConsultas = class(TDataModule)
    Qr_ListaNatureza: TSTQuery;
    Qr_ListaNaturezaNAT_CODIGO: TIntegerField;
    Qr_ListaNaturezaNAT_CFOP: TIBStringField;

    Qr_ListaNaturezaNAT_DESCRICAO: TIBStringField;
    Qr_ListaNaturezaCFOP: TIBStringField;
    Qr_ListaNaturezaNAT_RESUMIDO: TIBStringField;
    Ds_ListaNatureza: TDataSource;
    Qr_ListaCliente: TSTQuery;
    Ds_ListaCliente: TDataSource;
    Qr_ListaFornecedor: TSTQuery;
    Ds_ListaFornecedor: TDataSource;
    Qr_ListaEmpresa: TSTQuery;
    Ds_ListaEmpresa: TDataSource;
    Qr_ListaProduto: TSTQuery;
    Ds_ListaProduto: TDataSource;
    IBT_Consulta: TSTTransaction;
    Qr_Kind_Lucratividade: TSTQuery;
    Ds_Kind_Lucratividade: TDataSource;
    Qr_ListaEventosNFe: TSTQuery;
    Ds_ListaEventosNFe: TDataSource;
    Qr_ListaMedida: TSTQuery;
    Ds_ListaMedida: TDataSource;
    Qr_ListaMotoboy: TSTQuery;
    DS_ListaMotoboy: TDataSource;
    Ds_ListaPreco: TDataSource;
    Qr_ListaPreco: TSTQuery;
    Qr_ListaEstabelecimento: TSTQuery;
    Ds_ListaEstabelecimento: TDataSource;
    Qr_ListaTransportadora: TSTQuery;
    Ds_ListaTransportadora: TDataSource;
    Qr_ListaVendedor: TSTQuery;
    DS_ListaVendedor: TDataSource;
    Qr_ListaBancos: TSTQuery;
    Ds_ListaBancos: TDataSource;
    Qr_ListaContabilidade: TSTQuery;
    Ds_ListaContabilidade: TDataSource;
    Qr_ListaRamoAtividade: TSTQuery;
    Ds_ListaRamoAtividade: TDataSource;
    Qr_ListaPlanoContasFinal: TSTQuery;
    Ds_ListaPlanoContasFinal: TDataSource;
    procedure Qr_ListaEventosNFeAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Pc_ListaNatureza(Pc_Sentido:String);
    procedure Pc_ListaClientes(Pc_Order:String);
    procedure Pc_ListaFornecedores(Pc_Order:String);
    procedure Pc_ListaTransportadora(Pc_Order:String);
    procedure Pc_ListaEmpresas(Pc_Order:String);
    procedure Pc_ListaKindLucratividade;
    procedure Pc_ListaProdutos(Pc_Tipo:String);
    procedure Pc_ListaMedida(Pc_Especial,Descricao:String);
    procedure Pc_ListaMotoboy();
    procedure Pc_ListaPrecos_Disponiveis(Pc_Cd_preco:integer);
    procedure Pc_ListaEstabelecimentos(Pc_Order:String);
    procedure Pc_ListaTranportadoras(Pc_Order:String);
    procedure Pc_ListaVendedor();
    procedure Pc_ListaBanco;
    procedure Pc_ListaContabilidade;
    procedure Pc_ListaRamoAtividade;
  end;

var
  DM_ListaConsultas: TDM_ListaConsultas;

implementation

uses Un_DM, UN_Sistema;

{$R *.dfm}
procedure TDM_ListaConsultas.Pc_ListaNatureza(Pc_Sentido:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaNatureza do
  Begin

    if not DM.IB_Transacao.inTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT NAT_CODIGO, NAT_CFOP, NAT_DESCRICAO, NAT_CFOP || '' - '' || NAT_DESCRICAO CFOP, NAT_RESUMIDO '+
                 'FROM TB_NATUREZA '+
                 'WHERE NAT_ATIVO = ''S'' ';
    if (Pc_Sentido = 'E') then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (NAT_SENTIDO = ''E'')';
    if (Pc_Sentido = 'S') then
      Lc_SqlTxt := Lc_SqlTxt + ' AND (NAT_SENTIDO = ''S'')';
    Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY NAT_CFOP ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaClientes(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaCliente do
  Begin

    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_PESSOA, '+
                 ' EMP_CONSUMIDOR, '+
                 ' EMP_TIPO, '+
                 ' EMP_EMAIL, '+
                 ' EMP_DT_CADASTRO, '+
                 ' EMP_VL_CRED, '+
                 ' EMP_FORMDATA, '+
                 ' EMP_FORMDATA_E, '+
                 ' EMP_FORMDATA_C, '+
                 ' EMP_STCRED '+
                 'FROM TB_EMPRESA '+
                 ' INNER JOIN TB_CLIENTE '+
                 ' ON (CLI_CODEMP = EMP_CODIGO) '+
                  'WHERE (CLI_ATIVO = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaFornecedores(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaFornecedor do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR '+
                 'FROM TB_EMPRESA '+
                 ' INNER JOIN TB_FORNECEDOR '+
                 ' ON (FOR_CODEMP = EMP_CODIGO) '+
                  'WHERE (FOR_ATIVO = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaTransportadora(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaTransportadora do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR '+
                 'FROM TB_EMPRESA '+
                 ' INNER JOIN TB_TRANSPORTADORA '+
                 ' ON (TRP_CODEMP = EMP_CODIGO) '+
                  'WHERE (TRP_ATIVO = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaEmpresas(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaEmpresa do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR '+
                 'FROM TB_EMPRESA '+
                  'WHERE (EMP_ATIVA = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaKindLucratividade;
Begin
  with Qr_Kind_Lucratividade do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Active := true;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaProdutos(Pc_Tipo:String);
Begin
  with Qr_ListaProduto do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Sql.Clear;
    SQl.add('SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CODIGOFAB, PRO_CODIGOFOR '+
            'FROM TB_PRODUTO '+
            'WHERE (PRO_ATIVO = ''S'') AND (PRO_FORA_LINHA = ''N'') ');
    if (Length(Pc_Tipo) > 0) then
      SQl.add(' AND (PRO_TIPO =:PRO_TIPO) ');
    SQl.add('ORDER BY PRO_DESCRICAO');
    //passagem de parametros
    if (length(Pc_Tipo) > 0) then
      paramByName('PRO_TIPO').AsString := Pc_Tipo;
    Active := true;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaMedida(Pc_Especial,Descricao:String);
Begin
  with Qr_ListaMedida do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Sql.Clear;
    SQl.add('SELECT * FROM TB_MEDIDA '+
            'WHERE (MED_CODIGO IS NOT NULL)');

    if (Length(Pc_Especial) > 0) then
    Begin
      SQl.add(' AND (MED_ESPECIAL is not null) ');
      if (Length(Descricao) > 0) then
        SQl.add(' AND (MED_ESPECIAL =:MED_ESPECIAL) ');
    End
    else
    BEgin
      SQl.add(' AND (MED_ESPECIAL is null) ');
    End;

    SQl.add(' ORDER BY MED_ABREVIATURA ');
    //passagem de parametros
    if (Length(Descricao) > 0) then
      ParamByName('MED_ESPECIAL').AsString := Descricao;
    Active := true;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaMotoboy();
Begin
  with Qr_ListaMotoboy do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaPrecos_Disponiveis(Pc_Cd_preco:integer);
Begin

end;

procedure TDM_ListaConsultas.Pc_ListaEstabelecimentos(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaEstabelecimento do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR '+
                 'FROM TB_EMPRESA '+
                  'WHERE (EMP_ATIVA = ''S'') and (EMP_TIPO = ''0'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaTranportadoras(Pc_Order:String);
Var
  Lc_SqlTxt : String;
Begin
  with Qr_ListaTransportadora do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT '+
                 ' EMP_CODIGO, '+
                 ' EMP_NOME, '+
                 ' EMP_FANTASIA, '+
                 ' EMP_CODVDOR, '+
                 ' EMP_DT_FUNDA, '+
                 ' EMP_MULTIPLICADOR, '+
                 ' EMP_CONSUMIDOR, '+
                 ' EMP_TIPO, '+
                 ' EMP_EMAIL, '+
                 ' EMP_DT_CADASTRO, '+
                 ' EMP_VL_CRED, '+
                 ' EMP_FORMDATA, '+
                 ' EMP_FORMDATA_E, '+
                 ' EMP_FORMDATA_C '+
                 'FROM TB_EMPRESA '+
                 ' INNER JOIN TB_TRANSPORTADORA  '+
                 ' ON (TRP_CODEMP = EMP_CODIGO) '+
                  'WHERE (TRP_ATIVO = ''S'') ';

    IF Pc_Order = 'EMP_NOME' then
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_NOME '
    else
      Lc_SqlTxt := Lc_SqlTxt + ' ORDER BY EMP_FANTASIA ';
    SQL.Add(Lc_SqlTxt);
    Active := True;
    FetchAll;
  end;

End;


procedure TDM_ListaConsultas.Qr_ListaEventosNFeAfterOpen(
  DataSet: TDataSet);
begin
  Qr_ListaEventosNFe.FetchAll;
end;

procedure TDM_ListaConsultas.Pc_ListaVendedor();
Var
  Lc_Inst_Vend: Boolean;
  Lc_Compartilha: Boolean;
  Lc_SqlTxt: StriNg;
begin
  Lc_Inst_Vend := (Fc_Aq_Geral('L', 'ORDEM DE SERVICO', 'OSR_P_INSTALA_VENDE','N') = 'S');
  Lc_Compartilha := not(Fc_Tb_Geral('L', 'PES_G_COMPARTILHA', 'S') = 'S');
  with Qr_ListaVendedor do
  Begin
    Active := False;
    SQL.Clear;
    Lc_SqlTxt :=
      ' SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda,CLB_AQ_COM_SRV '
      +
      ' FROM TB_COLABORADOR tb_colaborador '
      +
      '     INNER JOIN TB_CARGO tb_cargo ' + '     ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG) ' + ' WHERE (CLB_DEMISSAO IS NULL) ';
    if Lc_Inst_Vend then
      Lc_SqlTxt := Lc_SqlTxt +
        ' AND ( (CRG_DESCRICAO LIKE ''VENDEDOR%'') or (CRG_DESCRICAO LIKE ''INSTALADOR%'') ) '
    else
      Lc_SqlTxt := Lc_SqlTxt + 'AND  (CRG_DESCRICAO LIKE ''VENDEDOR%'') ';
    if Lc_Compartilha then
      Lc_SqlTxt := Lc_SqlTxt + 'and clb_codmha = :clb_codmha ';

    SQL.Add(Lc_SqlTxt + ' ORDER BY CLB_NOME ');

    if Lc_Compartilha then
      ParamByName('CLB_CODMHA').AsInteger := Gb_CodMha;
    Active := true;
    FetchAll;
  end;
end;

procedure TDM_ListaConsultas.Pc_ListaBanco();
Begin
  with Qr_ListaBancos do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Active := True;
    FetchAll;
    First;
  end;
end;


procedure TDM_ListaConsultas.Pc_ListaContabilidade;
Begin
  with Qr_ListaContabilidade do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Active := True;
    FetchAll;
    First;
  end;
end;
procedure TDM_ListaConsultas.Pc_ListaRamoAtividade;
Begin
  with Qr_ListaRamoAtividade do
  Begin
    if not Transaction.InTransaction then Transaction.StartTransaction;
    Active := False;
    Active := True;
    FetchAll;
    First;
  end;
end;

end.
