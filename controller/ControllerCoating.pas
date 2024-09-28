unit ControllerCoating;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCoating, prm_coating;

Type
  TListCoating = TObjectList<TCoating>;
  TControllerCoating = Class(TControllerBase)
  private
    FParametros: TPrmCoating;
    procedure setFParametros(const Value: TPrmCoating);

  public
    Registro : TCoating;
    Lista : TListCoating;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmCoating read FParametros write setFParametros;
  End;

implementation

{ ControllerCoating}

function TControllerCoating.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCoating.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCoating.Create;
  FParametros := TPrmCoating.Create;
  Lista := TListCoating.Create;
end;

function TControllerCoating.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCoating.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerCoating.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCoating.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'RVT_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerCoating.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerCoating.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCoating;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_REVESTIMENTO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND RVT_CODIGO = :RVT_CODIGO';
        ParamByName('RVT_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND RVT_DESCRICAO LIKE :RVT_DESCRICAO';
        ParamByName('RVT_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCoating.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCoating.setFParametros(const Value: TPrmCoating);
begin
  FParametros := Value;
end;

procedure TControllerCoating.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCoating.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

