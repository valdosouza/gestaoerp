unit tblPetContact;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PET_CONTACT')]
  TPetContact = Class(TGenericEntity)

  private
    FPHONE: String;
    FTB_PET_ID: Integer;
    FEMERGENCY: String;
    FID: Integer;
    FNAME: String;
    FADDRESS: String;
    procedure setFADDRESS(const Value: String);
    procedure setFEMERGENCY(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFNAME(const Value: String);
    procedure setFPHONE(const Value: String);
    procedure setFTB_PET_ID(const Value: Integer);

  public

   [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_PET_ID')]
    property Pet: Integer read FTB_PET_ID write setFTB_PET_ID;

    [FieldName('NAME')]
    property Nome: String  read FNAME write setFNAME;

    [FieldName('ADDRESS')]
    property Endereco: String  read FADDRESS write setFADDRESS;

    [FieldName('PHONE')]
    property Fone: String  read FPHONE write setFPHONE;

    [FieldName('EMERGENCY')]
    property Emergencia: String  read FEMERGENCY write setFEMERGENCY;

  End;

implementation

{ TPetContact }

procedure TPetContact.setFADDRESS(const Value: String);
begin
  FADDRESS := Value;
end;

procedure TPetContact.setFEMERGENCY(const Value: String);
begin
  FEMERGENCY := Value;
end;

procedure TPetContact.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPetContact.setFNAME(const Value: String);
begin
  FNAME := Value;
end;

procedure TPetContact.setFPHONE(const Value: String);
begin
  FPHONE := Value;
end;

procedure TPetContact.setFTB_PET_ID(const Value: Integer);
begin
  FTB_PET_ID := Value;
end;

end.
