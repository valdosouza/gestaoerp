unit tblTaxIcmsSN;

interface

Uses GenericEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_tax_icms_sn')]
  TTaxIcmsSN = Class(TGenericEntity)
  private
    Fdescription: String;
    Fid: String;
    Fupdated_at: TDatetime;
    Fcreated_at: TDatetime;
    procedure setFcreated_at(const Value: TDatetime);
    procedure setFdescription(const Value: String);
    procedure setFid(const Value: String);
    procedure setFupdated_at(const Value: TDatetime);

  public

    [KeyField('id')]
    [FieldName('id')]
    property Codigo: String read Fid write setFid;

    [FieldName('description')]
    property Descricao: String read Fdescription write setFdescription;

	  [FieldName('created_at')]
    property RegistroCriado: TDatetime read Fcreated_at write setFcreated_at;

    [FieldName('updated_at')]
    property RegistroAlterado: TDatetime read Fupdated_at write setFupdated_at;

	End;

implementation


{ TTaxIcmsSN }

procedure TTaxIcmsSN.setFcreated_at(const Value: TDatetime);
begin
  Fcreated_at := Value;
end;

procedure TTaxIcmsSN.setFdescription(const Value: String);
begin
  Fdescription := Value;
end;

procedure TTaxIcmsSN.setFid(const Value: String);
begin
  Fid := Value;
end;

procedure TTaxIcmsSN.setFupdated_at(const Value: TDatetime);
begin
  Fupdated_at := Value;
end;

end.
