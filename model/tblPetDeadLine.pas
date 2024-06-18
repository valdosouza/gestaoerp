unit tblPetDeadLine;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PET_DEADLINE')]
  TPetDeadLine = Class(TGenericEntity)
  private
    FTB_PET_ID: Integer;
    FDESCRIPTION: String;
    FID: Integer;
    FFINAL_DATE: TDate;
    FINITIAL_DATE: TDate;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFFINAL_DATE(const Value: TDate);
    procedure setFID(const Value: Integer);
    procedure setFINITIAL_DATE(const Value: TDate);
    procedure setFTB_PET_ID(const Value: Integer);

  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_PET_ID')]
    property Pet: Integer read FTB_PET_ID write setFTB_PET_ID;

    [FieldName('DESCRIPTION')]
    property Descricao: String  read FDESCRIPTION write setFDESCRIPTION;


    [FieldName('INITIAL_DATE')]
    property DataInicial: TDate read FINITIAL_DATE write setFINITIAL_DATE;

    [FieldName('FINAL_DATE')]
    property DataFinal: TDate read FFINAL_DATE write setFFINAL_DATE;

  End;
implementation


{ TPetDeadLine }

procedure TPetDeadLine.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TPetDeadLine.setFFINAL_DATE(const Value: TDate);
begin
  FFINAL_DATE := Value;
end;

procedure TPetDeadLine.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPetDeadLine.setFINITIAL_DATE(const Value: TDate);
begin
  FINITIAL_DATE := Value;
end;

procedure TPetDeadLine.setFTB_PET_ID(const Value: Integer);
begin
  FTB_PET_ID := Value;
end;

end.
