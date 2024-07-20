unit ControllerInternet;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblInternet ,Un_MSg,Generics.Collections;

Type
  TControllerInternet = Class(TControllerBase)

  private

  public
    Registro : TInternet;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure getFirst;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function replace:boolean;
    function save:boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerInternet.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInternet.Create;
end;

function TControllerInternet.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerInternet.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerInternet.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_INTERNET');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerInternet.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerInternet.save: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_INTERNET');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerInternet.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerInternet.getFirst;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_INTERNET '));
      Active := True;
      FetchAll;
      exist := recordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;



end.
