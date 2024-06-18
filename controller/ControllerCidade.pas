unit ControllerCidade;

interface

uses STDatabase,Classes, STQuery,SysUtils,ControllerBase,
      tblCidade ,Un_MSg,Generics.Collections;

Type
  TListaCidade = TObjectList<TCidade>;

  TControllerCidade = Class(TControllerBase)

  private

  protected

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
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

function TControllerCidade.Buscacodigo(IBGE:Integer; Descricao,UF:String): Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
begin
  Try
    Lc_Qry := GeraQuery;
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
        ParamByName('CDD_DESCRICAO').AsAnsiString := Descricao;
        ParamByName('CDD_UF').AsAnsiString := UF;
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

constructor TControllerCidade.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCidade.Create;
  Lista := TListaCidade.Create;
end;

function TControllerCidade.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCidade.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerCidade.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CIDADE');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerCidade.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerCidade.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CIDADE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerCidade.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
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
  Try
    Lc_Qry := GeraQuery;
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
