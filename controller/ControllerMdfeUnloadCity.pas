unit ControllerMdfeUnloadCity;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeUnloadCity ,Un_MSg,Generics.Collections;

Type
  TControllerMdfeUnloadCity = Class(TControllerBase)
  private

  public
    Registro : TMdfeUnloadCity;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
  End;

implementation

{ TControllerMdfeUnloadCity }

constructor TControllerMdfeUnloadCity.Create(AOwner: TComponent);
begin
    inherited;
    Registro := TMdfeUnloadCity.Create;
end;

function TControllerMdfeUnloadCity.delete: boolean;
begin
Try
  DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeUnloadCity.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerMdfeUnloadCity.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeUnloadCity.insere: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDFE_UNLOAD_CITY');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeUnloadCity.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDFE_UNLOAD_CITY');
  SaveObj(Registro);
end;

function TControllerMdfeUnloadCity.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
