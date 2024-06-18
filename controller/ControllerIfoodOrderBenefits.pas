unit ControllerIfoodOrderBenefits;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblIfoodOrderBenefits ,Un_MSg,Generics.Collections;

Type
  TListaIfoodOrderBenefits = TObjectList<TIfoodOrderBenefits>;

  TControllerIfoodOrderBenefits = Class(TControllerBase)

  private

  public
    Registro : TIfoodOrderBenefits;
    Lista : TListaIfoodOrderBenefits;
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


procedure TControllerIfoodOrderBenefits.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerIfoodOrderBenefits.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TIfoodOrderBenefits.Create;
  Lista     := TListaIfoodOrderBenefits.Create;
end;

function TControllerIfoodOrderBenefits.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerIfoodOrderBenefits.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerIfoodOrderBenefits.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerIfoodOrderBenefits.replace: boolean;
begin
  Try
    ReplaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerIfoodOrderBenefits.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerIfoodOrderBenefits.getById;
begin
  _getByKey(Registro);
end;

function TControllerIfoodOrderBenefits.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TIfoodOrderBenefits;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_IFOOD_ORDER_BENEFITS ',
                'where (TB_IFOOD_ORDER_ID =:TB_IFOOD_ORDER_ID ) '
      ));
      ParambyName('TB_IFOOD_ORDER_ID').AsString := Registro.Ordem;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TIfoodOrderBenefits.Create;
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
