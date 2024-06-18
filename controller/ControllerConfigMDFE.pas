unit ControllerConfigMDFE;

interface

uses STDatabase, System.Classes, STQuery, System.SysUtils, ControllerBase;

implementation

Type
  TControllerConfigMDFE = Class(TControllerBase)
  private
  public
    Registro : TConfigMDFE;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function delete:boolean;
    function salva:boolean;
    function insere:boolean;
  End;

{ TControllerConfigMDFE }

constructor TControllerConfigMDFE.Create(AOwner: TComponent);
begin
  inherited;
  //Registro := TConfigMDFE.Create;
end;

function TControllerConfigMDFE.delete: boolean;
begin
  try
//    DeleteObj(Registro);
    result := True;
  except
    result := False;
  end;
end;

destructor TControllerConfigMDFE.Destroy;
begin
//  FreeAndNil(registro);
  inherited;
end;

procedure TControllerConfigMDFE.getById;
begin
  _getByKey(Registro);
end;

function TControllerConfigMDFE.insere: boolean;
begin
    Registro.Codigo := Generator('GN_MDF_ELETRONICA');
    SaveObj(Registro);
end;

function TControllerConfigMDFE.salva: boolean;
begin
    if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDF_ELETRONICA');
    SaveObj(Registro);
end;

end.
