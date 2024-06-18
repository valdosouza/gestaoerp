unit tblRpsNfse;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_rps_nfse')]
  TRpsNfse = Class(TGenericEntity)
  private
    Ftbnotafiscal : integer;
    FDtRecord : TDateTime;
    Fnumero: integer;
    FProtocolo :String;
    FObs :String;
    Ftbinstitutionid : integer;

    procedure setFtbnotafiscal( Value : integer);
    procedure setFDtRecord(Value : TDateTime);
    procedure setFnumero( Value : integer);
    procedure setFProtocolo( Value :String);
    procedure setFObs( Value :String);
    procedure setFtbinstitutionid( Value : integer);

  public


    [FieldName('numero')]
    property Numero: Integer read Fnumero write setFnumero;

    [KeyField('tb_notafiscal_id')]
    [FieldName('tb_notafiscal_id')]
    property CodigoNotaFiscal: Integer read FtbNotaFiscal write setFtbNotaFiscal;

    [FieldName('dt_record')]
    property DataEmissao: TDateTime read FDtRecord write setFDtRecord;

    [FieldName('protocolo')]
    property Protocolo: String read FProtocolo write setFProtocolo;

    [FieldName('obs')]
    property Observacao: String read FObs write setFObs;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property CodigoEstabelecimento: Integer read Ftbinstitutionid write setFtbinstitutionid;

  End;

implementation


{ TRpsNfse }

procedure TRpsNfse.setFDtRecord(Value: TDateTime);
begin
  FDtRecord := Value;
end;

procedure TRpsNfse.setFnumero(Value: integer);
begin
  Fnumero := Value;
end;

procedure TRpsNfse.setFObs(Value: String);
begin
  FObs := Value;
end;

procedure TRpsNfse.setFProtocolo(Value: String);
begin
  FProtocolo := Value;
end;

procedure TRpsNfse.setFtbinstitutionid(Value: integer);
begin
  Ftbinstitutionid := Value;
end;

procedure TRpsNfse.setFtbnotafiscal(Value: integer);
begin
  Ftbnotafiscal := Value;
end;

end.
