unit ControllerNegocio;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblNegocio, prm_business;

Type
  TListaNegocio = TObjectList<TNegocio>;

  TControllerNegocio = Class(TControllerBase)
  private
    FParametros: TPrmBusiness;
    procedure setFParametros(const Value: TPrmBusiness);

  public
    Registro : TNegocio;
    Lista : TListaNegocio;
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
    property Parametros : TPrmBusiness read FParametros write setFParametros;
  End;

  implementation
{ ControllerCfgEtiqueta}

function TControllerNegocio.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerNegocio.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNegocio.Create;
  FParametros := TPrmBusiness.Create;
  Lista := TListaNegocio.Create;
end;

function TControllerNegocio.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerNegocio.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerNegocio.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerNegocio.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'neg_codigo',0);
  SaveObj(Registro);
end;

function TControllerNegocio.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerNegocio.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TNegocio;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM tb_negocio where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND NEG_CODIGO = :NEG_CODIGO';
        ParamByName('NEG_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NEG_DESCRICAO LIKE :NEG_DESCRICAO';
        ParamByName('NEG_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TNegocio.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerNegocio.setFParametros(const Value: TPrmBusiness);
begin
  FParametros := Value;
end;

procedure TControllerNegocio.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerNegocio.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

