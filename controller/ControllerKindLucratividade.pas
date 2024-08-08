unit ControllerKindLucratividade;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblKindLucratividade, prm_kind_profitability;

Type
  TListaLucratividade= TObjectList<TKindLucratividade>;
  TControllerKindLucratividade = Class(TControllerBase)
  private
    FParametros: TPrmkindProfitability;
    procedure setFParametros(const Value: TPrmkindProfitability);
  public
    Registro : TKindLucratividade;
    Lista : TListaLucratividade;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
    Function GetcargoVendedor : Integer;
    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmkindProfitability read FParametros write setFParametros;

  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerKindLucratividade.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerKindLucratividade.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TKindLucratividade.Create;
  Lista := TListaLucratividade.Create;
  Parametros := TPrmkindProfitability.Create;
end;

function TControllerKindLucratividade.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerKindLucratividade.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerKindLucratividade.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'id',0);
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerKindLucratividade.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerKindLucratividade.replace: boolean;
begin
  Result := True;
  replaceObj(Registro);
end;

function TControllerKindLucratividade.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'id',0);
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerKindLucratividade.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TKindLucratividade;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_KIND_LUCRATIVIDADE WHERE 1=1';

      if Parametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ID = :ID';
        ParamByName('ID').AsInteger := Parametros.FieldName.Codigo;
      end;

      if Parametros.FieldName.descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DESCRIPTION LIKE :DESCRIPTION';
        ParamByName('DESCRIPTION').AsString := Concat('%',Parametros.FieldName.descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TKindLucratividade.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerKindLucratividade.setFParametros(const Value: TPrmkindProfitability);
begin
  FParametros := Value;
end;

function TControllerKindLucratividade.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerKindLucratividade.getById;
begin
  _getByKey(Registro);
end;

function TControllerKindLucratividade.GetcargoVendedor: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select * ',
                     'from TB_KIND_LUCRATIVIDADE ',
                     'where 1=1 '
                     ));

      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        REsult := FieldByName('CRG_CODIGO').AsInteger;
      End
      else
      BEgin
        Registro.codigo := 0;
        Registro.Descricao :=  'VENDEDOR';
        Self.insert;
        REsult := Registro.Codigo;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerKindLucratividade.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TKindLucratividade;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CARGO '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TKindLucratividade.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
