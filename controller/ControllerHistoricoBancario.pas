unit ControllerHistoricoBancario;

interface

Uses SysUtils,classes,tblHistoricoBancario,STQuery,Forms,controllerBase,
    System.Generics.Collections, prm_historico_bancario, FireDac.Stan.Param;

Type
  //nome da classe de entidade
  TListHistoricoBancario = TObjectList<THistoricoBancario>;

  TControllerHistoricoBancario = Class(TControllerBase)
  private
    FParametros: TPrmHistoricoBancario;
    procedure setFParametros(const Value: TPrmHistoricoBancario);

  public
    Registro : THistoricoBancario;
    Lista : TListHistoricoBancario;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getIdByDescription(value:String):Integer;
    procedure getlist;
    procedure getById;
    function update:Boolean;
    procedure search;
    procedure clear;
    procedure save;
    procedure insert;
    procedure delete;
    property Parametros : TPrmHistoricoBancario read FParametros write setFParametros;
  End;

implementation


procedure TControllerHistoricoBancario.clear;
begin
  clearObj(Registro);
end;

constructor TControllerHistoricoBancario.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := THistoricoBancario.Create;
  Lista     := TListHistoricoBancario.Create;
  FParametros := TPrmHistoricoBancario.Create;
end;

procedure TControllerHistoricoBancario.delete;
begin
  deleteObj(Registro);
end;

destructor TControllerHistoricoBancario.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  inherited;
end;

procedure TControllerHistoricoBancario.getById;
begin
  _getByKey(Registro);
end;

function TControllerHistoricoBancario.getIdByDescription(value:String):Integer;
Begin
  result := 0;
End;

procedure TControllerHistoricoBancario.getlist;
var
  Lc_Qry : TSTQuery;
  LcLista : THistoricoBancario;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_HISTBANCARIO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := THistoricoBancario.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerHistoricoBancario.insert;
begin
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_HISTBANCARIO');
  insertObj(Registro);
end;

procedure TControllerHistoricoBancario.save;
begin
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_HISTBANCARIO');
  SaveObj(Registro);
end;

procedure TControllerHistoricoBancario.search;
var
  Lc_Qry : TSTQuery;
  LcLista : THistoricoBancario;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_HISTBANCARIO ',
                'WHERE HTB_CODIGO IS NOT NULL '
      ));
      if FParametros.FieldName.Codigo > 0 then
        sql.add(' AND HTB_CODIGO =:HTB_CODIGO ');

      if FParametros.FieldName.Descricao <> EmptyStr then
        sql.add(' AND HTB_CODIGO like :HTB_CODIGO ');

      if FParametros.FieldName.Codigo > 0 then
        ParamByName('HTB_CODIGO').AsInteger := FParametros.FieldName.Codigo;

      if FParametros.FieldName.Descricao <> EmptyStr then
        ParamByName('HTB_DESCRICAO').AsString := FParametros.FieldName.Descricao;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := THistoricoBancario.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerHistoricoBancario.setFParametros(
  const Value: TPrmHistoricoBancario);
begin
  FParametros := Value;
end;

function TControllerHistoricoBancario.update:Boolean;
begin
  try
    updateObj(Registro);
    result := TRue;
  except
    result := False;
  end;
end;

end.
