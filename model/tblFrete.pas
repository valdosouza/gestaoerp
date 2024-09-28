unit tblFrete;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_FRETE')]
  TFrete = Class(TGenericEntity)

  private
    FFRT_VL_TAS: Real;
    FFRT_VL_DESPACHO: Real;
    FFRT_DESCRICAO: String;
    FFRT_CODIGO: Integer;
    FFRT_VL_PEDAGIO: Real;
    FFRT_GRIS_MIN: Real;
    FFRT_TAXA_GRIS: Real;
    FFRT_CODEMP: Integer;
    procedure setFFRT_CODEMP(const Value: Integer);
    procedure setFFRT_CODIGO(const Value: Integer);
    procedure setFFRT_DESCRICAO(const Value: String);
    procedure setFFRT_GRIS_MIN(const Value: Real);
    procedure setFFRT_TAXA_GRIS(const Value: Real);
    procedure setFFRT_VL_PEDAGIO(const Value: Real);
    procedure setFFRT_VL_TAS(const Value: Real);
    procedure setFRT_VL_DESPACHO(const Value: Real);

  public
    [KeyField('FRT_CODIGO')]
    [FieldName('FRT_CODIGO')]
    property Codigo: Integer read FFRT_CODIGO write setFFRT_CODIGO;

    [FieldName('FRT_CODEMP')]
    property CodigoEmpresa: Integer read FFRT_CODEMP write setFFRT_CODEMP;

    [FieldName('FRT_DESCRICAO')]
    property Descricao: String read FFRT_DESCRICAO write setFFRT_DESCRICAO;

    [FieldName('FRT_VL_DESPACHO')]
    property ValorDespacho: Real read FFRT_VL_DESPACHO write setFRT_VL_DESPACHO;

    [FieldName('FRT_VL_TAS')]
    property ValorTas: Real read FFRT_VL_TAS write setFFRT_VL_TAS;

    [FieldName('FRT_GRIS_MIN')]
    property GrisMinima: Real read FFRT_GRIS_MIN write setFFRT_GRIS_MIN;

    [FieldName('FRT_TAXA_GRIS')]
    property TaxaGris: Real read FFRT_TAXA_GRIS write setFFRT_TAXA_GRIS;

    [FieldName('FRT_VL_PEDAGIO')]
    property ValorPedagio: Real read FFRT_VL_PEDAGIO write setFFRT_VL_PEDAGIO;

  End;

implementation

{ TFrete }

procedure TFrete.setFFRT_CODEMP(const Value: Integer);
begin
  FFRT_CODEMP := Value;
end;

procedure TFrete.setFFRT_CODIGO(const Value: Integer);
begin
  FFRT_CODIGO := Value;
end;

procedure TFrete.setFFRT_DESCRICAO(const Value: String);
begin
  FFRT_DESCRICAO := Value;
end;

procedure TFrete.setFFRT_GRIS_MIN(const Value: Real);
begin
  FFRT_GRIS_MIN := Value;
end;

procedure TFrete.setFFRT_TAXA_GRIS(const Value: Real);
begin
  FFRT_TAXA_GRIS := Value;
end;

procedure TFrete.setFFRT_VL_PEDAGIO(const Value: Real);
begin
  FFRT_VL_PEDAGIO := Value;
end;

procedure TFrete.setFFRT_VL_TAS(const Value: Real);
begin
  FFRT_VL_TAS := Value;
end;

procedure TFrete.setFRT_VL_DESPACHO(const Value: Real);
begin
  FFRT_VL_DESPACHO := Value;
end;

end.

