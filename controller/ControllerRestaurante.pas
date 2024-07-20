unit ControllerRestaurante;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema, tblRestaurante,ControllerITensRTR;


Type
  TControllerRestaurante = Class(TControllerBase)
  private

  public
    Registro : TRestaurante;
    Items : TControllerITensRTR;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function salva:boolean;
    procedure getbyId;
    function salvaRecebimento:boolean;
    function delete:boolean;
  End;

implementation

{ TControllerRestaurante }

uses Un_Regra_Negocio;


procedure TControllerRestaurante.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerRestaurante.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRestaurante.Create;
  Items := TControllerITensRTR.create(Self);
end;

function TControllerRestaurante.delete: boolean;
begin
  deleteObj(registro);
end;

destructor TControllerRestaurante.Destroy;
begin
  Registro.DisposeOf;
  Items.DisposeOf;
  inherited;
end;



procedure TControllerRestaurante.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerRestaurante.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerRestaurante.salvaRecebimento: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_RESTAURANTE SET '+
              'VALUE_RECIVED =:VALUE_RECIVED, '+
              'VALUE_CHANGE =:VALUE_CHANGE '+
              'WHERE ( TB_PEDIDO_ID =:TB_PEDIDO_ID ) '+
              ' AND ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID) ');
      ParamByName('VALUE_RECIVED').AsFloat := Registro.ValorRecebido;
      ParamByName('VALUE_CHANGE').AsFloat := Registro.ValorTroco;
      ParamByName('TB_PEDIDO_ID').AsInteger := Registro.CodigoPedido;
      ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.CodigoEstabelecimento;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
