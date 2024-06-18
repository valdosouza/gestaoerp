unit ControllerCheckOutItems;

interface
uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,tblCommandItems;


Type
  TControllerCheckOutItems = Class(TControllerBase)
  private

  public
    Registro : TCommandItems;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    procedure getbyKey;
    procedure deleteByOrder;
  End;

implementation

{ TControllerCheckOutItems }

constructor TControllerCheckOutItems.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCommandItems.Create;
end;

procedure TControllerCheckOutItems.deleteByOrder;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'DELETE ',
              'FROM tb_command_items c ',
              'where c.tb_order_id =:tb_order_id',
              ' and tb_institution_id =:tb_institution_id'
      ));
      ParamByName('tb_institution_id').AsInteger := Registro.Estabelecimento;
      ParamByName('tb_order_id').AsInteger := Registro.Pedido;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerCheckOutItems.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerCheckOutItems.getbyKey;
begin
  _getByKey(Registro);
end;

function TControllerCheckOutItems.insere: boolean;
begin
  InsertObj(Registro);
end;

function TControllerCheckOutItems.salva: boolean;
begin
  SaveObj(Registro);
end;

end.
