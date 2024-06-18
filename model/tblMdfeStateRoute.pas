unit tblMdfeStateRoute;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_STATE_ROUTE')]
  TMdfeStateRoute = Class(TGenericEntity)

    private
    FTB_MDFE_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    FTB_STATE_ID: Integer;
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);
    procedure setFTB_STATE_ID(const Value: Integer);

    public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property MDFE: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [KeyField('TB_STATE_ID')]
    [FieldName('TB_STATE_ID')]
    property Estado: Integer read FTB_STATE_ID write setFTB_STATE_ID;

  End;

implementation


{ TMdfeStateRoute }

procedure TMdfeStateRoute.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeStateRoute.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

procedure TMdfeStateRoute.setFTB_STATE_ID(const Value: Integer);
begin
  FTB_STATE_ID := Value;
end;

end.
