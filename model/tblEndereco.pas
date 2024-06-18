unit tblEndereco;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_endereco')]
  TEndereco = Class(TGenericEntity)
  private
    FCODIGO : Integer;
    FCODEMP : Integer;
    FCNPJ : String;
    FTIPO : String;
    FENDER : String;
    FCOMPLEM : String;
    FBAIRRO : String;
    FCEP : String;
    FCONTATO : String;
    FFONE : String;
    FFAX : String;
    FCELULAR : String;
    FCOMERCIAL : String;
    FPORTARIA : String;
    FPRINCIPAL : String;
    FREGIAO : String;
    FNUMERO : String;
    FPAIS : Integer;
    FCODCDD : Integer;
    FCODUFE : Integer;
    FWHATSUP : String;

    procedure setFCODIGO( Value : Integer);
    procedure setFCODEMP( Value : Integer);
    procedure setFCNPJ( Value : String);
    procedure setFTIPO( Value : String);
    procedure setFENDER( Value : String);
    procedure setFCOMPLEM( Value : String);
    procedure setFBAIRRO( Value : String);
    procedure setFCEP( Value : String);
    procedure setFCONTATO( Value : String);
    procedure setFFONE( Value : String);
    procedure setFFAX( Value : String);
    procedure setFCELULAR( Value : String);
    procedure setFCOMERCIAL( Value : String);
    procedure setFPORTARIA( Value : String);
    procedure setFPRINCIPAL( Value : String);
    procedure setFREGIAO( Value : String);
    procedure setFNUMERO( Value : String);
    procedure setFPAIS( Value : Integer);
    procedure setFCODCDD( Value : Integer);
    procedure setFCODUFE( Value : Integer);
    procedure setFWHATSUP( Value : String);

  public

    [KeyField('END_CODIGO')]
    [FieldName('END_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;

    [KeyField('END_CODEMP')]
    [FieldName('END_CODEMP')]
    property CodigoEmpresa: Integer read FCODEMP write setFCODEMP;

    [FieldName('END_CNPJ')]
    property Cnpj: String read FCNPJ write setFCNPJ;


    [FieldName('END_TIPO')]
    property Tipo: String read FTIPO write setFTIPO;

    [FieldName('END_ENDER')]
    property Logradouro: String read FENDER write setFENDER;

    [FieldName('END_COMPLEM')]
    property Complemento: String read FCOMPLEM write setFCOMPLEM;

    [FieldName('END_BAIRRO')]
    property Bairro: String read FBAIRRO write setFBAIRRO;

    [FieldName('END_CEP')]
    property Cep: String read FCEP write setFCEP;

    [FieldName('END_CONTATO')]
    property Contato: String read FCONTATO write setFCONTATO;

    [FieldName('END_FONE')]
    property Fone: String read FFONE write setFFONE;

    [FieldName('END_FAX')]
    property Fax: String read FFAX write setFFAX;

    [FieldName('END_CELULAR')]
    property Celular: String read FCELULAR write setFCELULAR;

    [FieldName('END_COMERCIAL')]
    property FoneComercial: String read FCOMERCIAL write setFCOMERCIAL;

    [FieldName('END_PORTARIA')]
    property FonePortaria: String read FPORTARIA write setFPORTARIA;

    [FieldName('END_PRINCIPAL')]
    property EnderecoPrincipal: String read FPRINCIPAL write setFPRINCIPAL;

    [FieldName('END_REGIAO')]
    property Regiao: String read FREGIAO write setFREGIAO;

    [FieldName('END_NUMERO')]
    property NumeroPredial: String read FNUMERO write setFNUMERO;

    [FieldName('END_PAIS')]
    property CodigoPais: Integer read FPAIS write setFPAIS;

    [FieldName('END_CODCDD')]
    property CodigoCidade: Integer read FCODCDD write setFCODCDD;

    [FieldName('END_CODUFE')]
    property CodigoEstado: Integer read FCODUFE write setFCODUFE;

    [FieldName('END_WHATSUP')]
    property PossuiWhatsapp: String read FWHATSUP write setFWHATSUP;

  End;

implementation

{ TEndereco }

procedure TEndereco.setFBAIRRO(Value: String);
begin
  FBAIRRO := Value;
end;

procedure TEndereco.setFCELULAR(Value: String);
begin
  FCELULAR := Value;
end;

procedure TEndereco.setFCEP(Value: String);
begin
  FCEP := Value;
end;

procedure TEndereco.setFCNPJ(Value: String);
begin
  FCNPJ := Value;
end;

procedure TEndereco.setFCODCDD(Value: Integer);
begin
  FCODCDD := Value;
end;

procedure TEndereco.setFCODEMP(Value: Integer);
begin
  FCODEMP := Value;
end;

procedure TEndereco.setFCODIGO(Value: Integer);
begin
  FCODIGO  := Value;
end;

procedure TEndereco.setFCODUFE(Value: Integer);
begin
  FCODUFE := Value;
end;

procedure TEndereco.setFCOMERCIAL(Value: String);
begin
  FCOMERCIAL := Value;
end;

procedure TEndereco.setFCOMPLEM(Value: String);
begin
  FCOMPLEM := Copy(Value,1,25);
end;

procedure TEndereco.setFCONTATO(Value: String);
begin
  FCONTATO := Value;
end;

procedure TEndereco.setFENDER(Value: String);
begin
  FENDER := Value;
end;

procedure TEndereco.setFFAX(Value: String);
begin
  FFAX := Value;
end;

procedure TEndereco.setFFONE(Value: String);
begin
  FFONE := Value;
end;

procedure TEndereco.setFNUMERO(Value: String);
begin
  FNUMERO := COPY(Value,1,10);
end;

procedure TEndereco.setFPAIS(Value: Integer);
begin
  FPAIS := Value;
end;

procedure TEndereco.setFPORTARIA(Value: String);
begin
  FPORTARIA := Value;
end;

procedure TEndereco.setFPRINCIPAL(Value: String);
begin
  FPRINCIPAL := Value;
end;

procedure TEndereco.setFREGIAO(Value: String);
begin
  FREGIAO := Value;
end;

procedure TEndereco.setFTIPO(Value: String);
begin
  FTIPO := Value;
end;

procedure TEndereco.setFWHATSUP(Value: String);
begin
  FWHATSUP := Value;
end;

end.
