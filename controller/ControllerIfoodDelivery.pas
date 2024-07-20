unit ControllerIfoodDelivery;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodDelivery ,Un_MSg,Generics.Collections;

Type
  TListaIfoodDelivery = TObjectList<TIfoodDelivery>;

  TControllerIfoodDelivery = Class(TControllerBase)

  private

  public
    Registro : TIfoodDelivery;
    Lista : TListaIfoodDelivery;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    function replace:boolean;
    Function delete:boolean;
    function getList: Boolean;
    procedure Clear;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerIfoodDelivery.Clear;
begin
  clearObj(Registro);
  Lista.Clear;
end;

constructor TControllerIfoodDelivery.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodDelivery.Create;
  Lista := TListaIfoodDelivery.Create;
end;

function TControllerIfoodDelivery.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodDelivery.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerIfoodDelivery.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodDelivery.replace: boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerIfoodDelivery.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodDelivery.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodDelivery.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodDelivery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_DELIVERY '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodDelivery.Create;
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
