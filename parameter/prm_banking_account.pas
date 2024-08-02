unit prm_banking_account;

interface

uses
  prm_base, tblContaBancaria, System.SysUtils;

Type
  TPrmBankingAccount = class(TPrmBase)
  private
    FFieldName: TContaBancaria;
    procedure setFFieldName(const Value: TContaBancaria);
  public
    constructor Create;
    destructor Destroy;override;
    procedure Clear;Override;
    property FieldName : TContaBancaria read FFieldName write setFFieldName;
  end;

implementation

{ TPrmBankingAccount }

procedure TPrmBankingAccount.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmBankingAccount.Create;
begin
  inherited;
  FFieldName := TContaBancaria.Create;
end;

destructor TPrmBankingAccount.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmBankingAccount.setFFieldName(const Value: TContaBancaria);
begin
  FFieldName := Value;
end;

end.
