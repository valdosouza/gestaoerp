unit ControllerIfoodCustomer;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodCustomer ,Un_MSg,Generics.Collections;

Type
  TListaIfoodCustomer = TObjectList<TIfoodCustomer>;

  TControllerIfoodCustomer = Class(TControllerBase)

  private

  public
    Registro : TIfoodCustomer;
    Lista : TListaIfoodCustomer;
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

procedure TControllerIfoodCustomer.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerIfoodCustomer.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TIfoodCustomer.Create;
  Lista := TListaIfoodCustomer.Create;
end;

function TControllerIfoodCustomer.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodCustomer.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerIfoodCustomer.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodCustomer.replace: boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerIfoodCustomer.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodCustomer.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodCustomer.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodCustomer;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_IFOOD_CUSTOMER '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodCustomer.Create;
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

