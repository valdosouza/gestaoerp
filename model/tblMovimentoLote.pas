unit tblMovimentoLote;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MOVIMENTO_LOTE')]
  TMovimentoLote = Class(TGenericEntity)
  private
    FMLT_OBSERVACAO: String;
    FMLT_CODIGO: Integer;
    FMLT_CODVCL: Integer;
    FMLT_QTDE: Real;
    FMLT_CODCLT: Integer;
    FMLT_LOG: String;
    FMLT_CODEXT: Integer;
    FMLT_SENTIDO: String;
    FMLT_TIPO: String;
    FMLT_DATA: TDate;

    procedure setFMLT_CODCLT(const Value: Integer);
    procedure setFMLT_CODEXT(const Value: Integer);
    procedure setFMLT_CODIGO(const Value: Integer);
    procedure setFMLT_CODVCL(const Value: Integer);
    procedure setFMLT_DATA(const Value: TDate);
    procedure setFMLT_LOG(const Value: String);
    procedure setFMLT_OBSERVACAO(const Value: String);
    procedure setFMLT_QTDE(const Value: Real);
    procedure setFMLT_SENTIDO(const Value: String);
    procedure setFMLT_TIPO(const Value: String);


  public

    [KeyField('MLT_CODIGO')]
    [FieldName('MLT_CODIGO')]
    property Codigo: Integer read FMLT_CODIGO write setFMLT_CODIGO;

    [FieldName('MLT_CODCLT')]
    property Lote: Integer read FMLT_CODCLT write setFMLT_CODCLT;

    [FieldName('MLT_DATA')]
    property Data: TDate read FMLT_DATA write setFMLT_DATA;

    [FieldName('MLT_TIPO')]
    property Tipo: String read FMLT_TIPO write setFMLT_TIPO;

    [FieldName('MLT_CODVCL')]
    property Vinculo: Integer read FMLT_CODVCL write setFMLT_CODVCL;

    [FieldName('MLT_SENTIDO')]
    property Sentido: String read FMLT_SENTIDO write setFMLT_SENTIDO;

    [FieldName('MLT_QTDE')]
    property Qtde: Real read FMLT_QTDE write setFMLT_QTDE;

    [FieldName('MLT_CODEXT')]
    property Extintor: Integer read FMLT_CODEXT write setFMLT_CODEXT;

    [FieldName('MLT_OBSERVACAO')]
    property Observacao: String read FMLT_OBSERVACAO write setFMLT_OBSERVACAO;

    [FieldName('MLT_LOG')]
    property Log: String read FMLT_LOG write setFMLT_LOG;


  End;



implementation

{ TMovimentoLote }

procedure TMovimentoLote.setFMLT_CODCLT(const Value: Integer);
begin
  FMLT_CODCLT := Value;
end;


procedure TMovimentoLote.setFMLT_CODEXT(const Value: Integer);
begin
  FMLT_CODEXT := Value;
end;

procedure TMovimentoLote.setFMLT_CODIGO(const Value: Integer);
begin
  FMLT_CODIGO := Value;
end;

procedure TMovimentoLote.setFMLT_CODVCL(const Value: Integer);
begin
  FMLT_CODVCL := Value;
end;

procedure TMovimentoLote.setFMLT_DATA(const Value: TDate);
begin
  FMLT_DATA := Value;
end;

procedure TMovimentoLote.setFMLT_LOG(const Value: String);
begin
  FMLT_LOG := Value;
end;

procedure TMovimentoLote.setFMLT_OBSERVACAO(const Value: String);
begin
  FMLT_OBSERVACAO := Value;
end;

procedure TMovimentoLote.setFMLT_QTDE(const Value: Real);
begin
  FMLT_QTDE := Value;
end;

procedure TMovimentoLote.setFMLT_SENTIDO(const Value: String);
begin
  FMLT_SENTIDO := Value;
end;

procedure TMovimentoLote.setFMLT_TIPO(const Value: String);
begin
  FMLT_TIPO := Value;
end;

end.
