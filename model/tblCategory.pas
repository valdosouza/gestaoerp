unit tblCategory;

interface

Uses TEntity, CAtribEntity;

Type
  [TableName('TB_CATEGORY')]
  TCategory = Class(TGenericEntity)
  private
    FDESCRIPTION: String;
    FID: Integer;
    FPOSIT_LEVEL: String;
    FENABLED: String;
    FKIND: String;
    FTB_INSTITUTE_ID: Integer;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFENABLED(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFKIND(const Value: String);
    procedure setFPOSIT_LEVEL(const Value: String);
    procedure setFTB_INSTITUTE_ID(const Value: Integer);
  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_INSTITUTE_ID')]
    property Institute: Integer read FTB_INSTITUTE_ID write setFTB_INSTITUTE_ID;

    [FieldName('DESCRIPTION')]
    property Descricao: String read FDESCRIPTION write setFDESCRIPTION;

    [FieldName('POSIT_LEVEL')]
    property Posicao: String read FPOSIT_LEVEL write setFPOSIT_LEVEL;

    [FieldName('KIND')]
    property Tipo: String read FKIND write setFKIND;

    [FieldName('ENABLED')]
    property Situacao: String read FENABLED write setFENABLED;
  End;

Implementation

{ TCategory }

procedure TCategory.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TCategory.setFENABLED(const Value: String);
begin
  FENABLED := Value;
end;

procedure TCategory.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCategory.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TCategory.setFPOSIT_LEVEL(const Value: String);
begin
  FPOSIT_LEVEL := Value;
end;

procedure TCategory.setFTB_INSTITUTE_ID(const Value: Integer);
begin
  FTB_INSTITUTE_ID := Value;
end;

end.
