unit ControllerPetOrder;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPetOrder ,Un_MSg,Generics.Collections,ControllerPedido,ControllerNotaFiscal,ControllerPet;

Type
  TListaPetOrder = TObjectList<TPetOrder>;

  TControllerPetOrder = Class(TControllerBase)

  private

  public
    Registro : TPetOrder;
    Lista : TListaPetOrder;
    Pet : TControllerPEt;
    Pedido : TControllerPedido;
    NotaFiscal : TControllerNotaFiscal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;

  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerPetOrder.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPetOrder.Create;
  Lista := TListaPetOrder.Create;
  Pet := TControllerPEt.create(Self);
  Pedido := TControllerPedido.create(Self);
  NotaFiscal := TControllerNotaFiscal.create(Self);

end;

function TControllerPetOrder.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPetOrder.Destroy;
begin
  Pet.DisposeOf;
  Pedido.DisposeOf;
  NotaFiscal.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPetOrder.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPetOrder.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPetOrder.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPetOrder.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPetOrder.getById;
begin
  _getByKey(Registro);
end;



function TControllerPetOrder.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPetOrder;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PET_ORDER '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPetOrder.Create;
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
