unit tblcidade;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_CIDADE')]
  TCidade = Class(TGenericEntity)
  private
    FCDD_IBGE: Integer;
    FCDD_DESCRICAO: STring;
    FCDD_CODIGO: integer;
    FCDD_CEP: String;
    FCDD_ISS_ALIQ: Real;
    FCDD_UF: String;
    procedure setFCDD_CEP(const Value: String);
    procedure setFCDD_CODIGO(const Value: integer);
    procedure setFCDD_DESCRICAO(const Value: STring);
    procedure setFCDD_IBGE(const Value: Integer);
    procedure setFCDD_ISS_ALIQ(const Value: Real);
    procedure setFCDD_UF(const Value: String);
  published

    [KeyField('CDD_CODIGO')]
    [FieldName('CDD_CODIGO')]
    property Codigo: integer read FCDD_CODIGO write setFCDD_CODIGO;

    [FieldName('CDD_IBGE')]
    property IBGE: Integer read FCDD_IBGE write setFCDD_IBGE;

    [FieldName('CDD_DESCRICAO')]
    property Descricao: STring read FCDD_DESCRICAO write setFCDD_DESCRICAO;

    [FieldName('CDD_UF')]
    property Estado: String read FCDD_UF write setFCDD_UF;

    [FieldName('CDD_CEP')]
    property Cep:String  read FCDD_CEP write setFCDD_CEP;


    [FieldName('CDD_ISS_ALIQ')]
    property AliqISS: Real read FCDD_ISS_ALIQ write setFCDD_ISS_ALIQ;

  End;
implementation

{ TCidade }

procedure TCidade.setFCDD_CEP(const Value: String);
begin
  FCDD_CEP := Value;
end;

procedure TCidade.setFCDD_CODIGO(const Value: integer);
begin
  FCDD_CODIGO := Value;
end;

procedure TCidade.setFCDD_DESCRICAO(const Value: STring);
begin
  FCDD_DESCRICAO := Value;
end;

procedure TCidade.setFCDD_IBGE(const Value: Integer);
begin
  FCDD_IBGE := Value;
end;

procedure TCidade.setFCDD_ISS_ALIQ(const Value: Real);
begin
  FCDD_ISS_ALIQ := Value;
end;

procedure TCidade.setFCDD_UF(const Value: String);
begin
  FCDD_UF := Value;
end;

end.
