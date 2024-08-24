unit ControllerItensCtc;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblItensCtc, prm_ItensCtc;

type
  TListCtc = TObjectList<TItensCtc>;

  TControllerItensCtc = Class(TcontrollerBase)
  private
    FParametros: TPrmItensCtc;
    procedure setFParametros(const Value: TPrmItensCtc);
    public
    Registro : TItensCtc;
    Lista : TListCtc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure clear;
    procedure search;

    property Parametros : TPrmItensCtc read FParametros write setFParametros;
  End;

implementation

{ TControllerMenus }

procedure TControllerItensCtc.clear;
begin
  ClearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerItensCtc.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensCtc.create;
  Lista := TListCtc.create;
  FParametros := TPrmItensCtc.create;
end;

destructor TControllerItensCtc.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

procedure TControllerItensCtc.search;
var
  Lc_Qry : TSTQuery;
  LITem : TItensCtc;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        '   SELECT tb_itens_ctc.*, ' +
        '          tb_produto.PRO_CODIGOFAB, tb_produto.PRO_VL_CUSTO, tb_produto.PRO_DIVISOR, tb_produto.PRO_CODIGO, tb_tabela_preco.TPR_MODALIDADE' +
        '     FROM TB_ITENS_CTC tb_itens_ctc ' +
        '     left JOIN TB_PRODUTO tb_produto on (tb_produto.PRO_CODIGO = tb_itens_ctc.ICT_CODVCL) ' +
        '    INNER JOIN TB_TABELA_PRECO tb_tabela_preco on (tb_tabela_preco.TPR_CODIGO = tb_itens_ctc.ICT_CODTPR) ' +
        '    WHERE (tb_itens_ctc.ICT_CODCTC = :ICT_CODCTC) AND (tb_itens_ctc.ICT_TIPO <> ''S'') ' +
        ' ORDER BY tb_itens_ctc.ICT_CODIGO ';

      ParamByName('ICT_CODCTC').AsInteger := Parametros.FieldName.CodCTC;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensCtc.Create;
        get(Lc_Qry,LITem);

        LITem.CodigoFabrica := FieldByName('PRO_CODIGOFAB').AsString;

        if FieldByName('ICT_QTDE').AsFloat > 0 then
          LITem.SubTotal := FieldByName('ICT_QTDE').AsFloat * FieldByName('ICT_VL_UNIT').AsFloat;

        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerItensCtc.setFParametros(const Value: TPrmItensCtc);
begin
  FParametros := Value;
end;

end.
