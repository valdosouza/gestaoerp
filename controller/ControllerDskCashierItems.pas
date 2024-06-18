unit ControllerDskCashierItems;

interface

uses STDatabase,Classes, SysUtils,ControllerBase,
      tblDskCashierItems, Md5, STQuery;
Type
  TControllerDskCashierItems = Class(TControllerBase)

  private

  public
    Registro : TDskCashierItems;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
  End;

  implementation
{ ControllerDskCashierItems}

procedure TControllerDskCashierItems.clear;
begin

end;

constructor TControllerDskCashierItems.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskCashierItems.Create;
end;

function TControllerDskCashierItems.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDskCashierItems.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerDskCashierItems.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerDskCashierItems.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerDskCashierItems.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerDskCashierItems.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.
