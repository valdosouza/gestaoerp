unit ControllerPizzaria;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,tblProduto,
      ControllerPedido, ControllerRestaurante;

Type
  TControllerPizzaria = Class(TControllerBase)
  private

  public
    Pedido : TControllerPedido;
    Restaurante : TControllerRestaurante;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function getByDescricao(pProduto,pMedida,pGrupo:STring):TProduto;
    function getByCodigo(pCodigo:Integer):TProduto;
    function getMedidaAbreviatura(medidaID:Integer):String;
    function getByPhone(Numero,dddEstabelecimento:String ):Boolean;
  End;

implementation

{ ControllerPizzaria }

uses un_sistema,Un_Regra_Negocio, UnFunctions;

procedure TControllerPizzaria.Clear;
begin
  pedido.Clear;
  Restaurante.Clear;
end;

constructor TControllerPizzaria.Create(AOwner: TComponent);
begin
  inherited;
  Pedido := TControllerPedido.Create(Self);
  Restaurante := TControllerRestaurante.Create(Self);
end;

destructor TControllerPizzaria.Destroy;
begin
  Restaurante.disposeOf;
  Pedido.disposeOf;
  inherited;
end;

function TControllerPizzaria.getByPhone(Numero, dddEstabelecimento: String): Boolean;
var
  Lc_Aux : String;
begin
  Result := False;
  Numero := RemoveCaracterInformado(Numero, ['(',')','-',' ']);
  with pedido do
  Begin
    //5541999112072
    //Verifica se tem codigo de Pais
    if (Length(Numero) > 11 ) then
    Begin
      Lc_Aux := copy(Numero,1,2);
      if ( Lc_Aux = '55' ) then
      Begin
        Numero := Copy(Numero,3,11);
        Numero := Trim(Numero);
      End;
    End;
    //41999112072
    //Verifica se tem codigo de área
    if (Length(Numero) > 9 ) then
    Begin
      Lc_Aux := copy(Numero,1,2);
      if ( Lc_Aux = dddEstabelecimento ) then
      Begin
        Numero := Copy(Numero,3,9);
        Numero := Trim(Numero);
      End;
    End;

    //42999112072 ou 999112072
    Endereco.Registro.Fone := Numero;
    Endereco.getIdByFone;
    if ( Endereco.Registro.Codigo > 0 ) then
    Begin
      Cliente.Empresa.Registro.Codigo := Endereco.Registro.CodigoEmpresa;
      Cliente.Empresa.getById;
      Result := TRue;
    End;

  End;
end;

function TControllerPizzaria.getMedidaAbreviatura(medidaID: Integer): String;
var
  Lc_Qry: TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(Concat(
                'select m.med_abreviatura ',
                'from tb_medida m ',
                'WHERE MED_CODIGO=:MED_CODIGO '
//                'where m.med_descricao=:med_descricao ',
//                'and m.med_especial=:med_especial '
          ));
      ParamByName('MED_CODIGO').AsInteger := medidaID;
//      ParamByName('med_especial').AsString := pMedida;
//      ParamByName('grp_descricao').AsString := pGRupo;
      Active := True;
      Result := FieldByName('med_abreviatura').AsString;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerPizzaria.getByCodigo(pCodigo: Integer): TProduto;
var
  Lc_Qry: TSTQuery;
begin
  Try
    REsult := TProduto.Create;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(Concat(
                'SELECT P.* ',
                'FROM TB_PRODUTO P ',
                'WHERE P.PRO_CODIGO =:PRO_CODIGO '
          ));
      ParamByName('PRO_CODIGO').AsInteger:= pCodigo;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then
        get(Lc_Qry,REsult);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerPizzaria.getByDescricao(pProduto,pMedida,pGrupo:STring):TProduto;
var
  Lc_Qry: TSTQuery;
begin
  Try
    REsult := TProduto.Create;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(Concat(
                'SELECT P.* ',
                'FROM TB_PRODUTO P ',
                '  INNER JOIN TB_MEDIDA M ',
                '  ON (M.med_codigo = P.pro_codmed) ',
                '  INNER JOIN tb_grupos G ',
                '  ON (G.grp_codigo = P.pro_codgrp) ',
                'WHERE P.PRO_DESCRICAO =:PRO_DESCRICAO ',
                'AND M.med_descricao =:med_descricao ',
                'AND G.grp_descricao =:grp_descricao ',
                'AND PRO_ATIVO = ''S'' '
          ));
      ParamByName('PRO_DESCRICAO').AsString := pProduto;
      ParamByName('med_descricao').AsString := pMedida;
      ParamByName('grp_descricao').AsString := pGRupo;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then
        get(Lc_Qry,REsult);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
