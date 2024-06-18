unit ControllerTabelaPrecoHasFormaPagto;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_MSg, Generics.Collections,
  tblTabelaPrecoHasFormaPagto;

Type
  TSplFormaPAgto = class;
  TListaTabelaHasForma  = TObjectList<TTabelaPrecoHasFormaPagto>;
  TLsitaSplFormaPAgto  = TObjectList<TSplFormaPAgto>;

  TSplFormaPAgto = class
    private
    FDescricao: String;
    FCodigo: Integer;
    FAtivado: Boolean;
    procedure setFAtivado(const Value: Boolean);
    procedure setFCodigo(const Value: Integer);
    procedure setFDescricao(const Value: String);

    public
      property Codigo : Integer read FCodigo write setFCodigo;
      property Descricao : String Read FDescricao write setFDescricao;
      property Ativado : Boolean read FAtivado write setFAtivado;
  end;

  TControllerTabelaPrecoHasFormaPagto = Class(TControllerBase)
  private

  public
    Registro : TTabelaPrecoHasFormaPagto;
    Lista : TListaTabelaHasForma;
    ListaSpl : TLsitaSplFormaPAgto;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert: boolean;
    function save: boolean;
    function deleteALLByTabela: boolean;
    procedure getListSpl;
    procedure getbyID;
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

constructor TControllerTabelaPrecoHasFormaPagto.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTabelaPrecoHasFormaPagto.Create;
  Lista := TListaTabelaHasForma.Create;
  ListaSpl := TLsitaSplFormaPAgto.Create;
end;

function TControllerTabelaPrecoHasFormaPagto.deleteAllByTabela: boolean;
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
                  'FROM TB_TABELA_PRECO_HAS_FORMA_PAGTO ',
                  'WHERE TB_TABELA_PRECO_ID=',Registro.Tabela.ToString
      ));
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerTabelaPrecoHasFormaPagto.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  ListaSpl.DisposeOf;
  inherited;
end;

function TControllerTabelaPrecoHasFormaPagto.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerTabelaPrecoHasFormaPagto.save: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerTabelaPrecoHasFormaPagto.getbyID;
begin
  _getByKey(Registro);
end;

procedure TControllerTabelaPrecoHasFormaPagto.getListSpl;
var
  Lc_Qry : TSTQuery;
  LcLista : TSplFormaPAgto;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              'SELECT FP.FPT_CODIGO, FP.FPT_DESCRICAO ',
              'FROM TB_FORMAPAGTO FP ',
              'ORDER BY  FP.FPT_CODIGO '
      ));
      Active := True;
      FetchAll;
      First;
      ListaSpl.Clear;
      while not eof do
      Begin
        LcLista := TSplFormaPAgto.Create;
        LcLista.Codigo    := FieldByname('FPT_CODIGO').AsInteger;
        LcLista.Descricao := FieldByname('FPT_DESCRICAO').AsString;
        //Verifica se está ativo ou não
        Registro.FormaPagto := FieldByname('FPT_CODIGO').AsInteger;
        getbyID;
        LcLista.Ativado   := (Registro.Ativo = 'S');

        ListaSpl.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;



{ TSplFormaPAgto }

procedure TSplFormaPAgto.setFAtivado(const Value: Boolean);
begin
  FAtivado := Value;
end;

procedure TSplFormaPAgto.setFCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TSplFormaPAgto.setFDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
