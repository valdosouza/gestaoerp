unit tblPet;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PET')]
  TPet = Class(TGenericEntity)

  private
    FCOLOR: String;
    FTB_CUSTOMER_ID: Integer;
    FID: Integer;
    Fattendance: String;
    FRACE: String;
    FAGE: Integer;
    FHAIR: String;
    FCASTRATED: String;
    FGENDER: String;
    FNAME: String;
    FDT_RECORD: TDate;
    procedure setFAGE(const Value: Integer);
    procedure setFattendance(const Value: String);
    procedure setFCASTRATED(const Value: String);
    procedure setFCOLOR(const Value: String);
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFGENDER(const Value: String);
    procedure setFHAIR(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFNAME(const Value: String);
    procedure setFRACE(const Value: String);
    procedure setFTB_CUSTOMER_ID(const Value: Integer);


  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('DT_RECORD')]
    property Data: TDate read FDT_RECORD write setFDT_RECORD;

    [FieldName('NAME')]
    property Nome: String read FNAME write setFNAME;

    [FieldName('AGE')]
    property Idade: Integer read FAGE write setFAGE;

    [FieldName('RACE')]
    property Raca: String read FRACE write setFRACE;

    [FieldName('HAIR')]
    property Pelagem: String read FHAIR write setFHAIR;

    [FieldName('COLOR')]
    property Cor: String read FCOLOR write setFCOLOR;

    [FieldName('GENDER')]
    property Sexo: String read FGENDER write setFGENDER;

    [FieldName('TB_CUSTOMER_ID')]
    property Cliente: Integer read FTB_CUSTOMER_ID write setFTB_CUSTOMER_ID;

    [FieldName('CASTRATED')]
    property Castrado: String read FCASTRATED write setFCASTRATED;

    [FieldName('attendance')]
    property Frequencia: String read Fattendance write setFattendance;

  End;
implementation


{ TPet }

procedure TPet.setFAGE(const Value: Integer);
begin
  FAGE := Value;
end;

procedure TPet.setFattendance(const Value: String);
begin
  Fattendance := Value;
end;

procedure TPet.setFCASTRATED(const Value: String);
begin
  FCASTRATED := Value;
end;

procedure TPet.setFCOLOR(const Value: String);
begin
  FCOLOR := Value;
end;

procedure TPet.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TPet.setFGENDER(const Value: String);
begin
  FGENDER := Value;
end;

procedure TPet.setFHAIR(const Value: String);
begin
  FHAIR := Value;
end;

procedure TPet.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPet.setFNAME(const Value: String);
begin
  FNAME := Value;
end;

procedure TPet.setFRACE(const Value: String);
begin
  FRACE := Value;
end;

procedure TPet.setFTB_CUSTOMER_ID(const Value: Integer);
begin
  FTB_CUSTOMER_ID := Value;
end;

end.
