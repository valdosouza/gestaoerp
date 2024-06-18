unit tblMdfeTrailer;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_TRAILER')]
  TMdfeTrailer = Class(TGenericEntity)

    private
    FID: Integer;
    FTB_MDFE_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    FTB_VEHICLE_ID: Integer;
    procedure setFID(const Value: Integer);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);
    procedure setFTB_VEHICLE_ID(const Value: Integer);

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

    [FieldName('TB_VEHICLE_ID')]
    property Veiculo: Integer read FTB_VEHICLE_ID write setFTB_VEHICLE_ID;

  End;

implementation


{ TMdfeTrailer }

procedure TMdfeTrailer.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TMdfeTrailer.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeTrailer.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

procedure TMdfeTrailer.setFTB_VEHICLE_ID(const Value: Integer);
begin
  FTB_VEHICLE_ID := Value;
end;

end.
