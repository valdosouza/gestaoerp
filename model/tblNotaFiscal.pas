unit tblNotaFiscal;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_nota_fiscal')]
  TNotaFiscal = Class(TGenericEntity)
  private
    FNFL_PESO_BRUTO: String;
    FNFL_VL_FRETE: Real;
    FNFL_HR_SAIDA: TTime;
    FNFL_VL_IPI: Real;
    FNFL_VL_ICMS_SUBST: Real;
    FNFL_CODMHA: Integer;
    FNFL_BS_ICMS: Real;
    FNFL_ESPECIE: String;
    FNFL_VOL_NUMERO: String;
    FNFL_STATUS: String;
    FNFL_QT_PRODUTO: Real;
    FNFL_VL_TL_SRV: Real;
    FNFL_CODIGO: Integer;
    FNFL_CFOP: String;
    FNFL_VL_ICMS: Real;
    FNFL_SERIE: String;
    FNFL_MODELO: String;
    FNFL_VL_SEGURO: Real;
    FNFL_NUMERO: String;
    FNFL_CTA_FRETE: Integer;
    FNFL_CODTRP: Integer;
    FNFL_VL_DESP_ACESS: Real;
    FNFL_DT_EMISSAO: TDate;
    FNFL_CODPED: Integer;
    FNFL_VL_TL_NOTA: Real;
    FNFL_FINALIDADE: String;
    FNFL_PLC_VEICULO: String;
    FNFL_PESO_LIQ: String;
    FNFL_VL_ISS: Real;
    FNFL_PLC_UF: String;
    FNFL_MARCA: String;
    FNFL_BS_ICMS_SUBST: Real;
    FNFL_DT_SAIDA: TDate;
    FNFL_NFL_VINCULO: String;
    FNFL_CTRL_RETORNO: String;
    FNFL_CODNAT: Integer;
    FNFL_TIPO: String;
    FNFL_VL_TL_PROD: Real;
    FNFL_PED_ANT: String;
    FNFL_PLC_RNTC: String;
    FNFL_CODEMP: Integer;
    FNFL_VL_ISS_RET: Real;
    FNFL_IMP_XML: String;

    procedure setFNFL_CODIGO( Value : Integer);
    procedure setFNFL_CODMHA( Value : Integer);
    procedure setFNFL_TIPO( Value : String);
    procedure setFNFL_FINALIDADE( Value : String);
    procedure setFNFL_NUMERO( Value : String);
    procedure setFNFL_SERIE( Value : String);
    procedure setFNFL_CODNAT( Value : Integer);
    procedure setFNFL_CODPED( Value : Integer);
    procedure setFNFL_CODEMP( Value : Integer);
    procedure setFNFL_DT_EMISSAO( Value : Tdate);
    procedure setFNFL_DT_SAIDA( Value : Tdate);
    procedure setFNFL_HR_SAIDA( Value : TTime);
    procedure setFNFL_BS_ICMS( Value : Real);
    procedure setFNFL_VL_ICMS( Value : Real);
    procedure setFNFL_BS_ICMS_SUBST( Value : Real);
    procedure setFNFL_VL_ICMS_SUBST( Value : Real);
    procedure setFNFL_VL_TL_PROD( Value : Real);
    procedure setFNFL_VL_FRETE( Value : Real);
    procedure setFNFL_VL_SEGURO( Value : Real);
    procedure setFNFL_VL_DESP_ACESS( Value : Real);
    procedure setFNFL_VL_IPI( Value : Real);
    procedure setFNFL_VL_TL_NOTA( Value : Real);
    procedure setFNFL_CODTRP( Value : Integer);
    procedure setFNFL_CTA_FRETE( Value : Integer);
    procedure setFNFL_QT_PRODUTO( Value : Real);
    procedure setFNFL_ESPECIE( Value : String);
    procedure setFNFL_MARCA( Value : String);
    procedure setFNFL_PESO_BRUTO( Value : String);
    procedure setFNFL_PESO_LIQ( Value : String);
    procedure setFNFL_CTRL_RETORNO( Value : String);
    procedure setFNFL_NFL_VINCULO( Value : String);
    procedure setFNFL_STATUS( Value : String);
    procedure setFNFL_PED_ANT( Value : String);
    procedure setFNFL_VL_TL_SRV( Value : Real);
    procedure setFNFL_VL_ISS( Value : Real);
    procedure setFNFL_VOL_NUMERO( Value : String);
    procedure setFNFL_PLC_VEICULO( Value : String);
    procedure setFNFL_PLC_UF( Value : String);
    procedure setFNFL_PLC_RNTC( Value : String);
    procedure setFNFL_CFOP( Value : String);
    procedure setFNFL_VL_ISS_RET( Value : Real);
    procedure setFNFL_MODELO( Value : String);
    procedure setFNFL_IMP_XML(const Value: String);
  public
    [KeyField('NFL_CODIGO')]
    [FieldName('NFL_CODIGO')]
    property Codigo: Integer read FNFL_CODIGO write setFNFL_CODIGO;

    [FieldName('NFL_CODMHA')]
    property CodigoEstabelecimento: Integer read FNFL_CODMHA write setFNFL_CODMHA;

    [FieldName('NFL_TIPO')]
    property Tipo: String read FNFL_TIPO write setFNFL_TIPO;

    [FieldName('NFL_FINALIDADE')]
    property Finalidade: String read FNFL_FINALIDADE write setFNFL_FINALIDADE;

    [FieldName('NFL_NUMERO')]
    property Numero: String read FNFL_NUMERO write setFNFL_NUMERO;

    [FieldName('NFL_SERIE')]
    property Serie: String read FNFL_SERIE write setFNFL_SERIE;

    [FieldName('NFL_CODNAT')]
    property CodigoCFOP: Integer read FNFL_CODNAT write setFNFL_CODNAT;

    [FieldName('NFL_CODPED')]
    property CodigoPedido: Integer read FNFL_CODPED write setFNFL_CODPED;

    [FieldName('NFL_CODEMP')]
    property CodigoEmpresa: Integer read FNFL_CODEMP write setFNFL_CODEMP;

    [FieldName('NFL_DT_EMISSAO')]
    property DataEmissao: TDate read FNFL_DT_EMISSAO write setFNFL_DT_EMISSAO;

    [FieldName('NFL_DT_SAIDA')]
    property DataSaida: TDate read FNFL_DT_SAIDA write setFNFL_DT_SAIDA;

    [FieldName('NFL_HR_SAIDA')]
    property HoraSaida: TTime read FNFL_HR_SAIDA write setFNFL_HR_SAIDA;

    [FieldName('NFL_BS_ICMS')]
    property ValorBaseICMS: Real read FNFL_BS_ICMS write setFNFL_BS_ICMS;

    [FieldName('NFL_VL_ICMS')]
    property ValorICMS: Real read FNFL_VL_ICMS write setFNFL_VL_ICMS;

    [FieldName('NFL_BS_ICMS_SUBST')]
    property ValorBaseICMSST: Real read FNFL_BS_ICMS_SUBST write setFNFL_BS_ICMS_SUBST;

    [FieldName('NFL_VL_ICMS_SUBST')]
    property ValorICMSST: Real read FNFL_VL_ICMS_SUBST write setFNFL_VL_ICMS_SUBST;

    [FieldName('NFL_VL_TL_PROD')]
    property ValorProdutos: Real read FNFL_VL_TL_PROD write setFNFL_VL_TL_PROD;

    [FieldName('NFL_VL_FRETE')]
    property ValorFrete: Real read FNFL_VL_FRETE write setFNFL_VL_FRETE;

    [FieldName('NFL_VL_SEGURO')]
    property ValorSeguro: Real read FNFL_VL_SEGURO write setFNFL_VL_SEGURO;

    [FieldName('NFL_VL_DESP_ACESS')]
    property ValorOutrasDespesas: Real read FNFL_VL_DESP_ACESS write setFNFL_VL_DESP_ACESS;

    [FieldName('NFL_VL_IPI')]
    property ValorIPI: Real read FNFL_VL_IPI write setFNFL_VL_IPI;

    [FieldName('NFL_VL_TL_NOTA')]
    property ValorNota: Real read FNFL_VL_TL_NOTA write setFNFL_VL_TL_NOTA;

    [FieldName('NFL_CODTRP')]
    property CodigoTransportadora: Integer read FNFL_CODTRP write setFNFL_CODTRP;

    [FieldName('NFL_CTA_FRETE')]
    property ContaFrete: Integer read FNFL_CTA_FRETE write setFNFL_CTA_FRETE;

    [FieldName('NFL_QT_PRODUTO')]
    property QtdeProdutos: Real read FNFL_QT_PRODUTO write setFNFL_QT_PRODUTO;

    [FieldName('NFL_ESPECIE')]
    property Especie: String read FNFL_ESPECIE write setFNFL_ESPECIE;

    [FieldName('NFL_MARCA')]
    property Marca: String read FNFL_MARCA write setFNFL_MARCA;

    [FieldName('NFL_PESO_BRUTO')]
    property PesoBruto: String read FNFL_PESO_BRUTO write setFNFL_PESO_BRUTO;

    [FieldName('NFL_PESO_LIQ')]
    property PesoLiquido: String read FNFL_PESO_LIQ write setFNFL_PESO_LIQ;

    [FieldName('NFL_CTRL_RETORNO')]
    property ControlaRetorno: String read FNFL_CTRL_RETORNO write setFNFL_CTRL_RETORNO;

    [FieldName('NFL_NFL_VINCULO')]
    property NotaVinculada: String read FNFL_NFL_VINCULO write setFNFL_NFL_VINCULO;

    [FieldName('NFL_STATUS')]
    property Situacao: String read FNFL_STATUS write setFNFL_STATUS;

    [FieldName('NFL_PED_ANT')]
    property CodigoPedidoAnterior: String read FNFL_PED_ANT write setFNFL_PED_ANT;

    [FieldName('NFL_VL_TL_SRV')]
    property ValorServico: Real read FNFL_VL_TL_SRV write setFNFL_VL_TL_SRV;

    [FieldName('NFL_VL_ISS')]
    property ValorISS: Real read FNFL_VL_ISS write setFNFL_VL_ISS;

    [FieldName('NFL_VOL_NUMERO')]
    property NumeroVolume: String read FNFL_VOL_NUMERO write setFNFL_VOL_NUMERO;

    [FieldName('NFL_PLC_VEICULO')]
    property PlacaVeiculo: String read FNFL_PLC_VEICULO write setFNFL_PLC_VEICULO;

    [FieldName('NFL_PLC_UF')]
    property EstadoVeiculo: String read FNFL_PLC_UF write setFNFL_PLC_UF;

    [FieldName('NFL_PLC_RNTC')]
    property RNTC: String read FNFL_PLC_RNTC write setFNFL_PLC_RNTC;

    [FieldName('NFL_CFOP')]
    property CFOP: String read FNFL_CFOP write setFNFL_CFOP;

    [FieldName('NFL_VL_ISS_RET')]
    property ValorISSRetido: Real read FNFL_VL_ISS_RET write setFNFL_VL_ISS_RET;

    [FieldName('NFL_MODELO')]
    property Modelo: String read FNFL_MODELO write setFNFL_MODELO;

    [FieldName('NFL_IMP_XML')]
    property XMLImportado: String read FNFL_IMP_XML write setFNFL_IMP_XML;



  End;

implementation

{ TNotaFiscal }

procedure TNotaFiscal.setFNFL_BS_ICMS(Value: Real);
begin
  FNFL_BS_ICMS  := Value;
end;

procedure TNotaFiscal.setFNFL_BS_ICMS_SUBST(Value: Real);
begin
  FNFL_BS_ICMS_SUBST  := Value;
end;

procedure TNotaFiscal.setFNFL_CFOP(Value: String);
begin
  FNFL_CFOP  := Value;
end;

procedure TNotaFiscal.setFNFL_CODEMP(Value: Integer);
begin
  FNFL_CODEMP  := Value;
end;

procedure TNotaFiscal.setFNFL_CODIGO(Value: Integer);
begin
  FNFL_CODIGO  := Value;
end;

procedure TNotaFiscal.setFNFL_CODMHA(Value: Integer);
begin
  FNFL_CODMHA  := Value;
end;

procedure TNotaFiscal.setFNFL_CODNAT(Value: Integer);
begin
  FNFL_CODNAT  := Value;
end;

procedure TNotaFiscal.setFNFL_CODPED(Value: Integer);
begin
  FNFL_CODPED := Value;
end;

procedure TNotaFiscal.setFNFL_CODTRP(Value: Integer);
begin
  FNFL_CODTRP := Value;
end;

procedure TNotaFiscal.setFNFL_CTA_FRETE(Value: Integer);
begin
  FNFL_CTA_FRETE := Value;
end;

procedure TNotaFiscal.setFNFL_CTRL_RETORNO(Value: String);
begin
  FNFL_CTRL_RETORNO  := Value;
end;

procedure TNotaFiscal.setFNFL_DT_EMISSAO(Value: Tdate);
begin
  FNFL_DT_EMISSAO := Value;
end;

procedure TNotaFiscal.setFNFL_DT_SAIDA(Value: Tdate);
begin
  FNFL_DT_SAIDA := Value;
end;

procedure TNotaFiscal.setFNFL_ESPECIE(Value: String);
begin
  FNFL_ESPECIE := Value;
end;

procedure TNotaFiscal.setFNFL_FINALIDADE(Value: String);
begin
  FNFL_FINALIDADE := Value;
end;

procedure TNotaFiscal.setFNFL_HR_SAIDA(Value: TTime);
begin
  FNFL_HR_SAIDA  := Value;
end;

procedure TNotaFiscal.setFNFL_IMP_XML(const Value: String);
begin
  FNFL_IMP_XML := Value;
end;

procedure TNotaFiscal.setFNFL_MARCA(Value: String);
begin
  FNFL_MARCA  := Value;
end;

procedure TNotaFiscal.setFNFL_MODELO(Value: String);
begin
  FNFL_MODELO  := Value;
end;

procedure TNotaFiscal.setFNFL_NFL_VINCULO(Value: String);
begin
  FNFL_NFL_VINCULO  := Value;
end;

procedure TNotaFiscal.setFNFL_NUMERO(Value: String);
begin
  FNFL_NUMERO  := Value;
end;

procedure TNotaFiscal.setFNFL_PED_ANT(Value: String);
begin
  FNFL_PED_ANT  := Value;
end;

procedure TNotaFiscal.setFNFL_PESO_BRUTO(Value: String);
begin
  FNFL_PESO_BRUTO := Value;
end;

procedure TNotaFiscal.setFNFL_PESO_LIQ(Value: String);
begin
  FNFL_PESO_LIQ   := Value;
end;

procedure TNotaFiscal.setFNFL_PLC_RNTC(Value: String);
begin
  FNFL_PLC_RNTC := Value;
end;

procedure TNotaFiscal.setFNFL_PLC_UF(Value: String);
begin
  FNFL_PLC_UF  := Value;
end;

procedure TNotaFiscal.setFNFL_PLC_VEICULO(Value: String);
begin
  FNFL_PLC_VEICULO  := Value;
end;

procedure TNotaFiscal.setFNFL_QT_PRODUTO(Value: Real);
begin
  FNFL_QT_PRODUTO  := Value;
end;

procedure TNotaFiscal.setFNFL_SERIE(Value: String);
begin
  FNFL_SERIE  := Value;
end;

procedure TNotaFiscal.setFNFL_STATUS(Value: String);
begin
  FNFL_STATUS := Value;
end;

procedure TNotaFiscal.setFNFL_TIPO(Value: String);
begin
  FNFL_TIPO  := Value;
end;

procedure TNotaFiscal.setFNFL_VL_DESP_ACESS(Value: Real);
begin
  FNFL_VL_DESP_ACESS  := Value;
end;

procedure TNotaFiscal.setFNFL_VL_FRETE(Value: Real);
begin
  FNFL_VL_FRETE := Value;
end;

procedure TNotaFiscal.setFNFL_VL_ICMS(Value: Real);
begin
  FNFL_VL_ICMS  := Value;
end;

procedure TNotaFiscal.setFNFL_VL_ICMS_SUBST(Value: Real);
begin
  FNFL_VL_ICMS_SUBST  := Value;
end;

procedure TNotaFiscal.setFNFL_VL_IPI(Value: Real);
begin
  FNFL_VL_IPI  := Value;
end;

procedure TNotaFiscal.setFNFL_VL_ISS(Value: Real);
begin
  FNFL_VL_ISS  := Value;
end;

procedure TNotaFiscal.setFNFL_VL_ISS_RET(Value: Real);
begin
  FNFL_VL_ISS_RET := Value;
end;

procedure TNotaFiscal.setFNFL_VL_SEGURO(Value: Real);
begin
  FNFL_VL_SEGURO := Value;
end;

procedure TNotaFiscal.setFNFL_VL_TL_NOTA(Value: Real);
begin
  FNFL_VL_TL_NOTA := Value;
end;

procedure TNotaFiscal.setFNFL_VL_TL_PROD(Value: Real);
begin
  FNFL_VL_TL_PROD := Value;
end;

procedure TNotaFiscal.setFNFL_VL_TL_SRV(Value: Real);
begin
  FNFL_VL_TL_SRV := Value;
end;

procedure TNotaFiscal.setFNFL_VOL_NUMERO(Value: String);
begin
  FNFL_VOL_NUMERO := Value;
end;

end.
