unit ControllerProductSimilar;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_funcoes, tblProductSimilar ,Un_MSg;

Type
  TControllerProductSimilar = Class(TControllerBase)
  private

  public
    Registro : TProductSimilar;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
  End;

implementation

uses Un_Regra_Negocio;


constructor TControllerProductSimilar.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProductSimilar.Create;
end;

function TControllerProductSimilar.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerProductSimilar.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerProductSimilar.insere: boolean;
begin
  InsertObj(Registro);
end;

function TControllerProductSimilar.salva: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerProductSimilar.getById;
begin
  _getByKey(Registro);
end;


end.
