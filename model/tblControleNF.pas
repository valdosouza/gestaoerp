unit tblControleNF;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_controle_nf')]
  TControleNF = Class(TGenericEntity)
  private
    FCODNFL : Integer;
    FNUMERO : String;
    FSERIE : String;
    FMODELO : String;
    FINDOPER : String;
    FCODSIT : Integer;

    procedure setFCODNFL( Value : Integer);
    procedure setFNUMERO( Value : String);
    procedure setFSERIE( Value : String);
    procedure setFMODELO( Value : String);
    procedure setFINDOPER( Value : String);
    procedure setFCODSIT( Value : Integer);
  public

    [FieldName('CODNFL')]
    property Codigo: Integer read FCODNFL write setFCODNFL;

    [KeyField('NUMERO')]
    [FieldName('NUMERO')]
    property NumeroNotaFiscal: String read FNUMERO write setFNUMERO;

    [KeyField('SERIE')]
    [FieldName('SERIE')]
    property SerieNotaFiscal: String read FSERIE write setFSERIE;

    [KeyField('MODELO')]
    [FieldName('MODELO')]
    property Modelo: String read FMODELO write setFMODELO;

    [FieldName('IND_OPER')]
    property IndicadorOperacao: String read FINDOPER write setFINDOPER;

    [FieldName('COD_SIT')]
    property CodigoSituacao: Integer read FCODSIT write setFCODSIT;

  End;

implementation

{ TControleNF }

procedure TControleNF.setFCODNFL(Value: Integer);
begin
  FCODNFL := Value;
end;

procedure TControleNF.setFCODSIT(Value: Integer);
begin
  FCODSIT := Value;
end;

procedure TControleNF.setFINDOPER(Value: String);
begin
  FINDOPER := Value;
end;

procedure TControleNF.setFMODELO(Value: String);
begin
  FMODELO := Value;
end;

procedure TControleNF.setFNUMERO(Value: String);
begin
  FNUMERO := Value;
end;

procedure TControleNF.setFSERIE(Value: String);
begin
  FSERIE := Value;
end;

end.
