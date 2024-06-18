unit tblMdfeNfe;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_NFE')]
  TMdfeNfe = Class(TGenericEntity)

    private
    FTB_MDFE_ID: Integer;
    FTB_INVOICE_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_INVOICE_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);

    public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property MDFE: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [KeyField('TB_INVOICE_ID')]
    [FieldName('TB_INVOICE_ID')]
    property Nota: Integer read FTB_INVOICE_ID write setFTB_INVOICE_ID;


  End;

implementation

{ TMdfeNfe }

procedure TMdfeNfe.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeNfe.setFTB_INVOICE_ID(const Value: Integer);
begin
  FTB_INVOICE_ID := Value;
end;

procedure TMdfeNfe.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

end.
