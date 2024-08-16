unit ControllerMenus;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblMenus, prm_menus;

type
  TListMenus = TObjectList<TMenus>;

  TControllerMenus = Class(TcontrollerBase)
    private

    public
    Registro : TMenus;
    Lista : TListMenus;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure search;
    function getCodigoLista(Descricao: String): Integer;
    function getDescLista(Codigo: Integer): String;
  End;

implementation

{ TControllerMenus }

constructor TControllerMenus.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMenus.create;
  Lista := TListMenus.create;
end;

destructor TControllerMenus.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  inherited;
end;

function TControllerMenus.getCodigoLista(Descricao: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(Lista.Count) do
  Begin
    if Lista[i].Descricao = Descricao then
    Begin
      Result := Lista[i].Codigo;
      Break;
    End;
  End;
end;

function TControllerMenus.getDescLista(Codigo: Integer): String;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to Pred(Lista.Count) do
  Begin
    if Lista[i].Codigo = Codigo then
    Begin
      Result := Lista[i].Descricao;
      Break;
    End;
  End;
end;

procedure TControllerMenus.search;
var
  Lc_Qry : TSTQuery;
  LITem : TMenus;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_MENUS';
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMenus.Create;
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
