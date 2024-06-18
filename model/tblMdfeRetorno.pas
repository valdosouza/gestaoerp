unit tblMdfeRetorno;

interface

Uses TEntity,CAtribEntity, STQuery, SysUtils;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE_RETORNO')]
  TMdfeRetorno = Class(TGenericEntity)

    private
    FMOTIVE: string;
    FTB_MDFE_ID: Integer;
    FSERIE: Integer;
    FTB_SITUATION_ID: Integer;
    FTB_INSTITUTION_ID: Integer;
    FFILE_NAME: string;
    FPROTOCOL: String;
    procedure setFFILE_NAME(const Value: string);
    procedure setFMOTIVE(const Value: string);
    procedure setFSERIE(const Value: Integer);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_MDFE_ID(const Value: Integer);
    procedure setFTB_SITUATION_ID(const Value: Integer);
    procedure setFPROTOCOL(const Value: String);



    public

    [KeyField('TB_MDFE_ID')]
    [FieldName('TB_MDFE_ID')]
    property Codigo: Integer read FTB_MDFE_ID write setFTB_MDFE_ID;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('TB_SITUATION_ID')]
    property Situacao: Integer read FTB_SITUATION_ID write setFTB_SITUATION_ID;

    [FieldName('FILE_NAME')]
    property Arquivo: string read FFILE_NAME write setFFILE_NAME;

    [FieldName('MOTIVE')]
    property Motivo: string read FMOTIVE write setFMOTIVE;

    [FieldName('SERIE')]
    property Serie: Integer read FSERIE write setFSERIE;

    [FieldName('PROTOCOL')]
    property Protocolo: String read FPROTOCOL write setFPROTOCOL;

  End;
implementation

{ TMdfeRetorno }

procedure TMdfeRetorno.setFFILE_NAME(const Value: string);
begin
  FFILE_NAME := Value;
end;

procedure TMdfeRetorno.setFMOTIVE(const Value: string);
begin
  FMOTIVE := Value;
end;

procedure TMdfeRetorno.setFPROTOCOL(const Value: String);
begin
  FPROTOCOL := Value;
end;

procedure TMdfeRetorno.setFSERIE(const Value: Integer);
begin
  FSERIE := Value;
end;

procedure TMdfeRetorno.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfeRetorno.setFTB_MDFE_ID(const Value: Integer);
begin
  FTB_MDFE_ID := Value;
end;

procedure TMdfeRetorno.setFTB_SITUATION_ID(const Value: Integer);
begin
  FTB_SITUATION_ID := Value;
end;

end.
