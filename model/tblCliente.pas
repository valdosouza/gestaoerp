unit tblCliente;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_cliente')]
  TCliente = Class(TGenericEntity)
  private
    FCLI_ISS_NR_PROCESSO: String;
    FCLI_IND_IE_DEST: String;
    FCLI_ISS_EXIGIB: String;
    FCLI_ISS_RET: String;
    FCLI_ATIVO: String;
    FCLI_JUST_XML_NFE: String;
    FCLI_ISS_IND_INC_FISCAL: String;
    FCLI_CODEMP: Integer;
    FCLI_OBS_NF: String;
    FCLI_VL_ENTREGA: Real;
    FCLI_EMAIL_NF_AUTO: String;
    FCLI_CODTPR: Integer;


    procedure setFCLI_CODEMP( Value : INTEGER);
    procedure setFCLI_ATIVO( Value : String);
    procedure setFCLI_OBS_NF( Value : String);
    procedure setFCLI_JUST_XML_NFE( Value : String);
    procedure setFCLI_IND_IE_DEST( Value : String);
    procedure setFCLI_ISS_RET( Value : String);
    procedure setFCLI_ISS_EXIGIB( Value : String);
    procedure setFCLI_ISS_IND_INC_FISCAL( Value : String);
    procedure setFCLI_ISS_NR_PROCESSO( Value : String);
    procedure setFCLI_VL_ENTREGA( Value : Real);
    procedure setFCLI_EMAIL_NF_AUTO(const Value: String);
    procedure setFCLI_CODTPR(const Value: Integer);

  public

    [KeyField('CLI_CODEMP')]
    [FieldName('CLI_CODEMP')]
    property Codigo: Integer read FCLI_CODEMP write setFCLI_CODEMP;

    [FieldName('CLI_ATIVO')]
    property Ativo: String read FCLI_ATIVO write setFCLI_ATIVO;

    [FieldName('CLI_OBS_NF')]
    property ObservacaoNF: String read FCLI_OBS_NF write setFCLI_OBS_NF;

    [FieldName('CLI_JUST_XML_NFE')]
    property EnviarSomenteXML: String read FCLI_JUST_XML_NFE write setFCLI_JUST_XML_NFE;

    [FieldName('CLI_IND_IE_DEST')]
    property IndicadorIE_Dest: String read FCLI_IND_IE_DEST write setFCLI_IND_IE_DEST;

    [FieldName('CLI_ISS_RET')]
    property IssRetido: String read FCLI_ISS_RET write setFCLI_ISS_RET;

    [FieldName('CLI_ISS_EXIGIB')]
    property IssExigibilidade: String read FCLI_ISS_EXIGIB write setFCLI_ISS_EXIGIB;

    [FieldName('CLI_ISS_IND_INC_FISCAL')]
    property IssIncentivoFiscal: String read FCLI_ISS_IND_INC_FISCAL write setFCLI_ISS_IND_INC_FISCAL;

    [FieldName('CLI_ISS_NR_PROCESSO')]
    property IssNumeroProcesso: String read FCLI_ISS_NR_PROCESSO write setFCLI_ISS_NR_PROCESSO;

    [FieldName('CLI_VL_ENTREGA')]
    property ValorEntrega: Real read FCLI_VL_ENTREGA write setFCLI_VL_ENTREGA;

    [FieldName('CLI_EMAIL_NF_AUTO')]
    property EnviaEmailNFeAuto: String read FCLI_EMAIL_NF_AUTO write setFCLI_EMAIL_NF_AUTO;

    [FieldName('CLI_CODTPR')]
    property TabelaPreco: Integer read FCLI_CODTPR write setFCLI_CODTPR;

  End;

implementation
{ TCliente }

procedure TCliente.setFCLI_ATIVO(Value: String);
begin
  FCLI_ATIVO := Value;
end;

procedure TCliente.setFCLI_CODEMP(Value: INTEGER);
begin
  FCLI_CODEMP := Value;
end;

procedure TCliente.setFCLI_CODTPR(const Value: Integer);
begin
  FCLI_CODTPR := Value;
end;

procedure TCliente.setFCLI_EMAIL_NF_AUTO(const Value: String);
begin
  FCLI_EMAIL_NF_AUTO := Value;
end;

procedure TCliente.setFCLI_IND_IE_DEST(Value: String);
begin
  FCLI_IND_IE_DEST := Value;
end;

procedure TCliente.setFCLI_ISS_EXIGIB(Value: String);
begin
  FCLI_ISS_EXIGIB := Value;
end;

procedure TCliente.setFCLI_ISS_IND_INC_FISCAL(Value: String);
begin
  FCLI_ISS_IND_INC_FISCAL := Value;
end;

procedure TCliente.setFCLI_ISS_NR_PROCESSO(Value: String);
begin
  FCLI_ISS_NR_PROCESSO := Value;
end;

procedure TCliente.setFCLI_ISS_RET(Value: String);
begin
  FCLI_ISS_RET := Value;
end;

procedure TCliente.setFCLI_JUST_XML_NFE(Value: String);
begin
  FCLI_JUST_XML_NFE := Value;
end;

procedure TCliente.setFCLI_OBS_NF(Value: String);
begin
  FCLI_OBS_NF := Value;
end;

procedure TCliente.setFCLI_VL_ENTREGA(Value: Real);
begin
  FCLI_VL_ENTREGA := Value;
end;

end.
