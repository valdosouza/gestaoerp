unit ControllerItensAvulso;

interface

uses ControllerBase, tblItensAvulso, System.Classes;

Type
  TControllerItensAvulso = Class(TControllerBase)

  private

  public
    Registro :TItensAvulso;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insere:boolean;
    function delete:boolean;
  End;

implementation

{ TControllerItensAvulso }

constructor TControllerItensAvulso.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensAvulso.Create;
end;

function TControllerItensAvulso.delete: boolean;
begin
  Result := True;
  deleteObj(registro);
end;

destructor TControllerItensAvulso.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerItensAvulso.insere: boolean;
begin
  Result := True;
  try
    insertObj(Registro);
  except
    Result := False;
  end;
end;

end.
