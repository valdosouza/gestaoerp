unit ControllerInterface;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblInterface ,Un_MSg,Generics.Collections,EncdDecd,synacode;

Type
  TListaInterface = TObjectList<TInterface>;

  TControllerInterface = Class(TControllerBase)

  private

  public
    Registro : TInterface;
    Lista : TListaInterface;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

constructor TControllerInterface.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInterface.Create;
  Lista := TListaInterface.Create;
end;

function TControllerInterface.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerInterface.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerInterface.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_INTERFACE');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerInterface.replace: boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TInterface;
begin
  ReplaceObj(Registro);
end;

function TControllerInterface.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_INTERFACE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerInterface.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerInterface.getById;
begin
  _getByKey(Registro);
end;

function TControllerInterface.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TInterface;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_INTERFACE '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TInterface.Create;
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
