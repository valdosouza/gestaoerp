unit ControllerRecibo;

interface

uses ControllerBase,tblrecibo, System.Classes, System.SysUtils;

type
  TControllerRecibo = Class(TControllerBase)
    private

    public
    Registro : TRecibo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insert:Boolean;
    function Update:Boolean;
    function Detele:Boolean;
    procedure getById;
    procedure clear;

  End;
implementation

{ TControllerRecibo }

procedure TControllerRecibo.clear;
begin
  clearObj(Registro);
end;

constructor TControllerRecibo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRecibo.create;
end;

destructor TControllerRecibo.Destroy;
begin
  FreeAndNil(Registro);
  inherited;
end;

function TControllerRecibo.Detele: Boolean;
begin
  Result := True;
  try
    DeleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerRecibo.getById;
begin
  _getByKey(Registro);
end;

function TControllerRecibo.insert: Boolean;
begin
  Result := True;
  try
    insertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerRecibo.salva: boolean;
begin
  Result := True;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerRecibo.Update: Boolean;
begin
  Result := True;
  try
    UpdateObj(Registro);
  except
    Result := False;
  end;
end;

end.
