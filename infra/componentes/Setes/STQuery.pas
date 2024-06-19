unit STQuery;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, STTransaction,STDatabase;

type
  TSTQuery = class(TFDQuery)
  private
    FTSTTransaction: TSTTransaction;
    FForcedRefresh: Boolean;
    FDatabase: TSTDatabase;
    procedure setFTSTTransaction(const Value: TSTTransaction);
    procedure setFForcedRefresh(const Value: Boolean);
    procedure setFDatabase(const Value: TSTDatabase);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property ForcedRefresh :Boolean read FForcedRefresh write setFForcedRefresh;
    property Database : TSTDatabase read FDatabase write setFDatabase;
    property Transaction : TSTTransaction read FTSTTransaction write setFTSTTransaction;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTQuery]);
end;

{ TSTQuery }

procedure TSTQuery.setFDatabase(const Value: TSTDatabase);
begin
  Connection := Value;
end;

procedure TSTQuery.setFForcedRefresh(const Value: Boolean);
begin
  FForcedRefresh := Value;
end;

procedure TSTQuery.setFTSTTransaction(const Value: TSTTransaction);
begin
  FTSTTransaction := Value;
end;

end.
