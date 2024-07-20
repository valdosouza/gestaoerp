unit ControllerNcmControle;


interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblNcmControle ,Un_MSg,Generics.Collections;

Type
  TListaNcmControle = TObjectList<TNcmControle>;

  TControllerNcmControle = Class(TControllerBase)

  private

  public
    Registro : TNcmControle;
    Lista : TListaNcmControle;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerNcmControle.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNcmControle.Create;
  Lista := TListaNcmControle.Create;
end;

function TControllerNcmControle.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerNcmControle.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerNcmControle.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerNcmControle.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerNcmControle.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerNcmControle.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerNcmControle.getById;
begin
  _getByKey(Registro);
end;

function TControllerNcmControle.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TNcmControle;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_NCM '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TNcmControle.Create;
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
