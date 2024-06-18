unit ControllerIfoodOrderTotal;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrderTotal ,Un_MSg,Generics.Collections;

Type
  TListaIfoodOrderTotal = TObjectList<TIfoodOrderTotal>;

  TControllerIfoodOrderTotal = Class(TControllerBase)

  private

  public
    Registro : TIfoodOrderTotal;
    Lista : TListaIfoodOrderTotal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function insert:boolean;
    function replace:Boolean;
    function update:boolean;
    Function delete:boolean;
    function getList: Boolean;
    procedure Clear;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerIfoodOrderTotal.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerIfoodOrderTotal.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodOrderTotal.Create;
  Lista := TListaIfoodOrderTotal.Create;
end;

function TControllerIfoodOrderTotal.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrderTotal.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerIfoodOrderTotal.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrderTotal.replace: Boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerIfoodOrderTotal.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrderTotal.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodOrderTotal.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrderTotal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_ORDER_TOTAL '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrderTotal.Create;
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
