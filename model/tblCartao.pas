unit tblCartao;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('tb_cartao')]
  TCartao = Class(TGenericEntity)
  private
    FCODIGO: Integer;
    FCODMHA : Integer;
    FCODQTREC: Integer;
    FPARCELA: Integer;
    FCODQTPAG: Integer;
    FAUTORIZA: String;
    FIDETIFICA: String;
    FVALIDADE: TDate;
    FCODCTE: Integer;

    procedure setFCODIGO( Value : Integer);
    procedure setFCODMHA (Value : Integer);
    procedure setFCODCTE( Value : Integer);
    procedure setFIDETIFICA( Value : String);
    procedure setFAUTORIZA( Value : String);
    procedure setFVALIDADE( Value : TDATE);
    procedure setFPARCELA( Value : Integer);
    procedure setFCODQTREC( Value : Integer);
    procedure setFCODQTPAG( Value : Integer);
  public
    [KeyField('CRT_CODIGO')]
    [FieldName('CRT_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;

    [KeyField('CRT_CODMHA')]
    [FieldName('CRT_CODMHA')]
    property Estabelecimento: Integer read FCODMHA write setFCODMHA;

    [FieldName('CRT_CODCTE')]
    property CodigoCartao: Integer read FCODCTE write setFCODCTE;

    [FieldName('CRT_IDETIFICA')]
    property Identificacao: String read FIDETIFICA write setFIDETIFICA;

    [FieldName('CRT_AUTORIZA')]
    property Autorizacao: String read FAUTORIZA write setFAUTORIZA;

    [FieldName('CRT_VALIDADE')]
    property Validade: TDate read FVALIDADE write setFVALIDADE;

    [FieldName('CRT_PARCELA')]
    property NumeroParcela: Integer read FPARCELA write setFPARCELA;

    [FieldName('CRT_CODQT_REC')]
    property CodigoQuitacaoRec: Integer read FCODQTREC write setFCODQTREC;

    [FieldName('CRT_CODQT_PAG')]
    property CodigoQuitacaoPag: Integer read FCODQTPAG write setFCODQTPAG;


  End;

implementation

{ TCartao }

procedure TCartao.setFAUTORIZA(Value: String);
begin
  FAUTORIZA := Value;
end;

procedure TCartao.setFCODCTE(Value: Integer);
begin
  FCODCTE := Value;
end;

procedure TCartao.setFCODIGO(Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TCartao.setFCODMHA(Value: Integer);
begin
  FCODMHA := Value;
end;

procedure TCartao.setFCODQTPAG(Value: Integer);
begin
  FCODQTPAG := Value;
end;

procedure TCartao.setFCODQTREC(Value: Integer);
begin
  FCODQTREC := Value;
end;

procedure TCartao.setFIDETIFICA(Value: String);
begin
  FIDETIFICA := Value;
end;

procedure TCartao.setFPARCELA(Value: Integer);
begin
  FPARCELA := Value;
end;

procedure TCartao.setFVALIDADE(Value: TDATE);
begin
  FVALIDADE := Value;
end;

end.
