unit ControllerTransportadora;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tbltransportadora,
      ControllerFornecedor, tblPhone,tblAddress;


Type
  TControllerTransportadora = Class(TControllerBase)
  private

  public
    Registro : TTransportadora;
    Fornecedor : TControllerFornecedor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getById;
    procedure clear;
  End;

implementation


procedure TControllerTransportadora.clear;
begin
  ClearObj(registro);
end;

constructor TControllerTransportadora.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TTransportadora.Create;
  Fornecedor   := TControllerFornecedor.create(Self);
end;

destructor TControllerTransportadora.Destroy;
begin
  Fornecedor.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerTransportadora.getById;
begin
  _getByKey(Registro);
end;

function TControllerTransportadora.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
