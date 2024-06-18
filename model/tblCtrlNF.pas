unit tblCtrlNF;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_ctrl_nf')]
  TCtrlnf = Class(TGenericEntity)
  private
    FCD_EMISSOR : Integer;
    FNUMERO : String;
    FMODELO : String;
    FSERIE : String;
    fDT_RECORD : TDate;
    FTB_NOTA_FISCAL_ID : Integer;
    FCHAVE : String;
    FCD_SITUACAO : Integer;
    FOBSERVACAO : String;
    FTb_Institution_id :Integer;

    procedure setFCD_EMISSOR( Value  : Integer);
    procedure setFNUMERO( Value  : String);
    procedure setFMODELO( Value  : String);
    procedure setFSERIE( Value  : String);
    procedure setFDT_RECORD( Value : TDate);
    procedure setFTB_NOTA_FISCAL_ID( Value  : Integer);
    procedure setFCHAVE( Value  : String);
    procedure setFCD_SITUACAO( Value  : Integer);
    procedure setFOBSERVACAO( Value  : String);
    procedure setFTb_Institution_id( Value  : Integer);

  public

    [KeyField('CD_EMISSOR')]
    [FieldName('CD_EMISSOR')]
    property CodigoEmissor: Integer read FCD_EMISSOR write setFCD_EMISSOR;

    [KeyField('NUMERO')]
    [FieldName('NUMERO')]
    property NumeroNota: String read FNUMERO write setFNUMERO;

    [KeyField('MODELO')]
    [FieldName('MODELO')]
    property ModeloNota: String read FMODELO write setFMODELO;

    [FieldName('SERIE')]
    property SerieNota: String read FSERIE write setFSERIE;

    [FieldName('DT_RECORD')]
    property DataEmissao: TDate read FDT_RECORD write setFDT_RECORD;

    [FieldName('TB_NOTA_FISCAL_ID')]
    property CodigoNotaFiscal: Integer read FTB_NOTA_FISCAL_ID write setFTB_NOTA_FISCAL_ID;

    [FieldName('CHAVE')]
    property ChaveNota: String read FCHAVE write setFCHAVE;

    [FieldName('CD_SITUACAO')]
    property CodigoSituacao: Integer read FCD_SITUACAO write setFCD_SITUACAO;

    [FieldName('OBSERVACAO')]
    property Observacao: String read FOBSERVACAO write setFOBSERVACAO;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property CodigoEstabelecimento: Integer read FTb_Institution_id write setFTb_Institution_id;

  End;

implementation



{ TCtrlnf }

procedure TCtrlnf.setFCD_EMISSOR(Value: Integer);
begin
  FCD_EMISSOR := Value;
end;

procedure TCtrlnf.setFCD_SITUACAO(Value: Integer);
begin
  FCD_SITUACAO := Value;
end;

procedure TCtrlnf.setFCHAVE(Value: String);
begin
  FCHAVE := Value;
end;

procedure TCtrlnf.setFDT_RECORD(Value: TDate);
begin
  fDT_RECORD := Value;
end;

procedure TCtrlnf.setFMODELO(Value: String);
begin
  FMODELO := Value;
end;

procedure TCtrlnf.setFNUMERO(Value: String);
begin
  FNUMERO := Value;
end;

procedure TCtrlnf.setFOBSERVACAO(Value: String);
begin
  FOBSERVACAO := Value;
end;

procedure TCtrlnf.setFSERIE(Value: String);
begin
  FSERIE := Value;
end;

procedure TCtrlnf.setFTb_Institution_id(Value: Integer);
begin
  FTb_Institution_id := Value;
end;

procedure TCtrlnf.setFTB_NOTA_FISCAL_ID(Value: Integer);
begin
  FTB_NOTA_FISCAL_ID := Value;
end;

end.
