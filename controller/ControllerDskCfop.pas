unit ControllerDskCfop;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblDskCfop, Md5, STQuery,FireDAC.Stan.Param;
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
  result := True;
  deleteObj(Registro);
end;

destructor TControllerDskCfop.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerDskCfop.getByKey: Boolean;
begin
  result := True;
  _getByKey(Registro);
end;

function TControllerDskCfop.insert: boolean;
begin
  result := True;
  insertObj(Registro)
end;

function TControllerDskCfop.save: boolean;
begin
  result := True;
  SaveObj(Registro);
end;

end.
