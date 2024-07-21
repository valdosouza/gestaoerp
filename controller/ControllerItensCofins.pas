unit ControllerItensCofins;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      tblItensCofins,   System.Generics.Collections,controllerProduto,FireDAC.Stan.Param;


Type
  TListaItemCFS = TObjectList<TItensCofins>;

  TControllerItensCofins = Class(TControllerBase)

  private
    function nextCodigo:Integer;
  public
    Registro : TItensCofins;
    Lista: TListaItemCFS;
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

function TControllerItensCofins.atualiza: boolean;
begin
  UpdateObj(Registro);
end;

constructor TControllerItensCofins.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensCofins.Create;
  Lista := TListaItemCFS.Create;
end;

function TControllerItensCofins.delete: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE ',
                      'FROM tb_itens_CFS ',
                      'WHERE CFS_CODITF=:ITF_CODIGO '));
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemNota;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

destructor TControllerItensCofins.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerItensCofins.getByItemNota;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ITENS_CFS ',
                      'WHERE CSF_CODITF=:ITF_CODIGO '));
      ParamByName('ITF_CODIGO').AsInteger := Registro.ItemNota;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then get( Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerItensCofins.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TItensCofins;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ITENS_CFS ',
                      'WHERE CFS_CODNFL=:NFL_CODIGO ',
                      ' ORDER BY CFS_CODIGO '));

      ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensCofins.Create;
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

function TControllerItensCofins.insere: boolean;
begin
  try
    Result := TRue;
    Registro.Codigo :=  Generator('GN_ITENS_CFS'); //nextCodigo;
    InsertObj(Registro);
  Except
    Result := FAlse;
  end;
end;

function TControllerItensCofins.nextCodigo: Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT MAX(CFS_CODIGO) FROM TB_ITENS_CFS ' );
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

function TControllerItensCofins.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
