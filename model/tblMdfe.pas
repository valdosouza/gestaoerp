unit tblMdfe;

interface

Uses TEntity,CAtribEntity, STQuery, SysUtils;

Type

  //nome da classe de entidade
  [TableName('TB_MDFE')]
  TMdfe = Class(TGenericEntity)

    private
    FNOTE: string;
    FDT_TRAVEL_TIME: tDateTime;
    FID: Integer;
    FSERIE: string;
    FMODEL: string;
    FNUMBER: string;
    FDT_EMISSION: tDateTime;
    FUNLOAD_STATE: string;
    FNOTE_FISCO: string;
    FTB_INSTITUTION_ID: Integer;
    FMODALITY: string;
    FISSUER_KIND: string;
    FTB_STATE_ID: Integer;
    FCARRIER_KIND: string;
    procedure setFDT_EMISSION(const Value: tDateTime);
    procedure setFDT_TRAVEL_TIME(const Value: tDateTime);
    procedure setFID(const Value: Integer);
    procedure setFISSUER_KIND(const Value: string);
    procedure setFMODALITY(const Value: string);
    procedure setFMODEL(const Value: string);
    procedure setFNOTE(const Value: string);
    procedure setFNOTE_FISCO(const Value: string);
    procedure setFNUMBER(const Value: string);
    procedure setFSERIE(const Value: string);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_STATE_ID(const Value: Integer);
    procedure setFUNLOAD_STATE(const Value: string);
    procedure setFCARRIER_KIND(const Value: string);

    public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('MODEL')]
    property Modelo: string read FMODEL write setFMODEL;

    [FieldName('SERIE')]
    property Serie: string read FSERIE write setFSERIE;

    [FieldName('NUMBER')]
    property Numero: string read FNUMBER write setFNUMBER;

    [FieldName('DT_EMISSION')]
    property DataEmissao: tDateTime read FDT_EMISSION write setFDT_EMISSION;

    [FieldName('DT_TRAVEL_TIME')]
    property DataViagem: tDateTime read FDT_TRAVEL_TIME write setFDT_TRAVEL_TIME;

    [FieldName('TB_STATE_ID')]
    property Estado: Integer read FTB_STATE_ID write setFTB_STATE_ID;

    [FieldName('ISSUER_KIND')]
    property TipoEmissor: string read FISSUER_KIND write setFISSUER_KIND;

    [FieldName('MODALITY')]
    property Modalidade: string read FMODALITY write setFMODALITY;

    [FieldName('UNLOAD_STATE')]
    property EstadoDesembarque: string read FUNLOAD_STATE write setFUNLOAD_STATE;

    [FieldName('NOTE')]
    property Observacao: string read FNOTE write setFNOTE;

    [FieldName('NOTE_FISCO')]
    property ObservacaoFisco: string read FNOTE_FISCO write setFNOTE_FISCO;

    [FieldName('CARRIER_KIND')]
    property TipoDoTransportador: string read FCARRIER_KIND write setFCARRIER_KIND;

  End;

implementation

{ TMdfe }

procedure TMdfe.setFCARRIER_KIND(const Value: string);
begin
  FCARRIER_KIND := Value;
end;

procedure TMdfe.setFDT_EMISSION(const Value: tDateTime);
begin
  FDT_EMISSION := Value;
end;

procedure TMdfe.setFDT_TRAVEL_TIME(const Value: tDateTime);
begin
  FDT_TRAVEL_TIME := Value;
end;

procedure TMdfe.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TMdfe.setFISSUER_KIND(const Value: string);
begin
  FISSUER_KIND := Value;
end;

procedure TMdfe.setFMODALITY(const Value: string);
begin
  FMODALITY := Value;
end;

procedure TMdfe.setFMODEL(const Value: string);
begin
  FMODEL := Value;
end;

procedure TMdfe.setFNOTE(const Value: string);
begin
  FNOTE := Value;
end;

procedure TMdfe.setFNOTE_FISCO(const Value: string);
begin
  FNOTE_FISCO := Value;
end;

procedure TMdfe.setFNUMBER(const Value: string);
begin
  FNUMBER := Value;
end;

procedure TMdfe.setFSERIE(const Value: string);
begin
  FSERIE := Value;
end;

procedure TMdfe.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TMdfe.setFTB_STATE_ID(const Value: Integer);
begin
  FTB_STATE_ID := Value;
end;

procedure TMdfe.setFUNLOAD_STATE(const Value: string);
begin
  FUNLOAD_STATE := Value;
end;

end.
