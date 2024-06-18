unit ControllerLojaTrayOrder;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblLojaTrayOrder ,Un_MSg;

Type
  TControllerLojaTrayOrder = Class(TControllerBase)
  private

  public
    Registro : TLojaTrayOrder;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function LastModified:TDateTime;
    procedure clear;
  End;


implementation

{ TControllerLojaTrayOrder }

procedure TControllerLojaTrayOrder.clear;
begin
  inherited;
  ClearObj(Registro);
end;

constructor TControllerLojaTrayOrder.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TLojaTrayOrder.Create;
end;

function TControllerLojaTrayOrder.delete: boolean;
begin

end;

destructor TControllerLojaTrayOrder.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerLojaTrayOrder.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerLojaTrayOrder.insert: boolean;
begin

end;

function TControllerLojaTrayOrder.LastModified: TDateTime;
Var
  LcQry : TSTQuery;
begin
  LcQry := GeraQuery;
  with LcQry do
  Begin
    Active := False;
    sql.Add(concat(
              'select Max(lto.modified) hora ',
              'from tb_loja_tray_order lto '
    ));
    Active := True;
    FetchAll;
    Result := StrToDateTimeDef(FieldByNAme('hora').AsString,Now);
  End;
end;

function TControllerLojaTrayOrder.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerLojaTrayOrder.update: boolean;
begin

end;

end.
