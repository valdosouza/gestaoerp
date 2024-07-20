unit ControllerOperInterface;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblOperInterface ,Un_MSg,Generics.Collections,EncdDecd,synacode;

Type
  TListaOperInterface = TObjectList<TOperInterface>;

  TControllerOperInterface = Class(TControllerBase)

  private

  public
    Registro : TOperInterface;
    Lista : TListaOperInterface;
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

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerOperInterface.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOperInterface.Create;
  Lista := TListaOperInterface.Create;
end;

function TControllerOperInterface.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerOperInterface.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerOperInterface.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_OPER_INTERFACE');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerOperInterface.replace: boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TOperInterface;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'UPDATE OR INSERT INTO TB_OPER_INTERFACE (OPF_CODIGO, OPF_DESCRICAO, OPF_IMAGEM) ',
                ' VALUES (:OPF_CODIGO, :OPF_DESCRICAO,:OPF_IMAGEM) ',
                ' MATCHING (OPF_CODIGO);'
      ));
      ParamByName('OPF_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('OPF_DESCRICAO').AsAnsiString := Registro.Descricao;
      ParamByName('OPF_IMAGEM').value := DecodeBase64 (Registro.Imagem);
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerOperInterface.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_OPER_INTERFACE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerOperInterface.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerOperInterface.getById;
begin
  _getByKey(Registro);
end;

function TControllerOperInterface.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TOperInterface;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_OPER_INTERFACE '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TOperInterface.Create;
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
