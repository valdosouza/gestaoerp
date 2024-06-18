unit ControllerPafRegE2;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblPafRegE2 ,Un_MSg,Generics.Collections,ControllerCtrlEstoque;

Type
  TListaPafRegE2 = TObjectList<TPafRegE2>;

  TControllerPafRegE2 = Class(TControllerBase)

  private
    FEstoque: Integer;
    FDataMovimento: TDate;
    procedure setFEstoque(const Value: Integer);
    procedure setFDataMovimento(const Value: TDate);

  public
    Registro : TPafRegE2;
    Lista : TListaPafRegE2;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList(Itens:TStringList):Boolean;
    function FirstRegister:boolean;
    function closureDailyStock:Boolean;
    function updateDailyStock:Boolean;
    property Estoque: Integer read FEstoque write setFEstoque;
    property DataMovimento : TDate read FDataMovimento write setFDataMovimento;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerPafRegE2.closureDailyStock: Boolean;
Var
  Lc_ctrl_estoque : TControllerCtrlEstoque;
  I:Integer;
begin
  try
    Lc_ctrl_estoque := TControllerCtrlEstoque.create(nil);
    Lc_ctrl_estoque.DataInicial := FDataMovimento;
    Lc_ctrl_estoque.DataFinal   := FDataMovimento;
    Lc_ctrl_estoque.Estoque     := FEstoque;
    Lc_ctrl_estoque.ListarProdutoMovimentado;
    for I := 0 to Lc_ctrl_estoque.ListaProdutoMovimentado.count - 1 do
    Begin
      Lc_ctrl_estoque.CodigoProduto := Lc_ctrl_estoque.ListaProdutoMovimentado[I].Codigo;
      //Lc_ctrl_estoque.ListarMovimento;
      //Faz o registro;
      clearObj(registro);
      Registro.Estoque       := FEstoque;
      registro.Codigo        :=  Lc_ctrl_estoque.ListaProdutoMovimentado[I].Codigo;
      _getByKey(Registro);
      registro.Quantidade    := registro.Quantidade + Lc_ctrl_estoque.getSaldoByListarMovimento;
      Registro.DataMovimento := FDataMovimento;
      updateObj(registro);


    End;
  finally
    Lc_ctrl_estoque.disposeOf;
  end;
end;

constructor TControllerPafRegE2.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPafRegE2.Create;
  Lista := TListaPafRegE2.Create;
end;

function TControllerPafRegE2.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPafRegE2.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPafRegE2.FirstRegister: boolean;
var
  Lc_Qry : TSTQuery;
  Lc_itens : TStringList;
begin
  Result := False;
  Lc_itens := TStringList.create;
  getList(Lc_itens);
  if Lista.Count = 0 then
  Begin
    try
      Lc_Qry := GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add(concat(
                'select *',
                'from tb_estoque ',
                'where ( est_codets=:est_codets ) '
        ));
        parambyname('est_codets').asInteger := FEstoque;
        active := True;
        first;
        while not eof do
        Begin
          clearObj(Registro);
          Registro.Codigo         := FieldByName('EST_CODPRO').AsInteger;
          Registro.Quantidade     := FieldByName('EST_QTDE').AsFloat;
          Registro.DataMovimento  := FDataMovimento;
          Registro.Estoque        := FEStoque;
          insertObj(Registro);
          Next;
        End;
      end;
    Finally
      Result := True;
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;

function TControllerPafRegE2.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPafRegE2.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPafRegE2.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPafRegE2.setFDataMovimento(const Value: TDate);
begin
  FDataMovimento := Value;
end;

procedure TControllerPafRegE2.setFEstoque(const Value: Integer);
begin
  FEstoque := Value;
end;

function TControllerPafRegE2.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPafRegE2.updateDailyStock: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegE2;
  i: Integer;
  Lc_itens_Lista : String;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
               'UPDATE TB_PAF_REG_E2 SET ',
               ' DT_RECORD=:DT_RECORD '
      ));
      ParamByName('DT_RECORD').asDatetime := FDataMovimento;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerPafRegE2.getById;
begin
  _getByKey(Registro);
end;

function TControllerPafRegE2.getList(Itens:TStringList): Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegE2;
  i: Integer;
  Lc_itens_Lista : String;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select p.pro_codigo, p.pro_cest, p.pro_codigoncm, ',
                'p.pro_descricao, m.med_abreviatura, pe2.dt_record, ',
                ' pe2.quantity ',
                'from tb_produto p ',
                '  inner join tb_medida m ',
                '  on (m.med_codigo = p.pro_codmed) ',
                '  inner join tb_paf_reg_e2 pe2 ',
                '  on (pe2.tb_product_id = p.pro_codigo) '
      ));
      if itens.Count > 0 then
      Begin
        sql.add('WHERE PRO_CODIGO IN ( ');
        for I := 0 to (itens.Count - 1) do
        Begin
          if I = 0 then
            Lc_itens_Lista := itens[I]
          else
            Lc_itens_Lista := concat(Lc_itens_Lista,',',itens[I]);
        End;

        sql.add(concat(Lc_itens_Lista,' ) '));
      End;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPafRegE2.Create;
        LITem.Codigo        := FieldByname('PRO_CODIGO').AsInteger;
        LITem.CEST          := FieldByname('PRO_CEST').AsString;
        LITem.NCM           := FieldByname('PRO_CODIGONCM').AsString;
        LITem.Descricao     := FieldByname('PRO_DESCRICAO').AsString;
        LITem.Unidade       := FieldByname('MED_ABREVIATURA').AsString;
        LITem.Quantidade    := FieldByname('QUANTITY').AsFloat;
        LITem.DataMovimento := FieldByname('DT_RECORD').AsDateTime;
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
