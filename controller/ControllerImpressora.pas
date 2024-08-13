unit ControllerImpressora;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblImpressora, prm_printers;

Type
  TListaImpressora = TObjectList<TImpressora>;
  TControllerImpressora = Class(TControllerBase)
  private
    FParametros: TPrmPrinters;
    procedure setFParametros(const Value: TPrmPrinters);
  public
    Registro : TImpressora;
    Lista : TListaImpressora;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getCodigoLista(Descricao: String): Integer;
    function getDescLista(Codigo: Integer): String;

    function Clear:Boolean;
    function Search:Boolean;
    property Parametros : TPrmPrinters read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerImpressora.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerImpressora.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TImpressora.Create;
  Lista := TListaImpressora.Create;
  FParametros := TPrmPrinters.Create;
end;

function TControllerImpressora.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerImpressora.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Lista);
  FreeAndNil(Registro);
  inherited;
end;

function TControllerImpressora.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_IMPRESSORA');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerImpressora.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_IMPRESSORA');
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerImpressora.Search: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TImpressora;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_IMPRESSORA WHERE 1=1';

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND IMP_DESCRICAO LIKE :IMP_DESCRICAO';
        ParamByName('IMP_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TImpressora.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerImpressora.setFParametros(const Value: TPrmPrinters);
begin
  FParametros := Value;
end;

function TControllerImpressora.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerImpressora.getById;
begin
  _getByKey(Registro);
end;

function TControllerImpressora.getCodigoLista(Descricao: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pred(Lista.Count) do
  Begin
    if Lista[i].Descricao = Descricao then
    Begin
      Result := Lista[i].Codigo;
      Break;
    End;
  End;
end;

function TControllerImpressora.getDescLista(Codigo: Integer): String;
var
  i: Integer;
begin
  Result := EmptyStr;
  for i := 0 to Pred(Lista.Count) do
  Begin
    if Lista[i].Codigo = Codigo then
    Begin
      Result := Lista[i].Descricao;
      Break;
    End;
  End;
end;

end.
