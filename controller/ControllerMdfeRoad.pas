unit ControllerMdfeRoad;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeRoad ,Un_MSg,Generics.Collections,ControllerVehicle;

Type
  TControllerMdfeRoad = Class(TControllerBase)
  private

  public
    Registro : TMdfeRoad;
    Veiculo : TControllerVehicle;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    procedure Clear;
  End;

implementation

{ TControllerMdfeRoad }

procedure TControllerMdfeRoad.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeRoad.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeRoad.Create;
  Veiculo  := TControllerVehicle.Create(self);

end;

function TControllerMdfeRoad.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

destructor TControllerMdfeRoad.Destroy;
begin
  Registro.DisposeOf;
  Veiculo.DisposeOf;
  inherited;
end;


procedure TControllerMdfeRoad.getbyId;
begin
    _getByKey(Registro);
end;

function TControllerMdfeRoad.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeRoad.save: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerMdfeRoad.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

end.
