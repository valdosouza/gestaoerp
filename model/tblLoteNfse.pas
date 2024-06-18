unit tblLoteNfse;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_lote_nfse')]
  TLoteNfse = Class(TGenericEntity)
  private
    Ftbnotafiscal : integer;
    Fnumero: integer;
    FObs :String;
    Ftbinstitutionid : integer;


    procedure setFtbnotafiscal( Value : integer);
    procedure setFnumero( Value : integer);
    procedure setFObs( Value :String);
    procedure setFtbinstitutionid( Value : integer);

  public

    [KeyField('tb_notafiscal_id')]
    [FieldName('tb_notafiscal_id')]
    property CodigoNotaFiscal: Integer read FtbNotaFiscal write setFtbNotaFiscal;

    [FieldName('numerolote')]
    property Numero: Integer read Fnumero write setFnumero;

    [FieldName('obs')]
    property Observacao: String read FObs write setFObs;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property CodigoEstabelecimento: Integer read Ftbinstitutionid write setFtbinstitutionid;


  End;

implementation


{ TLoteNfse }

procedure TLoteNfse.setFnumero(Value: integer);
begin
  Fnumero := Value;
end;

procedure TLoteNfse.setFObs(Value: String);
begin
  FObs := Value;
end;

procedure TLoteNfse.setFtbinstitutionid(Value: integer);
begin
  Ftbinstitutionid := Value;
end;

procedure TLoteNfse.setFtbnotafiscal(Value: integer);
begin
  Ftbnotafiscal := Value;
end;

end.
