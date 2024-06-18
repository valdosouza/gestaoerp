unit ControllerDskConsignmentOperation;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblDskConsignmentOperation ,Un_MSg,
      System.Generics.Collections;

Type
  TListConsignmentOperation  =  TObjectList<TDskConsignmentOperation>;
  TControllerDskConsignmentOperation = Class(TControllerBase)

  private
  protected

  public
    Registro : TDskConsignmentOperation;
    Lista : TListConsignmentOperation;


    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure clear;
    function salva:boolean;
    function Insert:boolean;
    function replace:boolean;
    procedure getList;
    function update:boolean;
    Function delete:boolean;
    procedure getbyId;
    function getTotalValue:REal;
    function getTotalValueByProduct(Id:Integer):Real;
    function getBalanceByProduct(Id:Integer):Real;
  End;

implementation

{ TControllerDskConsignmentOperation }

procedure TControllerDskConsignmentOperation.clear;
begin
  clearObj(Registro);
  Lista.Clear;
end;

constructor TControllerDskConsignmentOperation.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskConsignmentOperation.Create;
  Lista := TListConsignmentOperation.Create;
end;

function TControllerDskConsignmentOperation.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDskConsignmentOperation.Destroy;
begin
  lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerDskConsignmentOperation.getBalanceByProduct(
  Id: Integer): Real;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := geraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select oco.kind, it.itf_qtde , it.itf_vl_unit ',
                'from tb_order_consignment_operation oco ',
                '  inner join tb_itens_nfl it ',
                '  on ( it.itf_codigo = oco.tb_itens_nfl_id ) ',
                'where (it.itf_codpro =:tb_product_id ) '
       ));

      if Registro.Ordem > 0 then
        SQL.Add('( oco.tb_order_id =:tb_order_id) ');

      //Passagem de PArametros
      if Registro.Ordem > 0 then
        ParamByName('tb_order_id').AsInteger := Registro.Ordem;

      ParamByName('tb_product_id').AsInteger := Id;

      Active := TRue;
      First;
      REsult := 0;
      while not eof do
      Begin
        if Copy(FieldByName('kind').AsString,1,1) = 'E' then
          REsult := REsult + FieldByName('itf_qtde').AsFloat
        else
          REsult := REsult - FieldByName('itf_qtde').AsFloat;
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerDskConsignmentOperation.getbyId;
begin

end;

procedure TControllerDskConsignmentOperation.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TDskConsignmentOperation;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_ORDER_CONSIGNMENT ',
                      ' where ( TB_INSTITUTION_ID=:TB_INSTITUTION_ID ) ',
                      ' AND (tb_order_id=:tb_order_id ) '
      ));

      if Registro.Estabelecimento > 0 then
        ParamByName('TB_INSTITUTION_ID').AsInteger := Registro.Estabelecimento;

      if Registro.Ordem > 0 then
        ParamByName('tb_order_id').AsInteger := Registro.Ordem;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TDskConsignmentOperation.Create;
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

function TControllerDskConsignmentOperation.getTotalValue: REal;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select distinct it.ITF_CODPRO ',
                'from tb_order_consignment_operation oco ',
                '  inner join TB_ITENS_NFL it ',
                '  on ( it.ITF_SEQUENCIA = oco.tb_order_item_id ) ',
                '     and  ( oi.tb_order_id = oco.tb_order_id) ',
                'where ( oco.tb_order_id =:tb_order_id) '
      ));

      if Registro.Data > 0 then
        sql.Add(' and ( oco.dt_record =:dt_record ) ');

      if Registro.Tipo <> '' then
        sql.Add(' and ( oco.kind like :kind ) ');

      //Passagem de PArametros
      ParamByName('tb_order_id').AsInteger := Registro.Ordem;

      if Registro.Data > 0 then
        ParamByName('dt_record').AsDate := Registro.Data;

      if Registro.Tipo <> '' then
        ParamByName('kind').AsString := concat(Registro.Tipo,'%');

      Active := TRue;
      First;
      REsult := 0;
      while not eof do
      Begin
        REsult := REsult + getTotalValueByProduct(FieldByName('tb_product_id').AsInteger);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskConsignmentOperation.getTotalValueByProduct(
  Id: Integer): Real;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add(concat(
                'select oco.kind, it.itf_qtde , it.itf_vl_unit ',
                'from tb_order_consignment_operation oco ',
                '  inner join tb_itens_nfl it ',
                '  on ( it.itf_codigo = oco.tb_itens_nfl_id ) ',
                'where  (it.itf_codpro =:tb_product_id ) '
      ));
      //Incrementar o SQL
      if Registro.Ordem > 0 then
        SQL.Add('( oco.tb_order_id =:tb_order_id) ');

      //Passagem de PArametros
      if Registro.Ordem > 0 then
        ParamByName('tb_order_id').AsInteger := Registro.Ordem;

      ParamByName('tb_product_id').AsInteger := Id;

      Active := TRue;
      First;
      REsult := 0;
      while not eof do
      Begin
        if Copy(FieldByName('kind').AsString,1,1) = 'E' then
          REsult := REsult + (FieldByName('itf_qtde').AsFloat * FieldByName('itf_vl_unit').AsFloat)
        else
          REsult := REsult - (FieldByName('itf_qtde').AsFloat * FieldByName('itf_vl_unit').AsFloat);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskConsignmentOperation.Insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerDskConsignmentOperation.replace: boolean;
begin
  Try
    replaceObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerDskConsignmentOperation.salva: boolean;
begin
  SaveObj(Registro);
end;


function TControllerDskConsignmentOperation.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.

