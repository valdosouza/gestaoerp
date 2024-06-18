unit tblRetaguardaSync;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RETAGUARDA_SYNC')]
  TRetaguardaSync = Class(TGenericEntity)
  private
    FID: String;
    FSYN_TIME: TDatetime;
    FWAY: String;
    procedure setFID(const Value: String);
    procedure setFSYN_TIME(const Value: TDatetime);
    procedure setFWAY(const Value: String);


  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: String read FID write setFID;

    [FieldName('SYN_TIME')]
    property Tempo: TDatetime read FSYN_TIME write setFSYN_TIME;

    [KeyField('WAY')]
    [FieldName('WAY')]
    property Sentido: String read FWAY write setFWAY;

  End;

implementation

{ TRetaguardaSync }

procedure TRetaguardaSync.setFID(const Value: String);
begin
  FID := Value;
end;

procedure TRetaguardaSync.setFSYN_TIME(const Value: TDatetime);
begin
  FSYN_TIME := Value;
end;

procedure TRetaguardaSync.setFWAY(const Value: String);
begin
  FWAY := Value;
end;

end.
