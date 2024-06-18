unit tblKind;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_kind')]
  TKind = Class(TGenericEntity)
  private
    Fcost_owner: string;
    Fdescription: String;
    FId: Integer;
    Fupdated_at: TDAteTime;
    Fdetail: string;
    Ftb_institution_id: integer;
    Fcreated_at: TDAteTime;
    procedure setFcost_owner(const Value: string);
    procedure setFcreated_at(const Value: TDAteTime);
    procedure setFdescription(const Value: String);
    procedure setFdetail(const Value: string);
    procedure setFId(const Value: Integer);
    procedure setFtb_institution_id(const Value: integer);
    procedure setFupdated_at(const Value: TDAteTime);



  public

    [FieldName('id')]
    [KeyField('id')]
    property Codigo: Integer read FId write setFId;

    [FieldName('tb_institution_id')]
    [KeyField('tb_institution_id')]
    property Estabelecimento: integer read Ftb_institution_id write setFtb_institution_id;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

    [FieldName('detail')]
    property Detalhe: string read Fdetail write setFdetail;

    [FieldName('cost_owner')]
    property DonoDoCusto: string read Fcost_owner write setFcost_owner;

    [FieldName('created_at')]
    property RegistroCriado: TDAteTime read Fcreated_at write setFcreated_at;

    [FieldName('updated_at')]
    property RegistroAlterado: TDAteTime read Fupdated_at write setFupdated_at;

    end;
implementation

{ TKind }

procedure TKind.setFcost_owner(const Value: string);
begin
  Fcost_owner := Value;
end;

procedure TKind.setFcreated_at(const Value: TDAteTime);
begin
  Fcreated_at := Value;
end;

procedure TKind.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TKind.setFdetail(const Value: string);
begin
  Fdetail := Value;
end;

procedure TKind.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TKind.setFtb_institution_id(const Value: integer);
begin
  Ftb_institution_id := Value;
end;

procedure TKind.setFupdated_at(const Value: TDAteTime);
begin
  Fupdated_at := Value;
end;

end.
