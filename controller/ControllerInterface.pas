unit ControllerInterface;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblInterface, prm_interface,
     ControllerMenus, ControllerOperInterface, ControllerItensIfc;

Type
  TListaInterface  = TObjectList<TInterface>;
  TControllerInterface = Class(TControllerBase)
  private
    FParametros: TPrmInterface;
    procedure setFParametros(const Value: TPrmInterface);
  public
    Registro : TInterface;
    Lista : TListaInterface;
    menus : TControllerMenus;
    operInterface : TControllerOperInterface;
    itensIfc : TControllerItensIfc;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;
    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmInterface read FParametros write setFParametros;
  End;

implementation

{ ControllerInterface }

function TControllerInterface.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerInterface.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInterface.Create;
  FParametros := TPrmInterface.Create;
  Lista := TListaInterface.Create;
  menus := TControllerMenus.Create(self);
  operInterface := TControllerOperInterface.Create(self);
  itensIfc := TControllerItensIfc.Create(self);
end;

function TControllerInterface.delete: boolean;
begin
  Result := True;
  Try
    deleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerInterface.Destroy;
begin
  Registro.DisposeOf;
  FParametros.DisposeOf;
  Lista.DisposeOf;
  menus.DisposeOf;
  operInterface.DisposeOf;
  itensIfc.DisposeOf;
  inherited;
end;

function TControllerInterface.insert: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerInterface.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_INTERFACE');
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerInterface.save: boolean;
begin
  Result := true;
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerInterface.setFParametros(const Value: TPrmInterface);
begin
  FParametros := Value;
end;

procedure TControllerInterface.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerInterface.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

procedure TControllerInterface.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TInterface;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_INTERFACE WHERE 1=1';

      if Parametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND IFC_CODIGO = :IFC_CODIGO';
        ParamByName('IFC_CODIGO').AsInteger := Parametros.FieldName.Codigo;
      end;

      if Parametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND IFC_DESCRICAO LIKE :IFC_DESCRICAO';
        ParamByName('IFC_DESCRICAO').AsString := Concat('%',Parametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TInterface.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

