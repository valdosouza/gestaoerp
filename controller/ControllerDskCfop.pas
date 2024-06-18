unit ControllerDskCfop;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblDskCfop, Md5, STQuery;
Type
  TControllerDskCfop = Class(TControllerBase)
private

  public
    Registro : TDskCfop;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
  End;

implementation

{ TControllerDskCfop }

constructor TControllerDskCfop.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskCfop.Create;
end;

function TControllerDskCfop.delete: boolean;
begin

end;

destructor TControllerDskCfop.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerDskCfop.getByKey: Boolean;
begin
  _getByKey(Registro);
end;

function TControllerDskCfop.insert: boolean;
begin

end;

function TControllerDskCfop.save: boolean;
begin

end;

end.
