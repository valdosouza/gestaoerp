unit ControllerBanco;

interface

uses
  tblbanco,ControllerBase, System.Classes, STQuery, System.SysUtils,
  System.Generics.Collections, FireDAC.Stan.Param;

type
  TListBanco = TObjectList<TBanco>;

  TControllerBanco = Class(TcontrollerBase)
    private

    public
    Registro : TBanco;
    Lista : TListBanco;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getNumber(Codigo: Integer):Integer;
    procedure search;
    function getCodigoBancoLista(NumeroNome:String):Integer;
    function getNumeroNomeLista(CodigoBanco: Integer): String;
  End;

implementation

{ TControllerBanco }

constructor TControllerBanco.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TBanco.create;
  Lista := TListBanco.create;
end;

destructor TControllerBanco.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  inherited;
end;

function TControllerBanco.getCodigoBancoLista(NumeroNome: String): Integer;
Var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Lista.count -1 do
  Begin
    if Lista[I].NumeroNome = NumeroNome then
    Begin
      Result := Lista[I].Codigo;
      Break;
    End;
  End;
end;

function TControllerBanco.getNumeroNomeLista(CodigoBanco: Integer): String;
Var
  I:Integer;
begin
  Result := EmptyStr;
  for I := 0 to Lista.count -1 do
  Begin
    if Lista[I].Codigo = CodigoBanco then
    Begin
      Result := Lista[I].NumeroNome;
      Break;
    End;
  End;
end;

function TControllerBanco.getNumber(Codigo: Integer):Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
        'select emp_codigo, EMP_NUMBCO ',
        'from tb_empresa ',
        'where EMP_CODIGO =:EMP_CODIGO '
      ));
      ParamByName('EMP_CODIGO').AsInteger := Codigo;
      Active := True;
      FetchAll;
      Result := StrToIntDEf(FieldByName('EMP_NUMBCO').AsString,1);
    End;
  finally
    Lc_Qry.DisposeOf;
  end;
end;

procedure TControllerBanco.search;
var
  Lc_Qry : TSTQuery;
  LcItem : TBanco;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT ',
              'EMP_CODIGO,',
              'EMP_NOME,',
              'EMP_FANTASIA,',
              'EMP_CNPJ,',
              'EMP_INSC_EST,',
              'EMP_OBSERV,',
              'EMP_DT_CADASTRO,',
              'EMP_EMAIL,',
              'EMP_SITE,',
              'EMP_DT_FUNDA,',
              'EMP_NUMBCO,',
              'EMP_ATIVA,',
              'EMP_STATUS,',
              ' (EMP_NUMBCO || '' - '' || EMP_FANTASIA) NUMERO_NOME ',
              'FROM TB_EMPRESA ',
              'WHERE EMP_TIPO = 4 '
      ));

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcItem := TBanco.Create;
        get(Lc_qry,LcItem);
        //Camapo concatenada para facilitar o preenchimento da combo e depois a localizção do codigo
        LcItem.NumeroNome := concat(LcItem.Numero, ' - ', LcItem.ApelidoFantasia);
        Lista.add(LcItem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
