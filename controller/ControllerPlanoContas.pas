unit ControllerPlanoContas;

interface

uses STDatabase,System.Classes, STQuery, Vcl.Grids,System.SysUtils,ControllerBase,
      tblPlanoContas, System.Generics.Collections,ObjFinancialPlans;
Type
  TListPlanoContas = TObjectList<TPLanoContas>;

  TControllerPlanoContas = Class(TControllerBase)
  private

  public
    Registro : TPlanoContas;
    Obj: TObjFinancialPlans;
    Lista : TListPlanoContas;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getByPlano:Boolean;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    procedure getById;
    procedure getList;
    procedure clear;
    procedure FillDataObjeto(PcPL: TPLanoContas;ObjPL:TObjFinancialPlans);
  End;

  implementation
{ ControllerContaBancaria }

procedure TControllerPlanoContas.clear;
begin
  ClearObj(Registro);
end;

constructor TControllerPlanoContas.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TPlanoContas.Create;
  Lista     := TListPlanoContas.Create;
  Obj       := TObjFinancialPlans.Create;
end;

function TControllerPlanoContas.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPlanoContas.Destroy;
begin
  Obj.Destroy;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

procedure TControllerPlanoContas.FillDataObjeto(PcPL: TPLanoContas;
  ObjPL: TObjFinancialPlans);
begin
  with Obj do
  Begin
    PlanoContas.Codigo          := PcPL.Codigo;
    PlanoContas.Estabelecimento := Estabelecimento;
    PlanoContas.NivelPosicao    := PcPL.PlanoContas;
    PlanoContas.Descricao       := PcPL.Descricao;
    PlanoContas.Fonte           := PcPL.Origem;
    PlanoContas.Tipo            := PcPL.Tipo;
    PlanoContas.Agrupador       := PcPL.Nivel;
    PlanoContas.Ativo           := 'S';
  End;

end;

function TControllerPlanoContas.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerPlanoContas.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


procedure TControllerPlanoContas.getById;
begin
    _getByKey(Registro);
end;

function TControllerPlanoContas.getByPlano: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TPLanoContas;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PLANOCONTAS ',
                'where ( PLC_CODMHA =:PLC_CODMHA ) ',
                ' AND ( PLC_CODPLANO=:PLC_CODPLANO ) '
      ));
      ParamByName('PLC_CODMHA').AsInteger := Registro.Estabelecimento;
      ParamByName('PLC_CODPLANO').AsString := Registro.PlanoContas;
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if exist then get(Lc_Qry,Registro);      
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPlanoContas.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TPLanoContas;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_PLANOCONTAS ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TPLanoContas.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
