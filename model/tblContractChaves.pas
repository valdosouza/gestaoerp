unit tblContractChaves;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('TB_CONTRACT_CHAVES')]
  TContractChaves = Class(TGenericEntity)
  private
    FID: Integer;
    FTB_CONTRACT_ID: Integer;
    FFIELD: String;
    FCHAVE: String;
    procedure setFCHAVE(const Value: String);
    procedure setFFIELD(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFTB_CONTRACT_ID(const Value: Integer);


  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_CONTRACT_ID')]
    [FieldName('TB_CONTRACT_ID')]
    property Contrato: Integer read FTB_CONTRACT_ID write setFTB_CONTRACT_ID;

    [FieldName('CHAVE')]
    property Chave: String read FCHAVE write setFCHAVE;

    [FieldName('FIELD')]
    property Campo :String  read FFIELD write setFFIELD;

  End;


implementation

{ TContractChaves }

procedure TContractChaves.setFCHAVE(const Value: String);
begin
  FCHAVE := Value;
end;

procedure TContractChaves.setFFIELD(const Value: String);
begin
  FFIELD := Value;
end;

procedure TContractChaves.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TContractChaves.setFTB_CONTRACT_ID(const Value: Integer);
begin
  FTB_CONTRACT_ID := Value;
end;

end.
