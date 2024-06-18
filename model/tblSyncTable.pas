unit tblSyncTable;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_SYNC_TABLE')]
  TSyncTable = Class(TGenericEntity)
  private
    FTM_UPDATE: TTime;
    FID: String;
    FOPERATOR: Integer;
    FWAY: String;
    FDT_UPDATE: TDAte;
    FKIND: String;
    procedure setFDT_UPDATE(const Value: TDAte);
    procedure setFID(const Value: String);
    procedure setFOPERATOR(const Value: Integer);
    procedure setFTM_UPDATE(const Value: TTime);
    procedure setFWAY(const Value: String);
    procedure setFKIND(const Value: String);

  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: String read FID write setFID;

    [KeyField('WAY')]
    [FieldName('WAY')]
    property Sentido: String read FWAY write setFWAY;

    [KeyField('KIND')]
    [FieldName('KIND')]
    property Tipo: String read FKIND write setFKIND;

    [FieldName('DT_UPDATE')]
    property Data: TDAte read FDT_UPDATE write setFDT_UPDATE;

    [FieldName('TM_UPDATE')]
    property Hora: TTime read FTM_UPDATE write setFTM_UPDATE;

    [FieldName('OPERATOR')]
    property OPerador: Integer read FOPERATOR write setFOPERATOR;


  End;

implementation



{ TSyncTable }

procedure TSyncTable.setFDT_UPDATE(const Value: TDAte);
begin
  FDT_UPDATE := Value;
end;

procedure TSyncTable.setFID(const Value: String);
begin
  FID := Value;
end;

procedure TSyncTable.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TSyncTable.setFOPERATOR(const Value: Integer);
begin
  FOPERATOR := Value;
end;

procedure TSyncTable.setFTM_UPDATE(const Value: TTime);
begin
  FTM_UPDATE := Value;
end;

procedure TSyncTable.setFWAY(const Value: String);
begin
  FWAY := Value;
end;

end.
