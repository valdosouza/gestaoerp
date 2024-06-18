unit ControllerComposicao;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblCtrlEstoque , Un_MSg,
      System.Generics.Collections, ControllerSyncTable, TEntity,CAtribEntity;

Type
  TComposicao = Class;

  TListaCtrEstoque = TObjectList<TCtrlEstoque>;
  TListaComposicao = TObjectList<TComposicao>;

  [TableName('TB_PROD_PROD')]
  TComposicao = Class(TGenericEntity)

    private
    FPRO_CODIGO: Integer;
    FPPD_QTDE: Real;
    FPPD_CODPRO_D: Integer;
    FPRO_COMPOSICAO: String;
    procedure setFPPD_CODPRO_D(const Value: Integer);
    procedure setFPPD_QTDE(const Value: Real);
    procedure setFPRO_CODIGO(const Value: Integer);
    procedure setFPRO_COMPOSICAO(const Value: String);

    public
      [FieldName('PRO_CODIGO')]
      property produtoMaster:Integer read FPRO_CODIGO write setFPRO_CODIGO;

      [FieldName('PRO_COMPOSICAO')]
      property Composicao : String read FPRO_COMPOSICAO write setFPRO_COMPOSICAO;

      [FieldName('PPD_QTDE')]
      property Qtde :Real read FPPD_QTDE write setFPPD_QTDE;

      [FieldName('PPD_CODPRO_D')]
      property produtodetalhe:Integer read FPPD_CODPRO_D write setFPPD_CODPRO_D;

  end;

  TControllerComposicao = Class(TControllerBase)

  private

  public
    Registro : TComposicao;
    Lista : TListaComposicao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getList;
  End;



implementation

{ TControllerComposicao }

uses UN_Sistema, Un_Regra_Negocio;

constructor TControllerComposicao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TComposicao.Create;
  Lista := TListaComposicao.Create;
end;

destructor TControllerComposicao.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;


procedure TControllerComposicao.getList;
Var
  Lc_Qry : TSTQuery;
  Lcreg : TComposicao;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                   'SELECT ',
                   '  PRO_CODIGO, ',
                   '  PRO_COMPOSICAO, ',
                   '  PPD_QTDE , ',
                   '  PPD_CODPRO_D ',
                   'FROM TB_PRODUTO tb_produto ',
                   '   LEFT OUTER JOIN TB_PROD_PROD tb_prod_prod ',
                   '   ON (tb_prod_prod.PPD_CODPRO_M = tb_produto.PRO_CODIGO) ',
                   'WHERE PRO_CODIGO =:PRO_CODIGO '
      ));
      ParamByName('PRO_CODIGO').AsInteger := Registro.produtoMaster;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      BEgin
        Lcreg := TComposicao.Create;
        Lcreg.produtoMaster  := FieldByName('PRO_CODIGO').AsInteger;
        Lcreg.Composicao     := FieldByName('PRO_COMPOSICAO').AsString;
        Lcreg.Qtde           := StrToFloatDef(FieldByName('PPD_QTDE').AsString,0);
        Lcreg.produtodetalhe := StrToIntDef(FieldByName('PPD_CODPRO_D').AsString,0);
        Lista.Add(Lcreg);
        Next;
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

{ TComposicao }

procedure TComposicao.setFPPD_CODPRO_D(const Value: Integer);
begin
  FPPD_CODPRO_D := Value;
end;

procedure TComposicao.setFPPD_QTDE(const Value: Real);
begin
  FPPD_QTDE := Value;
end;

procedure TComposicao.setFPRO_CODIGO(const Value: Integer);
begin
  FPRO_CODIGO := Value;
end;

procedure TComposicao.setFPRO_COMPOSICAO(const Value: String);
begin
  FPRO_COMPOSICAO := Value;
end;

end.
