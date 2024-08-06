unit ControllerUf;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tbluf, prm_uf;

Type
  TListaUf = TObjectList<TUF>;

  TControllerUf = Class(TControllerBase)

  private
    FParametros: TPrmuf;
    procedure setFParametros(const Value: TPrmuf);

  protected

  public
    Registro : TUf;
    Lista : TListaUf;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function BuscaCodigo(sigla:String):Integer;
    procedure clear;
    procedure Search;
    property Parametros : TPrmuf read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerUf.BuscaCodigo(sigla: String): Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select UFE_CODIGO FROM TB_UF WHERE UFE_SIGLA=:UFE_SIGLA');
      ParamByName('UFE_SIGLA').AsString := Sigla;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('UFE_CODIGO').AsInteger
      else
        Result := 41;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerUf.clear;
begin
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerUf.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TUf.Create;
  Lista := TListaUf.Create;
  Parametros := TPrmUF.Create;
end;

function TControllerUf.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerUf.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerUf.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_Uf');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerUf.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerUf.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_Uf');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerUf.Search;
var
  Lc_Qry : TSTQuery;
  LITem : Tuf;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_UF WHERE 1=1';

      if Parametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND UFE_CODIGO LIKE :UFE_CODIGO';
        ParamByName('UFE_CODIGO').AsInteger := Parametros.FieldName.Codigo;
      end;

      if Parametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND UFE_DESCRICAO LIKE :UFE_DESCRICAO';
        ParamByName('UFE_DESCRICAO').AsString := Concat('%',Parametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TUF.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerUf.setFParametros(const Value: TPrmuf);
begin
  FParametros := Value;
end;

function TControllerUf.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerUf.getById;
begin
  _getByKey(Registro);
end;

function TControllerUf.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TUf;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_UF '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TUf.Create;
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
