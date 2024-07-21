unit ControllerObsNota;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      Un_MSg,System.Generics.Collections, tblObsNota,FireDAC.Stan.Param;

Type
  TListaObsNota = TObjectList<TObsNota>;

  TControllerObsNota = Class(TControllerBase)

  private

  public
    Registro : TObsNota;
    Lista : TListaObsNota;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure clear;
  End;

implementation

{ TControllerObsNota }

procedure TControllerObsNota.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerObsNota.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TObsNota.create;
  Lista := TListaObsNota.Create;
end;

function TControllerObsNota.delete: boolean;
begin

end;

destructor TControllerObsNota.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerObsNota.getbyId;
begin

end;

function TControllerObsNota.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TObsNota;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT * ',
                  'FROM TB_OBS_NFE ',
                  'WHERE OBN_CODNFL =:NFL_CODIGO '
      ));
      ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TObsNota.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerObsNota.insert: boolean;
begin
  try
    Result := TRue;
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_OBS_NFE');
    insertObj(Registro);
  Except
    Result := FAlse;
  end;
end;

function TControllerObsNota.migra: Boolean;
begin
  InsertObj(Registro);
end;

function TControllerObsNota.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_OBS_NFE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerObsNota.update: boolean;
begin

end;

end.
