unit ControllerCategory;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCategory, prm_category;

Type
  TListaCategory = TObjectList<TCategory>;
  TControllerCategory = Class(TControllerBase)
  private
    FParametros: TPrmCategory;
    procedure setFParametros(const Value: TPrmCategory);

  public
    Registro : TCategory;
    Lista : TListaCategory;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function ProximoCodigo: integer;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmCategory read FParametros write setFParametros;
  End;

implementation

{ ControllerCategory}

function TControllerCategory.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCategory.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCategory.Create;
  FParametros := TPrmCategory.Create;
  Lista := TListaCategory.Create;
end;

function TControllerCategory.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCategory.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerCategory.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCategory.ProximoCodigo: integer;
begin
  Result := getNextByField(Registro,'ID',0);
end;

function TControllerCategory.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'ID',0);
  SaveObj(Registro);
end;

function TControllerCategory.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerCategory.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCategory;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_CATEGORY WHERE 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ID = :ID';
        ParamByName('ID').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DESCRIPTION LIKE :DESCRIPTION';
        ParamByName('DESCRIPTION').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.Institute > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TB_INSTITUTE_ID = :TB_INSTITUTE_ID';
        ParamByName('TB_INSTITUTE_ID').AsInteger := FParametros.FieldName.Institute;
      end;

      SQL.Text := SQL.Text + ' ORDER BY POSIT_LEVEL';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCategory.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCategory.setFParametros(const Value: TPrmCategory);
begin
  FParametros := Value;
end;

procedure TControllerCategory.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCategory.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

