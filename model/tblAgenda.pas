unit tblAgenda;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_agenda')]
  TAgenda = Class(TGenericEntity)

  private
    Fagd_Codigo: Integer;
    Fagd_hora: String;
    Fagd_compromisso: String;
    Fagd_avisar: String;
    Fagd_decodusu: Integer;
    Fagd_paracodusu : Integer;
    FFagd_dia: TDate;
    FFagd_data: TDate;
    Fagd_dia: TDate;
    Fagd_data: TDate;

    procedure setFagd_avisar(const Value: String);
    procedure setFagd_codigo(const Value: Integer);
    procedure setFagd_compromisso(const Value: String);
    procedure setFagd_data(const Value: TDate);
    procedure setFagd_decodusu(const Value: Integer);
    procedure setFagd_dia(const Value: TDate);
    procedure setFagd_hora(const Value: String);
    procedure setFagd_paracodusu(const Value: Integer);

  public

    [FieldName('agd_codigo')]
    [KeyField('agd_codigo')]
    property Codigo: Integer read Fagd_codigo write setFagd_codigo;

    [KeyField('agd_hora')]
    [FieldName('agd_hora')]
    property Hora: String read Fagd_hora write setFagd_hora;

    [FieldName('agd_compromisso')]
    property Compromisso: String read Fagd_compromisso write setFagd_compromisso;

    [FieldName('agd_avisar')]
    property Avisar: String read Fagd_avisar write setFagd_avisar;

    [FieldName('agd_decodusu')]
    property DecoDusu: Integer read Fagd_decodusu write setFagd_decodusu;

    [FieldName('agd_paracodusu')]
    property ParaCodusu: Integer read Fagd_paracodusu write setFagd_paracodusu;

    [FieldName('agd_dia')]
    property Dia: TDate read Fagd_dia write setFagd_dia;

    [FieldName('agd_data')]
    property Data: TDate read Fagd_data write setFagd_data;

  End;

  implementation
{ TAgenda }

  procedure TAgenda.setFagd_avisar(const Value: String);
  begin
    Fagd_avisar := Value;
  end;


  procedure TAgenda.setFagd_codigo(const Value: Integer);
  begin
  Fagd_codigo := Value;
  end;

  procedure TAgenda.setFagd_compromisso(const Value: String);
  begin
    Fagd_compromisso := Value;
  end;

  procedure TAgenda.setFagd_data(const Value: TDate);
  begin
    Fagd_data := Value;
  end;

  procedure TAgenda.setFagd_decodusu(const Value: Integer);
  begin
    Fagd_decodusu := Value;
  end;

  procedure TAgenda.setFagd_dia(const Value: TDate);
  begin
    Fagd_dia := Value;
  end;

  procedure TAgenda.setFagd_hora(const Value: String);
  begin
    Fagd_hora := Value;
  end;

  procedure TAgenda.setFagd_paracodusu(const Value: Integer);
  begin
    Fagd_paracodusu := Value;
  end;
end.

