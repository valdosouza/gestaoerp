unit STStoredProc;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, STDatabase, STTransaction;

type
  TSTStoredProc = class(TFDStoredProc)
  private
    FDatabase: TSTDatabase;
    FTSTTransaction: TSTTransaction;
    FForcedRefresh: Boolean;
    procedure setFDatabase(const Value: TSTDatabase);
    procedure setFTSTTransaction(const Value: TSTTransaction);
    procedure setFForcedRefresh(const Value: Boolean);
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
  RegisterComponents('Setes', [TSTStoredProc]);
end;

{ TSTStoredProc }

procedure TSTStoredProc.setFDatabase(const Value: TSTDatabase);
begin
  Connection := Value;
end;

procedure TSTStoredProc.setFForcedRefresh(const Value: Boolean);
begin
  FForcedRefresh := Value;
end;

procedure TSTStoredProc.setFTSTTransaction(const Value: TSTTransaction);
begin
  FTSTTransaction := Value;
end;

end.
