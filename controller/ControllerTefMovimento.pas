unit ControllerTefMovimento;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio,  tblTefMovimento, Un_MSg;

Type
  TControllerTefMovimento = Class(TControllerBase)
  private

  public
    Registro : TTefMovimento;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure save;
    procedure insert;
    procedure update;
    procedure encerraPendentes;
    procedure ConcluiPendentes;
    procedure finaliza;
    function getByStatus(Status:String):Boolean;
    procedure getbyId;
    procedure clear;
  End;

implementation

{ TControllerTefMovimento }

constructor TControllerTefMovimento.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTefMovimento.Create;
end;

destructor TControllerTefMovimento.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerTefMovimento.encerraPendentes;
Var
  Lc_Qry : TSTQuery;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      sql.Add(concat('update TB_TEF_MOVIMENTO set ',
                     'STATUS =:STATUS ',
                     'WHERE ( TB_USER_ID =:TB_USER_ID )',
                     ' AND ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID )',
                     ' AND ( STATUS = ''I'' )')
              );
      ParamByName('STATUS').AsString := 'C';
      ParamByName('TB_USER_ID').AsInteger := Registro.Usuario;
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerTefMovimento.clear;
begin
  ClearObj(Registro);
end;

procedure TControllerTefMovimento.ConcluiPendentes;
Var
  Lc_Qry : TSTQuery;
begin
  Try
  Lc_Qry := GeraQuery;
  with Lc_Qry do
  Begin
    Active := False;
    SQL.Clear;
    sql.Add(concat('update TB_TEF_MOVIMENTO set ',
                   'STATUS =:STATUS ',
                   'WHERE ( TB_USER_ID =:TB_USER_ID )',
                   ' AND ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID )',
                   ' AND ( STATUS = ''P'' )')
            );
    ParamByName('STATUS').AsString := 'F';
    ParamByName('TB_USER_ID').AsInteger := Registro.Usuario;
    ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
    ExecSQL;
  End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerTefMovimento.getByStatus(Status:String):Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
  Lc_Qry := GeraQuery;
  with Lc_Qry do
  Begin
    Active := False;
    SQL.Clear;
    sql.Add(concat('select status ',
                   'from TB_TEF_MOVIMENTO ',
                   'WHERE ( STATUS =:STATUS )',
                   ' and (TB_USER_ID =:TB_USER_ID )')
            );
    ParamByName('STATUS').AsString := Status;
    ParamByName('TB_USER_ID').AsInteger := Registro.Usuario;
    Active := True;
    FetchAll;
    Result := ( recordCount > 0 );
  End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerTefMovimento.finaliza;
Var
  Lc_Qry : TSTQuery;
begin
  try
  Lc_Qry := GeraQuery;
  with Lc_Qry do
  Begin
    Active := False;
    SQL.Clear;
    sql.Add(concat('update TB_TEF_MOVIMENTO set ',
                   'STATUS =:STATUS ',
                   'WHERE ( TB_PEDIDO_ID =:TB_PEDIDO_ID )',
                   ' AND ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID )')
            );
    ParamByName('STATUS').AsString := 'F';
    ParamByName('TB_PEDIDO_ID').AsInteger := Registro.CodigoPedido;
    ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;
    ExecSQL;
  End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerTefMovimento.getbyId;
Begin
  _getByKey(Registro);
End;

procedure TControllerTefMovimento.insert;
begin
  InsertObj(Registro);
end;

procedure TControllerTefMovimento.save;
begin
  SaveObj(Registro);
end;

procedure TControllerTefMovimento.update;
begin
  UpdateObj(Registro);
end;

end.
