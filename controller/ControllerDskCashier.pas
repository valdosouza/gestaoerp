unit ControllerDskCashier;

interface

uses STDatabase,Classes, STQuery,Vcl.Grids ,SysUtils,ControllerBase,objCashier,
      Un_sistema,Un_Regra_Negocio,  tblDskCashier, tblDskCashierItems ,
      Un_MSg, Generics.Collections;

Type
  TListaDskCashier = TObjectList<TDskCashier>;

  TControllerDskCashier = Class(TControllerBase)
  private

  public
    Registro : TDskCashier;
    Lista : TListaDskCashier;
    Obj: TObjCashier;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Clear;
    procedure getbyId;
    procedure getSincronia;
    procedure getList;
    function atualiza:Boolean;
    function VerificaCaixaAberto:Boolean;Overload;

    function VerificaCaixaFechadoAtual(pData:TDate): Boolean;
    function AbrirCaixa:Boolean;
    function FecharCaixa(ListaValores:TStringGrid):Boolean;
    procedure FillDataObjeto(PcRegistro:TDskCashier);
  published



  End;

implementation

{ TControllerDskCashier }

uses UnFunctions;

function TControllerDskCashier.atualiza: Boolean;
begin
  Try
    updateObj(Registro);
    Result := True;
  Except
    Result := FAlse;
  End;
end;

procedure TControllerDskCashier.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerDskCashier.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDskCashier.Create;
  Obj := TObjCashier.create;
  Lista := TListaDskCashier.Create;
end;

destructor TControllerDskCashier.Destroy;
begin
  Lista.DisposeOf;
  Obj.Destroy;
  Registro.DisposeOf;
  inherited;
end;


function TControllerDskCashier.AbrirCaixa:boolean;
begin
  Registro.Codigo := Fc_Generator('GN_CASHIER','TB_CASHIER','ID');
  Registro.Data := Date;
  Registro.Usuario := Registro.Usuario;
  Registro.Abertura := Now;
  insertObj(Registro);
end;

function TControllerDskCashier.VerificaCaixaAberto: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('select id,dt_record  from tb_cashier '+
              'where ( tb_user_id=:tb_user_id ) and '+
              ' ( HR_END is null) ');
      ParamByName('tb_user_id').AsInteger := Registro.Usuario;
      Active := True;
      FetchAll;
      if (recordCount > 0) then
      Begin
        Registro.Codigo := FieldByName('id').AsInteger;
        Registro.Data := FieldByName('dt_record').AsDateTime;
        Result := True;
      End
      else
      Begin
        Result := False;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


function TControllerDskCashier.VerificaCaixaFechadoAtual(pData:TDate): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Add('select id,dt_record,HR_END  from tb_cashier '+
              'where ( tb_user_id=:tb_user_id ) '+
              ' and ( dt_record =:dt_record ) '+
              ' and ( HR_END is not null) ' );
      ParamByName('tb_user_id').AsInteger := Registro.Usuario;
      ParamByName('dt_record').AsDate := pData;
      Active := True;
      FetchAll;
      if (recordCount > 0) then
      Begin
        Registro.Codigo     := FieldByName('id').AsInteger;
        Registro.Data       := FieldByName('dt_record').AsDateTime;
        Registro.Fechamento := FieldByName('HR_END').AsDateTime;
        Result := True;
      End
      else
      Begin
        Result := False;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerDskCashier.FecharCaixa(ListaValores:TStringGrid):Boolean;
Var
  lc_cashierItems : TDskCashierItems;
  I : Integer;
begin
  try
   //Informa os valores que estavam no caixa no fechamento
   lc_cashierItems := TDskCashierItems.Create;
    Try
      Result := True;
      lc_cashierItems.CodigoCaixa   := Registro.Codigo;
      lc_cashierItems.CodigoUsuario := Registro.Usuario;
      //Faz o loop na grade de valores informados
      with ListaValores do
      Begin
        for I := 1 to ( RowCount - 1 ) do
        Begin
          lc_cashierItems.TipoFormaPagamento := StrToIntDef( Cells[1,I],1);
          lc_cashierItems.Valor := StrToFloatDef( RemoveCaracterInformado( Cells[4,I],['.']) ,0);
          lc_cashierItems.Tipo  := 'C';
          SaveObj(lc_cashierItems);
        End;
      end;

      //Encerra Caixa
      getbyId;
      with Registro do
      Begin
        Fechamento := Now;
      End;
      SaveObj(Registro);
    Except
      Result := False;
    End;
  finally
    lc_cashierItems.DisposeOf;
  end;
end;
procedure TControllerDskCashier.FillDataObjeto(PcRegistro: TDskCashier);
begin
  with Obj do
  Begin
    Caixa.Codigo          := PcRegistro.Codigo;
    Caixa.Estabelecimento := Obj.Estabelecimento;
    Caixa.Terminal        := Obj.Terminal;
    Caixa.Data            := PcRegistro.Data;
    Caixa.Usuario         := PcRegistro.Usuario;
    Caixa.Abertura        := PcRegistro.Abertura;
    Caixa.Fechamento      := PcRegistro.Fechamento;
  End;
end;

procedure TControllerDskCashier.getbyId;
Begin
  _getByKey(Registro);
End;


procedure TControllerDskCashier.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TDskCashier;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CASHIER ',
                      'WHERE ID IS NOT NULL '
                    ));
      if FPeriodo then
        sql.add(' AND ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) ');

      if FPeriodo then
      Begin
        ParamByName('DATAINI').AsDateTime := FDataInicial;
        ParamByName('DATAFIM').AsDateTime := FDataFinal;
      End;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TDskCashier.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;

    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerDskCashier.getSincronia;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CASHIER ',
                      'WHERE ID=:ID '
                    ));
      ParamByName('ID').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      First;
      exist := (RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
