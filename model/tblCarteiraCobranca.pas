unit tblCarteiraCobranca;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_carteira_cobranca')]
  TCarteiraCobranca = Class(TGenericEntity)

  private
    Fctr_Codigo: Integer;
    Fctr_Codbco: Integer;
    Fctr_numero: String;
    Fctr_descricao: String;
    Fctr_tipo_emissao: String;
    procedure setFctr_codbco(const Value: Integer);
    procedure setFctr_codigo(const Value: Integer);
    procedure setFctr_descricao(const Value: String);
    procedure setFctr_numero(const Value: String);
    procedure setFctr_tipo_emissao(const Value: String);

  public

    [FieldName('ctr_codigo')]
    [KeyField('ctr_codigo')]
    property Codigo: Integer read Fctr_codigo write setFctr_codigo;

    [FieldName('ctr_codbco')]
    property Codbco: Integer read Fctr_codbco write setFctr_codbco;

    [FieldName('ctr_numero')]
    property Numero: String read Fctr_numero write setFctr_numero;

    [FieldName('ctr_descricao')]
    property Descricao: String read Fctr_descricao write setFctr_descricao;

    [FieldName('ctr_tipo_emissao')]
    property TipoEmissao: String read Fctr_tipo_emissao write setFctr_tipo_emissao;

  End;

  implementation

{ TCarteiraCobranca }


procedure TCarteiraCobranca.setFctr_codbco(const Value: Integer);
begin
  Fctr_codbco := Value;
end;

procedure TCarteiraCobranca.setFctr_codigo(const Value: Integer);
begin
  Fctr_codigo := Value;
end;

procedure TCarteiraCobranca.setFctr_descricao(const Value: String);
begin
  Fctr_descricao := Value;
end;

procedure TCarteiraCobranca.setFctr_numero(const Value: String);
begin
  Fctr_numero := Value;
end;

procedure TCarteiraCobranca.setFctr_tipo_emissao(const Value: String);
begin
  Fctr_tipo_emissao := Value;
end;

end.
