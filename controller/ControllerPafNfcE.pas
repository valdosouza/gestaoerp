unit ControllerPafNfcE;

interface

uses
  ControllerBase,System.Math, ACBrEAD, ComCtrls, ACBrBase, ACBrPAF_W,ACBrPAF,
  System.Classes, ControllerEstabelecimento, System.SysUtils,ControllerPafCtrl,
  ACBrPAF_E, ACBrPAFRegistros;

Type
  TControllerPafNfcE = Class(TComponent)
    PAF: TACBrPAF;
    EAD : TACBrEAD;
  private
    FUsuarioPAF: TControllerEstabelecimento;
    FBase : TControllerBase;
    FLocalGravacao: String;
    FEstabelecimento: Integer;
    FDataFinal: TDate;
    FDataInicial: TDate;
    FEstoqueParcial: Boolean;
    FListaEstoqueParcial: TStringList;
    FControle: TControllerPafCtrl;
    //U1 - Identificação   do Estabelecimento Usuário do PAF-NFC-e
    procedure GeraPafNfcE_U1;
    //A2 - Total Diário de Meios de Pagamento
    procedure GeraPafNfcE_A2;
    //P2 - Relação das Mercadorias e Serviços
    procedure GeraPafNfcE_P2;
    //E2 - Relação das Mercadorias em Estoque
    procedure GeraPafNfcE_E2;
    //D2 - Relação dos DAV Emitidos
    procedure GeraPafNfcE_D2;
    //D3 - Detalhe do DAV 	Número do DAV Número do Item
    procedure GeraPafNfcE_D3;
    //D4 - Log de Alteração de Itens do DAV 	Número do DAV Data da alteração Hora da alteração
    procedure GeraPafNfcE_D4;
    //S2 - Mesa/Conta de Cliente 	Data de abertura Hora de abertura
    procedure GeraPafNfcE_S2;
    //S3 - Itens da mesa/Conta de Cliente 	Número da mesa/da conta de cliente
    procedure GeraPafNfcE_S3;
    //J1 - NFC-e emitida pelo PAF-NFC-e TB_RETORNO_NFC	CNPJ
    //J2 - Detalhe da NFC-e emitida em contingência pelo PAF-NFC-e
    procedure GeraPafNfcE_J;

    //Z1 	Identificação do usuário do PAF-NFC-e 	1º registro (único)
    procedure GeraPafNfcE_Z1;
    //Z2 	Identificação da Empresa desenvolvedora do PAF-NFC-e 	2º registro (único)
    procedure GeraPafNfcE_Z2;
    //Z3 	Identificação do PAF-NFC-e 	3º registro (único)
    procedure GeraPafNfcE_Z3;
    //Z4 	Totalização de Vendas a CPF/CNPJ 	Vendas a CPF/CNPJ
    procedure GeraPafNfcE_Z4;
    //Z9 	Totalização de registros 	Penúltimo registro (único)
    procedure GeraPafNfcE_Z9;

    //W1 	Identificação do usuário do PAF-NFC-e 	1º registro (único)
    procedure GeraPafNfcE_W1;
    //W2 	Identificação da empresa desenvolvedora do PAF-NFC-e 	2º registro (único)
    procedure GeraPafNfcE_W2;
    //W3 	Identificação do PAF-NFC-e 	3º registro (único)
    procedure GeraPafNfcE_W3;
    //W4 	Identificação da RE 	Detalhamento RE 	A
    procedure GeraPafNfcE_W4;
    //W5 	Totalização de Registros 	Penúltimo registro (único)
    procedure GeraPafNfcE_W5;


    procedure setFEstabelecimento(const Value: Integer);
    procedure setFLocalGravacao(const Value: String);
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
    procedure setFEstoqueParcial(const Value: Boolean);
    procedure setFListaEstoqueParcial(const Value: TStringList);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GeraArquivoPAFNFCe;
    procedure GeraArquivoPAFNFCeZ;
    procedure GeraArquivoPAFNFCeW;
    property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;
    property LocalGravacao :String read FLocalGravacao write setFLocalGravacao;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
    property EstoqueParcial : Boolean read FEstoqueParcial write setFEstoqueParcial;
    property ListaEstoqueParcial : TStringList read FListaEstoqueParcial write setFListaEstoqueParcial;
    property Controle : TControllerPafCtrl read FControle;
  End;
implementation
{ TControllerPafNfcE }

uses ControllerPafRegA2, ACBrPAF_A, ACBrPAF_P, ControllerPafRegP2,
  ControllerPafRegE2,ControllerPafRegJ1,ControllerPafRegJ2, ACBrPAF_J,
  ControllerPafRegZ4, ACBrPAF_Z;

const
  DESENV_CNPJ         = '07742094000113';
  DESENV_IE           = '';
  DESENV_IM           = '';
  DESENV_RAZAOSOCIAL  = 'F. D. SOUZA DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS';
  DESENV_SISTEMA      = 'Sistema Gestao Setes';
  DESENV_VERSAO       = '2.0';

constructor TControllerPafNfcE.Create(AOwner: TComponent);
begin
  inherited;
  FListaEstoqueParcial := TStringList.Create;
  FUsuarioPAF := TControllerEstabelecimento.Create(self);
  FControle := TControllerPafCtrl.Create(self);
  FBase := TControllerBase.Create(self);
  PAF := TACBrPAF.Create(self);
  EAD := TACBrEAD.Create(self);
  PAF.EAD := EAD;
end;

destructor TControllerPafNfcE.Destroy;
begin
  FListaEstoqueParcial.DisposeOf;
  FUsuarioPAF.DisposeOf;
  FControle.DisposeOf;
  FBase.DisposeOf;
  EAD.DisposeOf;
  PAF.DisposeOf;
  inherited;
end;

procedure TControllerPafNfcE.GeraPafNfcE_A2;
Var
  RegA2 : TControllerPafRegA2;
  NovoRegistroA2: TRegistroA2;
  I : Integer;
begin
  Try
    RegA2 := TControllerPafRegA2.create(nil);
    RegA2.DataInicial := FDataInicial;
    RegA2.DataFinal := FDataFinal;
    RegA2.getList;
    for I := 0 to RegA2.Lista.Count -1 do
    begin
      NovoRegistroA2 := PAF.PAF_A.RegistroA2.New;

      NovoRegistroA2.DT             := RegA2.Lista[I].DataMovimento;
      NovoRegistroA2.MEIO_PGTO      := RegA2.Lista[I].MeioPagamento;
      NovoRegistroA2.TIPO_DOC       := RegA2.Lista[I].TipoDocumento; // 1-NFC-e 2-NF-e 3-Operação não tributável, identificando o CPF ou CNPJ do cliente.
      NovoRegistroA2.VL             := RegA2.Lista[I].Valor;
      NovoRegistroA2.CNPJ           := RegA2.Lista[I].CnpjCpfCliente; // Só é preciso informar para o tipo de documento "3"
      NovoRegistroA2.NUMDOCUMENTO   := RegA2.Lista[I].NumeroDocumento ; // Só é preciso informar para o tipo de documento "3"

      NovoRegistroA2.RegistroValido := True;
    end;
  Finally
    RegA2.DisposeOf;
  End;

end;

procedure TControllerPafNfcE.GeraPafNfcE_D2;
begin

end;

procedure TControllerPafNfcE.GeraPafNfcE_D3;
begin

end;

procedure TControllerPafNfcE.GeraPafNfcE_D4;
begin

end;

procedure TControllerPafNfcE.GeraPafNfcE_E2;
Var
  RegE2 : TControllerPafRegE2;
  NovoRegistroE2: TRegistroE2;
  I : Integer;
begin
  Try
    RegE2 := TControllerPafRegE2.create(nil);
    RegE2.getList(FListaEstoqueParcial);
    for I := 0 to RegE2.Lista.Count -1 do
    begin
      NovoRegistroE2 := PAF.PAF_E.RegistroE2.New;

      NovoRegistroE2.COD_MERC       := RegE2.Lista[I].Codigo.toString();
      NovoRegistroE2.CEST           := RegE2.Lista[I].CEST;
      NovoRegistroE2.NCM            := RegE2.Lista[I].NCM;
      NovoRegistroE2.DESC_MERC      := RegE2.Lista[I].Descricao;
      NovoRegistroE2.UN_MED         := RegE2.Lista[I].Unidade;
      NovoRegistroE2.QTDE_EST       := RegE2.Lista[I].Quantidade;
      NovoRegistroE2.DATAEMISSAO    := Date;
      NovoRegistroE2.DATAESTOQUE    := RegE2.Lista[I].DataMovimento;
      NovoRegistroE2.RegistroValido := True;
    end;
  Finally
    RegE2.DisposeOf;
  End;
end;

procedure TControllerPafNfcE.GeraPafNfcE_J;
Var
  RegJ1 : TControllerPafRegJ1;
  RegJ2 : TControllerPafRegJ2;
  NovoRegistroJ1: TRegistroJ1;
  NovoRegistroJ2: TRegistroJ2;
  I,J : Integer;

begin
  Try
    RegJ1 := TControllerPafRegJ1.create(nil);
    RegJ2 := TControllerPafRegJ2.create(nil);
    RegJ1.DataInicial := FDataInicial;
    RegJ1.DataFinal := FDataFinal;
    RegJ1.getList;
    for I := 0 to RegJ1.Lista.Count -1 do
    begin
      NovoRegistroJ1 := PAF.PAF_J.RegistroJ1.New;

      NovoRegistroJ1.CNPJ                  := PAF.PAF_U.RegistroU1.CNPJ;
      NovoRegistroJ1.DATA_EMISSAO          := RegJ1.Lista[I].DataEmissao;
      NovoRegistroJ1.SUBTOTAL              := RegJ1.Lista[I].SubTotal;
      NovoRegistroJ1.DESC_SUBTOTAL         := RegJ1.Lista[I].DescontoSubTotal;
      NovoRegistroJ1.INDICADOR_DESC        := 'V';
      NovoRegistroJ1.ACRES_SUBTOTAL        := 0;
      NovoRegistroJ1.INDICADOR_ACRES       := 'V';
      NovoRegistroJ1.VALOR_LIQUIDO         := RegJ1.Lista[I].ValorTotalLiquido;
      NovoRegistroJ1.TIPOEMISSAO           := RegJ1.Lista[I].TipoEmissao;
      NovoRegistroJ1.CHAVE_NF              := RegJ1.Lista[I].ChaveAcesso;
      NovoRegistroJ1.NUMERO_NOTA           := RegJ1.Lista[I].NumeroNFCE;
      NovoRegistroJ1.SERIE_NOTA            := RegJ1.Lista[I].SerieNFCE;
      NovoRegistroJ1.CPFCNPJ_CLIENTE       := RegJ1.Lista[I].CPFCNPJADQUIRENTE;

      if (RegJ1.Lista[I].TipoEmissao = '9') then
      Begin
        RegJ2.NumeroNFce := RegJ1.Lista[I].NumeroNFCE;
        RegJ2.SerieNfce :=  RegJ1.Lista[I].SerieNFCE;
        RegJ2.getNfce;
        for J := 0 to RegJ2.Lista.Count -1 do
        begin
          NovoRegistroJ2 := NovoRegistroJ1.RegistroJ2.New;
          NovoRegistroJ2.CNPJ                    := PAF.PAF_U.RegistroU1.CNPJ;
          NovoRegistroJ2.DATA_EMISSAO            := RegJ2.Lista[J].DataEmissao;
          NovoRegistroJ2.NUMERO_ITEM             := RegJ2.Lista[J].NumeroItem;
          NovoRegistroJ2.CODIGO_PRODUTO          := RegJ2.Lista[J].Produto;
          NovoRegistroJ2.DESCRICAO               := RegJ2.Lista[J].Descricao;
          NovoRegistroJ2.QUANTIDADE              := RegJ2.Lista[J].Quantidade;
          NovoRegistroJ2.UNIDADE                 := RegJ2.Lista[J].Unidade;
          NovoRegistroJ2.VALOR_UNITARIO          := RegJ2.Lista[J].ValorUnitario;
          NovoRegistroJ2.DESCONTO_ITEM           := RegJ2.Lista[J].DescontoItem;
          NovoRegistroJ2.ACRESCIMO_ITEM          := 0;
          NovoRegistroJ2.VALOR_LIQUIDO           := RegJ2.Lista[J].ValorLiquido;
          NovoRegistroJ2.TOTALIZADOR_PARCIAL     := RegJ2.Lista[J].TotalizadorParcial;
          NovoRegistroJ2.CASAS_DECIMAIS_QTDE     := RegJ2.Lista[J].CasasDecimaisQtde;
          NovoRegistroJ2.CASAS_DECIMAIS_VAL_UNIT := RegJ2.Lista[J].CasasDecimaisVlUnit;
          NovoRegistroJ2.NUMERO_NOTA             := RegJ2.Lista[J].NumeroNFCE;
          NovoRegistroJ2.SERIE_NOTA              := RegJ2.Lista[J].SerieNFCE;
          NovoRegistroJ2.CHAVE_NF                := RegJ2.Lista[J].ChaveAcesso;
        end;
      end;
      NovoRegistroJ1.RegistroValido := True;
    end;
  Finally
    RegJ1.DisposeOf;
    RegJ2.DisposeOf;
  End;

end;


procedure TControllerPafNfcE.GeraPafNfcE_P2;
Var
  RegP2 : TControllerPafRegP2;
  NovoRegistroP2: TRegistroP2;
  I : Integer;
begin
  Try
    RegP2 := TControllerPafRegP2.create(nil);
    RegP2.getList;
    for I := 0 to RegP2.Lista.Count -1 do
    begin
      NovoRegistroP2 := PAF.PAF_P.RegistroP2.New;
      NovoRegistroP2.COD_MERC_SERV  := RegP2.Lista[I].Codigo;
      NovoRegistroP2.DESC_MERC_SERV := RegP2.Lista[I].Descricao;
      NovoRegistroP2.UN_MED         := RegP2.Lista[I].Unidade;
      NovoRegistroP2.IAT            := RegP2.Lista[I].IAT;
      NovoRegistroP2.IPPT           := RegP2.Lista[I].IPPT;
      NovoRegistroP2.ST             := RegP2.Lista[I].SituacaoTributaria;
      NovoRegistroP2.ALIQ           := RegP2.Lista[I].Aliquota;
      NovoRegistroP2.VL_UNIT        := RegP2.Lista[I].ValorUnitario;
      NovoRegistroP2.RegistroValido := True;
    end;
  Finally
    RegP2.DisposeOf;
  End;
end;

procedure TControllerPafNfcE.GeraPafNfcE_S2;
begin

end;

procedure TControllerPafNfcE.GeraPafNfcE_S3;
begin

end;

procedure TControllerPafNfcE.GeraPafNfcE_U1;
begin
  with PAF.PAF_U do
  Begin
    RegistroU1.CNPJ             := FUsuarioPAF.Registro.CpfCNPJ;
    RegistroU1.IE               := FUsuarioPAF.Registro.InscricaoEstadual;
    RegistroU1.IM               := FUsuarioPAF.Registro.InscricaoMunicipal;
    RegistroU1.RAZAOSOCIAL      := FUsuarioPAF.Registro.NomeRazaoSocial;
    RegistroU1.InclusaoExclusao := True;
  End;
end;

procedure TControllerPafNfcE.GeraPafNfcE_W1;
begin
  PAF.PAF_W.RegistroW1.CNPJ             := FUsuarioPAF.Registro.CpfCNPJ;
  PAF.PAF_W.RegistroW1.IE               := FUsuarioPAF.Registro.InscricaoEstadual;;
  PAF.PAF_W.RegistroW1.IM               := FUsuarioPAF.Registro.InscricaoMunicipal;
  PAF.PAF_W.RegistroW1.RAZAOSOCIAL      := FUsuarioPAF.Registro.NomeRazaoSocial;
end;

procedure TControllerPafNfcE.GeraPafNfcE_W2;
begin
  PAF.PAF_W.RegistroW2.CNPJ             := DESENV_CNPJ;
  PAF.PAF_W.RegistroW2.IE               := DESENV_IE;
  PAF.PAF_W.RegistroW2.IM               := DESENV_IM;
  PAF.PAF_W.RegistroW2.RAZAOSOCIAL      := DESENV_RAZAOSOCIAL;
end;

procedure TControllerPafNfcE.GeraPafNfcE_W3;
begin
  PAF.PAF_W.RegistroW3.NOME   := DESENV_SISTEMA;
  PAF.PAF_W.RegistroW3.VERSAO := DESENV_VERSAO;
end;

procedure TControllerPafNfcE.GeraPafNfcE_W4;
begin

end;

procedure TControllerPafNfcE.GeraPafNfcE_W5;
begin
  //Prenchido Automaticamente pelo Componente ACBR
end;

procedure TControllerPafNfcE.GeraPafNfcE_Z1;
begin
  PAF.PAF_Z.RegistroZ1.CNPJ             := FUsuarioPAF.Registro.CpfCNPJ;
  PAF.PAF_Z.RegistroZ1.IE               := FUsuarioPAF.Registro.InscricaoEstadual;;
  PAF.PAF_Z.RegistroZ1.IM               := FUsuarioPAF.Registro.InscricaoMunicipal;
  PAF.PAF_Z.RegistroZ1.RAZAOSOCIAL      := FUsuarioPAF.Registro.NomeRazaoSocial;
end;

procedure TControllerPafNfcE.GeraPafNfcE_Z2;
begin
  PAF.PAF_Z.RegistroZ2.CNPJ             := DESENV_CNPJ;
  PAF.PAF_Z.RegistroZ2.IE               := DESENV_IE;
  PAF.PAF_Z.RegistroZ2.IM               := DESENV_IM;
  PAF.PAF_Z.RegistroZ2.RAZAOSOCIAL      := DESENV_RAZAOSOCIAL;
end;

procedure TControllerPafNfcE.GeraPafNfcE_Z3;
begin
  PAF.PAF_Z.RegistroZ3.NOME:= DESENV_SISTEMA;
  PAF.PAF_Z.RegistroZ3.VERSAO:=  DESENV_VERSAO;
end;

procedure TControllerPafNfcE.GeraPafNfcE_Z4;
Var
  RegZ4 : TControllerPafRegZ4;
  LRegistroZ4: TRegistroZ4;
  I : Integer;
begin
  Try
    RegZ4 := TControllerPafRegZ4.create(nil);
    RegZ4.DataInicial := FDataInicial;
    RegZ4.DataFinal   := FDataFinal;
    RegZ4.getList;
    for I := 0 to RegZ4.Lista.Count -1 do
    begin
      LRegistroZ4 := PAF.PAF_Z.RegistroZ4.New;

      LRegistroZ4.CPF_CNPJ:= RegZ4.Lista[I].CpfCnpj;
      LRegistroZ4.VL_TOTAL_MENSAL:= RegZ4.Lista[I].TotalizadorMensal;
      LRegistroZ4.DATA_INI:= FDataInicial;
      LRegistroZ4.DATA_FIM:= FDataFinal;
    end;
  Finally
    RegZ4.DisposeOf;
  End;
end;

procedure TControllerPafNfcE.GeraPafNfcE_Z9;
begin
  //Prenchido Automaticamente pelo Componente ACBR
end;

procedure TControllerPafNfcE.GeraArquivoPAFNFCe;
begin
  PAF.Layout := lpPAFNFCe;
  //U1 - Identificação   do Estabelecimento Usuário do PAF-NFC-e
  GeraPafNfcE_U1;
  //A2 - Total Diário de Meios de Pagamento
  GeraPafNfcE_A2;
  //P2 - Relação das Mercadorias e Serviços
  GeraPafNfcE_P2;
  //E2 - Relação das Mercadorias em Estoque
  GeraPafNfcE_E2;
  //D2 - Relação dos DAV Emitidos
  GeraPafNfcE_D2;
  //D3 - Detalhe do DAV 	Número do DAV Número do Item
  GeraPafNfcE_D3;
  //D4 - Log de Alteração de Itens do DAV 	Número do DAV Data da alteração Hora da alteração
  GeraPafNfcE_D4;
  //S2 - Mesa/Conta de Cliente 	Data de abertura Hora de abertura
  GeraPafNfcE_S2;
  //S3 - Itens da mesa/Conta de Cliente 	Número da mesa/da conta de cliente
  GeraPafNfcE_S3;
  //J1 - NFC-e emitida pelo PAF-NFC-e TB_RETORNO_NFC	CNPJ
  //J2 - Detalhe da NFC-e emitida em contingência pelo PAF-NFC-e
  GeraPafNfcE_J;

  PAF.SaveToFile_RegistrosPAF(concat(FLocalGravacao,'RegistrosPAFNFCe.txt'));
end;

procedure TControllerPafNfcE.GeraArquivoPAFNFCeW;
begin
  PAF.Layout := lpPAFNFCe;
  //W1 	Identificação do usuário do PAF-NFC-e 	1º registro (único)
  GeraPafNfcE_W1;
  //W2 	Identificação da empresa desenvolvedora do PAF-NFC-e 	2º registro (único)
  GeraPafNfcE_W2;
  //W3 	Identificação do PAF-NFC-e 	3º registro (único)
  GeraPafNfcE_W3;
  //W4 	Identificação da RE 	Detalhamento RE 	A
  GeraPafNfcE_W4;
  //W5 	Totalização de Registros 	Penúltimo registro (único)
  GeraPafNfcE_W5;

  PAF.SaveToFile_W(concat(FLocalGravacao,'RegistrosPAFNFCeW.txt'));
end;

procedure TControllerPafNfcE.GeraArquivoPAFNFCeZ;
begin
  PAF.Layout := lpPAFNFCe;
  //Z1 	Identificação do usuário do PAF-NFC-e 	1º registro (único)
  GeraPafNfcE_Z1;
  //Z2 	Identificação da Empresa desenvolvedora do PAF-NFC-e 	2º registro (único)
  GeraPafNfcE_Z2;
  //Z3 	Identificação do PAF-NFC-e 	3º registro (único)
  GeraPafNfcE_Z3;
  //Z4 	Totalização de Vendas a CPF/CNPJ 	Vendas a CPF/CNPJ
  GeraPafNfcE_Z4;
  //Z9 	Totalização de registros 	Penúltimo registro (único)
  GeraPafNfcE_Z9;

  PAF.SaveToFile_Z(concat(FLocalGravacao,'RegistrosPAFNFCeZ.txt'));
end;

procedure TControllerPafNfcE.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerPafNfcE.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TControllerPafNfcE.setFEstabelecimento(const Value: Integer);
begin
  FUsuarioPAF.Registro.Codigo := Value;
  FUsuarioPAF.getAll;
end;

procedure TControllerPafNfcE.setFEstoqueParcial(const Value: Boolean);
begin
  FEstoqueParcial := Value;
end;

procedure TControllerPafNfcE.setFListaEstoqueParcial(const Value: TStringList);
begin
  FListaEstoqueParcial := Value;
end;

procedure TControllerPafNfcE.setFLocalGravacao(const Value: String);
begin
  FLocalGravacao := Value;
end;

end.
