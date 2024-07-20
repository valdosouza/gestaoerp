unit ControllerAnnotation;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblAnnotation, Generics.Collections,Md5,  STQuery;

Type
  TListaAnnotation = TObjectList<TAnnotation>;

  TControllerAnnotation = Class(TControllerBase)

  private

  public
    Registro : TAnnotation;
    Lista : TListaAnnotation;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
    procedure getList;
  End;

  implementation
{ ControllerAnnotation }



procedure TControllerAnnotation.clear;
begin
  clearObj(Registro);
end;

constructor TControllerAnnotation.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAnnotation.Create;
  Lista := TListaAnnotation.Create;
end;

function TControllerAnnotation.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerAnnotation.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerAnnotation.insert: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ANNOTATION');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerAnnotation.save: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ANNOTATION');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerAnnotation.update: boolean;
begin
  try
    UpdateObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerAnnotation.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerAnnotation.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
procedure TControllerAnnotation.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TAnnotation;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_ANNOTATION ',
                     'WHERE (LINK_ID1 =:LINK_ID1) ',
                     'and (IDENTIFY =:IDENTIFY ) '
          ));
      ParamByName('LINK_ID1').AsInteger := Registro.Link1;
      ParamByName('IDENTIFY').AsString := Registro.Identificar;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TAnnotation.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

end.


