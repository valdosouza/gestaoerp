unit tblPafCtrl;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils,System.DateUtils;
Type
  //nome da classe de entidade
  [TableName('TB_PAF_CTRL')]
  TPafCtrl = Class(TGenericEntity)
  private
    FTS_OPENING: TDateTime;
    FUSER_ID_OPENING: Integer;
    FTS_CLOSURE: TDateTime;
    FSTATUS: String;
    FDT_RECORD: TDate;
    FUSER_ID_CLOSURE: Integer;
    FHAS_STATEMENT: String;
    procedure setFDT_RECORD(const Value: TDate);
    procedure setFSTATUS(const Value: String);
    procedure setFTS_CLOSURE(const Value: TDateTime);
    procedure setFTS_OPENING(const Value: TDateTime);
    procedure setFUSER_ID_CLOSURE(const Value: Integer);
    procedure setFUSER_ID_OPENING(const Value: Integer);
    procedure setFHAS_STATEMENT(const Value: String);


  public
    [KeyField('DT_RECORD')]
    [FieldName('DT_RECORD')]
    property DataMovimento: TDate read FDT_RECORD write setFDT_RECORD;

    [FieldName('TS_OPENING')]
    property TempoAbertura: TDateTime read FTS_OPENING write setFTS_OPENING;

    [FieldName('USER_ID_OPENING')]
    property UsuarioAbertura: Integer read FUSER_ID_OPENING write setFUSER_ID_OPENING;

    [FieldName('STATUS')]
    property Situacao: String read FSTATUS write setFSTATUS;

    [FieldName('HAS_STATEMENT')]
    property HaMovimentacao: String read FHAS_STATEMENT write setFHAS_STATEMENT;


    [FieldName('USER_ID_CLOSURE')]
    property UsuarioFechamento: Integer read FUSER_ID_CLOSURE write setFUSER_ID_CLOSURE;

    [FieldName('TS_CLOSURE')]
    property TempoFechamento: TDateTime read FTS_CLOSURE write setFTS_CLOSURE;

  End;


implementation

{ TPafCtrl }

procedure TPafCtrl.setFDT_RECORD(const Value: TDate);
begin
  FDT_RECORD := Value;
end;

procedure TPafCtrl.setFHAS_STATEMENT(const Value: String);
begin
  FHAS_STATEMENT := Value;
end;

procedure TPafCtrl.setFSTATUS(const Value: String);
begin
  FSTATUS := Value;
end;

procedure TPafCtrl.setFTS_CLOSURE(const Value: TDateTime);
begin
  FTS_CLOSURE := Value;
end;

procedure TPafCtrl.setFTS_OPENING(const Value: TDateTime);
begin
  FTS_OPENING := Value;
end;

procedure TPafCtrl.setFUSER_ID_CLOSURE(const Value: Integer);
begin
  FUSER_ID_CLOSURE := Value;
end;

procedure TPafCtrl.setFUSER_ID_OPENING(const Value: Integer);
begin
  FUSER_ID_OPENING := Value;
end;

end.
