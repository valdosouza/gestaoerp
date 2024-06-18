unit ControllerTerminal;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblTerminal ,Un_MSg,Generics.Collections;

Type
  TListaCargo = TObjectList<TTerminal>;

  TControllerTerminal = Class(TControllerBase)
  private

  public
    Registro : TTerminal;
    Lista : TListaCargo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    function liberaMenu:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

constructor TControllerTerminal.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTerminal.Create;
  Lista := TListaCargo.Create;
end;

function TControllerTerminal.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTerminal.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerTerminal.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_TERMINAL');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerTerminal.liberaMenu: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_TERMINAL '));
      Active := True;
      FetchAll;
      Result := (RecordCount > 1);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerTerminal.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerTerminal.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_TERMINAL');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerTerminal.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerTerminal.getById;
begin
  _getByKey(Registro);
end;

function TControllerTerminal.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TTerminal;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_TERMINAL '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TTerminal.Create;
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
