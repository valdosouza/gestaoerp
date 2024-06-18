unit TblPrintShopOS;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_PRINT_SHOP_OS')]
  TPrintShopOS = Class(TGenericEntity)

  private
    FHR_FORECAST: TTIME;
    FOUTSOURCED_SERVICE: String;
    FNOTE: String;
    FEQUIPMENT: String;
    FMATERIAL: String;
    FHR_FINAL: TTIME;
    FSERVICES: String;
    FDT_DELIVERY: TDATE;
    FKNIFE: String;
    FID: Integer;
    FTB_COLLABORATOR_ID: Integer;
    FHR_DELIVERY: TTIME;
    FMATERIAL_USED: String;
    FTB_SITUATION_ID: Integer;
    FMATERIAL_SUPPLIED: String;
    FMANUFACTURER: String;
    FTB_INSTITUTION_ID: Integer;
    FDT_FORECAST: TDATE;
    FTB_ORDER_ID: Integer;
    FDT_FINAL: TDATE;
    FFINISHING: String;
    FNUMBER: String;
    procedure setFDT_DELIVERY(const Value: TDATE);
    procedure setFDT_FINAL(const Value: TDATE);
    procedure setFDT_FORECAST(const Value: TDATE);
    procedure setFEQUIPMENT(const Value: String);
    procedure setFFINISHING(const Value: String);
    procedure setFHR_DELIVERY(const Value: TTIME);
    procedure setFHR_FINAL(const Value: TTIME);
    procedure setFHR_FORECAST(const Value: TTIME);
    procedure setFID(const Value: Integer);
    procedure setFKNIFE(const Value: String);
    procedure setFMANUFACTURER(const Value: String);
    procedure setFMATERIAL(const Value: String);
    procedure setFMATERIAL_SUPPLIED(const Value: String);
    procedure setFMATERIAL_USED(const Value: String);
    procedure setFNOTE(const Value: String);
    procedure setFOUTSOURCED_SERVICE(const Value: String);
    procedure setFSERVICES(const Value: String);
    procedure setFTB_COLLABORATOR_ID(const Value: Integer);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTB_ORDER_ID(const Value: Integer);
    procedure setFTB_SITUATION_ID(const Value: Integer);
    procedure setFNUMBER(const Value: String);


  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('TB_ORDER_ID')]
    property Ordem:Integer  read FTB_ORDER_ID write setFTB_ORDER_ID;

    [FieldName('NUMBER')]
    property Numero: String  read FNUMBER write setFNUMBER;

    [FieldName('MATERIAL')]
    property Material: String  read FMATERIAL write setFMATERIAL;

    [FieldName('MANUFACTURER')]
    property Fabricante: String read FMANUFACTURER write setFMANUFACTURER;

    [FieldName('KNIFE')]
    property Faca: String read FKNIFE write setFKNIFE;

    [FieldName('MATERIAL_SUPPLIED')]
    property MaterialFornecido:String  read FMATERIAL_SUPPLIED write setFMATERIAL_SUPPLIED;

    [FieldName('MATERIAL_USED')]
    property MaterialUtilizado: String read FMATERIAL_USED write setFMATERIAL_USED;

    [FieldName('EQUIPMENT')]
    property Equipamento:String  read FEQUIPMENT write setFEQUIPMENT;

    [FieldName('SERVICES')]
    property Servico:String  read FSERVICES write setFSERVICES;

    [FieldName('OUTSOURCED_SERVICE')]
    property ServicoTercerizado: String read FOUTSOURCED_SERVICE write setFOUTSOURCED_SERVICE;

    [FieldName('FINISHING')]
    property Acabamentos: String read FFINISHING write setFFINISHING;

    [FieldName('NOTE')]
    property Observacao:String  read FNOTE write setFNOTE;

    [FieldName('TB_SITUATION_ID')]
    property Situacao:Integer  read FTB_SITUATION_ID write setFTB_SITUATION_ID;

    [FieldName('TB_COLLABORATOR_ID')]
    property Responsavel:Integer  read FTB_COLLABORATOR_ID write setFTB_COLLABORATOR_ID;

    [FieldName('DT_FORECAST')]
    property DataPrevista: TDATE read FDT_FORECAST write setFDT_FORECAST;

    [FieldName('HR_FORECAST')]
    property HoraPrevista:TTIME  read FHR_FORECAST write setFHR_FORECAST;

    [FieldName('DT_FINAL')]
    property DataFinal:TDATE  read FDT_FINAL write setFDT_FINAL;

    [FieldName('HR_FINAL')]
    property HoraFinal: TTIME read FHR_FINAL write setFHR_FINAL;

    [FieldName('DT_DELIVERY')]
    property DataEntrega:TDATE  read FDT_DELIVERY write setFDT_DELIVERY;

    [FieldName('HR_DELIVERY')]
    property HoraEntrega:TTIME  read FHR_DELIVERY write setFHR_DELIVERY;

  End;

implementation

{ TPrintShopOS }

procedure TPrintShopOS.setFDT_DELIVERY(const Value: TDATE);
begin
  FDT_DELIVERY := Value;
end;

procedure TPrintShopOS.setFDT_FINAL(const Value: TDATE);
begin
  FDT_FINAL := Value;
end;

procedure TPrintShopOS.setFDT_FORECAST(const Value: TDATE);
begin
  FDT_FORECAST := Value;
end;

procedure TPrintShopOS.setFEQUIPMENT(const Value: String);
begin
  FEQUIPMENT := Value;
end;

procedure TPrintShopOS.setFFINISHING(const Value: String);
begin
  FFINISHING := Value;
end;

procedure TPrintShopOS.setFHR_DELIVERY(const Value: TTIME);
begin
  FHR_DELIVERY := Value;
end;

procedure TPrintShopOS.setFHR_FINAL(const Value: TTIME);
begin
  FHR_FINAL := Value;
end;

procedure TPrintShopOS.setFHR_FORECAST(const Value: TTIME);
begin
  FHR_FORECAST := Value;
end;

procedure TPrintShopOS.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPrintShopOS.setFKNIFE(const Value: String);
begin
  FKNIFE := Value;
end;

procedure TPrintShopOS.setFMANUFACTURER(const Value: String);
begin
  FMANUFACTURER := Value;
end;

procedure TPrintShopOS.setFMATERIAL(const Value: String);
begin
  FMATERIAL := Value;
end;

procedure TPrintShopOS.setFMATERIAL_SUPPLIED(const Value: String);
begin
  FMATERIAL_SUPPLIED := Value;
end;

procedure TPrintShopOS.setFMATERIAL_USED(const Value: String);
begin
  FMATERIAL_USED := Value;
end;

procedure TPrintShopOS.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TPrintShopOS.setFNUMBER(const Value: String);
begin
  FNUMBER := Value;
end;

procedure TPrintShopOS.setFOUTSOURCED_SERVICE(const Value: String);
begin
  FOUTSOURCED_SERVICE := Value;
end;

procedure TPrintShopOS.setFSERVICES(const Value: String);
begin
  FSERVICES := Value;
end;

procedure TPrintShopOS.setFTB_COLLABORATOR_ID(const Value: Integer);
begin
  FTB_COLLABORATOR_ID := Value;
end;

procedure TPrintShopOS.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TPrintShopOS.setFTB_ORDER_ID(const Value: Integer);
begin
  FTB_ORDER_ID := Value;
end;

procedure TPrintShopOS.setFTB_SITUATION_ID(const Value: Integer);
begin
  FTB_SITUATION_ID := Value;
end;

end.
