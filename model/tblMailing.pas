unit tblMailing;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_mailing')]
  TMailing = Class(TGenericEntity)
  private
    FNEWS: String;
    FEMAIL: String;
    FID: Integer;
    FKIND: String;
    procedure setFEMAIL(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFKIND(const Value: String);
    procedure setFNEWS(const Value: String);


  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: Integer read FID write setFID;
    [FieldName('email')]
    property email: String read FEMAIL write setFEMAIL;
    [FieldName('kind')]
    property kind: String read FKIND write setFKIND;
    [FieldName('news')]
    property news: String read FNEWS write setFNEWS;

  End;

{ TMailing }
implementation

{ TMailing }

procedure TMailing.setFEMAIL(const Value: String);
begin
  FEMAIL := Value;
end;

procedure TMailing.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TMailing.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TMailing.setFNEWS(const Value: String);
begin
  FNEWS := Value;
end;

end.
