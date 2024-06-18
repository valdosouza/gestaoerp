unit ControllerNotaFiscal;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes, tblNotaFiscal ,Un_MSg,
     Generics.Collections, StrUtils,objInvoiceMerchandise,
     ControllerPedido, ControllerObsNota,ControllerDskCfop,tblRetornoNfe,
     tblOrderItemIcms, tblOrderItemIpi, tblOrderItemPis, tblOrderItemCofins,
     tblOrderItemII,tblOrderItemISSqn,tblInvoiceObs,ControllerFinanceiro,
     ControllerRetornoNFe,ControllerEmpresa,ControllerGestaoWeb;
Type
  TListaNota = TObjectList<TNotaFiscal>;
  TControllerNotaFiscal = Class(TControllerBase)

  private

    FTipoPedido: Integer;
    FTipoNota: String;
    FEstabelecimento: Integer;
    function getCSTByCodigo(Id:Integer):String;
    function getCSOSNByCodigo(Id:Integer):String;
    function getCFOPByCodigo(Id:Integer):String;
    function getCST_IPIByCodigo(Id:Integer):String;
    function getCST_PISByCodigo(Id:Integer):String;
    function getCST_CFSByCodigo(Id:Integer):String;
    function getCFOPByItems:String;
    procedure FillDataObjetoOrdem(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaFiscal(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoMercadoria(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaEntrega(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaObservaocao(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaItemsICMS(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaItemsIPI(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaItemsPIS(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaItemsCOFINS(PcRegistro: TNotaFiscal);
    procedure FillDataObjetoNotaItemsII(PcRegistro: TNotaFiscal);
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
    procedure setFPeriodo(const Value: Boolean);
    procedure setFEstabelecimento(const Value: Integer);
    procedure setFTipoNota(const Value: String);
    procedure setFTipoPedido(const Value: Integer);

  public

    NotaAvulsa : Boolean;
    Registro : TNotaFiscal;
    Lista : TListaNota;
    Pedido : TControllerPedido;
    Empresa : TControllerEmpresa;
    CFOP : TControllerDskCfop;
    Observacoes : TControllerObsNota;
    Obj:TObjInvoiceMerchandise;
    REtorno55 : TControllerRetornoNFe;
    financeiro : TControllerFinanceiro;
    //ExportGestaoWeb : TControllerGestaoWeb;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function salva:boolean;
    function update:boolean;
    function updateDataHora:boolean;
    function migra:Boolean;
    function delete: boolean;
    function getCodigoPedidoByNota():Integer;
    function getCodigoNotaByPedido():Integer;
    procedure getbyId;
    procedure getbyPedido;
    function GeraNumeroNota():Integer;
    function insere:boolean;
    function updateCodigoPedido:Boolean;
    procedure getList;
    function getTotalValue:Real;
    procedure getSincronia;
    procedure ClearDataObjecto;
    procedure FillDataObjeto(PcRegistro: TNotaFiscal);
    function VerificaServico:Boolean;
    function DocFiscalRefComplementar:String;
    function AtualizaEmpresaNF:Boolean;
    function AtualizaEstabelecimento(CodigoAnterior:Integer;EstoqueID:Integer):boolean;
    function alteraStatus:Boolean;
    function ControlaRetorno:Boolean;
    function BaixaRetorno:Boolean;
    PROCEDURE AtualizaSeries(Disponivel:String;Lista:TSTQuery);
    function valorFinanceiro:Real;

    function ValoTotalCofins:Real;
    function ValorTotalCofinsST:Real;
    function ValorTotalPisST:Real;
    function ValorTotalPis:Real;
    function ValoTotalII:Real;
    function ValorTotalDesconto:Real;
    function ValorProdutoDesconto:Real;


    property TipoPedido : Integer read FTipoPedido write setFTipoPedido;
    property TipoNota : String read FTipoNota write setFTipoNota;


  End;

implementation

{ ControllerPedido }

uses Un_Regra_Negocio;

function TControllerNotaFiscal.alteraStatus: Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
              'UPDATE TB_NOTA_FISCAL SET ',
              'NFL_STATUS =:NFL_STATUS ',
              'WHERE NFL_CODIGO=:NFL_CODIGO '
      ));
      ParamByName('NFL_STATUS').AsString := Registro.Situacao;
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;
end;

function TControllerNotaFiscal.AtualizaEmpresaNF: Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
              'UPDATE TB_NOTA_FISCAL SET ',
              'NFL_CODEMP =:EMP_CODIGO ',
              'WHERE NFL_CODIGO=:NFL_CODIGO '
      ));
      ParamByName('EMP_CODIGO').AsInteger := Registro.CodigoEmpresa;
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;
end;

function TControllerNotaFiscal.AtualizaEstabelecimento(CodigoAnterior:Integer;EstoqueID:Integer): boolean;
Var
  Lc_cd_Nota, Lc_cd_Pedido: Integer;
  Lc_Qry :TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    With Lc_Qry do
    BEgin
      //Lc_cd_Nota := Qr_Nota.FieldByName('NFL_CODIGO').AsInteger;
      //Lc_cd_Pedido := Qr_Nota.FieldByName('PED_CODIGO').AsInteger;

      if (CodigoAnterior <> Registro.CodigoEstabelecimento) then
      Begin
        Active := False;
        sql.Clear;
        sql.Add(concat(
                  'UPDATE TB_FINANCEIRO SET ',
                  ' FIN_CODMHA =:FIN_CODMHA ',
                  'WHERE FIN_CODNFL =:FIN_CODNFL '
        ));
        ParamByName('FIN_CODNFL').AsInteger := Registro.codigo;
        ParamByName('FIN_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
        ExecSQL;
      end;

      // atualiza pedido
      if (CodigoAnterior <> Registro.CodigoEstabelecimento) then
      Begin
        Active := False;
        sql.Clear;
        sql.Add(concat(
                      'UPDATE TB_PEDIDO SET ',
                      'PED_CODMHA =:PED_CODMHA ',
                      'WHERE PED_CODIGO =:PED_CODIGO '
        ));
        ParamByName('PED_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
        ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
        ExecSQL;
      end;

      // atualiza nota fsical
      Active := False;
      sql.Clear;
      sql.Add(concat(
                'UPDATE TB_NOTA_FISCAL SET ',
                'NFL_NUMERO=:NFL_NUMERO, ' ,
                'NFL_CODMHA =:NFL_CODMHA ',
                'WHERE NFL_CODIGO =:NFL_CODIGO '
      ));
      ParamByName('NFL_NUMERO').AsString := Registro.Numero;
      ParamByName('NFL_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;

      // atualiza controle de estoque
      if (CodigoAnterior <> Registro.CodigoEstabelecimento) then
      Begin
        Active := False;
        sql.Clear;
        sql.Add(concaT(
                'UPDATE TB_CTRL_ESTOQUE SET ',
                'CET_CODETS =:CET_CODETS ' ,
                'WHERE CET_VINCULO=:CET_VINCULO ',
                ' AND CET_CONTROLE =:CET_CONTROLE '
        ));
        ParamByName('CET_VINCULO').AsString := 'P';
        ParamByName('CET_CODETS').AsInteger := EstoqueID;
        ParamByName('CET_CONTROLE').AsInteger := Lc_cd_Pedido;
        ExecSQL;
      end;

      // atualiza itens da nota fiscal
      if (CodigoAnterior <> Registro.CodigoEstabelecimento) then
      Begin
        Active := False;
        sql.Clear;
        sql.Add(concat(
                'UPDATE TB_ITENS_NFL SET ',
                'ITF_CODEST =:ITF_CODEST ' ,
                'WHERE ITF_CODNFL=:NFL_CODIGO '
        ));
        ParamByName('ITF_CODEST').AsInteger := EstoqueID;
        ParamByName('NFL_CODIGO').AsInteger := Lc_cd_Nota;
        ExecSQL;
      END;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerNotaFiscal.AtualizaSeries(Disponivel:String; Lista: TSTQuery);
Var
  Oper : String;
begin
  Lista.First;
  while not Lista.eof do
  Begin
    if ( Lista.FieldByName('PRO_SERIE').asString = 'S') then
    Begin
      Oper := copy(Registro.Tipo,1,1);
      Pedido.Itens.Produto.AtualizaSeries(Oper,Disponivel,Lista.FieldByName('ITF_CODIGO').asinteger);
    End;
    Lista.Next;
  End;
end;

function TControllerNotaFiscal.BaixaRetorno: Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
              'UPDATE TB_NOTA_FISCAL SET ',
              ' NFL_CTRL_RETORNO = ''N'' ',
              'WHERE (NFL_NFL_VINCULO=:NFL_NFL_VINCULO) '
      ));
      ParamByName('NFL_NFL_VINCULO').AsString := Registro.NotaVinculada;
      ExecSQL;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;
end;

procedure TControllerNotaFiscal.Clear;
begin
  clearObj(Registro);
end;

procedure TControllerNotaFiscal.ClearDataObjecto;
begin
  clearObj(Obj);
end;

function TControllerNotaFiscal.ControlaRetorno: Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
              ' update tb_nota_fiscal set ',
              ' nfl_ctrl_retorno = :nfl_ctrl_retorno, ',
              ' NFL_NFL_VINCULO = :NFL_NFL_VINCULO ',
              ' where nfl_codigo  =:nfl_codigo '
      ));
      ParamByName('nfl_ctrl_retorno').AsAnsiString:= Registro.ControlaRetorno;
      ParamByName('NFL_NFL_VINCULO').AsAnsiString := Registro.NotaVinculada;
      ExecSQL;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;

end;

constructor TControllerNotaFiscal.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TNotaFiscal.Create;
  Lista := TListaNota.Create;
  Pedido := TControllerPedido.Create(self);
  Empresa := TControllerEmpresa.Create(self);
  Observacoes := TControllerObsNota.Create(self);
  CFOP := TControllerDskCfop.Create(self);
  REtorno55 := TControllerRetornoNFe.Create(self);
  Obj := TObjInvoiceMerchandise.Create;
  financeiro := TControllerFinanceiro.Create(self);
  //ExportGestaoWeb := TControllerGestaoWeb.create(Self);
end;

function TControllerNotaFiscal.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerNotaFiscal.Destroy;
begin
  financeiro.disposeOf;
  Obj.Destroy;
  //ExportGestaoWeb.disposeOf;
  REtorno55.disposeOf;
  CFOP.disposeOf;
  Observacoes.disposeOf;
  Pedido.disposeOf;
  Empresa.disposeOf;
  Lista.disposeOf;
  Registro.disposeOf;
  inherited;
end;


function TControllerNotaFiscal.DocFiscalRefComplementar: String;
Var
  Lc_Qry: TSTQuery;
  Lc_Inicio: Integer;
Begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select nfe_arquivo ',
                'from tb_retorno_nfe ',
                'where nfe_nota_ini =:NOTA_INI ',
                ' and (NFE_CODMHA =:NFE_CODMHA) '

      ));
      ParamByName('NOTA_INI').AsString    := Registro.NotaVinculada;
      ParamByName('NFE_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
      Active := True;
      Result := FieldByName('nfe_arquivo').AsString;
      Lc_Inicio := pos('41', Result);
      Result := Copy(Result, Lc_Inicio, 44);
    end;
  finally
    FinalizaQuery( Lc_Qry );
  end;
end;

function TControllerNotaFiscal.ValorProdutoDesconto: Real;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'SELECT SUM(ii.itf_vl_desc) VALORTOTAL ',
                'FROM tb_nota_fiscal NF ',
                '    inner join tb_itens_nfl ii ',
                '    on (ii.itf_codnfl = nf.nfl_codigo) ',
                '    INNER JOIN tb_retorno_nfe nfe ',
                '    on (nfe.nfe_codnfl = nf.nfl_codigo) ',
                '    INNER JOIN TB_PRODUTO PRD ',
                '    on (prd.PRO_CODIGO = ii.ITF_CODPRO) ',
                'where (NF.NFL_CODIGO =:NFL_CODIGO) ',
                'AND NF.nfl_status = ''F'' ',
                ' and (PRD.PRO_TIPO =:PRO_TIPO) '
      ));
      if Periodo then
        Sql.Add(' AND (Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM) ');

      ParamByName('PRO_TIPO').AsString := 'P';
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      Result := FieldByName('VALORTOTAL').AsFloat;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;

end;

function TControllerNotaFiscal.ValorTotalCofinsST: Real;
begin
  REsult := 0;
end;

function TControllerNotaFiscal.ValorTotalDesconto: Real;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'SELECT SUM(ii.itf_vl_desc) VALORTOTAL ',
                'FROM tb_nota_fiscal NF ',
                '    inner join tb_itens_nfl ii ',
                '    on (ii.itf_codnfl = nf.nfl_codigo) ',
                '    INNER JOIN tb_retorno_nfe nfe ',
                '    on (nfe.nfe_codnfl = nf.nfl_codigo) ',
                'where Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM ',
                'AND NF.nfl_status = ''F'' ',
                'AND ( nfe.nfe_codsit = 2 ) '
      ));
      if Periodo then
        Sql.Add(' AND (Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM) ');

      if Periodo then
      Begin
        ParamByName('DATAINI').AsDate := FDataInicial;
        ParamByName('DATAFIM').AsDate := FDataFinal;
      End;
      Active := True;
      Result := FieldByName('VALORTOTAL').AsFloat;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;


end;

function TControllerNotaFiscal.ValorTotalPis: Real;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'SELECT SUM(pi.pis_vl_nr) VALORTOTAL ',
                'FROM tb_nota_fiscal NF ',
                '    inner join tb_itens_pis pi ',
                '    on (pi.pis_codnfl = nf.nfl_codigo) ',
                '    INNER JOIN tb_retorno_nfe nfe ',
                '    on (nfe.nfe_codnfl = nf.nfl_codigo) ',
                'where Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM ',
                'AND NF.nfl_status = ''F'' ',
                'AND ( nfe.nfe_codsit = 2 ) '
      ));
      if Periodo then
        Sql.Add(' AND (Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM) ');

      if Periodo then
      Begin
        ParamByName('DATAINI').AsDate := FDataInicial;
        ParamByName('DATAFIM').AsDate := FDataFinal;
      End;
      Active := True;
      Result := FieldByName('VALORTOTAL').AsFloat;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;
end;

function TControllerNotaFiscal.ValorTotalPisST: Real;
begin
  Result := 0;
end;

function TControllerNotaFiscal.ValoTotalCofins: Real;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'SELECT SUM(CO.cfs_vl_nr) VALORTOTAL ',
                'FROM tb_nota_fiscal NF ',
                '    inner join tb_itens_cfs co ',
                '    on (co.cfs_codnfl = nf.nfl_codigo) ',
                '    INNER JOIN tb_retorno_nfe nfe ',
                '    on (nfe.nfe_codnfl = nf.nfl_codigo) ',
                'where NF.nfl_status = ''F''  ',
                'AND ( nfe.nfe_codsit = 2 ) '
      ));
      if Periodo then
        Sql.Add(' AND (Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM) ');

      if Periodo then
      Begin
        ParamByName('DATAINI').AsDate := FDataInicial;
        ParamByName('DATAFIM').AsDate := FDataFinal;
      End;
      Active := True;
      Result := FieldByName('VALORTOTAL').AsFloat;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;

end;

function TControllerNotaFiscal.ValoTotalII: Real;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'SELECT SUM(ii.iip_vl_ii) VALORTOTAL ',
                'FROM tb_nota_fiscal NF ',
                '    inner join tb_itens_ii ii ',
                '    on (ii.iip_codnfl = nf.nfl_codigo) ',
                '    INNER JOIN tb_retorno_nfe nfe ',
                '    on (nfe.nfe_codnfl = nf.nfl_codigo) ',
                'where Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM ',
                'AND NF.nfl_status = ''F'' ',
                'AND ( nfe.nfe_codsit = 2 ) '
      ));
      if Periodo then
        Sql.Add(' AND (Nf.nfl_dt_emissao between :DATAINI AND :DATAFIM) ');

      if Periodo then
      Begin
        ParamByName('DATAINI').AsDate := FDataInicial;
        ParamByName('DATAFIM').AsDate := FDataFinal;
      End;
      Active := True;
      Result := FieldByName('VALORTOTAL').AsFloat;
    end;
  Finally
    FinalizaQuery( Lc_Qry );
  End;

end;

function TControllerNotaFiscal.VerificaServico: Boolean;
Var
  Lc_Qry: TSTQuery;
Begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.Add(concat(
                'SELECT  ITF_CODIGO ',
                'FROM TB_ITENS_NFL ',
                '   INNER JOIN TB_PRODUTO ',
                '   ON  (PRO_CODIGO = ITF_CODPRO) ',
                'WHERE (ITF_CODNFL=:ITF_CODNFL) AND (PRO_TIPO = ''S'') '
      ));
      ParamByName('ITF_CODNFL').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      Result := (recordcount > 0);
    end;
  finally
    FinalizaQuery( Lc_Qry );
  end;


end;

procedure TControllerNotaFiscal.FillDataObjeto(PcRegistro: TNotaFiscal);
Var
  LcII : TOrderItemII;
begin
  //Order
  if PcRegistro.CodigoPedido > 0 then
  Begin
    Pedido.Registro.Codigo := PcRegistro.CodigoPedido;
    Pedido.getbyId;
  End;

  Empresa.Registro.Codigo := PcRegistro.CodigoEmpresa;
  Empresa.getById;
  //Pedido/Ordem
  FillDataObjetoOrdem(PcRegistro);
  //Nota
  FillDataObjetoNotaFiscal(PcRegistro);
  //Observações
  FillDataObjetoNotaObservaocao(PcRegistro);

  if PcRegistro.CodigoPedido > 0 then
  Begin
    //NOta Mercadoria
    FillDataObjetoMercadoria(PcRegistro);
    //ICMS
    FillDataObjetoNotaItemsICMS(PcRegistro);
    //IPI
    FillDataObjetoNotaItemsIPI(PcRegistro);
    //PIS -   Obj.ItemsPIS.
    FillDataObjetoNotaItemsPIS(PcRegistro);
    //COFINS - Obj.ItemsCofins.
    FillDataObjetoNotaItemsCOFINS(PcRegistro);
    //IMPORTAÇÃO - Obj.ItemsII
    FillDataObjetoNotaItemsII(PcRegistro);
  End;
end;

procedure TControllerNotaFiscal.FillDataObjetoMercadoria(
  PcRegistro: TNotaFiscal);
begin
  //Nota de Mercadoria
  Obj.Mercadoria.Codigo             := obj.Nota.NF.Codigo;
  Obj.Mercadoria.Estabelecimento    := Obj.Estabelecimento;
  Obj.Mercadoria.Terminal           := Obj.Terminal;
  Obj.Mercadoria.DataSaida          := PcRegistro.DataSaida;
  Obj.Mercadoria.HoraSaida          := PcRegistro.HoraSaida;
  Obj.Mercadoria.ValorBaseICMS      := PcRegistro.ValorBaseICMS;
  Obj.Mercadoria.ValorIcms          := PcRegistro.ValorICMS;
  Obj.Mercadoria.ValorBaseIcmsSt    := PcRegistro.ValorBaseICMSST;
  Obj.Mercadoria.ValorIcmsSt        := PcRegistro.ValorICMSST;
  Obj.Mercadoria.ValorTotal         := PcRegistro.ValorProdutos;
  Obj.Mercadoria.ValorFrete         := PcRegistro.ValorFrete;
  Obj.Mercadoria.ValorSeguro        := PcRegistro.ValorSeguro;
  Obj.Mercadoria.ValorDespesas      := PcRegistro.ValorOutrasDespesas;
  Obj.Mercadoria.ValorIpi           := PcRegistro.ValorIPI;
  Obj.Mercadoria.ValorDesc          := pedido.Registro.ValorDesconto;
  Obj.Mercadoria.QuantidadeTotal    := PcRegistro.QtdeProdutos;
  Obj.Mercadoria.IndicacaoPresenca  := pedido.Registro.IndicaPresenca;

end;

procedure TControllerNotaFiscal.FillDataObjetoNotaEntrega(
  PcRegistro: TNotaFiscal);
begin
  //Nota de Mercadoria  - Entrega
  Obj.Entrega.Codigo                := obj.Nota.NF.Codigo;
  Obj.Entrega.Estabelecimento       := obj.Estabelecimento;
  Obj.Entrega.Terminal              := obj.Terminal;
  Obj.Entrega.Quantidade            := PcRegistro.QtdeProdutos;
  Obj.Entrega.Classificacao         := PcRegistro.Especie;
  Obj.Entrega.Marca                 := PcRegistro.Marca;
  Obj.Entrega.PesoBruto             := PcRegistro.PesoBruto;
  Obj.Entrega.PesoLiquido           := PcRegistro.PesoLiquido;
  Obj.Entrega.NumeroVolume          := PcRegistro.NumeroVolume;
  Obj.Entrega.PlacaVeiculo          := PcRegistro.PlacaVeiculo;
  Obj.Entrega.PlacaEstado           := PcRegistro.EstadoVeiculo;
  Obj.Entrega.PlacaRntc             := PcRegistro.RNTC;
end;

procedure TControllerNotaFiscal.FillDataObjetoNotaFiscal(
  PcRegistro: TNotaFiscal);
begin
  //Preeche o objeto base
  Obj.Estabelecimento  := Obj.Estabelecimento;
  Obj.Terminal         := Obj.Terminal;
  obj.Descricao        := obj.Descricao;
  //Nota Geral
  obj.Nota.DestinatarioDoc := '';
  obj.Nota.EmitenteDoc     := '';

  if PcRegistro.Tipo = 'EE' then
  Begin
    obj.Nota.EmitenteDoc      := Empresa.Registro.CpfCNPJ;
    obj.Nota.NF.Emitente      := Empresa.Registro.Codigo;
    obj.Nota.DestinatarioDoc  := Obj.EstabelecimentoCNPJ;
    obj.Nota.NF.Destinatario  := Obj.Estabelecimento;
  End
  else
  BEgin
    obj.Nota.EmitenteDoc      := Obj.EstabelecimentoCNPJ;
    obj.Nota.NF.Emitente      := Obj.Estabelecimento;
    obj.Nota.DestinatarioDoc  := Empresa.Registro.CpfCNPJ;
    obj.Nota.NF.Destinatario  := Empresa.Registro.Codigo;
  End;

  obj.Nota.NF.Codigo          := PcRegistro.Codigo;
  Obj.Nota.NF.Estabelecimento := Obj.Estabelecimento;
  Obj.Nota.NF.Terminal        := Obj.Terminal;
  //Obj.Nota.NF.Emitente        :=  0; Foi tratado nos blocos de Tipo = 'EE' ou not
  //Obj.Nota.NF.Destinatario    := 0;  Foi tratado nos blocos de Tipo = 'EE' ou not
  Obj.Nota.NF.TipoEmissao     := PcRegistro.Tipo;
  Obj.Nota.NF.Finalidade      := PcRegistro.Finalidade;
  Obj.Nota.NF.Numero          := PcRegistro.Numero;
  Obj.Nota.NF.Serie           := PcRegistro.Serie;
  if Trim(PcRegistro.CFOP) = '' then
  Begin
    Registro.codigo           := PcRegistro.Codigo;
    Obj.Nota.NF.Cfop          := getCFOPByItems;
  End
  else
  Begin
     Obj.Nota.NF.Cfop     := PcRegistro.CFOP;
  End;
  Obj.Nota.NF.Data_emissao     := PcRegistro.DataEmissao;
  Obj.Nota.NF.Valor            := PcRegistro.ValorNota - PcRegistro.ValorServico;
  Obj.Nota.NF.Modelo           := PcRegistro.Modelo;
  Obj.Nota.NF.Status           := PcRegistro.Situacao;
end;

procedure TControllerNotaFiscal.FillDataObjetoNotaItemsCOFINS(
  PcRegistro: TNotaFiscal);
Var
  LcCfs : TOrderItemCofins;
  I : Integer;
begin
  Pedido.Itens.ItensCofins.Registro.Nota := PcRegistro.Codigo;
  Pedido.Itens.ItensCofins.getList;
  Obj.ItemsCofins.Clear;
  for I := 0 to Pedido.Itens.ItensCofins.Lista.Count-1 do
  Begin
    LcCfs := TOrderItemCofins.Create;
    LcCfs.ItemOrdem           := Pedido.Itens.ItensCofins.Lista[I].Codigo;
    LcCfs.Ordem               := obj.Nota.NF.Codigo;
    LcCfs.Estabelecimento     := Obj.Estabelecimento;
    LcCfs.Terminal            := Obj.Terminal;
    LcCfs.CST                 := '';
    LcCfs.ValorBase           := Pedido.Itens.ItensCofins.Lista[I].ValorBase;
    LcCfs.Aliquota            := Pedido.Itens.ItensCofins.Lista[I].Aliquota;
    LcCfs.Valor               := Pedido.Itens.ItensCofins.Lista[I].Valor;
    LcCfs.QuantVendas         := Pedido.Itens.ItensCofins.Lista[I].QtdeVenda;
    LcCfs.QuantValorAliquota  := Pedido.Itens.ItensCofins.Lista[I].ValorAliquota;
    Obj.ItemsCofins.Add(LcCfs);
  End;
end;

procedure TControllerNotaFiscal.FillDataObjetoNotaItemsICMS(
  PcRegistro: TNotaFiscal);
Var
  I : Integer;
  LcIcms : TOrderItemIcms;
begin
  Pedido.Itens.ItensIcms.Registro.Nota := PcRegistro.Codigo;
  Pedido.Itens.ItensIcms.getList;
  Obj.ItemsICMS.Clear;
  for I := 0 to Pedido.Itens.ItensIcms.Lista.Count-1 do
  Begin
    LcIcms := TOrderItemIcms.Create;
    LcIcms.ItemOrdem          := Pedido.Itens.ItensIcms.Lista[I].ItemNota;
    LcIcms.Ordem              := obj.Nota.NF.Codigo;
    LcIcms.Estabelecimento    := Obj.Estabelecimento;
    LcIcms.Terminal           := Obj.Terminal;
    if Pedido.Itens.ItensIcms.Lista[I].CST > 0 then
      LcIcms.cst              := getCSTByCodigo(Pedido.Itens.ItensIcms.Lista[I].CST)
    else
      LcIcms.cst              := getCSOSNByCodigo(Pedido.Itens.ItensIcms.Lista[I].CSOSN);
    LcIcms.Origem             := Pedido.Itens.ItensIcms.Lista[I].Origem;
    LcIcms.DetermincaoBase    := Pedido.Itens.ItensIcms.Lista[I].Determinacao;
    LcIcms.DetermincaoBaseST  := Pedido.Itens.ItensIcms.Lista[I].DeterminacaoBaseST;
    LcIcms.Desoneracao        := Pedido.Itens.ItensIcms.Lista[I].Desoneracao;
    LcIcms.AliqReducaoBase    := Pedido.Itens.ItensIcms.Lista[I].AliqRedBase;
    LcIcms.ValorBase          := Pedido.Itens.ItensIcms.Lista[I].ValorBase;
    LcIcms.Aliquota           := Pedido.Itens.ItensIcms.Lista[I].Aliquota;
    LcIcms.ReducaoAliquota    := Pedido.Itens.ItensIcms.Lista[I].AliquotaReduzida;
    LcIcms.Valor              := Pedido.Itens.ItensIcms.Lista[I].Valor;
    LcIcms.AliqReducaoBaseST  := Pedido.Itens.ItensIcms.Lista[I].AliqRedBaseST;
    LcIcms.ValorBaseST        := Pedido.Itens.ItensIcms.Lista[I].ValorBaseST;
    LcIcms.AliquotaST         := Pedido.Itens.ItensIcms.Lista[I].AliquotaST;
    LcIcms.ReducaoAliquotaST  := Pedido.Itens.ItensIcms.Lista[I].AliqRedST;
    LcIcms.ValorST            := Pedido.Itens.ItensIcms.Lista[I].ValorST;
    LcIcms.MVA                := Pedido.Itens.ItensIcms.Lista[I].MVA;
    LcIcms.ValorBaseRetido    := Pedido.Itens.ItensIcms.Lista[I].BaseICMSRetido;
    LcIcms.ValorRetido        := Pedido.Itens.ItensIcms.Lista[I].ValorICMSRetido;
    LcIcms.ValorBaseRetidoST  := Pedido.Itens.ItensIcms.Lista[I].VAlorBaseSTRetido;
    LcIcms.ValorRetidoST      := Pedido.Itens.ItensIcms.Lista[I].ValorSTRetido;
    LcIcms.PArtilha           := Pedido.Itens.ItensIcms.Lista[I].Partilha;
    LcIcms.Repasse            := Pedido.Itens.ItensIcms.Lista[I].Repasse;
    LcIcms.Aliquota_CalcCred  := Pedido.Itens.ItensIcms.Lista[I].AliqCalcCred;
    LcIcms.Valor_CredExpl     := Pedido.Itens.ItensIcms.Lista[I].CreditoAprox;
    LcIcms.ValorFrete         := Pedido.Itens.ItensIcms.Lista[I].ValorFrete;
    LcIcms.ValorSeguro        := Pedido.Itens.ItensIcms.Lista[I].Seguro;
    LcIcms.ValorDespesas      := Pedido.Itens.ItensIcms.Lista[I].OutrasDespesas;
    LcIcms.Cfop               := getCFOPByCodigo(Pedido.Itens.ItensIcms.Lista[I].CFOP);
    Obj.ItemsICMS.Add(LcIcms);
  End;
end;

procedure TControllerNotaFiscal.FillDataObjetoNotaItemsII(
  PcRegistro: TNotaFiscal);
Var
  LcII : TOrderItemII;
  I : Integer;
begin
  Pedido.Itens.ItensII.Registro.Nota := PcRegistro.Codigo;
  Pedido.Itens.ItensII.getList;
  Obj.ItemsII.Clear;
  for I := 0 to Pedido.Itens.ItensII.Lista.Count-1 do
  Begin
    LcII := TOrderItemII.Create;
    LcII.ItemOrdem        := Pedido.Itens.ItensII.Lista[I].Codigo;
    LcII.Ordem            := obj.Nota.NF.Codigo;
    LcII.Estabelecimento  := Obj.Estabelecimento;
    LcII.Terminal         := Obj.Terminal;
    LcII.ValorBase        := Pedido.Itens.ItensII.Lista[I].ValorBase;
    LcII.Despesas         := Pedido.Itens.ItensII.Lista[I].ValorDespesaAd;
    LcII.Valor            := Pedido.Itens.ItensII.Lista[I].Valor;
    LcII.ValorIOF         := Pedido.Itens.ItensII.Lista[I].ValorIOF;
    Obj.ItemsII.Add(LcII);
  End;
end;

procedure TControllerNotaFiscal.FillDataObjetoNotaItemsIPI(
  PcRegistro: TNotaFiscal);
Var
  I : Integer;
  LcIPI : TOrderItemIpi;
begin
  Pedido.Itens.ItensIpi.Registro.Nota := PcRegistro.Codigo;
  Pedido.Itens.ItensIpi.getList;
  Obj.ItemsIPI.Clear;
  for I := 0 to Pedido.Itens.ItensIpi.Lista.Count-1 do
  Begin
    LcIPI := TOrderItemIpi.Create;
    LcIPI.ItemOrdem         := Pedido.Itens.ItensIpi.Lista[I].Codigo;
    LcIPI.Ordem             := obj.Nota.NF.Codigo;
    LcIPI.Estabelecimento   := Obj.Estabelecimento;
    LcIPI.Terminal          := Obj.Terminal;
    LcIPI.CST               := getCST_IPIByCodigo(Pedido.Itens.ItensIPI.Lista[I].CST);
    LcIPI.Classe_Frame      := Pedido.Itens.ItensIPI.Lista[I].ClassEnqu;
    LcIPI.CnpjFabricante    := Pedido.Itens.ItensIPI.Lista[I].CNPJProdutor;
    LcIPI.Selo_ctrl         := Pedido.Itens.ItensIPI.Lista[I].CodigoSelo;
    LcIPI.Selo_Quant        := Pedido.Itens.ItensIPI.Lista[I].QtdeSelo;
    LcIPI.Classe_FrameCode  := Pedido.Itens.ItensIPI.Lista[I].CodigoEnqu;
    LcIPI.ValorBase         := Pedido.Itens.ItensIPI.Lista[I].ValorBase;
    LcIPI.ValorAliquota     := Pedido.Itens.ItensIPI.Lista[I].Aliquota;
    LcIPI.QuantUnidade      := Pedido.Itens.ItensIPI.Lista[I].QtdeUnid;
    LcIPI.ValorUnitario     := Pedido.Itens.ItensIPI.Lista[I].ValorUnid;
    Obj.ItemsIPI.Add(LcIPI);
  End;
end;

procedure TControllerNotaFiscal.FillDataObjetoNotaItemsPIS(
  PcRegistro: TNotaFiscal);
Var
  LcPis : TOrderItemPis;
  I : Integer;
Begin
  Pedido.Itens.ItensPIs.Registro.Nota := PcRegistro.Codigo;
  Pedido.Itens.ItensPis.getList;
  Obj.ItemsPIS.Clear;
  for I := 0 to Pedido.Itens.ItensPis.Lista.Count-1 do
  Begin
    LcPis := TOrderItemPis.Create;
    LcPis.ItemOrdem           := Pedido.Itens.ItensPis.Lista[I].Codigo;
    LcPis.Ordem               := obj.Nota.NF.Codigo;
    LcPis.Estabelecimento     := Obj.Estabelecimento;
    LcPis.Terminal            := Obj.Terminal;
    LcPis.CST                 := getCST_PISByCodigo(Pedido.Itens.ItensPis.Lista[I].CST);
    LcPis.ValorBase           := Pedido.Itens.ItensPis.Lista[I].ValorBase;
    LcPis.Aliquota            := Pedido.Itens.ItensPis.Lista[I].Aliquota;
    LcPis.Valor               := Pedido.Itens.ItensPis.Lista[I].Valor;
    LcPis.QuantVendas         := Pedido.Itens.ItensPis.Lista[I].QtdeVenda;
    LcPis.QuantValorAliquota  := Pedido.Itens.ItensPis.Lista[I].ValorAliquota;
    Obj.ItemsPIS.Add(LcPis);
  End;
end;


procedure TControllerNotaFiscal.FillDataObjetoNotaObservaocao(
  PcRegistro: TNotaFiscal);
Var
  LcObs : TInvoiceObs;
  I : Integer;
begin
  Observacoes.Registro.Nota := PcRegistro.Codigo;
  Observacoes.getList;
  Obj.Nota.Observacoes.Clear;
  for I := 0 to Observacoes.Lista.Count - 1 do
  Begin
    LcObs := TInvoiceObs.Create;
    LcObs.Codigo          := Observacoes.Lista[I].Codigo;
    LcObs.Estabelecimento := Obj.Estabelecimento;
    LcObs.NotaFiscal      := obj.Nota.NF.Codigo;
    LcObs.Terminal        := Obj.Terminal;
    LcObs.Observacao      := Observacoes.Lista[I].Conteudo;
    Obj.Nota.Observacoes.Add(LcObs);
  End;
end;


procedure TControllerNotaFiscal.FillDataObjetoOrdem(PcRegistro: TNotaFiscal);
begin
  with obj.Nota do
  Begin
    Order.Codigo          := PcRegistro.Codigo;
    Order.Estabelecimento := Obj.Estabelecimento;
    Order.Terminal        := Obj.Terminal;
    Order.Data            := PcRegistro.DataEmissao;
    Order.Observacao      := '';
    Order.Origem          := 'D';
    Order.Status          := 'S';
    Order.SendoUsado      := '';
  End;
end;

function TControllerNotaFiscal.GeraNumeroNota: Integer;
var
   Lc_Qry: TSTQuery;
   Lc_SqlTxt: string;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt := ' select max(nfe_nota_fim)Ult_NF from tb_retorno_nfe where nfe_codmha = :cod_empresa ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('cod_empresa').AsInteger := Registro.CodigoEstabelecimento;
      Active := True;
      FetchAll;
      IF IsEmpty THEN
       Result :=1
      else
       Result := StrToIntDef(FieldByName('Ult_NF').AsString,0) + 1;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.insere: boolean;
begin
  Registro.Codigo := Generator('GN_NOTA_FISCAL');
  InsertObj(Registro);
end;

function TControllerNotaFiscal.migra: Boolean;
begin
  InsertObj(Registro);
end;

function TControllerNotaFiscal.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_NOTA_FISCAL');
  SaveObj(Registro);
end;

procedure TControllerNotaFiscal.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerNotaFiscal.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TControllerNotaFiscal.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TControllerNotaFiscal.setFPeriodo(const Value: Boolean);
begin
  FPeriodo := Value;
end;

procedure TControllerNotaFiscal.setFTipoNota(const Value: String);
begin
  FTipoNota := Value;
end;

procedure TControllerNotaFiscal.setFTipoPedido(const Value: Integer);
begin
  FTipoPedido := Value;
end;

function TControllerNotaFiscal.update: boolean;
begin
  try
    updateObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

function TControllerNotaFiscal.updateCodigoPedido: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'update tb_nota_fiscal set ',
                'NFL_CODPED =:PED_CODIGO ',
                'WHERE NFL_CODIGO=:NFL_CODIGO '
      ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.updateDataHora: boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('UPDATE TB_NOTA_FISCAL SET ',
                     'NFL_DT_EMISSAO=:NFL_DT_EMISSAO, ',
                     'NFL_HR_SAIDA =:NFL_HR_SAIDA ',
                     'WHERE NFL_CODIGO =:NFL_CODIGO '
                ));
      ParamByName('NFL_DT_EMISSAO').AsDate := Registro.DataEmissao;
      ParamByName('NFL_HR_SAIDA').AsDateTime := Registro.HoraSaida;
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.valorFinanceiro: Real;
var
  Lc_Qry: TSTQuery;
begin
  getbyId;
  pedido.Registro.Codigo := Registro.CodigoPedido;
  pedido.getbyId;
  Result := pedido.valorFinanceiro;
  Result := Result + registro.ValorICMSST;
  Result := Result  + registro.ValorSeguro;
  Result := Result  + registro.ValorOutrasDespesas;
  Result := Result  + registro.ValorIPI;
  if pedido.Registro.ValorFrete = 0 then
    Result := Result  + registro.ValorFrete;
  //Lc_Subtotal := Lc_Subtotal + registro.ValorServico; já está no pedido

end;

procedure TControllerNotaFiscal.getById;
begin
  _getByKey(Registro);
end;


procedure TControllerNotaFiscal.getbyPedido;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      SQL.Clear;
      SQL.Add(concat('Select * ',
                       'From tb_nota_Fiscal ',
                       'where NFL_CODPED =:PED_CODIGO '
      ));
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCFOPByCodigo(Id: Integer): String;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT NAT_CFOP ',
                      'FROM TB_NATUREZA ',
                      'WHERE NAT_CODIGO =:NAT_CODIGO '
                ));
      ParamByName('NAT_CODIGO').AsInteger := Id;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('NAT_CFOP').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCFOPByItems: String;
Var
  SqlTxt : String;
  Lc_Qry : TSTQuery;
Begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      SQL.Add(concat(
                'select first 1 na.nat_cfop ',
                'from tb_nota_fiscal nf ',
                '   inner join tb_itens_icms ic ',
                '   on (ic.icm_codnfl = nf.nfl_codigo) ',
                '   inner join tb_natureza na ',
                '   on (na.nat_codigo = ic.icm_codnat) ',
                'where nf.nfl_codigo =:nfl_codigo ',
                'order by ic.icm_coditf '
      ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('nat_cfop').AsString
      else
        Result := '';
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerNotaFiscal.getCodigoNotaByPedido: Integer;
Var
  SqlTxt : String;
  Lc_Qry : TSTQuery;
Begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      SQL.Add(concat(
                'Select NFL_CODIGO ',
                'FROM TB_NOTA_FISCAL ',
                'WHERE ( NFL_CODPED =:PED_CODIGO) '
      ));
      ParamByName('PED_CODIGO').AsInteger := Registro.CodigoPedido;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('NFL_CODIGO').AsInteger
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCodigoPedidoByNota():Integer;
Var
  SqlTxt : String;
  Lc_Qry : TSTQuery;
Begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      SqlTxt := 'Select NFL_CODPED FROM TB_NOTA_FISCAL ';
      if ( Registro.Tipo = 'P') then
        SqlTxt := SqlTxt + 'WHERE ( (NFL_TIPO = ''SI'') OR (NFL_TIPO = ''EI'') ) '
      else
        SqlTxt := SqlTxt + 'WHERE ( (NFL_TIPO = ''EE'') OR (NFL_TIPO = ''SE'') ) ';
      SqlTxt := SqlTxt + ' and (NFL_NUMERO=:NFL_NUMERO) ';
      SqlTxt := SqlTxt + ' and (NFL_CODMHA=:NFL_CODMHA) ';
      SQL.Clear;
      SQL.Add(SqlTxt);
      ParamByName('NFL_NUMERO').AsString := Registro.Numero;
      ParamByName('NFL_CODMHA').AsInteger := Registro.CodigoEstabelecimento;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('NFL_CODPED').AsInteger
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
End;

function TControllerNotaFiscal.getCSOSNByCodigo(Id: Integer): String;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT TBI_GRUPO ',
                      'FROM TB_TRIB_ICMS_SN ',
                      'WHERE TBI_CODIGO =:TBI_CODIGO '
                ));
      ParamByName('TBI_CODIGO').AsInteger := Id;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('TBI_GRUPO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCSTByCodigo(Id: Integer): String;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT TBI_GRUPO ',
                      'FROM TB_TRIB_ICMS_NR ',
                      'WHERE TBI_CODIGO =:TBI_CODIGO '
                ));
      ParamByName('TBI_CODIGO').AsInteger := Id;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('TBI_GRUPO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCST_CFSByCodigo(Id: Integer): String;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT TBC_GRUPO ',
                      'FROM TB_TRIB_CSF ',
                      'WHERE TBC_CODIGO =:TBC_CODIGO '
                ));
      ParamByName('TBC_CODIGO').AsInteger := Id;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('TBC_GRUPO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCST_IPIByCodigo(Id: Integer): String;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT TBI_GRUPO ',
                      'FROM TB_TRIB_IPI ',
                      'WHERE TBI_CODIGO =:TBI_CODIGO '
                ));
      ParamByName('TBI_CODIGO').AsInteger := Id;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('TBI_GRUPO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getCST_PISByCodigo(Id: Integer): String;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT TBP_GRUPO ',
                      'FROM TB_TRIB_PIS ',
                      'WHERE TBP_CODIGO =:TBP_CODIGO '
                ));
      ParamByName('TBP_CODIGO').AsInteger := Id;
      Active := True;
      FetchAll;
      First;
      Result := FieldByName('TBP_GRUPO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerNotaFiscal.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT N.* ',
                      'FROM TB_NOTA_FISCAL N '
                ));
      if FTipoPedido > 0 then
      Begin
        sql.add(concat('  INNER JOIN TB_PEDIDO P ',
                       '  ON (N.NFL_CODPED = P.PED_CODIGO) '
                  ));
      End;
      sql.add('WHERE ( NFL_CODIGO IS NOT NULL ) ');

      if FPeriodo then
        sql.add(' AND ( NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ) ');

      if FEstabelecimento > 0 then
        sql.add(' and ( NFL_CODMHA=:NFL_CODMHA )  ');

      if FTipoPedido > 0 then
        sql.add(' and ( PED_TIPO=:PED_TIPO )  ');

      if ( FTipoNota = 'EM' ) then
        sql.add(' AND ( N.nfl_tipo = ''EM'' )' );

      if FEstabelecimento > 0 then
        ParamByName('NFL_CODMHA').AsInteger := FEstabelecimento;

      if FTipoPedido > 0 then
        ParamByName('PED_TIPO').AsInteger := FTipoPedido;

      if FPeriodo then
      Begin
        ParamByName('DATAINI').AsDateTime := FDataInicial;
        ParamByName('DATAFIM').AsDateTime := FDataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TNotaFiscal.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerNotaFiscal.getSincronia;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select N.* ',
                'FROM tb_nota_fiscal N '
      ));
      if NotaAvulsa then
      Begin
        sql.add(concat('WHERE  ( NFL_CODIGO =:NFL_CODIGO ) ',
                       ' AND   ( NFL_TIPO =:NFL_TIPO ) '
                  ));
      End
      else
      Begin
        sql.add(concat('  INNER JOIN TB_PEDIDO P ',
                       '  ON (N.NFL_CODPED = P.PED_CODIGO) ',
                       ' WHERE  ( NFL_CODIGO =:NFL_CODIGO ) '
                  ));
      End;
      sql.add(' ORDER BY NFL_CODIGO asc ');

      if NotaAvulsa then
        ParamByName('NFL_TIPO').AsString := Registro.Tipo;

      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exisT := (recordcount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNotaFiscal.getTotalValue: Real;
var
  Lc_Qry : TSTQuery;
  LITem : TNotaFiscal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT nfl_vl_tl_nota ',
                     'FROM tb_nota_fiscal ' ,
                     'WHERE NFL_CODIGO=:NFL_CODIGO '
                ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      Result := FieldByName('nfl_vl_tl_nota').AsFloat;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;


end.
