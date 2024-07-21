unit ControllerGeral;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblGeral ,Generics.Collections;


Type
  TListaGeral = TObjectList<TGeral>;

  TControllerGeral = Class(TControllerBase)
    Lista : TListaGeral;
  private

  public
    Registro : TGeral;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure getById;
    function salva:boolean;
    function migra:Boolean;
    function Seleciona: boolean;
    procedure getList;
  End;

implementation

{ TControllerGeral }

procedure TControllerGeral.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerGeral.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TGeral.Create;
  Lista := TListaGeral.Create;
end;

destructor TControllerGeral.Destroy;
begin
  Registro.DisposeOf;
  lista.DisposeOf;
  inherited;
end;

procedure TControllerGeral.getById;
begin
  _getByKey(Registro);
end;


procedure TControllerGeral.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TGeral;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_GERAL ',
                      'order by GRL_CODIGO '
                    ));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TGeral.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerGeral.migra: Boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerGeral.salva: boolean;
begin
  Result := True;
  TRy
    SaveObj(Registro);
  except
    Result := False;
  End;
end;

function TControllerGeral.Seleciona: boolean;
begin
  Result := True;
  REsult := existObj(Registro);
end;

end.
