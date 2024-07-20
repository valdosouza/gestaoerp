unit ControllerContractChaves;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblContractChaves ,Un_MSg,Generics.Collections;

Type
  TListaContratoChaves = TObjectList<TContractChaves>;

  TControllerContractChaves = Class(TControllerBase)

  private



  public
    Registro : TContractChaves;
    Lista : TListaContratoChaves;
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
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;



constructor TControllerContractChaves.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TContractChaves.Create;
  Lista := TListaContratoChaves.Create;
end;

function TControllerContractChaves.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerContractChaves.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;



function TControllerContractChaves.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CONTRACT_CHAVES');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContractChaves.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerContractChaves.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerContractChaves.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CONTRACT_CHAVES');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContractChaves.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerContractChaves.getById;
begin
  _getByKey(Registro);
end;


function TControllerContractChaves.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TContractChaves;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
              'SELECT * ',
              'FROM TB_CONTRACT_CHAVES ',
              'WHERE TB_CONTRACT_ID =:TB_CONTRACT_ID '
      ));
      ParamByName('TB_CONTRACT_ID').AsInteger := Registro.Contrato;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TContractChaves.Create;
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
