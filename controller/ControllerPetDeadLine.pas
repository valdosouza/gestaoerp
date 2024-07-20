unit ControllerPetDeadLine;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPetDeadLine ,Un_MSg,Generics.Collections, Vcl.StdCtrls;

Type
  TListaPetDeadLine = TObjectList<TPetDeadLine>;

  TControllerPetDeadLine = Class(TControllerBase)

  private

  public
    Registro : TPetDeadLine;
    Lista : TListaPetDeadLine;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure Clear;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;


procedure TControllerPetDeadLine.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerPetDeadLine.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPetDeadLine.Create;
  Lista := TListaPetDeadLine.Create;
end;

function TControllerPetDeadLine.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPetDeadLine.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPetDeadLine.insert: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_PET_DEADLINE');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPetDeadLine.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPetDeadLine.salva: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_PET_DEADLINE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPetDeadLine.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPetDeadLine.getById;
begin
  _getByKey(Registro);
end;



function TControllerPetDeadLine.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPetDeadLine;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PET_DEADLINE ',
                      'WHERE TB_PET_ID =:TB_PET_ID '
      ));
      ParamByName('TB_PET_ID').AsInteger := Registro.Pet;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPetDeadLine.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
