unit ControllerSalesOrigin;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblSalesOrigin, prm_Sales_Origin;

Type
  TListSalesOrigin = TObjectList<TSalesOrigin>;
  TControllerSalesOrigin = Class(TControllerBase)
  private
    FParametros: TPrmSalesOrigin;
    procedure setFParametros(const Value: TPrmSalesOrigin);

  public
    Registro : TSalesOrigin;
    Lista : TListSalesOrigin;
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
    property Parametros : TPrmSalesOrigin read FParametros write setFParametros;
  End;

implementation

function TControllerSalesOrigin.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerSalesOrigin.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSalesOrigin.Create;
  FParametros := TPrmSalesOrigin.Create;
  Lista := TListSalesOrigin.Create;
end;

function TControllerSalesOrigin.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerSalesOrigin.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerSalesOrigin.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerSalesOrigin.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_SALE_ORIGEN');
  SaveObj(Registro);
end;

function TControllerSalesOrigin.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerSalesOrigin.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TSalesOrigin;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_SALE_ORIGEN where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ID = :ID';
        ParamByName('ID').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DESCRIPTION LIKE :DESCRIPTION';
        ParamByName('DESCRIPTION').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY DESCRIPTION ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TSalesOrigin.Create;
        get(Lc_Qry, LITem);

        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerSalesOrigin.setFParametros(const Value: TPrmSalesOrigin);
begin
  FParametros := Value;
end;

procedure TControllerSalesOrigin.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerSalesOrigin.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

