unit ControllerCidade;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCidade, prm_city;

Type
  TListaCidade = TObjectList<TCidade>;

  TControllerCidade = Class(TControllerBase)

  private
    FParametros: TPrmCidade;
    procedure setFParametros(const Value: TPrmCidade);
  public
    Registro : TCidade;
    Lista : TListaCidade;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function Buscacodigo(IBGE:Integer; Descricao,UF:String):Integer;
    function Clear:Boolean;
    function Search:Boolean;
    property Parametros : TPrmCidade read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerCidade.Buscacodigo(IBGE:Integer; Descricao,UF:String): Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
      Begin
      if (IBGE > 0) then
        Begin
        SQL.Add('select CDD_CODIGO FROM TB_CIDADE WHERE CDD_IBGE=:CDD_IBGE');
        ParamByName('CDD_IBGE').AsInteger := IBGE;
        end
      else
        Begin
        SQL.Add('select CDD_CODIGO '+
                'FROM TB_CIDADE '+
                'WHERE CDD_DESCRICAO=:CDD_DESCRICAO AND CDD_UF =:CDD_UF');
        ParamByName('CDD_DESCRICAO').AsString := Descricao;
        ParamByName('CDD_UF').AsString := UF;
        end;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('CDD_CODIGO').AsInteger
      else
        Result := 4004;
      end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCidade.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCidade.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCidade.Create;
  Lista := TListaCidade.Create;
  FParametros := TPrmCidade.Create;
end;

function TControllerCidade.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerCidade.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerCidade.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CIDADE');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerCidade.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerCidade.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CIDADE');
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;


function TControllerCidade.Search: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TCidade;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_CIDADE WHERE 1=1';

      if FParametros.FieldName.IBGE > 0 then
      begin
        SQL.Text := SQL.Text + ' AND CDD_IBGE = :CDD_IBGE';
        ParamByName('CDD_IBGE').AsInteger := FParametros.FieldName.IBGE;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND CDD_DESCRICAO LIKE :CDD_DESCRICAO';
        ParamByName('CDD_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.Estado <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND CDD_UF = :CDD_UF';
        ParamByName('CDD_UF').AsString := FParametros.FieldName.Estado;
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCidade.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCidade.setFParametros(const Value: TPrmCidade);
begin
  FParametros := Value;
end;

function TControllerCidade.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerCidade.getById;
begin
  _getByKey(Registro);
end;

function TControllerCidade.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TCidade;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CIDADE '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TCidade.Create;
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
