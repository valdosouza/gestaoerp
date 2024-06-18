unit ControllerVendedor;


interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblVendedor ,Un_MSg,Generics.Collections;

Type
  TListaVendedor = TObjectList<TVendedor>;
  TControllerVendedor = Class(TControllerBase)
  private

  public
    Registro : TVendedor;
    Lista : TListaVendedor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    function replace:boolean;
    function migra:boolean;
    function getList:Boolean;
    function deleteByItemPedido:Boolean;
  End;

implementation

constructor TControllerVendedor.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TVendedor.Create;
  Lista := TListaVendedor.Create;
end;

function TControllerVendedor.deleteByItemPedido: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'DELETE  ',
              'FROM TB_VENDEDOR ',
              'WHERE VEN_CODITF =:VEN_CODITF ',
              ' AND VEN_TERMINAL =:VEN_TERMINAL '
              ));
      ParamByName('VEN_CODITF').AsInteger := Registro.ItemPedido;
      ParamByName('VEN_TERMINAL').AsInteger := Registro.Terminal;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerVendedor.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerVendedor.replace: boolean;
begin
  replaceObj(Registro);
end;

procedure TControllerVendedor.getById;
begin
  _getByKey(Registro);
end;

function TControllerVendedor.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TVendedor;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT * ',
              'FROM TB_VENDEDOR ',
              'WHERE VEN_CODITF is not null '
              ));
      if Registro.ItemPedido > 0 then
        sql.add(' and (VEN_CODITF =:VEN_CODITF) ');

      if Registro.Terminal > 0 then
        sql.add(' AND VEN_TERMINAL =:VEN_TERMINAL ');

      if Registro.ItemPedido > 0 then
        ParamByName('VEN_CODITF').AsInteger := Registro.ItemPedido;

      if Registro.Terminal > 0 then
        ParamByName('VEN_TERMINAL').AsInteger := Registro.Terminal;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TVendedor.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerVendedor.migra: boolean;
begin
  Try
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

end.
