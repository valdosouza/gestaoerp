unit ControllerNegocio;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio ;


Type
  TControllerNegocio = Class(TControllerBase)
  private

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AbrirTela;
  End;

implementation

constructor TControllerNegocio.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TControllerNegocio.Destroy;
begin
  inherited;
end;




{ TControllerNegocio }

procedure TControllerNegocio.AbrirTela;
begin
end;

end.
