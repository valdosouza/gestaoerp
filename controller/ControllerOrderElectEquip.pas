unit ControllerOrderElectEquip;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblElectEquip ,Un_MSg,Generics.Collections;

Type

  TControllerOrderElectEquip = Class(TControllerBase)

  private

  public
    Registro : TElectEquip;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerOrderElectEquip.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TElectEquip.Create;
end;

function TControllerOrderElectEquip.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerOrderElectEquip.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerOrderElectEquip.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ELECT_EQUIP');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerOrderElectEquip.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ELECT_EQUIP');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerOrderElectEquip.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerOrderElectEquip.getById;
begin
  _getByKey(Registro);
end;

function TControllerOrderElectEquip.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TElectEquip;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ELECT_EQUIP '));
      Active := True;
      FetchAll;
      First;
      while not eof do
      Begin
        LITem := TElectEquip.Create;
        get(Lc_Qry,LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
