unit ControllerService;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblProduto, prm_service;

Type
  TListService = TObjectList<TProduto>;
  TControllerService = Class(TControllerBase)
  private
    FParametros: TPrmService;
    procedure setFParametros(const Value: TPrmService);

  public
    Registro : TProduto;
    Lista : TListService;
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
    property Parametros : TPrmService read FParametros write setFParametros;
  End;

implementation

{ ControllerCfgEtiqueta}

function TControllerService.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerService.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TProduto.Create;
  FParametros := TPrmService.Create;
  Lista := TListService.Create;
end;

function TControllerService.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerService.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerService.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerService.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'PRO_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerService.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerService.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TProduto;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        ' SELECT PRO.*, PRC.PRC_VL_VDA ' +
        '   FROM TB_PRODUTO PRO ' +
        '   JOIN TB_PRECO PRC ON PRC.PRC_CODPRO = PRO.PRO_CODIGO ' +
        '  WHERE PRO.PRO_TIPO = ''S'' ' +
        '    AND PRC.PRC_CODTPR = 1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND PRO.PRO_CODIGO = :PRO_CODIGO';
        ParamByName('PRO_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND PRO.PRO_DESCRICAO LIKE :PRO_DESCRICAO';
        ParamByName('PRO_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      if FParametros.FieldName.Ativo <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND PRO.PRO_ATIVO = :PRO_ATIVO';
        ParamByName('PRO_ATIVO').AsString := FParametros.FieldName.Ativo;
      end;

      SQL.Text := SQL.Text + ' ORDER BY PRO.PRO_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TProduto.Create;
        get(Lc_Qry, LITem);

        LITem.PrecoVenda := FieldByName('PRC_VL_VDA').AsFloat;

        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerService.setFParametros(const Value: TPrmService);
begin
  FParametros := Value;
end;

procedure TControllerService.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerService.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

