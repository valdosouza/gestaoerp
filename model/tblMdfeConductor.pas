unit tblMdfeConductor;

interface

Uses TEntity,CAtribEntity, STQuery;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_CONDUCTOR')]
  TMdfeConductor = Class(TGenericEntity)

    private
    FTB_MDFE_ID: Integer;
    FTB_COLLABORATOR_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    procedure setFTB_COLLABORATOR_ID(const Value: Integer);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);


    public

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property MDFE: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [KeyField('TB_COLLABORATOR_ID')]
    [FieldName('TB_COLLABORATOR_ID')]
    property Colaborador: Integer read FTB_COLLABORATOR_ID write setFTB_COLLABORATOR_ID;

  End;

implementation

{ TMdfeConductor }
{ TMdfeConductor }

procedure TMdfeConductor.setFTB_COLLABORATOR_ID(const Value: Integer);
begin
  FTB_COLLABORATOR_ID := Value;
end;

procedure TMdfeConductor.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeConductor.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

end.
