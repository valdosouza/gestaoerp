unit ControllerTaxRelievesIcms;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblTaxRelievesIcms, prm_tax_relieves_icms;

Type
  TListTaxRelievesIcms = TObjectList<TTaxRelievesIcms>;
  TControllerTaxRelievesIcms = Class(TControllerBase)
  private
    FParametros: TPrmTaxRelievesIcms;
    procedure setFParametros(const Value: TPrmTaxRelievesIcms);

  public
    Registro : TTaxRelievesIcms;
    Lista : TListTaxRelievesIcms;
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
    property Parametros : TPrmTaxRelievesIcms read FParametros write setFParametros;
  End;

implementation

function TControllerTaxRelievesIcms.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerTaxRelievesIcms.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxRelievesIcms.Create;
  FParametros := TPrmTaxRelievesIcms.Create;
  Lista := TListTaxRelievesIcms.Create;
end;

function TControllerTaxRelievesIcms.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTaxRelievesIcms.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerTaxRelievesIcms.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerTaxRelievesIcms.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'DSI_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerTaxRelievesIcms.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerTaxRelievesIcms.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxRelievesIcms;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_DESONERA_ICMS where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND DSI_CODIGO = :DSI_CODIGO';
        ParamByName('DSI_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DSI_DESCRICAO LIKE :DSI_DESCRICAO';
        ParamByName('DSI_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY DSI_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTaxRelievesIcms.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTaxRelievesIcms.setFParametros(const Value: TPrmTaxRelievesIcms);
begin
  FParametros := Value;
end;

procedure TControllerTaxRelievesIcms.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerTaxRelievesIcms.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

