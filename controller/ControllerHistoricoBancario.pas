unit ControllerHistoricoBancario;

interface

Uses SysUtils,classes,tblHistoricoBancario,STQuery,Forms,controllerBase,
    System.Generics.Collections;

Type
  //nome da classe de entidade
  TListHistoricoBancario = TObjectList<THistoricoBancario>;

  TControllerHistoricoBancario = Class(TControllerBase)
  private

  public
    Registro : THistoricoBancario;
    Lista : TListHistoricoBancario;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function getIdByDescription(value:String):Integer;
    procedure getlist;
    procedure getById;
    function update:Boolean;
  End;

implementation


constructor TControllerHistoricoBancario.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := THistoricoBancario.Create;
  Lista     := TListHistoricoBancario.Create;
end;

destructor TControllerHistoricoBancario.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

procedure TControllerHistoricoBancario.getById;
begin
  _getByKey(Registro);
end;

function TControllerHistoricoBancario.getIdByDescription(value:String):Integer;
Begin

End;

procedure TControllerHistoricoBancario.getlist;
var
  Lc_Qry : TSTQuery;
  LcLista : THistoricoBancario;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_HISTBANCARIO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := THistoricoBancario.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerHistoricoBancario.update:Boolean;
begin
  try
    updateObj(Registro);
    result := TRue;
  except
    result := False;
  end;
end;

end.
