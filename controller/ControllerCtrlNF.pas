unit ControllerCtrlNF;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblCtrlNF ;

Type
  TControllerCtrlNF = Class(TControllerBase)
  private

  public
    Registro : TCtrlNF;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Insere:boolean;
    function salva:boolean;
    Function getByKey:Boolean;
  End;

implementation

{ TControllerCtrlNF }

constructor TControllerCtrlNF.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCtrlNf.Create;

end;

destructor TControllerCtrlNF.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerCtrlNF.getByKey: Boolean;
begin
  _getByKey(Registro);
end;

function TControllerCtrlNF.Insere: boolean;
begin
  if not existObj(Registro) then
  Begin
    InsertObj(Registro);
  End;
end;

function TControllerCtrlNF.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
