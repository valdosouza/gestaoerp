unit tblDskCashier;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('tb_cashier')]
  TDskCashier = Class(TGenericEntity)
  private
    FID: Integer;
    FDTRECORD: TDate;
    FUSERID : Integer;
    FHRBEGIN: TDateTime;
    FHREND: TDateTime;

    procedure setFID(value: Integer);
    procedure setFDTRECORD(value: TDate);
    procedure setFUSERID(value: Integer );
    procedure setFHRBEGIN(value: TDateTime);
    procedure setFHREND(value: TDateTime);

  public
    [KeyField('id')]
    [FieldName('id')]
    property Codigo: Integer read FID write setFID;

    [FieldName('dt_record')]
    property Data: TDate read FDTRECORD write setFDTRECORD;

    [FieldName('tb_user_id')]
    property Usuario: Integer read FUSERID write setFUSERID;

    [FieldName('hr_begin')]
    property Abertura: TDateTime read FHRBEGIN write setFHRBEGIN;

    [FieldName('hr_end')]
    property Fechamento: TDateTime read FHREND write setFHREND;

  End;

implementation

uses Un_DM;

procedure TDskCashier.setFDTRECORD(value: TDAte);
begin
  FDTRECORD := value;
end;

procedure TDskCashier.setFHRBEGIN(value: TDateTime);
begin
  FHRBEGIN := value;
end;

procedure TDskCashier.setFHREND(value: TDateTime);
begin
  FHREND :=value;
end;

procedure TDskCashier.setFID(value: Integer);
begin
  FID := Value;
end;

procedure TDskCashier.setFUSERID(value: Integer);
begin
  FUSERID := value;
end;

end.
