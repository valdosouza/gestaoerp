unit tblVendedor;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_VENDEDOR')]
  TVendedor = Class(TGenericEntity)
  private
    FVEN_CODPED: Integer;
    FVEN_CODCLB: Integer;
    FVEN_EDICAO: String;
    FVEN_CODITF: Integer;
    FVEN_TERMINAL: Integer;
    FVEN_PROPORCAO: Real;
    procedure setFVEN_CODCLB(const Value: Integer);
    procedure setFVEN_CODITF(const Value: Integer);
    procedure setFVEN_CODPED(const Value: Integer);
    procedure setFVEN_EDICAO(const Value: String);
    procedure setFVEN_PROPORCAO(const Value: Real);
    procedure setFVEN_TERMINAL(const Value: Integer);

  public
    [KeyField('VEN_CODITF')]
    [FieldName('VEN_CODITF')]
    property ItemPedido: Integer read FVEN_CODITF write setFVEN_CODITF;

    [KeyField('VEN_TERMINAL')]
    [FieldName('VEN_TERMINAL')]
    property Terminal: Integer read FVEN_TERMINAL write setFVEN_TERMINAL;

    [KeyField('VEN_CODCLB')]
    [FieldName('VEN_CODCLB')]
    property Colaborador: Integer read FVEN_CODCLB write setFVEN_CODCLB;

    [FieldName('VEN_CODPED')]
    property Pedido: Integer read FVEN_CODPED write setFVEN_CODPED;

    [FieldName('VEN_PROPORCAO')]
    property Proporcao: Real read FVEN_PROPORCAO write setFVEN_PROPORCAO;

    [FieldName('VEN_EDICAO')]
    property Edicao: String read FVEN_EDICAO write setFVEN_EDICAO;

  End;

implementation

{ TVendedor }

procedure TVendedor.setFVEN_CODCLB(const Value: Integer);
begin
  FVEN_CODCLB := Value;
end;

procedure TVendedor.setFVEN_CODITF(const Value: Integer);
begin
  FVEN_CODITF := Value;
end;

procedure TVendedor.setFVEN_CODPED(const Value: Integer);
begin
  FVEN_CODPED := Value;
end;

procedure TVendedor.setFVEN_EDICAO(const Value: String);
begin
  FVEN_EDICAO := Value;
end;

procedure TVendedor.setFVEN_PROPORCAO(const Value: Real);
begin
  FVEN_PROPORCAO := Value;
end;

procedure TVendedor.setFVEN_TERMINAL(const Value: Integer);
begin
  FVEN_TERMINAL := Value;
end;

end.
