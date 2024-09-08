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
    property Parametros : TPrmCfop read FParametros write setFParametros;
  End;

  implementation
{ ControllerCfgEtiqueta}

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
    Registro.Codigo := getNextByField(Registro,'cge_natureza',0);
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
      SQL.Text := ' SELECT * FROM TB_NATUREZA where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND NAT_CODIGO = :NAT_CODIGO';
        ParamByName('NAT_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND NAT_DESCRICAO LIKE :NAT_DESCRICAO';
        ParamByName('NAT_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

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

end.

