unit ControllerOrderImport;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblOrderImport ,Un_MSg;

Type
  TControllerOrderImport = Class(TControllerBase)
  private

  public
    Registro : TOrderImport;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;

  End;

implementation



constructor TControllerOrderImport.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOrderImport.Create;
end;

function TControllerOrderImport.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerOrderImport.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerOrderImport.insere: boolean;
begin
  InsertObj(Registro);
end;

function TControllerOrderImport.salva: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerOrderImport.getById;
begin
  _getByKey(Registro);
end;

end.
