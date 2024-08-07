unit ControllerGestaoWeb;

interface
uses System.Classes, System.SysUtils,ControllerBase,FireDAC.Stan.Param,
      tblGestaoweb,STQuery;

Type

  TControllerGestaoWeb = Class(TControllerBase)
  private
    function getNext:Integer;
  public
    Registro : TGestaoWeb;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert:boolean;
    function getByKey:Boolean;
    function getByWebID:Boolean;
    function setToExport:Boolean;
  End;

implementation

{ TControllerGestaoWeb }

constructor TControllerGestaoWeb.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TGestaoWeb.Create;
end;


destructor TControllerGestaoWeb.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerGestaoWeb.getByKey: Boolean;
begin
  Result := True;
  _getByKey(Registro);
end;

function TControllerGestaoWeb.getByWebID: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      SQL.Clear;
      SQL.Add(Concat(
                'Select * ',
                'FROM TB_GESTAO_WEB ',
                'WHERE (TABELA =:TABELA ) ',
                ' AND (WEB_ID =:WEB_ID) '
          ));
      ParamByName('TABELA').AsString := Registro.Tabela;
      ParamByName('WEB_ID').AsInteger := Registro.WebID;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerGestaoWeb.getNext: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      SQL.Clear;
      SQL.Add(Concat(
                'Select MAX(WEB_ID) MAX_WEB_ID  ',
                'FROM TB_GESTAO_WEB ',
                'WHERE (TABELA =:TABELA ) '
          ));
      ParamByName('TABELA').AsString := Registro.Tabela;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByName('MAX_WEB_ID').AsInteger + 1
      else
        Result := 1;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerGestaoWeb.insert: boolean;
begin
  Result := True;
  try
    Registro.WebID := getNext;
    insertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerGestaoWeb.setToExport: Boolean;
begin
  Result := True;
  _getByKey(Registro);
  if not exist then
  Begin
    insert;
  End;
end;

end.
