unit ControllerPais;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPais ,Un_MSg,Generics.Collections;

Type
  TListaPais = TObjectList<TPais>;

  TControllerPais = Class(TControllerBase)

  private

  protected


  public
    Registro : TPais;
    Lista : TListaPAis;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
  End;

implementation

{ TControllerPais }

constructor TControllerPais.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPais.create;
  Lista := TListaPAis.create;
end;

destructor TControllerPais.Destroy;
begin
  Registro.disposeOF;
  Lista.disposeOF;
  inherited;
end;

procedure TControllerPais.getbyId;
begin
  _getByKey(Registro);
end;


end.
