unit tblFcpUfNcm;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_FCP_UF_NCM')]
  TFcpUfNcm = Class(TGenericEntity)
  private
    FNCM: String;
    FALIQUOTA: Real;
    FTB_STATE_ID: Integer;
    procedure setFALIQUOTA(const Value: Real);
    procedure setFNCM(const Value: String);
    procedure setFTB_STATE_ID(const Value: Integer);

  public

    [KeyField('TB_STATE_ID')]
    [FieldName('TB_STATE_ID')]
    property CodigoUF : Integer  read FTB_STATE_ID write setFTB_STATE_ID;

    [KeyField('NCM')]
    [FieldName('NCM')]
    property NCM: String  read FNCM write setFNCM;

    [FieldName('ALIQUOTA')]
    property Aliquota: Real  read FALIQUOTA write setFALIQUOTA;

  End;

implementation

{ TFcpUfNcm }

procedure TFcpUfNcm.setFALIQUOTA(const Value: Real);
begin
  FALIQUOTA := Value;
end;

procedure TFcpUfNcm.setFNCM(const Value: String);
begin
  FNCM := Value;
end;

procedure TFcpUfNcm.setFTB_STATE_ID(const Value: Integer);
begin
  FTB_STATE_ID := Value;
end;

end.
