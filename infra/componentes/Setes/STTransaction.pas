unit STTransaction;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Client;

type
  TSTTransaction = class(TFDTransaction)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    function inTransaction: boolean;
    //procedure StartTransaction;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TSTTransaction]);
end;

{ TSTTransaction }

function TSTTransaction.inTransaction: boolean;
begin
  result := self.Active;
end;


end.
