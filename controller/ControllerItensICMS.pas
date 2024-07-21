unit ControllerItensICMS;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblItensicms ,  Generics.Collections,controllerProduto,FireDAC.Stan.Param;


Type
  TListaItemICMS = TObjectList<TItensIcms>;

  TControllerItensICMS = Class(TControllerBase)
    Lista: TListaItemICMS;
  private

    function nextCodigo:Integer;
  public
    Registro : TItensIcms;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:Boolean;
    function insere:boolean;
    function atualiza:boolean;
    procedure getList;
    procedure getByItemNota;
    function delete:boolean;

  End;

implementation

uses Un_Regra_Negocio;

function TControllerItensICMS.atualiza: boolean;
begin
  Result := true;
  UpdateObj(Registro);
end;

constructor TControllerItensICMS.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensICMS.Create;
  Lista := TListaItemICMS.Create;
end;

function TControllerItensICMS.delete: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE ',
                      'FROM tb_itens_icms ',
                      'WHERE ICM_CODITF=:ITF_CODIGO '));
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemNota;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

destructor TControllerItensICMS.Destroy;
begin
  Registro.DisposeOf;
  FreeAndNil(Lista);
  inherited;
end;

procedure TControllerItensICMS.getByItemNota;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_icms ',
                      'WHERE ICM_CODITF=:ITF_CODIGO '));
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

procedure TControllerItensICMS.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TItensICMS;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_icms ',
                      'WHERE ICM_CODIGO > 0 '
            ));
      if Registro.Nota > 0 then
        sql.add(' AND ICM_CODNFL=:NFL_CODIGO ');

      sql.add(' ORDER BY ICM_CODIGO ');

      if Registro.Nota > 0 then
        ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensICMS.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
      Close;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerItensICMS.nextCodigo:Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT MAX(ICM_CODIGO) FROM TB_ITENS_ICMS ' );
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

function TControllerItensICMS.insere: boolean;
begin
  Result := true;
  Registro.Codigo := Generator('GN_ITENS_ICMS');// nextCodigo;
  InsertObj(Registro);
end;

function TControllerItensICMS.migra: Boolean;
begin
  Result := true;
  InsertObj(Registro);
end;

function TControllerItensICMS.salva: boolean;
begin
  Result := true;
  SaveObj(Registro);
end;

end.
