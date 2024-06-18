unit ControllerRetornoNFCe;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblRetornoNfCe,
      Generics.Collections,ObjInvoiceReturn65,ControllerGestaoWeb, UnFunctions;


Type
  TListaRetornoNFCe = TObjectList<TRetornoNfCe>;

  TControllerRetornoNFCe = Class(TControllerBase)

  private
    ExportGestaoWeb : TControllerGestaoWeb;
    function getNext:Integer;
  public
    Registro : TRetornoNFCe;
    Lista : TListaRetornoNFCe;
    Obj: TObjInvoiceReturn65;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    procedure getByNotaFiscal;
    procedure getlist;
    function UpdateFileXMl:Boolean;
    function salva:boolean;
    procedure clear;
    function atualiza:boolean;
    function delete:boolean;
    function insere:boolean;
    procedure getSincronia;
    function SalvaRetorno:Boolean;
    procedure FillDataObjeto(pReg: TRetornoNFCe);
    function VerificaPendentesNumeradas:boolean;
  End;

implementation

{ TControllerRetornoNFCe }

uses Un_Regra_Negocio, UN_Sistema;

function TControllerRetornoNFCe.atualiza: boolean;
begin
  try
    updateObj(Registro);
    REsult := True;
  except
    REsult := False;
  end;
end;

procedure TControllerRetornoNFCe.clear;
begin
  clearObj(Registro);
end;

constructor TControllerRetornoNFCe.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetornoNFCe.Create;
  Lista := TListaRetornoNFCe.Create;
  Obj := TObjInvoiceReturn65.Create;
  ExportGestaoWeb := TControllerGestaoWeb.Create(self);
end;

function TControllerRetornoNFCe.delete: boolean;
begin
  try
    deleteObj(Registro);
    REsult := True;
  except
    REsult := False;
  end;
end;

destructor TControllerRetornoNFCe.Destroy;
begin
  ExportGestaoWeb.DisposeOf;
  Lista.DisposeOf;
  Obj.Destroy;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerRetornoNFCe.FillDataObjeto(pReg: TRetornoNFCe);
begin
  with obj do
  Begin
    Retorno.Codigo            := pReg.NotaFiscal;
    Retorno.Estabelecimento   := obj.Estabelecimento;
    Retorno.Terminal          := obj.Terminal;
    Retorno.Numero            := StrZero(preg.Codigo,6,0);
    Retorno.Serie             := preg.Serie.ToString;
    Retorno.Lote              := preg.Lote;
    Retorno.Sincrono          := preg.Sincrono;
    Retorno.TipoEmissao       := preg.TipoEmissao;
    Retorno.TipoFormato       := preg.Formato;
    Retorno.IndicadorPresenca := preg.IndicacaoPresenca;
    Retorno.Status            := pReg.Situacao;
    Retorno.NomeArquivo       := pReg.NomeArquivo;
    Retorno.Motivo            := pReg.Motivo;
  End;
end;

procedure TControllerRetornoNFCe.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerRetornoNFCe.getByNotaFiscal;
var
  Lc_Qry : TSTQuery;
  LITem : TRetornoNFCe;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_RETORNO_NFC ',
                      'WHERE NFC_CODNFL=:NFC_CODNFL '
                    ));
      ParamByName('NFC_CODNFL').AsInteger := Registro.NotaFiscal;
      Active := True;
      FetchAll;
      exist := RecordCount > 0;
      if exist then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetornoNFCe.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TRetornoNFCe;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT NFC.* ',
                      'FROM TB_RETORNO_NFC NFC '
                    ));
      if FPeriodo then
      Begin
        sql.add(concat(
                  '  INNER JOIN TB_NOTA_FISCAL NF ',
                  '  ON (NF.NFL_CODIGO = NFC.NFC_CODNFL) '
        ));

        sql.add('WHERE ( NF.NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ) ');
      End;

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
        LITem := TRetornoNFCe.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerRetornoNFCe.getNext: Integer;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Result := 0;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select min(cn.numero) numero ',
                'from tb_ctrl_nf cn ',
                '   left outer join tb_retorno_nfc r ',
                '   on (r.nfc_codigo = cn.numero) ',
                'where r.nfc_codigo is null and cn.modelo = ''65'' '
      ));
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := StrToIntDef(FieldByName('numero').AsString,0);
      if (Result = 0) then
        Result := Generator('GN_RETORNO_NFC');
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetornoNFCe.getSincronia;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ',
                '    NFC_CODIGO, ',
                '    NFC_CODNFL, ',
                '    NFC_LOTE, ',
                '    NFC_DATETIME, ',
                '    NFC_SINCRONO, ',
                '    NFC_TP_EMISSAO, ',
                '    NFC_FORMATO, ',
                '    NFC_IND_PRES, ',
                '    NFC_CODSIT, ',
                '    NFC_ARQUIVO, ',
                '    NFC_MOTIVO, ',
                '    NFC_CODMHA, ',
                '    N.nfl_serie NFC_SERIE, ',
                '    N.nfl_numero NFC_NUMERO ',
                'FROM tb_retorno_nfc R ',
                '  INNER JOIN tb_nota_fiscal N ',
                '  ON (R.nfc_codnfl = N.nfl_codigo) ',
                'WHERE ( NFC_CODIGO=:NFC_CODIGO ) ',
                ' ORDER BY NFC_CODNFL ASC '
      ));
      ParamByName('NFC_CODIGO').AsInteger := Registro.Codigo;
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

function TControllerRetornoNFCe.insere: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := getNext;
  Registro.Lote   := Registro.Codigo;
  Registro.Numero   := Registro.Codigo;
  InsertObj(Registro);
end;

function TControllerRetornoNFCe.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerRetornoNFCe.SalvaRetorno: Boolean;
Var
  Lc_Qry:TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE TB_RETORNO_NFC SET '+
              'NFC_CODSIT =:NFC_CODSIT,'+
              'NFC_ARQUIVO =:NFC_ARQUIVO '+
              'WHERE (NFC_CODNFL =:NFC_CODNFL) '+
              'AND ( (NFC_CODSIT <:NFC_CODSIT) or (NFC_CODSIT > 5) ) ');

      //Tratamento de variaveis
      if ( Registro.Situacao > 5 ) then Registro.Situacao := 1;

      //Passagem de Parametros
      ParamByName('NFC_CODNFL').AsInteger := Registro.NotaFiscal;
      ParamByName('NFC_CODSIT').AsInteger := Registro.Situacao;
      ParamByName('NFC_ARQUIVO').AsString := Registro.NomeArquivo;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerRetornoNFCe.UpdateFileXMl: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('UPDATE TB_RETORNO_NFC SET ',
                     'NFC_ARQUIVO =:NFC_ARQUIVO ',
                      'WHERE NFC_CODNFL=:NFC_CODNFL '
                    ));
      ParamByName('NFC_ARQUIVO').AsString := Registro.NomeArquivo;
      ParamByName('NFC_CODNFL').AsInteger := Registro.NotaFiscal;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerRetornoNFCe.VerificaPendentesNumeradas: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT count(NFL_CODIGO) NFL_CODIGO ',
                'FROM TB_NOTA_FISCAL nf ',
                '    INNER JOIN TB_PEDIDO pd ',
                '    ON (pd.PED_CODIGO = nf.NFL_CODPED) ',
                '    INNER JOIN tb_retorno_nfc nfc ',
                '    ON (nfc.nfc_codnfl = NFL_CODIGO) ',
                'WHERE (NFL_CODIGO IS NOT NULL) ',
                ' AND (NFL_CODMHA =:NFL_CODMHA) ',
                ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM) ',
                ' AND ( ( nfc.nfc_codsit is null) or ( nfc.nfc_codsit = 0 ) ) '
      ));
      ParamByName('NFL_CODMHA').AsInteger := FEstabelecimento;
      ParamByName('DATAINI').AsDate       := FDataInicial;
      ParamByName('DATAFIM').AsDate       := FDataFinal;
      Active := True;
      FetchAll;
      Result := ( FieldByName('NFL_CODIGO').AsInteger > 0 );
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
