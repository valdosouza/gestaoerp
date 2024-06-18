unit ControllerContractOrder;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblContractOrder ,Un_MSg,Generics.Collections, Vcl.StdCtrls,
      ControllerContract;

Type
  TListaContratoOrder = TObjectList<TContractOrder>;

  TControllerContractOrder = Class(TControllerBase)

  private

  public
    Registro : TContractOrder;
    Lista : TListaContratoOrder;
    Contrato : TControllerContract;
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

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;


constructor TControllerContractOrder.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TContractOrder.Create;
  Contrato := TControllerContract.create(self);
  Lista := TListaContratoOrder.Create;
end;

function TControllerContractOrder.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerContractOrder.Destroy;
begin
  Contrato.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerContractOrder.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContractOrder.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerContractOrder.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerContractOrder.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContractOrder.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerContractOrder.getById;
begin
  _getByKey(Registro);
end;


function TControllerContractOrder.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TContractOrder;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CONTRACT '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TContractOrder.Create;
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
