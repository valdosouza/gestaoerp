unit ControllerTaxIcmsNr;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, TblTaxIcmsNr, prm_TaxIcmsNr;

Type
  TListaTaxIcmsNr = TObjectList<TTaxIcmsNr>;
  TControllerTaxIcmsNr = Class(TControllerBase)
  private
    FParametros: TPrmTaxIcmsNr;
    procedure setFParametros(const Value: TPrmTaxIcmsNr);
  public
    Registro : TTaxIcmsNr;
    Lista : TListaTaxIcmsNr;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function getCodigoLista(Descricao: String): Integer;
    function getDescricaoLista(Codigo: Integer): String;

    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
    Function GetTaxIcmsNrVendedor : Integer;
    procedure Clear;
    procedure Search;
    property Parametros : TPrmTaxIcmsNr read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerTaxIcmsNr.Clear;
begin
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerTaxIcmsNr.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxIcmsNr.Create;
  Lista := TListaTaxIcmsNr.Create;
  FParametros := TPrmTaxIcmsNr.Create;
end;

function TControllerTaxIcmsNr.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerTaxIcmsNr.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerTaxIcmsNr.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'TBI_CODIGO',0);
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerTaxIcmsNr.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerTaxIcmsNr.replace: boolean;
begin
  Result := True;
  replaceObj(Registro);
end;

function TControllerTaxIcmsNr.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'TBI_CODIGO',0);
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerTaxIcmsNr.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxIcmsNr;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_TRIB_ICMS_NR where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TBI_CODIGO = :TBI_CODIGO';
        ParamByName('TBI_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND TBI_DESCRICAO LIKE :TBI_DESCRICAO';
        ParamByName('TBI_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY TBI_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTaxIcmsNr.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTaxIcmsNr.setFParametros(const Value: TPrmTaxIcmsNr);
begin
  FParametros := Value;
end;

function TControllerTaxIcmsNr.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerTaxIcmsNr.getById;
begin
  _getByKey(Registro);
end;

function TControllerTaxIcmsNr.GetTaxIcmsNrVendedor: Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.Add(concat('select CRG_CODIGO ',
                     'from TB_TaxIcmsNr ',
                     'where ( CRG_DESCRICAO =:CRG_DESCRICAO ) '
                     ));
      ParamByName('CRG_DESCRICAO').AsString := 'VENDEDOR';
      Active := True;
      First;
      if RecordCount > 0 then
      Begin
        REsult := FieldByName('CRG_CODIGO').AsInteger;
      End
      else
      BEgin
        Registro.codigo := 0;
        Registro.Descricao :=  'VENDEDOR';
        Self.insert;
        REsult := Registro.Codigo;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerTaxIcmsNr.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxIcmsNr;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_TaxIcmsNr '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TTaxIcmsNr.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerTaxIcmsNr.getCodigoLista(Descricao: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(Lista.Count) do
  begin
    if Lista[i].Descricao = Descricao then
    begin
      Result := Lista[i].Codigo;
      Break;
    end;
  end;
end;

function TControllerTaxIcmsNr.getDescricaoLista(Codigo: Integer): String;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to Pred(Lista.Count) do
  begin
    if Lista[i].Codigo = Codigo then
    begin
      Result := Lista[i].Descricao;
      Break;
    end;
  end;
end;

end.
