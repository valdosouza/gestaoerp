unit ControllerCommand;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,tblCommand;


Type
  TControllerCommand = Class(TControllerBase)
  private

  public
    Registro : TCommand;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    function update:boolean;
    procedure getByComanda;
    procedure getByComandaLivre;
    function veriryDuplicity:Boolean;
    procedure getbyKey;
    procedure clear;
  End;

implementation

{ TControllerCommand }

procedure TControllerCommand.clear;
begin
  clearObj(Registro);
end;

constructor TControllerCommand.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCommand.Create;
end;

destructor TControllerCommand.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerCommand.getByComanda;
Var
  Lc_Qry :TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                  'SELECT c.* ',
                  'FROM tb_command c ',
                  ' inner join tb_pedido p ',
                  ' on (p.ped_codigo = c.tb_order_id) ',
                  'where c.control_id =:control_id ',
                  ' and tb_institution_id =:institution_id '
              ));
      parambyname('control_id').asString := Registro.Numero;
      parambyname('institution_id').AsInteger := Registro.Estabelecimento;
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then
      Begin
        get(Lc_Qry,Registro);
      End
      else
      Begin
        clear;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCommand.getByComandaLivre;
Var
  Lc_Qry :TSTQuery;
begin
  TRy
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                  'SELECT c.* ',
                  'FROM tb_command c ',
                  ' inner join tb_pedido p ',
                  ' on (p.ped_codigo = c.tb_order_id) ',
                  'where c.control_id =:control_id ',
                  ' and tb_institution_id =:institution_id ',
                  '  and ( ped_faturado = ''N'' ) '
              ));
      parambyname('control_id').asString := Registro.Numero;
      parambyname('institution_id').AsInteger := Registro.Estabelecimento;
      active := True;
      fetchall;
      exist := (RecordCount > 0);
      if exist then
      Begin
        get(Lc_Qry,Registro);
      End
      else
      Begin
        clear;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerCommand.getbyKey;
begin
  _getByKey(Registro);
end;

function TControllerCommand.insere: boolean;
begin
  SaveObj(Registro);
end;

function TControllerCommand.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerCommand.update: boolean;
begin
  try
    updateObj(REgistro);
    result := TRue;
  except
    result := False;
  end;
end;

function TControllerCommand.veriryDuplicity: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                  'SELECT c.control_id ',
                  'FROM tb_command c ',
                  ' inner join tb_pedido p ',
                  ' on (p.ped_codigo = c.tb_order_id) ',
                  'where c.control_id =:control_id ',
                  ' and tb_institution_id =:institution_id ',
                  ' AND (PED_FATURADO = ''N'' )'
              ));
      parambyname('control_id').asString := Registro.Numero;
      parambyname('institution_id').AsInteger := Registro.Estabelecimento;
      active := True;
      fetchall;
      Result := (RecordCount > 0);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
