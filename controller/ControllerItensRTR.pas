unit ControllerItensRTR;

interface

uses ControllerBase, tblItensRTR, System.Classes, STQuery, FireDAC.Stan.Param;

Type
  TControllerItensRTR = Class(TControllerBase)

  private

  public
    Registro :TItensRTR;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insere:boolean;
    function update:boolean;
    procedure getById;
    function updateQtdeLasItem(Pc_Cd_Pedido,Pc_Nr_Item:Integer;Pc_Vl_SubTotal,Pc_Qtde:Real):Boolean;
    procedure Clear;
    function delete:boolean;
  End;

implementation

{ TControllerItensRTR }

procedure TControllerItensRTR.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerItensRTR.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensRTR.Create;
end;

function TControllerItensRTR.delete: boolean;
begin
  deleteObj(Registro);
end;

destructor TControllerItensRTR.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerItensRTR.getById;
begin
  _getByKey(Registro);
end;

function TControllerItensRTR.insere: boolean;
begin
  try
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerItensRTR.update: boolean;
begin
  try
    updateObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

function TControllerItensRTR.updateQtdeLasItem(Pc_Cd_Pedido,Pc_Nr_Item:Integer;Pc_Vl_SubTotal,Pc_Qtde:Real): Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry DO
    Begin
      sql.add(concat(
          'select '+
          '  ITR_CODITF, '+
          '  ITR_NR_ITEM, '+
          '  ITR_QTDE '+
          'FROM tb_itens_nfl '+
          '  INNER JOIN tb_itens_rtr '+
          '  ON (ITR_CODITF = ITF_CODIGO) '+
          'WHERE ITF_CODPED =:ITF_CODPED '+
//          ' AND (ITR_CODITF =:ITR_CODITF) '+
          ' AND (ITR_NR_ITEM =:ITR_NR_ITEM) '+
          'ORDER BY ITR_NR_ITEM,ITR_DESCRICAO '
      ));
      ParamByName('ITF_CODPED').AsInteger := Pc_Cd_Pedido;
      ParamByName('ITR_NR_ITEM').AsInteger := Pc_Nr_Item;
      Active := True;
      last;
      clearObj(Registro);
      Registro.Item := FieldByName('ITR_CODITF').AsInteger;
      getById;
      //Atualizar
      Registro.Qtde := Pc_Qtde;
      Registro.ValorUnitario := Pc_Vl_SubTotal;
      Self.update;
    End;
  finally

  end;
end;

end.
