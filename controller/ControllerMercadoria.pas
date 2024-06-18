unit ControllerMercadoria;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblMercadoria ,Un_MSg,ControllerProduto,
      ControllerEstoque;

Type
  TControllerMercadoria = Class(TControllerBase)
  private
  public
    Registro : TMercadoria;
    Produto : TControllerProduto;
    Estoque : TControllerEstoque;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    Function delete:boolean;
  End;

implementation


constructor TControllerMercadoria.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMercadoria.Create;
end;

function TControllerMercadoria.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMercadoria.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerMercadoria.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerMercadoria.getById;
begin
  _getByKey(Registro);
end;

end.
