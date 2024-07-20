unit ControllerItensPIS;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      tblItenspis,
      System.Generics.Collections,controllerProduto;


Type
  TListaItemPIS = TObjectList<TItensPIS>;

  TControllerItensPIS = Class(TControllerBase)

  private
    function nextCodigo:Integer;
  public
    Registro : TItensPIS;
    Lista: TListaItemPIS;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    function atualiza:boolean;
    procedure getList;
    procedure getByItemNota;
    function delete:boolean;
  End;

implementation

uses Un_Regra_Negocio;

function TControllerItensPIS.atualiza: boolean;
begin
  UpdateObj(Registro);
end;

constructor TControllerItensPIS.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensPIS.Create;
  Lista := TListaItemPIS.Create;
end;

function TControllerItensPIS.delete: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE ',
                      'FROM tb_itens_pis ',
                      'WHERE PIS_CODITF=:ITF_CODIGO '));
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemNota;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

destructor TControllerItensPIS.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerItensPIS.getByItemNota;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_pis ',
                      'WHERE PIS_CODITF=:ITF_CODIGO '));
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemNota;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

procedure TControllerItensPIS.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TItensPIS;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_PIS ',
                      'WHERE PIS_CODNFL=:NFL_CODIGO ',
                      ' ORDER BY PIS_CODIGO '));

      ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensPIS.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerItensPIS.insere: boolean;
begin
  try
    Result := TRue;
    Registro.Codigo := Generator('GN_ITENS_PIS'); //nextCodigo;
    InsertObj(Registro);
  Except
    Result := FAlse;
  end;
end;

function TControllerItensPIS.nextCodigo: Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT MAX(PIS_CODIGO) FROM TB_ITENS_PIS ' );
      Active := True;
      fetchall;
      if recordcount > 0 then
        Result := FieldByName('MAX').AsInteger + 1
      else
        Result := 1;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerItensPIS.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
