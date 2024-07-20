unit ControllerContato;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblContato,  System.Generics.Collections;
Type
  TListContato = TObjectList<TContato>;

  TControllerContato = Class(TControllerBase)


  private

  public
    Registro : TContato;
    Lista : TListContato ;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    Function getList:Boolean;
  End;

implementation

{ ControllerContato }

constructor TControllerContato.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TContato.Create;
  Lista := TListContato.Create;
end;


destructor TControllerContato.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerContato.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerContato.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerContato.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerContato.getByKey: Boolean;
begin
end;

function TControllerContato.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TContato;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'Select * ',
                'from tb_contato c '
          ));
      Active := True;

      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TContato.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

end.

