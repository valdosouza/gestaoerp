unit tblMedida;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_medida')]
  TMedida = Class(TGenericEntity)
  private
    FMED_SEQUENCIA: iNTEGER;
    FMED_ESCALA: String;
    FMED_ATIVO: String;
    FMED_DESCRICAO: String;
    FMED_CODIGO: Integer;
    FMED_ESPECIAL: String;
    FMED_ABREVIATURA: String;
    FMED_PROPORCAO: Real;
    procedure setFMED_ABREVIATURA(const Value: String);
    procedure setFMED_ATIVO(const Value: String);
    procedure setFMED_CODIGO(const Value: Integer);
    procedure setFMED_DESCRICAO(const Value: String);
    procedure setFMED_ESCALA(const Value: String);
    procedure setFMED_ESPECIAL(const Value: String);
    procedure setFMED_PROPORCAO(const Value: Real);
    procedure setFMED_SEQUENCIA(const Value: iNTEGER);

  public

    [KeyField('MED_CODIGO')]
    [FieldName('MED_CODIGO')]
    property Codigo: Integer read FMED_CODIGO write setFMED_CODIGO;


    [FieldName('MED_DESCRICAO')]
    property Descricao: String read FMED_DESCRICAO write setFMED_DESCRICAO;

    [FieldName('MED_ABREVIATURA')]
    property Abreviatura: String read FMED_ABREVIATURA write setFMED_ABREVIATURA;

    [FieldName('MED_ESCALA')]
    property Escala: String read FMED_ESCALA write setFMED_ESCALA;

    [FieldName('MED_ESPECIAL')]
    property MedidaCardapio: String read FMED_ESPECIAL write setFMED_ESPECIAL;

    [FieldName('MED_PROPORCAO')]
    property Proporcao: Real read FMED_PROPORCAO write setFMED_PROPORCAO;

    [FieldName('MED_SEQUENCIA')]
    property Sequencia: iNTEGER read FMED_SEQUENCIA write setFMED_SEQUENCIA;

    [FieldName('MED_ATIVO')]
    property Ativo: String read FMED_ATIVO write setFMED_ATIVO;
  End;

implementation

{ TMedida }

procedure TMedida.setFMED_ABREVIATURA(const Value: String);
begin
  FMED_ABREVIATURA := Value;
end;

procedure TMedida.setFMED_ATIVO(const Value: String);
begin
  FMED_ATIVO := Value;
end;

procedure TMedida.setFMED_CODIGO(const Value: Integer);
begin
  FMED_CODIGO := Value;
end;

procedure TMedida.setFMED_DESCRICAO(const Value: String);
begin
  FMED_DESCRICAO := Value;
end;

procedure TMedida.setFMED_ESCALA(const Value: String);
begin
  FMED_ESCALA := Value;
end;

procedure TMedida.setFMED_ESPECIAL(const Value: String);
begin
  FMED_ESPECIAL := Value;
end;

procedure TMedida.setFMED_PROPORCAO(const Value: Real);
begin
  FMED_PROPORCAO := Value;
end;

procedure TMedida.setFMED_SEQUENCIA(const Value: iNTEGER);
begin
  FMED_SEQUENCIA := Value;
end;

end.
