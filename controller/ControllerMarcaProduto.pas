unit ControllerMarcaProduto;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      tblMarcaProduto ,Un_MSg,System.Generics.Collections,FireDAC.Stan.Param,
      prm_product_brand;

Type
  TListaMarcaProduto  = TObjectList<TMarcaProduto>;
  TControllerMarcaProduto = Class(TControllerBase)

  private
    FParametros: TPrmProductBrand;
    procedure setFParametros(const Value: TPrmProductBrand);
  protected

  public
    Registro : TMarcaProduto;
    Lista : TListaMarcaProduto;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyDescricao;
    procedure getIdAutoByDesc;
    procedure getbyId;
    function insert:boolean;
    function replace:boolean;
    function update:boolean;
    Function delete:boolean;
    Function getList:boolean;
    procedure clear;
    function GetCNPJFactory(MarcaID:Integer):String;

    procedure Search;
    property Parametros : TPrmProductBrand read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerMarcaProduto.clear;
begin
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerMarcaProduto.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMarcaProduto.Create;
  Lista := TListaMarcaProduto.create;
  FParametros := TPrmProductBrand.Create;
end;

function TControllerMarcaProduto.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerMarcaProduto.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerMarcaProduto.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MARCAPRODUTO');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerMarcaProduto.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerMarcaProduto.replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;

end;

function TControllerMarcaProduto.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MARCAPRODUTO');
  SaveObj(Registro);
end;


procedure TControllerMarcaProduto.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TMarcaProduto;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_MARCA_PRODUTO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND MRC_CODIGO = :MRC_CODIGO';
        ParamByName('MRC_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND MRC_DESCRICAO LIKE :MRC_DESCRICAO';
        ParamByName('MRC_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TMarcaProduto.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMarcaProduto.setFParametros(const Value: TPrmProductBrand);
begin
  FParametros := Value;
end;

function TControllerMarcaProduto.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerMarcaProduto.getbyDescricao;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_MARCA_PRODUTO '+
              'WHERE ( UPPER( MRC_DESCRICAO) =:MRC_DESCRICAO ) ');
      ParamByName('MRC_DESCRICAO').AsString := UpperCase( Registro.Descricao );
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0 ;
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMarcaProduto.getById;
begin
  _getByKey(Registro);
  if Trim(Registro.Descricao) = '' then
    Registro.Descricao := 'N�o informada';
end;


function TControllerMarcaProduto.GetCNPJFactory(MarcaID: Integer): String;
Var
  Lc_Qry:TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select e.emp_cnpj ',
                'from tb_marca_produto m ',
                '  inner join tb_empresa e ',
                '  on (e.emp_codigo = m.mrc_codfab) ',
                'where m.mrc_codigo =:mrc_codigo '
      ));
      ParamByName('MRC_CODIGO').AsInteger := MarcaID;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
        Result := FieldByName('emp_cnpj').AsString
      else
        Result := '';
    end;
  Finally
    FinalizaQuery(Lc_Qry);
    DisposeOf;
  End;
end;

procedure TControllerMarcaProduto.getIdAutoByDesc;
begin
  getbyDescricao;
  if  not exist then
  Begin
    Registro.Codigo := 0;
    //'ESSE CAMPO � PRENCHIDO NA ENTRADA E ELE QUE VAI SER PREENCHIDO AUTOMATICAMENTE
    //Registro.Descricao := ''
    Registro.Fabrica := 0;
    insert;
  End;
end;

function TControllerMarcaProduto.getList: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TMarcaProduto;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_MARCA_PRODUTO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TMarcaProduto.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;


end.
