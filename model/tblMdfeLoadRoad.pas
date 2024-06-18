unit tblMdfeLoadRoad;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_LOAD_ROUTE')]
  TMdfeLoadRoad = Class(TGenericEntity)

    private
    FID: Integer;
    FTB_MDFE_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    FTB_STATE_ID: Integer;
    procedure setFID(const Value: Integer);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);
    procedure setFTB_STATE_ID(const Value: Integer);

    public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property MDFE: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [FieldName('TB_STATE_ID')]
    property Estado: Integer read FTB_STATE_ID write setFTB_STATE_ID;

  End;

implementation


{ TMdfeLoadRoad }

procedure TMdfeLoadRoad.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TMdfeLoadRoad.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeLoadRoad.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

procedure TMdfeLoadRoad.setFTB_STATE_ID(const Value: Integer);
begin
  FTB_STATE_ID := Value;
end;

end.
