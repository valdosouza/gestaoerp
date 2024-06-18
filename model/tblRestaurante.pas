unit tblRestaurante;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_restaurante')]
  TRestaurante = Class(TGenericEntity)
  private
    FTb_pedido_id : Integer;
    FAttendance : Integer;
    FDescricao : String;
    FValue_recived : Real;
    FValue_change : Real;
    FTb_Institution_id : Integer;
    FTm_incio: String;

    procedure setFTb_pedido_id( Value  : Integer);
    procedure setFAttendance( Value  : Integer);
    procedure setFDescricao( Value  : String);
    procedure setFValue_recived( Value  : Real);
    procedure setFValue_change( Value  : Real);
    procedure setFTb_Institution_id( Value  : Integer);
    procedure setFTM_Inicio( Value  : String);
    procedure setFTm_incio(Value: String);
  public

    [KeyField('tb_pedido_id')]
    [FieldName('tb_pedido_id')]
    property CodigoPedido: Integer read FTb_pedido_id write setFTb_pedido_id;

    [FieldName('attendance')]
    property TipoAtendimento: Integer read FAttendance write setFAttendance;

    [FieldName('descricao')]
    property Descricao: String read FDescricao write setFDescricao;

    [FieldName('value_recived')]
    property ValorRecebido: Real read FValue_recived write setFValue_recived;

    [FieldName('value_change')]
    property ValorTroco: Real read FValue_change write setFValue_change;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property CodigoEstabelecimento: Integer read FTb_Institution_id write setFTb_Institution_id;

    [FieldName('tm_inicio')]
    property TempoInicio: String read FTm_incio write setFTm_incio;

  End;

implementation


{ TRestaurante }

procedure TRestaurante.setFAttendance(Value: Integer);
begin
  FAttendance := Value;
end;

procedure TRestaurante.setFDescricao(Value: String);
begin
  FDescricao := Value;
end;

procedure TRestaurante.setFTb_Institution_id(Value: Integer);
begin
  FTb_Institution_id := Value;
end;

procedure TRestaurante.setFTb_pedido_id(Value: Integer);
begin
  FTb_pedido_id := Value;
end;

procedure TRestaurante.setFTm_incio(Value: String);
begin
  FTm_incio := Value;
end;

procedure TRestaurante.setFTM_Inicio(Value: String);
begin

end;

procedure TRestaurante.setFValue_change(Value: Real);
begin
  FValue_change := Value;
end;

procedure TRestaurante.setFValue_recived(Value: Real);
begin
  FValue_recived := Value;
end;

end.
