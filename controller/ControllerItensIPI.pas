unit ControllerItensIPI;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblItensipi,    Generics.Collections,controllerProduto,FireDAC.Stan.Param;


Type
  TListaItemIPI = TObjectList<TItensIpi>;

  TControllerItensIPI = Class(TControllerBase)
    Lista: TListaItemIPI;
  private
    function nextCodigo:Integer;
  public
    Registro : TItensIpi;
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

function TControllerItensIPI.atualiza: boolean;
begin
  UpdateObj(Registro);
end;

constructor TControllerItensIPI.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensIPI.Create;
  Lista := TListaItemIPI.Create;
end;

function TControllerItensIPI.delete: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE ',
                      'FROM tb_itens_ipi ',
                      'WHERE IPI_CODITF=:ITF_CODIGO '));
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemNota;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

destructor TControllerItensIPI.Destroy;
begin
  FreeAndNil(Lista);
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerItensIPI.getByItemNota;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM tb_itens_ipi ',
                      'WHERE IPI_CODITF=:IPI_CODIGO '));
      ParamByName('IPI_CODIGO').AsInteger := Registro.ItemNota;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

procedure TControllerItensIPI.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TItensIPI;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM tb_itens_ipi ',
                     'WHERE IPI_CODIGO > 0 '
          ));
      if Registro.Nota > 0 then
        sql.add(' AND IPI_CODNFL=:NFL_CODIGO ');

      sql.add(' ORDER BY IPI_CODIGO ');

      if Registro.Nota > 0 then
        ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensIPI.Create;
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


function TControllerItensIPI.nextCodigo:Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT MAX(IPI_CODIGO) FROM TB_ITENS_IPI ' );
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

function TControllerItensIPI.insere: boolean;
begin
  Registro.Codigo := Generator('GN_ITENS_IPI'); //nextCodigo;
  InsertObj(Registro);
end;

function TControllerItensIPI.migra: Boolean;
begin
  InsertObj(Registro);
end;

function TControllerItensIPI.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
