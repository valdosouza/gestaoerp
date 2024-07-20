unit ControllerCrpItens;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblcrpitens ,Un_MSg,
      Generics.Collections, tblRestMenuHasIngredient, ObjRestMenuHasIngredient,
      ObjRestGRoupHasOptional ;

Type
  TListaCrpItens = TObjectList<TCrpItens>;

  TControllerCrpItens = Class(TControllerBase)
  private

  public
    Registro : TCrpItens;
    Lista : TListaCrpItens;
    ObjIngredientes : TObjRestMenuHasIngredient;
    ObjOptional : TObjRestGroupHasOptional;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insert:boolean;
    procedure getbyId;
    Function delete:boolean;
    procedure getList;
    function update:Boolean;
    procedure Clear;
    procedure FillDataRestIngredientes(itens: TCrpItens;ObjRestIngredient:TObjRestMenuHasIngredient; institutioWebId:Integer);
    procedure FillDataRestOptional(itens: TCrpItens;ObjRestOptional:TObjRestGroupHasOptional; institutioWebId:Integer);
  End;

implementation


procedure TControllerCrpItens.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerCrpItens.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCrpItens.Create;
  Lista := TListaCrpItens.create;
  ObjIngredientes := TObjRestMenuHasIngredient.create;
  ObjOptional := TObjRestGroupHasOptional.create;
end;

function TControllerCrpItens.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCrpItens.Destroy;
begin
  ObjOptional.DisposeOf;
  ObjIngredientes.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerCrpItens.FillDataRestIngredientes(itens: TCrpItens;
  ObjRestIngredient: TObjRestMenuHasIngredient; institutioWebId: Integer);
begin
  ObjRestIngredient.Menu                          := itens.Sabor;
  ObjRestIngredient.Grupo                         := itens.Grupo;
  ObjRestIngredient.Ingredientes.Estabelecimento  := institutioWebId;
  ObjRestIngredient.Ingredientes.Cardapio         := 0;
  ObjRestIngredient.Ingredientes.Ingrediente      := itens.CodigoProduto;
  ObjRestIngredient.Ingredientes.Quantidade       := itens.Qtde;
  ObjRestIngredient.Ingredientes.Ativo            := 'S';

end;

procedure TControllerCrpItens.FillDataRestOptional(itens: TCrpItens;
  ObjRestOptional: TObjRestGroupHasOptional; institutioWebId: Integer);
begin

  ObjRestOptional.Estabelecimento           := institutioWebId;
  ObjRestOptional.Opcional.Estabelecimento  := institutioWebId;
  ObjRestOptional.Opcional.Grupo            := itens.Grupo;
  ObjRestOptional.Opcional.Produto          := itens.CodigoProduto;
  ObjRestOptional.Opcional.Quantidade       := itens.Qtde;
  ObjRestOptional.Opcional.Preco            := itens.Valor;

end;

function TControllerCrpItens.salva: boolean;
begin
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_CRP_ITENS');
  SaveObj(Registro);
end;

function TControllerCrpItens.update:Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

procedure TControllerCrpItens.getById;
Var
  Lc_Qry : TSTQuery;
  LcItem : TCrpItens;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select * ',
                'from tb_crp_itens i ',
                'where i.CPI_TIPO =:CPI_TIPO  ',
                'AND CPI_CODIGO =:CPI_CODIGO  '
      ));
      ParamByName('CPI_TIPO').AsSTring   := Registro.Tipo;
      ParamByName('CPI_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if (exist) then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCrpItens.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TCrpItens;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT * ',
              'FROM TB_CRP_ITENS ',
              'WHERE CPI_CODIGO IS NOT NULL '
      ));

      if registro.Tipo <> '' then
        sql.add(' and ( CPI_TIPO =:CPI_TIPO ) ');

      if registro.CodigoProduto > 0 then
        sql.add(' and ( CPI_CODPRO =:CPI_CODPRO ) ');

      if registro.Grupo > 0 then
        sql.add(' and ( CPI_CODGRP =:CPI_CODGRP ) ');

      if registro.Sabor <> '' then
        sql.add(' and ( CPI_SABOR =:CPI_SABOR ) ');

      if FORderby = '' then
        sql.add(' ORDER BY CPI_CODIGO ')
      else
        sql.add( FORderby );

      if registro.Tipo <> '' then
        ParamByName('CPI_TIPO').AsString := Registro.Tipo;

      if registro.Grupo > 0 then
        ParamByName('CPI_CODGRP').AsInteger := Registro.Grupo;

      if registro.CodigoProduto > 0 then
        ParamByName('CPI_CODPRO').AsInteger := Registro.CodigoProduto;

      if registro.Sabor <> '' then
        ParamByName('CPI_SABOR').AsString := Registro.Sabor;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TCrpItens.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerCrpItens.insert: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_CRP_ITENS');
    SaveObj(Registro);
    Result := true;
  except
    Result := false;
  End;
end;

end.
