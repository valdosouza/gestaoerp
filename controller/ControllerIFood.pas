unit ControllerIFood;


interface
uses Classes, SysUtils,ControllerBase, tblIFood,STQuery,
     Generics.Defaults, Generics.Collections;

Type

  TControllerIFood = Class(TControllerBase)
  private

  public
    Registro : TIFood;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert:boolean;
    function delete:boolean;
    function getByKey:Boolean;
    function save:Boolean;
    procedure postRefreshToken;
    function  getRefreshToken:String;
  End;

implementation

{ TControllerIFood }

constructor TControllerIFood.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIFood.Create;
end;


function TControllerIFood.delete: boolean;
begin
  deleteObj(Registro);
end;

destructor TControllerIFood.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerIFood.getByKey: Boolean;
begin
  _getByKey(Registro);
end;


function TControllerIFood.getRefreshToken: String;
Var
  Lc_Qry : TSTQuery;
begin
  Result := '';
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
            'select REFRESH_TOKEN ',
            'FROM tb_ifood ',
            'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      Active := True;
      First;
      Result := FieldByname('REFRESH_TOKEN').asString;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerIFood.insert: boolean;
begin
  try
    SAVEObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


procedure TControllerIFood.postRefreshToken;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
            'UPDATE tb_ifood SET ',
            ' REFRESH_TOKEN =:REFRESH_TOKEN ',
            'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) '
      ));
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ParamByName('REFRESH_TOKEN').AsString := Registro.RefreshToken;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerIFood.save: Boolean;
begin
  SaveObj(Registro);
end;

end.
