unit tblSchedule;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_SCHEDULE')]
  TSchedule = Class(TGenericEntity)

  private
    Fphone: String;
    Fclerk_id: Integer;
    Fduration: String;
    Ftm_record: String;
    Fnote: String;
    FId: Integer;
    Ftb_situation_id: Integer;
    Ftb_institution_id: Integer;
    Fserved: String;
    Ftb_user_id: Integer;
    Fkind: String;
    Fdt_record: TDate;
    procedure setFclerk_id(const Value: Integer);
    procedure setFdt_record(const Value: TDate);
    procedure setFduration(const Value: String);
    procedure setFId(const Value: Integer);
    procedure setFkind(const Value: String);
    procedure setFnote(const Value: String);
    procedure setFphone(const Value: String);
    procedure setFserved(const Value: String);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFtb_situation_id(const Value: Integer);
    procedure setFtb_user_id(const Value: Integer);
    procedure setFtm_record(const Value: String);



  public

    [KeyField('id')]
    [FieldName('id')]
    property Codigo: Integer read FId write setFId;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [FieldName('dt_record')]
    property Data: TDate read Fdt_record write setFdt_record;

    [FieldName('tm_record')]
    property Hora: String read Ftm_record write setFtm_record;

    [FieldName('duration')]
    property Duracao: String read Fduration write setFduration;

    [FieldName('kind')]
    property Tipo: String read Fkind write setFkind;

    [FieldName('clerk_id')]
    property Atendente: Integer read Fclerk_id write setFclerk_id;

    [FieldName('phone')]
    property Fone: String read Fphone write setFphone;

    [FieldName('served')]
    property Atendido: String read Fserved write setFserved;

    [FieldName('tb_user_id')]
    property Usuario: Integer read Ftb_user_id write setFtb_user_id;

    [FieldName('note')]
    property Obervacao: String read Fnote write setFnote;

    [FieldName('tb_situation_id')]
    property Situacao: Integer read Ftb_situation_id write setFtb_situation_id;

  End;


implementation

{ TSchedule }

procedure TSchedule.setFclerk_id(const Value: Integer);
begin
  Fclerk_id := Value;
end;

procedure TSchedule.setFdt_record(const Value: TDate);
begin
  Fdt_record := Value;
end;

procedure TSchedule.setFduration(const Value: String);
begin
  Fduration := Value;
end;

procedure TSchedule.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TSchedule.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure TSchedule.setFnote(const Value: String);
begin
  Fnote := Value;
end;

procedure TSchedule.setFphone(const Value: String);
begin
  Fphone := Value;
end;

procedure TSchedule.setFserved(const Value: String);
begin
  Fserved := Value;
end;

procedure TSchedule.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TSchedule.setFtb_situation_id(const Value: Integer);
begin
  Ftb_situation_id := Value;
end;

procedure TSchedule.setFtb_user_id(const Value: Integer);
begin
  Ftb_user_id := Value;
end;

procedure TSchedule.setFtm_record(const Value: String);
begin
  Ftm_record := Value;
end;

end.
