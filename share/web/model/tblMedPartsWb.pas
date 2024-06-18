unit tblMedPartsWb;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_med_parts_wb')]
  TMedPartsWb = Class(TGenericEntity)
  private
    Fprint_views: real;
    Fchannel_kind: String;

    Fkind_of_purchase: String;
    FId: Integer;
    Fupdated_at: TDAteTime;
    Fdays: Integer;
    Fmeasures: String;
    Ftb_institution_id: Integer;
    Ftb_order_id: Integer;
    Fdt_final: TDate;
    Fdt_initial: TDate;
    Fcreated_at: TDAteTime;
    procedure setFchannel_kind(const Value: String);

    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFdays(const Value: Integer);
    procedure setFdt_final(const Value: TDate);
    procedure setFdt_initial(const Value: TDate);
    procedure setFId(const Value: Integer);
    procedure setFkind_of_purchase(const Value: String);
    procedure setFmeasures(const Value: String);
    procedure setFprint_views(const Value: real);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFtb_order_id(const Value: Integer);
    procedure setFupdated_at(const Value: TDAteTime);




  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: Integer read FId write setFId;

    [FieldName('tb_institution_id')]
    [KeyField('tb_institution_id')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [KeyField('tb_order_id')]
    [FieldName('tb_order_id')]
    property Ordem: Integer read Ftb_order_id write setFtb_order_id;

    [FieldName('channel_kind')]
    property Canal: String  read Fchannel_kind write setFchannel_kind;

    [FieldName('measures')]
    property Medidas: String  read Fmeasures write setFmeasures;

    [FieldName('dt_initial')]
    property DataInicial: TDate read Fdt_initial write setFdt_initial;


    [FieldName('dt_final')]
    property DataFinal: TDate  read Fdt_final write setFdt_final;

    [FieldName('days')]
    property Dias: Integer read Fdays write setFdays;

    [FieldName('kind_of_purchase')]
    property TipoCompra: String  read Fkind_of_purchase write setFkind_of_purchase;


    [FieldName('print_views')]
    property Impressoes: real  read Fprint_views write setFprint_views;

    [FieldName('created_at')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('updated_at')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;




  End;

implementation

{ TMedPartsWb }

procedure TMedPartsWb.setFchannel_kind(const Value: String);
begin
  Fchannel_kind := Value;
end;

procedure TMedPartsWb.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := Value;
end;

procedure TMedPartsWb.setFdays(const Value: Integer);
begin
  Fdays := Value;
end;

procedure TMedPartsWb.setFdt_final(const Value: TDate);
begin
  Fdt_final := Value;
end;

procedure TMedPartsWb.setFdt_initial(const Value: TDate);
begin
  Fdt_initial := Value;
end;

procedure TMedPartsWb.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TMedPartsWb.setFkind_of_purchase(const Value: String);
begin
  Fkind_of_purchase := Value;
end;

procedure TMedPartsWb.setFmeasures(const Value: String);
begin
  Fmeasures := Value;
end;

procedure TMedPartsWb.setFprint_views(const Value: real);
begin
  Fprint_views := Value;
end;

procedure TMedPartsWb.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TMedPartsWb.setFtb_order_id(const Value: Integer);
begin
  Ftb_order_id := Value;
end;

procedure TMedPartsWb.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := Value;
end;

end.
