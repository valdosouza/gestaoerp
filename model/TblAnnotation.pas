unit TblAnnotation;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_annotation')]
  TAnnotation = Class(TGenericEntity)

  private
    Flink_id2: Integer;
    Fobservation: String;
    Flink_id1: Integer;
    Fid: Integer;
    Fidentify: String;
    Freference: String;
    Fdt_record: TDate;
    procedure setFdt_record(const Value: TDate);
    procedure setFid(const Value: Integer);
    procedure setFidentify(const Value: String);
    procedure setFlink_id1(const Value: Integer);
    procedure setFlink_id2(const Value: Integer);
    procedure setFobservation(const Value: String);
    procedure setFreference(const Value: String);


  public
    [FieldName('id')]
    [KeyField('id')]
    property Codigo: Integer read Fid write setFid;

    [KeyField('identify')]
    [FieldName('identify')]
    property Identificar: String read Fidentify write setFidentify;

    [FieldName('dt_record')]
    property Data: TDate read Fdt_record write setFdt_record;

   [FieldName('link_id1')]
    property Link1: Integer read Flink_id1 write setFlink_id1;

    [FieldName('link_id2')]
    property Link2: Integer read Flink_id2 write setFlink_id2;

    [FieldName('reference')]
    property Referencia: String read Freference write setFreference;

    [FieldName('observation')]
    property Observacao: String read Fobservation write setFobservation;
  End;

  implementation

{ TAnnotation }

procedure TAnnotation.setFdt_record(const Value: TDate);
begin
  Fdt_record := Value;
end;

procedure TAnnotation.setFid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TAnnotation.setFidentify(const Value: String);
begin
  Fidentify := Value;
end;

procedure TAnnotation.setFlink_id1(const Value: Integer);
begin
  Flink_id1 := Value;
end;

procedure TAnnotation.setFlink_id2(const Value: Integer);
begin
  Flink_id2 := Value;
end;

procedure TAnnotation.setFobservation(const Value: String);
begin
  Fobservation := Value;
end;

procedure TAnnotation.setFreference(const Value: String);
begin
  Freference := Value;
end;

end.
