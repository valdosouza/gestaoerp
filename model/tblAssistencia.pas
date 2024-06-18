unit tblAssistencia;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_assistencia')]
  TAssistencia = Class(TGenericEntity)

  private
    Fass_codigo: Integer;
    Fass_codMha: Integer;
    Fass_numero: Integer;
    Fass_pedido: Integer;
    Fass_codemp: Integer;
    Fass_prazo : TDateTime;
    procedure setFass_codemp(const Value: Integer);
    procedure setFass_codigo(const Value: Integer);
    procedure setFass_codmha(const Value: Integer);
    procedure setFass_numero(const Value: Integer);
    procedure setFass_pedido(const Value: Integer);
    procedure setFass_prazo(const Value: TDateTime);


   public
    [FieldName('ass_codigo')]
    [KeyField('ass_codigo')]
    property Codigo: Integer read Fass_codigo write setFass_codigo;

    [KeyField('ass_codmha')]
    [FieldName('ass_codmha')]
    property CodMha: Integer read Fass_codmha write setFass_codmha;

    [FieldName('ass_numero')]
    property Numero: Integer read Fass_numero write setFass_numero;

   [FieldName('ass_pedido')]
    property Pedido: Integer read Fass_pedido write setFass_pedido;

    [FieldName('ass_codemp')]
    property Codemp: Integer read Fass_codemp write setFass_codemp;

    [FieldName('ass_prazo')]
    property Prazo: TDateTime read Fass_prazo write setFass_prazo;

  End;

  implementation

{ TAssistencia }

procedure TAssistencia.setFass_codemp(const Value: Integer);
begin
  Fass_codemp := Value;
end;

procedure TAssistencia.setFass_codigo(const Value: Integer);
begin
  Fass_codigo := Value;
end;

procedure TAssistencia.setFass_codmha(const Value: Integer);
begin
  Fass_codmha := Value;
end;

procedure TAssistencia.setFass_numero(const Value: Integer);
begin
  Fass_numero := Value;
end;

procedure TAssistencia.setFass_pedido(const Value: Integer);
begin
  Fass_pedido := Value;
end;

procedure TAssistencia.setFass_prazo(const Value: TDateTime);
begin
  Fass_prazo := Value;
end;

end.
