unit ControllerItensIfc;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblItensIfc ,Un_MSg,Generics.Collections,EncdDecd,synacode;

Type
  TListaItensIfc = TObjectList<TItensIfc>;

  TControllerItensIfc = Class(TControllerBase)

  private

  public
    Registro : TItensIfc;
    Lista : TListaItensIfc;
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

constructor TControllerItensIfc.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensIfc.Create;
  Lista := TListaItensIfc.Create;
end;

function TControllerItensIfc.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerItensIfc.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerItensIfc.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ITENS_IFC');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerItensIfc.replace: boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TItensIfc;
begin
  ReplaceObj(Registro);
end;

function TControllerItensIfc.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_ITENS_IFC');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerItensIfc.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerItensIfc.getById;
begin
  _getByKey(Registro);
end;

function TControllerItensIfc.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TItensIfc;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ITENS_IFC '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensIfc.Create;
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
