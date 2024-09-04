unit ControllerObservacao;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblObservacao, prm_note;

Type
  TListaObservacao = TObjectList<TObservacao>;
  TControllerObservacao = Class(TControllerBase)
  private
    FParametros: TPrmNote;
    procedure setFParametros(const Value: TPrmNote);

  public
    Registro : TObservacao;
    Lista : TListaObservacao;
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
    property Parametros : TPrmNote read FParametros write setFParametros;
  End;

implementation

function TControllerObservacao.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerObservacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TObservacao.Create;
  FParametros := TPrmNote.Create;
  Lista := TListaObservacao.Create;
end;

function TControllerObservacao.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerObservacao.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerObservacao.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerObservacao.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'obs_codigo',0);
  SaveObj(Registro);
end;

function TControllerObservacao.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


procedure TControllerObservacao.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TObservacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM tb_observacao where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND OBS_CODIGO = :OBS_CODIGO';
        ParamByName('OBS_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND OBS_DESCRICAO LIKE :OBS_DESCRICAO';
        ParamByName('OBS_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TObservacao.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerObservacao.setFParametros(const Value: TPrmNote);
begin
  FParametros := Value;
end;

procedure TControllerObservacao.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerObservacao.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

