unit tblSalesOrigin;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_SALE_ORIGEN')]
  TSalesOrigin = Class(TGenericEntity)

  private
    FID: Integer;
    FDESCRIPTION: String;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFPID(const Value: Integer);

  public
    [KeyField('ID')]
    [FieldName('ID')]
    property ID: Integer read FID write setFPID;

    [FieldName('DESCRIPTION')]
    property Description: String read FDESCRIPTION write setFDESCRIPTION;

  End;

implementation

{ TSalesOrigin }

procedure TSalesOrigin.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TSalesOrigin.setFPID(const Value: Integer);
begin
  FID := Value;
end;

end.
