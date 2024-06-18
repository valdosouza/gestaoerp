unit ControllerCheckOutItems;

interface
uses Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,tblCheckOutItems,Generics.Collections;


Type
  TListaCheckOut = TObjectList<TCheckOutItems>;

  TControllerCheckOutItems = Class(TControllerBase)
    Lista : TListaCheckOut;
  private

  public
    Registro : TCheckOutItems;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    procedure getbyKey;
    procedure deleteByOrder;
    procedure getList;
    procedure Clear;
  End;

implementation

{ TControllerCheckOutItems }

procedure TControllerCheckOutItems.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerCheckOutItems.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCheckOutItems.Create;
  Lista := TListaCheckOut.Create;
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
              'FROM tb_check_out_items c ',
              'where c.tb_order_id =:tb_order_id',
              ' and tb_institution_id =:tb_institution_id '
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
  FreeAndNil( Lista );
  inherited;
end;



procedure TControllerCheckOutItems.getbyKey;
begin
  _getByKey(Registro);
end;

procedure TControllerCheckOutItems.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TCheckOutItems;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                ' FROM tb_check_out_items ',
                'where ( tb_institution_id =:institution_id ) ',
                ' and (TB_ORDER_ID =:ORDER_ID) '
            ));
      //Passagem de Parametro
      ParamByName('institution_id').AsInteger := Registro.Estabelecimento;
      ParamByName('ORDER_ID').AsInteger := Registro.Pedido;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TCheckOutItems.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
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
