unit ControllerSituation;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblSituacao, prm_situation;

Type
  TListaSituacao = TObjectList<TSituacao>;
  TControllerSituation = Class(TControllerBase)
  private
    FParametros: TPrmSituation;
    procedure setFParametros(const Value: TPrmSituation);

  public
    Registro : TSituacao;
    Lista : TListaSituacao;
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
    property Parametros : TPrmSituation read FParametros write setFParametros;
  End;

implementation

function TControllerSituation.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerSituation.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSituacao.Create;
  FParametros := TPrmSituation.Create;
  Lista := TListaSituacao.Create;
end;

function TControllerSituation.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerSituation.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerSituation.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerSituation.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'SIT_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerSituation.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerSituation.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TSituacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_SITUACAO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND SIT_CODIGO = :SIT_CODIGO';
        ParamByName('SIT_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND SIT_DESCRICAO LIKE :SIT_DESCRICAO';
        ParamByName('SIT_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.Modulo <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND SIT_MODULO = :SIT_MODULO';
        ParamByName('SIT_MODULO').AsString := FParametros.FieldName.Modulo;
      end;

      SQL.Text := SQL.Text + ' ORDER BY SIT_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TSituacao.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerSituation.setFParametros(const Value: TPrmSituation);
begin
  FParametros := Value;
end;

procedure TControllerSituation.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerSituation.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

