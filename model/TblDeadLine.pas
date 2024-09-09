unit TblDeadLine;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PRAZO')]
  TDeadLine = Class(TGenericEntity)

  private
    FPRZ_VL_MINIMO: Real;
    FPRZ_CODIGO: Integer;
    FPRZ_PRAZO: String;
    procedure setFPRZ_CODIGO(const Value: Integer);
    procedure setFPRZ_PRAZO(const Value: String);
    procedure setFPRZ_VL_MINIMO(const Value: Real);

  public
    [KeyField('PRZ_CODIGO')]
    [FieldName('PRZ_CODIGO')]
    property Codigo: Integer read FPRZ_CODIGO write setFPRZ_CODIGO;

    [FieldName('PRZ_PRAZO')]
    property Prazo: String read FPRZ_PRAZO write setFPRZ_PRAZO;

    [FieldName('PRZ_VL_MINIMO')]
    property ValorMinima: Real read FPRZ_VL_MINIMO write setFPRZ_VL_MINIMO;

  End;

implementation

{ TDeadLine }

procedure TDeadLine.setFPRZ_CODIGO(const Value: Integer);
begin
  FPRZ_CODIGO := Value;
end;

procedure TDeadLine.setFPRZ_PRAZO(const Value: String);
begin
  FPRZ_PRAZO := Value;
end;

procedure TDeadLine.setFPRZ_VL_MINIMO(const Value: Real);
begin
  FPRZ_VL_MINIMO := Value;
end;

end.
