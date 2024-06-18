unit TblCartaCorrecao;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_CARTA_CORRECAO')]
  TCartaCorrecao = Class(TGenericEntity)

  private
    Fcce_codigo: Integer;
    Fcce_codnfl: Integer;
    Fcce_data: TDate;
    Fcce_chave: String;
    Fcce_codufe: Integer;
    Fcce_sequencia: Integer;
    Fcce_detalhe: String;
    Fcce_codsit: Integer;
    Fcce_motivo: String;
    Fcce_protocolo: String;
    Fcce_dt_protocolo: TDate;
    procedure setFcce_chave(const Value: String);
    procedure setFcce_codigo(const Value: Integer);
    procedure setFcce_codnfl(const Value: Integer);
    procedure setFcce_codsit(const Value: Integer);
    procedure setFcce_codufe(const Value: Integer);
    procedure setFcce_data(const Value: TDate);
    procedure setFcce_detalhe(const Value: String);
    procedure setFcce_dt_protocolo(const Value: TDate);
    procedure setFcce_motivo(const Value: String);
    procedure setFcce_protocolo(const Value: String);
    procedure setFcce_sequencia(const Value: Integer);


   public
    [FieldName('CCE_CODIGO')]
    [KeyField('CCE_CODIGO')]
    property Codigo: Integer read Fcce_codigo write setFcce_codigo ;

    [FieldName('CCE_CODNFL')]
    property Codnfl: Integer read Fcce_codnfl write setFcce_codnfl;

    [FieldName('CCE_DATA')]
    property Data: TDate read Fcce_data write setFcce_data;

    [FieldName('CCE_CHAVE')]
    property Chave: String read Fcce_chave write setFcce_chave;

    [FieldName('CCE_CODUFE')]
    property Codufe: Integer read Fcce_codufe write setFcce_codufe;

    [FieldName('CCE_SEQUENCIA')]
    property Sequencia: Integer read Fcce_sequencia write setFcce_sequencia;

    [FieldName('CCE_DETALHE')]
    property Detalhe: String read Fcce_detalhe write setFcce_detalhe;

    [FieldName('CCE_CODSIT')]
    property Codsit: Integer read Fcce_codsit write setFcce_codsit;

    [FieldName('CCE_MOTIVO')]
    property Motivo: String read Fcce_motivo write setFcce_motivo;

    [FieldName('CCE_PROTOCOLO')]
    property Protocolo: String read Fcce_protocolo write setFcce_protocolo;

    [FieldName('CCE_DT_PROTOCOLO')]
    property DtProtocolo: TDate read Fcce_dt_protocolo write setFcce_dt_protocolo;
  End;


  implementation



{ TCartaCorrecao }

procedure TCartaCorrecao.setFcce_chave(const Value: String);
begin
  Fcce_chave := Value;
end;

procedure TCartaCorrecao.setFcce_codigo(const Value: Integer);
begin
  Fcce_codigo := Value;
end;

procedure TCartaCorrecao.setFcce_codnfl(const Value: Integer);
begin
  Fcce_codnfl := Value;
end;

procedure TCartaCorrecao.setFcce_codsit(const Value: Integer);
begin
  Fcce_codsit := Value;
end;

procedure TCartaCorrecao.setFcce_codufe(const Value: Integer);
begin
  Fcce_codufe := Value;
end;

procedure TCartaCorrecao.setFcce_data(const Value: TDate);
begin
  Fcce_data := Value;
end;

procedure TCartaCorrecao.setFcce_detalhe(const Value: String);
begin
  Fcce_detalhe := Value;
end;

procedure TCartaCorrecao.setFcce_dt_protocolo(const Value: TDate);
begin
  Fcce_dt_protocolo := Value;
end;

procedure TCartaCorrecao.setFcce_motivo(const Value: String);
begin
  Fcce_motivo := Value;
end;

procedure TCartaCorrecao.setFcce_protocolo(const Value: String);
begin
  Fcce_protocolo := Value;
end;

procedure TCartaCorrecao.setFcce_sequencia(const Value: Integer);
begin
  Fcce_sequencia := Value;
end;

end.
