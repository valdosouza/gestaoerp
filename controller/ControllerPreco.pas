unit ControllerPreco;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_funcoes, tblPreco ,Un_MSg,
      Generics.Collections;

Type
  TListaPreco = TObjectList<TPreco>;

  TControllerPreco = Class(TControllerBase)

  private
    TipoCalculoPreco : String;

  public
    Registro : TPreco;
    Lista : TListaPreco;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure DefineTipoCalculoPreco;
    function salva:boolean;
    function replace:Boolean;
    function migra:Boolean;
    function Insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteByID:boolean;
    Function deleteByTabela:boolean;
    procedure getbyId;
    Function getIdByTabelaProduto:Integer;
    procedure getByTabelaProduto;
    procedure getByCodigo;
    procedure getList;
    function CalcularPrecoPelaMargemLucro(Fc_Vl_Custo,Fc_Aq_Margem:real):Real;
    procedure clear;

  End;

implementation

uses UN_Sistema, Un_Regra_Negocio;

function TControllerPreco.CalcularPrecoPelaMargemLucro(Fc_Vl_Custo,  Fc_Aq_Margem: real): Real;
begin
  Result := 0;
  If (Fc_Vl_Custo > 0) then
  Begin
    if (TipoCalculoPreco = '1') then
    Begin
      //Preço de Custo / [( 100 - Taxa de Lucro ) / 100 ]
      Result := Fc_Vl_Custo / (( 100 - Fc_Aq_Margem) /100);
    end
    else
    Begin
      //Preço de Custo + (Preço de Custo * Taxa de Lucro)
      Result := Fc_Vl_Custo + (Fc_Vl_Custo * (Fc_Aq_Margem/100));
    end;
  end;
end;

procedure TControllerPreco.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerPreco.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPreco.Create;
  Lista := TListaPreco.Create;
end;


procedure TControllerPreco.DefineTipoCalculoPreco;
begin
  TipoCalculoPreco := Fc_Tb_Geral('L','PRO_G_CALC_MRG_LUCRO','1');
end;

destructor TControllerPreco.Destroy;
begin
  Registro.disposeOf;
  Lista.disposeOf;
  inherited;
end;


function TControllerPreco.salva: boolean;
begin
  Try
    Registro.Codigo := getIdByTabelaProduto;
    if Registro.Codigo = 0 then
    Begin
      Registro.Codigo := Generator('GN_PRECO');
      insertObj(Registro);
    End
    else
    Begin
      updateObj(Registro);
    End;
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPreco.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;


function TControllerPreco.Insert: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRECO');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;


function TControllerPreco.migra: Boolean;
begin
  SaveObj(Registro);
end;

function TControllerPreco.replace: Boolean;
begin
  Try
    Registro.Codigo := getIdByTabelaProduto;
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_PRECO');
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPreco.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPreco.deleteByID: boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('DELETE  '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODIGO=:PRC_CODIGO )');
      ParamByName('PRC_CODIGO').AsInteger := Registro.Codigo;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerPreco.deleteByTabela: boolean;
VAr
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('DELETE  '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODTPR=:PRC_CODTPR )');
      ParamByName('PRC_CODTPR').AsInteger := Registro.CodigoTabela;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerPreco.getById;
begin
  _getByKey(Registro);
end;

Function TControllerPreco.getIdByTabelaProduto:Integer;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT PRC_CODIGO '+
              'FROM TB_Preco '+
              '  inner join tb_tabela_preco '+
              '  on (prc_codtpr = tpr_codigo) '+
              '  inner join tb_produto '+
              '  on (pro_codigo = prc_codpro) '+
              'WHERE ( PRC_CODTPR=:TPR_CODIGO ) AND ( PRC_CODPRO =:PRO_CODIGO )');
      ParamByName('TPR_CODIGO').AsInteger := Registro.CodigoTabela;
      ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      if RecordCount > 0 then
        Result := FieldByName('PRC_CODIGO').AsInteger
      else
        Result := 0;
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

procedure TControllerPreco.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TPreco;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_PRECO where (PRC_CODIGO > 0 ) ');
      if Registro.CodigoProduto > 0 then
        sql.add(' AND (PRC_CODPRO=:PRO_CODIGO) ');
      if Registro.CodigoTabela > 0 then
        sql.add(' AND (PRC_CODTPR=:TPR_CODIGO) ');

      sql.add(' ORDER BY PRC_CODTPR, prc_codpro ');
      //Passagem de Parametro
      if Registro.CodigoProduto > 0 then
        ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      if Registro.CodigoTabela > 0 then
        ParamByName('TPR_CODIGO').AsInteger := Registro.CodigoTabela;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TPreco.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPreco.getByTabelaProduto;
VAr
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODTPR=:TPR_CODIGO ) AND ( PRC_CODPRO =:PRO_CODIGO )');
      ParamByName('TPR_CODIGO').AsInteger := Registro.CodigoTabela;
      ParamByName('PRO_CODIGO').AsInteger := Registro.CodigoProduto;
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0;
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


procedure TControllerPreco.getByCodigo;
VAr
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_Preco '+
              'WHERE ( PRC_CODIGO=:PRC_CODIGO )');
      ParamByName('PRC_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

end.
