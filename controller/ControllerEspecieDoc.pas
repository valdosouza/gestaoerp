unit ControllerEspecieDoc;

interface

uses  STDatabase, Classes, STQuery, SysUtils, ControllerBase, tblCartao,
      Un_sistema, Un_funcoes, Un_Regra_Negocio, tblEspecieDoc ;

Type
  TControllerEspecieDoc = Class(TControllerBase)
  private
  public

    Registro : TEspecieDoc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function delete:boolean;
    function salva:boolean;
    function insere:boolean;
  End;

implementation

{ TControllerFinanceiro }

constructor TControllerEspecieDoc.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEspecieDoc.Create;
end;

function TControllerEspecieDoc.delete: boolean;
begin
  try
    DeleteObj(Registro);
    result := True;
  except
    result := False;
  end;
end;

destructor TControllerEspecieDoc.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerEspecieDoc.getById;
begin
  _getByKey(Registro);
end;

function TControllerEspecieDoc.insere: boolean;
begin
  Registro.Codigo := Generator('GN_ESPECIE_DOC');
  SaveObj(Registro);
end;

function TControllerEspecieDoc.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ESPECIE_DOC');
  SaveObj(Registro);
end;

end.
