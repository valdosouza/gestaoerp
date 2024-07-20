unit ControllerLojaTray;


interface
uses Classes, SysUtils,ControllerBase,
      tblLojaTray,STQuery,
       Generics.Defaults, Generics.Collections;

Type

  TControllerLojaTray = Class(TControllerBase)
  private

  public
    Registro : TLojaTray;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert:boolean;
    function save:boolean;
    function delete:Boolean;
    function deleteById:Boolean;
    function getByKey:Boolean;
    Function GetIDbyWeb:Integer;
    Function GetbyID:Integer;
    procedure Clear;
  End;

implementation

{ TControllerLojaTray }

procedure TControllerLojaTray.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerLojaTray.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TLojaTray.Create;
end;


function TControllerLojaTray.delete: Boolean;
begin
  deleteObj(Registro);
end;

function TControllerLojaTray.deleteById: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(CONCAT(
                'DELETE ',
                'FROM TB_LOJA_TRAY ',
                'WHERE (TABELA =:TABELA)',
                ' AND (ID=:ID)'
        ));
      ParamByName('TABELA').AsString := Registro.Tabela;
      ParamByName('ID').AsInteger := Registro.Codigo;
      ExecSQL;
      Result := True;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerLojaTray.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerLojaTray.GetbyID: Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(CONCAT(
                'SELECT  * ',
                'FROM TB_LOJA_TRAY ',
                'WHERE (TABELA =:TABELA)',
                ' AND (ID=:ID)'
        ));
      ParamByName('TABELA').AsString := Registro.Tabela;
      ParamByName('ID').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerLojaTray.getByKey: Boolean;
begin
  _getByKey(Registro);
end;

function TControllerLojaTray.GetIDbyWeb: Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(CONCAT(
                'SELECT  ID ',
                'FROM TB_LOJA_TRAY ',
                'WHERE (TABELA =:TABELA)',
                ' AND (WEB_ID=:WEB_ID)'
        ));
      ParamByName('TABELA').AsString := Registro.Tabela;
      ParamByName('WEB_ID').AsInteger := Registro.WebID;
      Active := True;
      FetchAll;
      Result := FieldByName('ID').AsInteger;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerLojaTray.insert: boolean;
begin
  try
    SAVEObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerLojaTray.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := True;
  Except
    Result := false;
  end;
end;

end.
