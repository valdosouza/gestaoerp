unit ControllerCfgEtiqueta;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCfgEtiqueta, prm_configtag;

Type
  TListaCfgEtiqueta = TObjectList<TCfgEtiqueta>;
  TControllerCfgEtiqueta = Class(TControllerBase)
  private
    FParametros: TPrmConfigTag;
    procedure setFParametros(const Value: TPrmConfigTag);

  public
    Registro : TCfgEtiqueta;
    Lista : TListaCfgEtiqueta;
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
    property Parametros : TPrmConfigTag read FParametros write setFParametros;
  End;

  implementation
{ ControllerCfgEtiqueta}

function TControllerCfgEtiqueta.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCfgEtiqueta.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCfgEtiqueta.Create;
  FParametros := TPrmConfigTag.Create;
  Lista := TListaCfgEtiqueta.Create;
end;

function TControllerCfgEtiqueta.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCfgEtiqueta.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerCfgEtiqueta.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCfgEtiqueta.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'cge_codigo',0);
  SaveObj(Registro);
end;

function TControllerCfgEtiqueta.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


procedure TControllerCfgEtiqueta.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCfgEtiqueta;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM tb_cfg_etiqueta where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND cge_codigo = :cge_codigo';
        ParamByName('cge_codigo').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND cge_descricao LIKE :cge_descricao';
        ParamByName('cge_descricao').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCfgEtiqueta.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCfgEtiqueta.setFParametros(const Value: TPrmConfigTag);
begin
  FParametros := Value;
end;

procedure TControllerCfgEtiqueta.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCfgEtiqueta.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

