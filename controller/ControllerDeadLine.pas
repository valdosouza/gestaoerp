unit ControllerDeadLine;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblDeadLine, prm_dead_line;

Type
  TLisTDeadLine = TObjectList<TDeadLine>;
  TControllerDeadLine = Class(TControllerBase)
  private
    FParametros: TPrmDeadLine;
    procedure setFParametros(const Value: TPrmDeadLine);

  public
    Registro : TDeadLine;
    Lista : TLisTDeadLine;
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
    property Parametros : TPrmDeadLine read FParametros write setFParametros;
  End;

implementation

{ ControllerDeadLine}

function TControllerDeadLine.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerDeadLine.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDeadLine.Create;
  FParametros := TPrmDeadLine.Create;
  Lista := TLisTDeadLine.Create;
end;

function TControllerDeadLine.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDeadLine.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerDeadLine.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerDeadLine.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := generator('GN_PRAZO');//getNextByField(Registro,'PRZ_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerDeadLine.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerDeadLine.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TDeadLine;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_PRAZO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND PRZ_CODIGO = :PRZ_CODIGO';
        ParamByName('PRZ_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND PRZ_PRAZO LIKE :PRZ_PRAZO';
        ParamByName('PRZ_PRAZO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY PRZ_PRAZO';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TDeadLine.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerDeadLine.setFParametros(const Value: TPrmDeadLine);
begin
  FParametros := Value;
end;

procedure TControllerDeadLine.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerDeadLine.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

