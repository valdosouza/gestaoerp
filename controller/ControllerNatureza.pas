unit ControllerNatureza;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblNatureza, prm_cfop;

Type
  TListaNatureza = TObjectList<TNatureza>;
  TControllerNatureza = Class(TControllerBase)
  private
    FParametros: TPrmCfop;
    procedure setFParametros(const Value: TPrmCfop);
  public
    Registro : TNatureza;
    Lista : TListaNatureza;

    const
      SENTIDO_ENTRADA = 'E';
      SENTIDO_SAIDA   = 'S';

      ALCADA_ESTADUAL = 'E';
      ALCADA_NACIONAL = 'N';
      ALCADA_EXTERIOR = 'X';

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;
    function Fc_BuscaCFOP(Pc_CFOP: String): Boolean;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmCfop read FParametros write setFParametros;
  End;

implementation

function TControllerNatureza.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerNatureza.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNatureza.Create;
  FParametros := TPrmCfop.Create;
  Lista := TListaNatureza.Create;
end;

function TControllerNatureza.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerNatureza.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerNatureza.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerNatureza.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'nat_codigo',0);
  SaveObj(Registro);
end;

function TControllerNatureza.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerNatureza.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TNatureza;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_NATUREZA WHERE NAT_CODIGO IS NOT NULL ';

      if FParametros.FieldName.Cfop <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NAT_CFOP = :NAT_CFOP';
        ParamByName('NAT_CFOP').AsString := FParametros.FieldName.Cfop
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NAT_DESCRICAO LIKE :NAT_DESCRICAO';
        ParamByName('NAT_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.Sentido <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NAT_SENTIDO = :NAT_SENTIDO';
        ParamByName('NAT_SENTIDO').AsString := FParametros.FieldName.Sentido;
      end;

      if FParametros.FieldName.Alcada <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NAT_ALCADA = :NAT_ALCADA';
        ParamByName('NAT_ALCADA').AsString := FParametros.FieldName.Alcada;
      end;

      if FParametros.FieldName.Ativo <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NAT_ATIVO = :NAT_ATIVO';
        ParamByName('NAT_ATIVO').AsString := FParametros.FieldName.Ativo;
      end;

      SQL.Text := SQL.Text + ' ORDER BY NAT_DESCRICAO';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TNatureza.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerNatureza.setFParametros(const Value: TPrmCfop);
begin
  FParametros := Value;
end;

procedure TControllerNatureza.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerNatureza.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

function TControllerNatureza.Fc_BuscaCFOP(Pc_CFOP: String): Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := False;
  Lc_Qry := GeraQuery;
  Try
    Lc_Qry.SQL.Text := ' SELECT 1 FROM TB_NATUREZA WHERE NAT_CFOP = :NAT_CFOP ';
    Lc_Qry.ParamByName('NAT_CFOP').AsString := Pc_CFOP;
    Lc_Qry.Active := True;

    if not Lc_Qry.IsEmpty then
      Result := True;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

