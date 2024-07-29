unit ControllerRecibo;

interface

uses ControllerBase,tblrecibo, System.Classes, System.SysUtils, STQuery,
  prm_receipt, System.Generics.Collections, FireDac.Stan.Param;

type
  TListaRecibo = TObjectList<TRecibo>;

  TControllerRecibo = Class(TControllerBase)
    private
    FParametros: TPrmReceipt;
    procedure setFParametros(const Value: TPrmReceipt);

    public
    Registro : TRecibo;
    Lista : TListaRecibo;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insert:Boolean;
    function Update:Boolean;
    function Delete:Boolean;
    procedure getById;
    procedure clear;
    procedure Search;
    function VerificaNumRecibo:Boolean;
    property Parametros : TPrmReceipt read FParametros write setFParametros;
  End;
implementation

{ TControllerRecibo }

procedure TControllerRecibo.clear;
begin
  clearObj(Registro);
  clearObj(FParametros.FieldName);
end;

constructor TControllerRecibo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRecibo.create;
  Lista := TListaRecibo.Create();
  Parametros := TPrmReceipt.Create;
end;

destructor TControllerRecibo.Destroy;
begin
  FreeAndNil(FParametros);
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  inherited;
end;

function TControllerRecibo.Delete: Boolean;
begin
  Result := True;
  try
    DeleteObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerRecibo.getById;
begin
  _getByKey(Registro);
end;

function TControllerRecibo.insert: Boolean;
begin
  Result := True;
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_RECIBO');
  try
    insertObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerRecibo.salva: boolean;
begin
  Result := True;
  if registro.Codigo = 0 then
    registro.Codigo := Generator('GN_RECIBO');
  try
    SaveObj(Registro);
  except
    Result := False;
  end;
end;

procedure TControllerRecibo.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TRecibo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_RECIBO '));

      IF Parametros.FieldName.Numero > 0 THEN
        sql.add(' AND REC_NUMERO = :rec_numero ');

      IF Parametros.FieldName.Valor > 0 THEN
        sql.add(' AND REC_VALOR = :REC_VALOR ');

      if Parametros.Periodo then
        sql.add(' and REC_DATA BETWEEN :Dat_ini and :dat_fim ');

      if Parametros.FieldName.Emitente <> '' then
        sql.add(' and REC_EMITENTE like :REC_EMITENTE ')
      else
      if Parametros.FieldName.Sacado <> '' then
        sql.add(' and REC_SACADO like :REC_SACADO ');

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TRecibo.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRecibo.setFParametros(const Value: TPrmReceipt);
begin
  FParametros := Value;
end;

function TControllerRecibo.Update: Boolean;
begin
  Result := True;
  try
    UpdateObj(Registro);
  except
    Result := False;
  end;
end;

function TControllerRecibo.VerificaNumRecibo: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'SELECT rec_codigo ',
                'FROM tb_recibo    ',
                'where rec_numero = :rec_numero ',
                ' and rec_codigo<>:rec_codigo '

      ));
      ParamByName('rec_numero').AsInteger :=  Registro.Numero;
      ParamByName('rec_codigo').AsInteger :=  Registro.Codigo;
      Active:=true;
      FetchAll;
      Result := (RecordCount > 0);
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

end.
