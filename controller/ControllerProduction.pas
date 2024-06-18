unit ControllerProduction;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblProduction ,Un_MSg,
      ControllerProductionForeCast, ControllerProductionRealized,ControllerCtrlEstoque;

Type
  TControllerProduction = Class(TControllerBase)
  private

  public
    Registro : TProduction;
    ProducaoPrevista : TControllerProductionForeCast;
    ProducaoRealizada : TControllerProductionRealized;
    CtrlEstoque : TControllerCtrlEstoque;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
    Function deleteByOrder:boolean;
  End;

implementation

constructor TControllerProduction.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProduction.Create;
  ProducaoPrevista := TControllerProductionForeCast.create(Self);
  ProducaoRealizada := TControllerProductionRealized.create(Self);
  CtrlEstoque := TControllerCtrlEstoque.create(Self);
end;

function TControllerProduction.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerProduction.deleteByOrder: boolean;
begin

end;

destructor TControllerProduction.Destroy;
begin
  CtrlEstoque.DisposeOf;
  ProducaoRealizada.DisposeOf;
  ProducaoPrevista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


function TControllerProduction.insere: boolean;
begin
  Registro.Codigo := Generator('GN_ORP');
  InsertObj(Registro);
end;

function TControllerProduction.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ORP');
  SaveObj(Registro);
end;


procedure TControllerProduction.getById;
begin
  _getByKey(Registro);
end;


end.
