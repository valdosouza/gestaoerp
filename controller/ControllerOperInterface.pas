unit ControllerOperInterface;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblOperInterface, prm_oper_interface;

Type
  TListaOperInterface = TObjectList<TOperInterface>;

  TControllerOperInterface = Class(TControllerBase)

  private
    FParametros: TPrm_Oper_Interface;
    procedure setFParametros(const Value: TPrm_Oper_Interface);
  public
    Registro : TOperInterface;
    Lista : TListaOperInterface;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
    function getCodigoLista(Descricao: String): Integer;
    function getDescLista(Codigo: Integer): String;
    procedure search;

    procedure clear;
    property Parametros : TPrm_Oper_Interface read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerOperInterface.clear;
begin
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerOperInterface.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TOperInterface.Create;
  Lista := TListaOperInterface.Create;
  FParametros := TPrm_Oper_Interface.Create;
end;

function TControllerOperInterface.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerOperInterface.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerOperInterface.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_OPER_INTERFACE');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerOperInterface.replace: boolean;
var
  Lc_Qry : TSTQuery;
  //LITem : TOperInterface;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'UPDATE OR INSERT INTO TB_OPER_INTERFACE (OPF_CODIGO, OPF_DESCRICAO, OPF_IMAGEM) ',
                ' VALUES (:OPF_CODIGO, :OPF_DESCRICAO,:OPF_IMAGEM) ',
                ' MATCHING (OPF_CODIGO);'
      ));
      ParamByName('OPF_CODIGO').AsInteger := Registro.Codigo;
      ParamByName('OPF_DESCRICAO').AsString := Registro.Descricao;
      //ParamByName('OPF_IMAGEM').value := DecodeBase64 (Registro.Imagem);
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerOperInterface.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_OPER_INTERFACE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerOperInterface.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerOperInterface.getById;
begin
  _getByKey(Registro);
end;

function TControllerOperInterface.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TOperInterface;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_OPER_INTERFACE '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TOperInterface.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerOperInterface.search;
var
  Lc_Qry : TSTQuery;
  LITem : TOperInterface;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      //--SQL.Text := 'SELECT OPF_CODIGO, OPF_DESCRICAO FROM TB_OPER_INTERFACE WHERE 1=1';
      SQL.Text := 'SELECT * FROM TB_OPER_INTERFACE WHERE 1=1';

      if Parametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND OPF_CODIGO = :OPF_CODIGO';
        ParamByName('OPF_CODIGO').AsInteger := Parametros.FieldName.Codigo;
      end;

      if Parametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND OPF_DESCRICAO LIKE :OPF_DESCRICAO';
        ParamByName('OPF_DESCRICAO').AsString := Concat('%',Parametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY OPF_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TOperInterface.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerOperInterface.setFParametros(
  const Value: TPrm_Oper_Interface);
begin
  FParametros := Value;
end;

function TControllerOperInterface.getCodigoLista(Descricao: String): Integer;
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

function TControllerOperInterface.getDescLista(Codigo: Integer): String;
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
