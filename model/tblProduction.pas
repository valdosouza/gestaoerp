unit tblProduction;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ORP')]
  TProduction = Class(TGenericEntity)

  private
    FORP_CODPRO: Integer;
    FORP_CODIGO: Integer;
    FORP_QTDPREV: REal;
    FORP_ESTMP: Integer;
    FORP_ESTACB: Integer;
    FORP_NUMERO: String;
    FORP_DTINI: TDate;
    FORP_INDSIT: String;
    FORP_CODMHA: Integer;
    FORP_DTCAD: TDate;
    FORP_DTPREV: TDate;
    FORP_QTDREAL: Real;
    FORP_DTFIM: TDate;
    procedure setFORP_CODIGO(const Value: Integer);
    procedure setFORP_CODMHA(const Value: Integer);
    procedure setFORP_CODPRO(const Value: Integer);
    procedure setFORP_DTCAD(const Value: TDate);
    procedure setFORP_DTFIM(const Value: TDate);
    procedure setFORP_DTINI(const Value: TDate);
    procedure setFORP_DTPREV(const Value: TDate);
    procedure setFORP_ESTACB(const Value: Integer);
    procedure setFORP_ESTMP(const Value: Integer);
    procedure setFORP_INDSIT(const Value: String);
    procedure setFORP_NUMERO(const Value: String);
    procedure setFORP_QTDPREV(const Value: REal);
    procedure setFORP_QTDREAL(const Value: Real);


   public

    [KeyField('ORP_CODIGO')]
    [FieldName('ORP_CODIGO')]
    property Codigo: Integer read FORP_CODIGO write setFORP_CODIGO;

    [FieldName('ORP_NUMERO')]
    property Numero: String read FORP_NUMERO write setFORP_NUMERO;

    [FieldName('ORP_ESTMP')]
    property EstoqueMP: Integer read FORP_ESTMP write setFORP_ESTMP;

    [FieldName('ORP_ESTACB')]
    property EstoquePA: Integer read FORP_ESTACB write setFORP_ESTACB;

    [FieldName('ORP_DTCAD')]
    property DataCadastro:  TDate read FORP_DTCAD write setFORP_DTCAD;

    [FieldName('ORP_DTPREV')]
    property DataPrevista:  TDate read FORP_DTPREV write setFORP_DTPREV;

    [FieldName('ORP_INDSIT')]
    property Situacao:  String read FORP_INDSIT write setFORP_INDSIT;

    [FieldName('ORP_CODPRO')]
    property Produto:  Integer read FORP_CODPRO write setFORP_CODPRO;

    [FieldName('ORP_QTDPREV')]
    property QtdePrevista:  REal read FORP_QTDPREV write setFORP_QTDPREV;

    [FieldName('ORP_DTINI')]
    property DataInicio:  TDate read FORP_DTINI write setFORP_DTINI;

    [FieldName('ORP_DTFIM')]
    property DataFinal:  TDate read FORP_DTFIM write setFORP_DTFIM;

    [FieldName('ORP_QTDREAL')]
    property QtdeProduzida:  Real read FORP_QTDREAL write setFORP_QTDREAL;

    [FieldName('ORP_CODMHA')]
    property Estabelecimento:  Integer read FORP_CODMHA write setFORP_CODMHA;


  End;


  implementation


{ TProduction }

procedure TProduction.setFORP_CODIGO(const Value: Integer);
begin
  FORP_CODIGO := Value;
end;

procedure TProduction.setFORP_CODMHA(const Value: Integer);
begin
  FORP_CODMHA := Value;
end;

procedure TProduction.setFORP_CODPRO(const Value: Integer);
begin
  FORP_CODPRO := Value;
end;

procedure TProduction.setFORP_DTCAD(const Value: TDate);
begin
  FORP_DTCAD := Value;
end;

procedure TProduction.setFORP_DTFIM(const Value: TDate);
begin
  FORP_DTFIM := Value;
end;

procedure TProduction.setFORP_DTINI(const Value: TDate);
begin
  FORP_DTINI := Value;
end;

procedure TProduction.setFORP_DTPREV(const Value: TDate);
begin
  FORP_DTPREV := Value;
end;

procedure TProduction.setFORP_ESTACB(const Value: Integer);
begin
  FORP_ESTACB := Value;
end;

procedure TProduction.setFORP_ESTMP(const Value: Integer);
begin
  FORP_ESTMP := Value;
end;

procedure TProduction.setFORP_INDSIT(const Value: String);
begin
  FORP_INDSIT := Value;
end;

procedure TProduction.setFORP_NUMERO(const Value: String);
begin
  FORP_NUMERO := Value;
end;

procedure TProduction.setFORP_QTDPREV(const Value: REal);
begin
  FORP_QTDPREV := Value;
end;

procedure TProduction.setFORP_QTDREAL(const Value: Real);
begin
  FORP_QTDREAL := Value;
end;

end.
