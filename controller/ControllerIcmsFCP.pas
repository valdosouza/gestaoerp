unit ControllerIcmsFCP;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_Regra_Negocio, Data.DB,
      tblIcmsFCP,Generics.Collections;


Type
  TListaIcmsFCP = TObjectList<TIcmsFCP>;

  TControllerIcmsFCP = Class(TControllerBase)
    Lista : TListaIcmsFCP;
  private

  public
    Registro : TIcmsFCP;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function salva:boolean;
    function insere:boolean;
    function getlist:boolean;
    function deleteAllProduct:boolean;
    procedure clear;
  End;

implementation

{ TControllerCashier }

procedure TControllerIcmsFCP.clear;
begin
  clearObj(Registro);
end;

constructor TControllerIcmsFCP.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIcmsFCP.Create;
  Lista := TListaIcmsFCP.Create;
end;

function TControllerIcmsFCP.deleteAllProduct: boolean;
begin

end;

destructor TControllerIcmsFCP.Destroy;
begin
  FreeAndNil( Lista );
  Registro.DisposeOf;
  inherited;
end;



procedure TControllerIcmsFCP.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerIcmsFCP.getlist: boolean;
begin

end;

function TControllerIcmsFCP.insere: boolean;
begin
  InsertObj(Registro);
end;

function TControllerIcmsFCP.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
