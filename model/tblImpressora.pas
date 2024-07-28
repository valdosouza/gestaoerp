unit tblImpressora;

interface

Uses TEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_IMPRESSORA')]
  TImpressora = Class(TGenericEntity)
  private
    FIMP_CAMINHO: String;
    FIMPIMP_SALTO: Integer;
    FIMP_DESCRICAO: String;
    FIMP_CODIGO: Integer;
    FIMP_MODELO: String;
    FIMP_COLUNAS: Integer;
    FIMP_TIPO: String;
    FIMP_VIAS: Integer;
    procedure setFIIMP_TIPO(const Value: String);
    procedure setFIMP_CAMINHO(const Value: String);
    procedure setFIMP_CODIGO(const Value: Integer);
    procedure setFIMP_COLUNAS(const Value: Integer);
    procedure setFIMP_DESCRICAO(const Value: String);
    procedure setFIMP_MODELO(const Value: String);
    procedure setFIMP_SALTO(const Value: Integer);
    procedure setFIMP_VIAS(const Value: Integer);
  public
    [KeyField('IMP_CODIGO')]
    [FieldName('IMP_CODIGO')]
    property Codigo: Integer read FIMP_CODIGO write setFIMP_CODIGO;

    [FieldName('IMP_DESCRICAO')]
    property Descricao: String read FIMP_DESCRICAO write setFIMP_DESCRICAO;

    [FieldName('IMP_CAMINHO')]
    property Caminho: String read FIMP_CAMINHO write setFIMP_CAMINHO;

    [FieldName('IMP_TIPO')]
    property Tipo: String read FIMP_TIPO write setFIIMP_TIPO;

    [FieldName('IMP_SALTO')]
    property Salto: Integer read FIMPIMP_SALTO write setFIMP_SALTO;

    [FieldName('IMP_VIAS')]
    property Vias: Integer read FIMP_VIAS write setFIMP_VIAS;

    [FieldName('IMP_COLUNAS')]
    property Colunas: Integer read FIMP_COLUNAS write setFIMP_COLUNAS;

    [FieldName('IMP_MODELO')]
    property Modelo: String read FIMP_MODELO write setFIMP_MODELO;
  End;

implementation

{ TImpressora }

procedure TImpressora.setFIIMP_TIPO(const Value: String);
begin
  FIMP_TIPO := Value;
end;

procedure TImpressora.setFIMP_CAMINHO(const Value: String);
begin
  FIMP_CAMINHO := Value;
end;

procedure TImpressora.setFIMP_CODIGO(const Value: Integer);
begin
  FIMP_CODIGO := Value;
end;

procedure TImpressora.setFIMP_COLUNAS(const Value: Integer);
begin
  FIMP_COLUNAS := Value;
end;

procedure TImpressora.setFIMP_DESCRICAO(const Value: String);
begin
  FIMP_DESCRICAO := Value;
end;

procedure TImpressora.setFIMP_MODELO(const Value: String);
begin
  FIMP_MODELO := Value;
end;

procedure TImpressora.setFIMP_SALTO(const Value: Integer);
begin
  FIMPIMP_SALTO := Value;
end;

procedure TImpressora.setFIMP_VIAS(const Value: Integer);
begin
  FIMP_VIAS := Value;
end;

end.
