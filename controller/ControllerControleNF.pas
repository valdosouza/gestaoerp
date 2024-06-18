unit ControllerControleNF;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblControleNF ;


Type
  TControllerControleNF = Class(TControllerBase)
  private

  public
    Registro : TControleNF;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
  End;

implementation

{ TControllerCashier }


constructor TControllerControleNF.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TControleNF.Create;
end;

destructor TControllerControleNF.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerControleNF.insere: boolean;
begin
  Registro.Codigo := Fc_Generator('GN_ARQUIVOS','TB_ARQUIVOS','ARQ_CODIGO');
  SaveObj(Registro);
end;

function TControllerControleNF.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
