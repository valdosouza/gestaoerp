unit ControllerMdfeTotalizer;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeTotalizer ,Un_MSg,Generics.Collections,
  ControllerMedida;

Type
  TControllerMdfeTotalizer = Class(TControllerBase)
  private

  public
    Registro : TMdfeTotalizer;
    Medida  : TControllerMedida;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    procedure Clear;
  End;

implementation

{ TControllerMdfeTotalizer }

procedure TControllerMdfeTotalizer.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeTotalizer.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeTotalizer.Create;
  Medida  := TControllerMedida.Create(Self);
end;

function TControllerMdfeTotalizer.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeTotalizer.Destroy;
begin
  Registro.DisposeOf;
  Medida.DisposeOf;
  inherited;
end;


procedure TControllerMdfeTotalizer.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeTotalizer.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeTotalizer.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerMdfeTotalizer.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
