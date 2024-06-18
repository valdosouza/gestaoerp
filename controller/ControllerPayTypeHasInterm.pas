unit ControllerPayTypeHasInterm;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblPayTypeHasInterm ,Un_MSg,Generics.Collections;

Type
  TControllerPayTypeHasInterm = Class(TControllerBase)

  private

  public
    Registro : TPayTypeHasInterm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    procedure Clear;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerPayTypeHasInterm.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerPayTypeHasInterm.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPayTypeHasInterm.Create;
end;

function TControllerPayTypeHasInterm.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPayTypeHasInterm.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerPayTypeHasInterm.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerPayTypeHasInterm.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPayTypeHasInterm.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPayTypeHasInterm.getById;
begin
  _getByKey(Registro);
end;

end.
