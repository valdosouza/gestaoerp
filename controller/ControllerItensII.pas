unit ControllerItensII;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      tblItensII,  System.Generics.Collections,controllerProduto,FireDAC.Stan.Param;


Type
  TListaItemII = TObjectList<TItensII>;

  TControllerItensII = Class(TControllerBase)

  private
    function nextCodigo:Integer;
  public
    Registro : TItensII;
    Lista: TListaItemII;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    function atualiza:boolean;
    procedure getList;
    procedure getByItemNota;

  End;

implementation

uses Un_Regra_Negocio;

function TControllerItensII.atualiza: boolean;
begin
  UpdateObj(Registro);
end;

constructor TControllerItensII.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensII.Create;
  Lista := TListaItemII.Create;
end;

destructor TControllerItensII.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerItensII.getByItemNota;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ITENS_II ',
                      'WHERE IIP_CODITF=:ITF_CODIGO '));
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

procedure TControllerItensII.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TItensII;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ITENS_II ',
                      'WHERE IIP_CODNFL=:NFL_CODIGO ',
                      ' ORDER BY IIP_CODIGO '));

      ParamByName('NFL_CODIGO').AsInteger := Registro.Nota;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensII.Create;
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

function TControllerItensII.insere: boolean;
begin
  try
    Result := TRue;
    Registro.Codigo := nextCodigo;
    InsertObj(Registro);
  Except
    Result := FAlse;
  end;

end;

function TControllerItensII.nextCodigo: Integer;
var
  Lc_Qry: TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT MAX(IIP_CODIGO) FROM TB_ITENS_II ' );
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

function TControllerItensII.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
