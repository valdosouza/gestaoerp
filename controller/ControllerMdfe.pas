unit ControllerMdfe;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
     tblMdfe ,Un_MSg,Generics.Collections,
     ControllerMdfeConfig, ControllerMdfeLoadLocal, ControllerMdfeStateRoute, ControllerMdfeRoad,
     ControllerMdfeTrailer, ControllerMdfeConductor,  ControllerMdfeNfe,
     ControllerMdfeTotalizer, ControllerMdfeUnloadLocal, ControllerEmpresa,
  ACBrMDFe, AnsiStrings,pcnConversao, pmdfeConversaoMDFe,
  tblMdfeLoadLocal, tblMdfeUnloadLocal, tblMdfeConductor,ControllerMdfeRetorno,
  ControllerARquivo, Data.DB,ACBrMDFeDAMDFeClass,ACBrMDFeDAMDFeRLClass;

Type

  TControllerMdfe = Class(TControllerBase)
  private
    FOperador: TACBrMDFe;
    DAMDFe   : TACBrMDFeDAMDFeRL;
    FMotivoCancelamento: String;
    procedure setFOperador(const Value: TACBrMDFe);
    procedure setFMotivoCancelamento(const Value: String);

  public
    Registro              : TMdfe;
    Estabelecimento       : TcontrollerEmpresa;
    Config                : TControllerMdfeConfig;
    LoadLocal             : TControllerMdfeLoadLocal;
    StateRoute            : TControllerMdfeStateRoute;
    UnloadLocal           : TControllerMdfeUnloadLocal;
    Road                  : TControllerMdfeRoad;
    Trailler              : TControllerMdfeTrailer;
    Conductor             : TControllerMdfeConductor;
    Nfe                   : TControllerMdfeNfe;
    Totalizer             : TControllerMdfeTotalizer;
    Retorno               : TControllerMdfeRetorno;
    Arquivo               : TControllerARquivo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure getAllbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    //====================================
    procedure Gerar;
    procedure clear;
    procedure LimpaWebService;
    function Transmitir:Integer;
    function Consultar:Integer;
    function Cancelar:integer;
    function Encerrar:integer;
    function Imprimir:Integer;
    function ImprimirPDF:Integer;
    procedure SalvaRetorno;
    procedure SalvaArquivoBanco;
    function VerificaStatusServico:Boolean;
    property Operador : TACBrMDFe read FOperador write setFOperador;
    property MotivoCancelamento : String read FMotivoCancelamento write setFMotivoCancelamento;
  End;

implementation

{ TControllerMdfe }

function TControllerMdfe.Cancelar: integer;
Var
  Lc_NumeroLote : Integer;
  Lc_Aux:String;
begin
  Lc_Aux := FormatDateTime('yymmddhhmmss', NOW);
  Lc_Aux := copy(Lc_Aux,2,10);
  Lc_NumeroLote := StrToInt64(Lc_Aux);
  FOperador.EventoMDFe.Evento.Clear;
  FOperador.EventoMDFe.idLote := Lc_NumeroLote;
  with FOperador.EventoMDFe.Evento.New do
  begin
    infEvento.dhEvento := NOW;
    infEvento.tpEvento := teCancelamento;
    infEvento.detEvento.xJust := FMotivoCancelamento;
  end;
  FOperador.EnviarEvento(Lc_NumeroLote);
end;

procedure TControllerMdfe.clear;
begin
  clearObj(Registro);
  LoadLocal.clear;
  StateRoute.clear;
  UnloadLocal.clear;
  Road.clear;
  Trailler.clear;
  Conductor.clear;
  Nfe.clear;
  Totalizer.clear;
  Retorno.clear;
  Arquivo.clear;

end;

function TControllerMdfe.Consultar: Integer;
begin
  FOperador.WebServices.Consulta.Clear;
  FOperador.Consultar;
  //Este campos são prenchidos aqui pois o Webservice retorna em objetos diferentes
  Retorno.Registro.protocolo        := FOperador.WebServices.Consulta.Protocolo;
  Retorno.Registro.Situacao         := FOperador.WebServices.Consulta.cStat;
  Retorno.Registro.Motivo           := FOperador.WebServices.Consulta.XMotivo;
end;

constructor TControllerMdfe.Create(AOwner: TComponent);
begin
  inherited;
  Registro        := TMdfe.Create;
  Estabelecimento := TcontrollerEmpresa.Create(self);
  LoadLocal       := TControllerMdfeLoadLocal.Create(self);
  StateRoute      := TControllerMdfeStateRoute.Create(self);
  UnloadLocal     := TControllerMdfeUnloadLocal.Create(self);
  Road            := TControllerMdfeRoad.Create(self);
  Trailler        := TControllerMdfeTrailer.Create(self);
  Conductor       := TControllerMdfeConductor.Create(self);
  Nfe             := TControllerMdfeNfe.Create(self);
  Totalizer       := TControllerMdfeTotalizer.Create(self);
  FOperador       := TACBrMDFe.Create(Self);
  DAMDFe          := TACBrMDFeDAMDFeRL.Create(Self);
  FOperador.DAMDFE := DAMDFe;
  Config          := TControllerMdfeConfig.Create(self);
  Config.Operador := FOperador;
  Config.PreparaComponente;
  Retorno         := TControllerMdfeRetorno.Create(Self);
  Arquivo         := TControllerARquivo.Create(Self);
end;

function TControllerMdfe.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfe.Destroy;
begin
  Registro.DisposeOf;
  Estabelecimento.DisposeOf;
  Config.DisposeOf;
  LoadLocal.DisposeOf;
  StateRoute.DisposeOf;
  UnloadLocal.DisposeOf;
  Road.DisposeOf;
  Trailler.DisposeOf;
  Conductor.DisposeOf;
  Nfe.DisposeOf;
  Totalizer.DisposeOf;
  FOperador.DisposeOf;
  Retorno.DisposeOf;
  Arquivo.DisposeOf;
  DAMDFe.DisposeOf;
  inherited;
end;


function TControllerMdfe.Encerrar: integer;
Var
  Lc_NumeroLote: Int64;
  Lc_Aux:String;
begin
  Lc_Aux := FormatDateTime('yymmddhhmmss', NOW);
  Lc_Aux := copy(Lc_Aux,2,10);
  Lc_NumeroLote := StrToInt64(Lc_Aux);
  FOperador.EventoMDFe.Evento.Clear;
  FOperador.EventoMDFe.idLote := Lc_NumeroLote;
  with FOperador.EventoMDFe.Evento.New do
  begin
    infEvento.dhEvento := NOW;
    infEvento.tpEvento := teEncerramento;
    infEvento.nSeqEvento := 1;
    infEvento.detEvento.nProt := FOperador.Manifestos.Items[0].MDFe.procMDFe.nProt;
    infEvento.detEvento.dtEnc := Date;
    infEvento.detEvento.cUF   := StrToInt(Copy(IntToStr(FOperador.Manifestos.Items[0].MDFe.infDoc.infMunDescarga.Items[0].cMunDescarga),1,2));
    infEvento.detEvento.cMun  := FOperador.Manifestos.Items[0].MDFe.infDoc.infMunDescarga.Items[0].cMunDescarga;
  end;
  FOperador.EnviarEvento(Lc_NumeroLote);
end;

procedure TControllerMdfe.Gerar;
Var
  I,J:Integer;
  LcloadLocal : TMdfeLoadLocal;
  LcUnloadLocal : TMdfeUnloadLocal;
  LcCondutor : TMdfeConductor;
  LcOk :Boolean;
  LcListaChave :TStringList;
begin
  FOperador.Manifestos.Clear;
  with FOperador.Manifestos.Add.MDFe do
  begin
    //
    // Dados de Identificação do MDF-e
    //

    Ide.cUF := Estabelecimento.Endereco.Uf.Registro.Codigo;

    // TpcnTipoAmbiente = (taProducao, taHomologacao);
    case AnsiIndexStr(UpperCase(Config.Registro.Camada), ['P', 'H']) of
      0: Ide.tpAmb := taProducao;
      1: Ide.tpAmb := taHomologacao;
    end;

    // TMDFeTpEmitente = ( teTransportadora, teTranspCargaPropria );
    case AnsiIndexStr(UpperCase(Registro.TipoEmissor), ['T', 'P']) of
      0: Ide.tpEmit  := teTransportadora;
      1: Ide.tpEmit  := teTranspCargaPropria;
    end;

    Ide.modelo  := Registro.Modelo;
    Ide.serie   := StrToIntDef(Registro.Serie,1);
    Ide.nMDF    := StrToIntDef(Registro.Numero,0);
    Ide.cMDF    := Registro.codigo;  // Código Aleatório
    // TMDFeModal = ( moRodoviario, moAereo, moAquaviario, moFerroviario );
    case AnsiIndexStr(UpperCase(Registro.Modalidade), ['R', 'A','Q','F']) of
      0: Ide.modal := moRodoviario;
      1: Ide.modal := moAereo;
      2: Ide.modal := moAquaviario;
      3: Ide.modal := moFerroviario;
    end;

    Ide.dhEmi   := Registro.DataEmissao;
    // TpcnTipoEmissao = (teNormal, teContingencia, teSCAN, teDPEC, teFSDA);
    Ide.tpEmis  := StrToTpEmis(lcok,Config.Registro.TipoEmissao);
    // TpcnProcessoEmissao = (peAplicativoContribuinte, peAvulsaFisco, peAvulsaContribuinte, peContribuinteAplicativoFisco);
    Ide.procEmi := peAplicativoContribuinte;
    Ide.verProc := '2.016';
    //MDFe.loadLocal.getlist; - Carregou no getallByKey
    for I := 0 to loadLocal.Lista.Count -1 do
    Begin
      LcloadLocal := TMdfeLoadLocal.Create;
      LcloadLocal := LoadLocal.Lista[I];
      loadLocal.Cidade.Registro.Codigo := LcloadLocal.Cidade;
      loadLocal.Cidade.getbyId;

      if I = 0 then
      Begin
        //Estado de carregamento
        Ide.UFIni   := loadLocal.Cidade.Registro.Estado;

      End;

      with Ide.infMunCarrega.New do
      begin
        cMunCarrega := loadLocal.Cidade.Registro.IBGE;
        xMunCarrega := loadLocal.Cidade.Registro.Descricao;
      end;
    End;

    //MDFe.unloadLocal.getlist; - Carregou no getallByKey
    //Esta seção preenche a tag Unload Local
    for I := 0 to unloadLocal.Lista.Count -1 do
    Begin
      LcunloadLocal := TMdfeunLoadLocal.Create;
      LcunloadLocal := unLoadLocal.Lista[I];
      unloadLocal.Cidade.Registro.Codigo := LcunloadLocal.Cidade;
      unloadLocal.Cidade.getbyId;

      if I = unloadLocal.Lista.Count -1 then
      Begin
        //Estado de descarregamento
        Ide.UFFim   := unloadLocal.Cidade.Registro.Estado;
      End;

    End;

    //Informar se houver mais de um estado
    if StateRoute.Lista.Count >1 then
    Begin
      for I := 0 to StateRoute.Lista.Count -1 do
      Begin
        with ide.infPercurso.New do
        Begin
          StateRoute.Uf.Registro.Codigo := StateRoute.Registro.Estado;
          StateRoute.Uf.getbyId;
          UFPer := StateRoute.Uf.Registro.Sigla;
        End;
      End;
    End;
    Ide.dhIniViagem := Registro.DataViagem;
    // Dados do Emitente
    with Estabelecimento do
    BEgin
      Emit.CNPJCPF := Registro.CpfCNPJ;
      Emit.IE      := Registro.InscricaoEstadual;
      Emit.xNome   := Registro.NomeRazaoSocial;
      Emit.xFant   := Registro.ApelidoFantasia;

      with Estabelecimento.Endereco do
      Begin
        Emit.EnderEmit.xLgr    := Registro.Logradouro;
        Emit.EnderEmit.nro     := Registro.NumeroPredial;
        Emit.EnderEmit.xCpl    := Registro.Complemento;
        Emit.EnderEmit.xBairro := Registro.Bairro;
          Cidade.Registro.Codigo := Registro.CodigoCidade;
          Cidade.getbyId;
        Emit.EnderEmit.cMun    := Cidade.Registro.IBGE;
        Emit.EnderEmit.xMun    := Cidade.Registro.Descricao;
        Emit.EnderEmit.CEP     := StrToIntDef(Registro.Cep,0);
        Emit.EnderEmit.UF      := Cidade.Registro.Estado;
        Emit.EnderEmit.fone    := Registro.Fone;
      end;
      Emit.enderEmit.email   := Registro.Email;
    end;

    rodo.RNTRC := Road.Registro.RNTRC;
    rodo.CIOT  := '';

    with Road.Veiculo do
    begin
      rodo.veicTracao.cInt    := IntToStr(Registro.Codigo);
      rodo.veicTracao.placa   := Registro.Placa;
      rodo.veicTracao.RENAVAM := Registro.Renavan;
      rodo.veicTracao.tara    := trunc(Registro.Tara);
      rodo.veicTracao.capKG   := trunc(Registro.CapacidadeKg);
      rodo.veicTracao.capM3   := trunc(Registro.CapacidadeM3);

      // TpcteTipoRodado = (trNaoAplicavel, trTruck, trToco, trCavaloMecanico, trVAN, trUtilitario, trOutros);
      // Para o MDF-e não utilizar o trNaoAplicavel.
      case AnsiIndexStr(Road.Veiculo.Registro.TipoRodado, ['Truck','Toco','Cavalo Mecânico','VAN','Utilitário','Outros']) of
        0: rodo.veicTracao.tpRod := trTruck;
        1: rodo.veicTracao.tpRod := trToco;
        2: rodo.veicTracao.tpRod := trCavaloMecanico;
        3: rodo.veicTracao.tpRod := trVAN;
        4: rodo.veicTracao.tpRod := trUtilitario;
        5: rodo.veicTracao.tpRod := trOutros;
      end;

      // TpcteTipoCarroceria = (tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider);
      case AnsiIndexStr(Road.Veiculo.Registro.Carroceria, ['Não Aplicável','Aberta','Fechada/Baú','Granelera','Porta-Contêiner','Sider']) of
        0: rodo.veicTracao.tpCar := tcNaoAplicavel;
        1: rodo.veicTracao.tpCar := tcAberta;
        2: rodo.veicTracao.tpCar := tcFechada;
        3: rodo.veicTracao.tpCar := tcGraneleira;
        4: rodo.veicTracao.tpCar := tcPortaContainer;
        5: rodo.veicTracao.tpCar := tcSider;
      end;

      Uf.Registro.Codigo := Registro.Estado;
      uf.getbyId;
      rodo.veicTracao.UF := uf.Registro.Sigla;
    end;

    //MDFe.Conductor.getlist; - Carregou no getallByKey
    for I := 0 to Conductor.Lista.Count -1 do
    Begin
      Lccondutor := TMdfeConductor.Create;
      Lccondutor := Conductor.Lista[I];
      Conductor.Colaborador.Registro.Codigo := Lccondutor.Colaborador;
      Conductor.Colaborador.getbyId;

      with rodo.veicTracao.condutor.New do
      begin
      xNome := Conductor.Colaborador.Registro.Nome;
      CPF   := Conductor.Colaborador.Registro.CPFCNPJ;
      end;
    End;
    {
    with rodo.veicReboque.Add do
    begin
      cInt    := '';
      placa   := '';
      RENAVAM := '';
      tara    := 4000;
      capKG   := 3000;
      capM3   := 300;

      // TpcteTipoCarroceria = (tcNaoAplicavel, tcAberta, tcFechada, tcGraneleira, tcPortaContainer, tcSider);
      tpCar := tcFechada;

      UF := edtEmitUF.Text;
    end;
     }
     {
    with rodo.valePed.disp.Add do
    begin
      CNPJForn := '12345678000199';
      CNPJPg   := '21543876000188';
      nCompra  := '789';
    end;
     }

    //MDFe.UnloadLocal.getlist;  - Carregou no getallByKey
    //Esta seção utiliza o load local para vincular a NFE à Cidade
    for I := 0 to unloadLocal.Lista.Count -1 do
    Begin
      LcunloadLocal := TMdfeunLoadLocal.Create;
      LcunloadLocal := unLoadLocal.Lista[I];
      unloadLocal.Cidade.Registro.Codigo := LcunloadLocal.Cidade;
      unloadLocal.Cidade.getbyId;

      with infDoc.infMunDescarga.New do
      begin
        cMunDescarga := unloadLocal.Cidade.Registro.IBGE;
        xMunDescarga := unloadLocal.Cidade.Registro.Descricao;

        unloadLocal.Registro := LcunloadLocal;
        LcListaChave := TStringList.Create;
        LcListaChave := unloadLocal.getchave;
        for J := 0 to LcListaChave.Count -1 do
        BEgin
          with infNFe.New do
          Begin
            chNFe       := LcListaChave[J];
            SegCodBarra := '';
          End;
        End;
      end;

    End;

    With Totalizer do
      begin
        tot.qCTe := 0;
        tot.qNFe := Registro.QuantidadeNfe;
        tot.vCarga := Registro.ValorTotalCarga;
        // UnidMed = (uM3,uKG, uTON, uUNIDADE, uLITROS);
        Medida.Registro.Codigo := Registro.MedidaId;
        Medida.getbyId;
        if Medida.Registro.Abreviatura = 'TON' then
          tot.cUnid  := uTON
        else
          tot.cUnid  := uKG;

        tot.qCarga := Registro.PesoBruto;
      end;

    {with lacres.Add do
    begin
      nLacre := '123';
    end;}

    infAdic.infCpl     := Registro.Observacao;
    infAdic.infAdFisco := Registro.ObservacaoFisco;
  end;
  FOperador.Manifestos.GravarXML(Config.Registro.RepositorioMdfe);
  FOperador.Manifestos[0].GerarXML;
  FOperador.Manifestos.Assinar;
  FOperador.Manifestos.Validar;

end;

procedure TControllerMdfe.getAllbyId;
begin
  getbyId;

  Estabelecimento.Registro.Codigo :=  Registro.Estabelecimento;
  Estabelecimento.getAllBykey;

  Config.Registro.Estabelecimento := Registro.Estabelecimento;
  Config.getbyId;

  loadlocal.registro.Estabelecimento := Registro.Estabelecimento;
  loadlocal.registro.MDFE            := Registro.Codigo;
  loadlocal.GetList;

  StateRoute.registro.Estabelecimento := Registro.Estabelecimento;
  StateRoute.registro.MDFE            := Registro.Codigo;
  StateRoute.GetList;

  UnloadLocal.registro.Estabelecimento := Registro.Estabelecimento;
  UnloadLocal.registro.MDFE            := Registro.Codigo;
  UnloadLocal.GetList;

  Road.Registro.Estabelecimento := Registro.Estabelecimento;
  Road.Registro.MDFE            := registro.Codigo;
  Road.getbyId;
  Road.Veiculo.Registro.Placa := Road.Registro.Veiculo;
  Road.Veiculo.getbyId;
  {
  //Trailler      := TControllerMdfeTrailer.Create(self);
  Trailler.Registro.Estabelecimento := Registro.Estabelecimento;
  Trailler.Registro.Codigo         := registro.Codigo;
  Trailler.getlist()
  }
  conductor.registro.Estabelecimento   := Registro.Estabelecimento;
  conductor.registro.MDFE              := Registro.Codigo;
  conductor.GetList;

  //da suporte no preenchimento da tela mas no xml é feito de outra maneira
  Nfe.Registro.Estabelecimento := Registro.Estabelecimento;
  Nfe.registro.MDFE            := Registro.Codigo;
  Nfe.GetList;

  //Totalizer
  Totalizer.Registro.Estabelecimento := Registro.Estabelecimento;
  Totalizer.Registro.MDFE            := registro.Codigo;
  Totalizer.getbyId;

  //Retorno
  Retorno.Registro.Estabelecimento := Registro.Estabelecimento;
  Retorno.Registro.Codigo            := registro.Codigo;
  Retorno.getbyId;

  //Arquivo
  Arquivo.Registro.TipoDoArquivo  := 7;
  Arquivo.Registro.CodigoVinculo := Self.Registro.Codigo;
  Arquivo.getbyVinculo;

end;

procedure TControllerMdfe.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfe.Imprimir: Integer;
Var
  LcPathFile : String;
begin
  LcPathFile := concat(Config.Registro.RepositorioMdfe,'\',
                       Retorno.Registro.Arquivo);
  Arquivo.Salva_Arq_disco(LcPathFile);
  FOperador.Manifestos.LoadFromFile(LcPathFile);
  DAMDFE.MostraPreview := True;
  DAMDFE.Cancelada := False;
  if Retorno.Registro.Situacao = 3 then
  Begin
    DAMDFe.Cancelada := True;
    DAMDFe.Protocolo := Retorno.Registro.Protocolo;
  End;
  DAMDFe.Encerrado := False;
  if Retorno.Registro.Situacao = 4 then
  Begin
    DAMDFe.Encerrado := True;
    DAMDFe.Protocolo := Retorno.Registro.Protocolo;
  End;
 FOperador.Manifestos[0].Cancelado;
 FOperador.Manifestos[0].Imprimir;
end;

function TControllerMdfe.ImprimirPDF: Integer;
Var
  LcPathFile : String;
begin
  LcPathFile := concat(Config.Registro.RepositorioMdfe,'\',
                       Retorno.Registro.Arquivo);
  Arquivo.Salva_Arq_disco(LcPathFile);
  FOperador.Manifestos.LoadFromFile(LcPathFile);
  FOperador.DAMDFE.MostraPreview := True;
  FOperador.DAMDFE.Cancelada := False;
  if Retorno.Registro.Situacao = 3 then
  Begin
    DAMDFe.Cancelada := True;
    DAMDFe.Protocolo := Retorno.Registro.Protocolo;
  End;
  DAMDFe.Encerrado := False;
  if Retorno.Registro.Situacao = 4 then
  Begin
    DAMDFe.Encerrado := True;
    DAMDFe.Protocolo := Retorno.Registro.Protocolo;
  End;
  FOperador.DAMDFE.MostraPreview := True;
  FOperador.Manifestos[0].ImprimirPDF;

end;

function TControllerMdfe.insere: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDFE');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerMdfe.LimpaWebService;
begin
  with FOperador.WebServices do
  Begin
    Enviar.Clear;
    Retorno.Clear;
    Consulta.Clear;
    EnvioWebService.Clear;
  end;
end;

function TControllerMdfe.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDFE');

  SaveObj(Registro);

end;

procedure TControllerMdfe.setFMotivoCancelamento(const Value: String);
begin
  FMotivoCancelamento := Value;
end;

procedure TControllerMdfe.setFOperador(const Value: TACBrMDFe);
begin
  FOperador := Value;
end;

function TControllerMdfe.Transmitir: Integer;
begin
  FOperador.WebServices.Retorno.Clear;
  FOperador.WebServices.Enviar.Clear;
  FOperador.DAMDFE.MostraPreview := True;
  FOperador.Enviar(Registro.Codigo,true);
  //Este campos são prenchidos aqui pois o Webservice retorna em objetos diferentes
  Retorno.Registro.protocolo        := FOperador.WebServices.Retorno.Protocolo;
  Retorno.Registro.Situacao         := FOperador.WebServices.Retorno.cStat;
  Retorno.Registro.Motivo           := FOperador.WebServices.Retorno.xMsg;

end;


procedure TControllerMdfe.SalvaArquivoBanco;
begin
  Arquivo.Registro.TipoDoArquivo  := 7;
  Arquivo.Registro.Formato        := 'XML';
  Arquivo.Registro.CodigoVinculo  := self.Registro.Codigo;
  Arquivo.Salva_Arq_Banco(concat(
                  Config.Registro.RepositorioMdfe,'\',
                  ExtractFileName(FOperador.Manifestos[0].NomeArq)
                  ));
end;

procedure TControllerMdfe.SalvaRetorno;
begin
  Retorno.Registro.Estabelecimento  := Self.Registro.Estabelecimento;
  Retorno.Registro.Codigo           := Self.Registro.Codigo;
  //Este campos serão prenchidos conforme a operação executada anteriormente
    //Retorno.Registro.protocolo        := FOperador.WebServices.Consulta.Protocolo;
    //Retorno.Registro.Situacao         := FOperador.WebServices. Retorno.cStat;
    //Retorno.Registro.Motivo           := FOperador.WebServices.Retorno.xMsg;
  Retorno.Registro.Arquivo :=  ExtractFileName(FOperador.Manifestos[0].NomeArq);
  case Retorno.Registro.Situacao of
  100:Begin
         Retorno.Registro.Situacao := 2;
      End;
  101:Begin
         Retorno.Registro.Situacao := 3;
      End;
  132:Begin
         Retorno.Registro.Situacao := 4;
      End;
    else
     Retorno.Registro.Situacao := 0;
  end;

  Retorno.salva;
end;

function TControllerMdfe.update: Boolean;
begin
   Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfe.VerificaStatusServico: Boolean;
Begin
 Result := True;
  with FOperador.WebServices do
  Begin
    try
      StatusServico.Executar;
    finally
      if (StatusServico.cStat <> 107) AND (Trim(StatusServico.xMotivo) <> '') then
      Begin
        MensagemPadrao('Mensagem', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       'Status do Serviço : ' + StatusServico.xMotivo + EOLN,
                       ['OK'], [bEscape], mpInformacao);
        Result := False;
      end;
    end;
  End;
end;

end.
