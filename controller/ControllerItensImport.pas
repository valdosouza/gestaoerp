unit ControllerItensImport;
interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,Un_Principal,
      Un_sistema,Un_funcoes,Un_Regra_Negocio,  tblCashier, tblItensImport ,Un_MSg;

Type
  TControllerItensImport = Class(TControllerBase)
  private

  public
    Registro : TItensImport;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function salva:boolean;
    function delete:Boolean;
    procedure clear;
  End;


implementation

{ TControllerItensImport }

procedure TControllerItensImport.clear;
begin
  clearObj(Registro);
end;

constructor TControllerItensImport.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensImport.Create;
end;

function TControllerItensImport.delete: Boolean;
begin
  try
    DeleteObj(Registro);
    result := True;
  except
    result := False;
  end;
end;

destructor TControllerItensImport.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerItensImport.salva: boolean;
begin
  if (Registro.Codigo = 0 ) then
    Registro.Codigo := Fc_Generator('gn_itens_import','','ID');
  SaveObj(Registro);

end;

end.
