unit ControllerArquivo;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema, tblArquivo ,Data.DB,Generics.Collections,
      synacode,objFile;


Type
  TListaArquivo = TObjectList<TArquivo>;

  TControllerArquivo = Class(TControllerBase)
  private
    function getfilenameRPS(NOtaID:Integer):String;
    function getfilenameNFSE(NOtaID:Integer):String;
    function getListSQL:String;
    function VerificaCodigoVinculoNFeArquivo(Fc_cd_Nota:Integer):Integer;
    function VerificaCodigoVinculoCartaCorrecao(Fc_cd_Nota:Integer):Integer;
    function VerificaCodigoVinculoNFCeArquivo(Fc_cd_Nota:Integer):Integer;
    function DeleteByVinculo:Boolean;
  public
    Registro : TArquivo;
    Lista : TListaArquivo;
    Obj : TobjFile;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyId;
    procedure getlist;
    procedure getlistSimples(NFirst,NSkip:Integer);
    function getFirst:boolean;
    procedure getbyVinculo;
    function salva:boolean;
    function atualiza:boolean;
    function insere:boolean;
    function delete:boolean;
    procedure LoadFromFile(const FileName: string; BlobType: TBlobType);
    procedure LoadFromStream(Stream: TStream; BlobType: TBlobType);
    procedure Salva_Arq_disco(PathFile:String);
    procedure Salva_Arq_Banco(PathFile:String);
    procedure Clear;
    procedure getSincronia;
    procedure DeleteByNotaViaVinculo(Tipo, NotaID: Integer);

    procedure FillDataObjeto(pReg: TArquivo);
  End;

implementation

{ TControllerCashier }

uses Un_Regra_Negocio;

function TControllerArquivo.atualiza: boolean;
begin
  Try
    updateObj(Registro);
    REsult := True;
  except
    REsult := False
  End;
end;

procedure TControllerArquivo.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerArquivo.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TArquivo.Create;
  Lista := TListaArquivo.Create;
  Obj := TobjFile.create;
end;

function TControllerArquivo.delete: boolean;
begin
  Try
    deleteObj(Registro);
    REsult := True;
  except
    REsult := False
  End;

end;

procedure TControllerArquivo.DeleteByNotaViaVinculo(Tipo, NotaID: Integer);
Begin
  ClearObj(Registro);
  case tipo of
    1: Registro.CodigoVinculo := VerificaCodigoVinculoNfeArquivo(NOtaId);
    2: Registro.CodigoVinculo := VerificaCodigoVinculoCartaCorrecao(NOtaId);
    3: Registro.CodigoVinculo := NotaId;
    4: Registro.CodigoVinculo := VerificaCodigoVinculoNFCeArquivo(NOtaId);
  end;
  if (Registro.CodigoVinculo > 0 ) then
  Begin
     Registro.TipoDoArquivo := Tipo;
     DeleteByVinculo;
  End;
end;

function TControllerArquivo.DeleteByVinculo: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      sql.Add(concat(
               'delete from tb_arquivos ',
               'where arq_codvcl =:arq_codvcl ',
               'and arq_tipo =:arq_tipo '
      ));
      ParamByName('arq_codvcl').AsInteger := registro.CodigoVinculo;
      ParamByName('arq_tipo').AsInteger   := registro.TipoDoArquivo;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerArquivo.Destroy;
begin
  Obj.Destroy;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerArquivo.FillDataObjeto(pReg: TArquivo);
var
  LcConteudo : String;
  Lc_Qry : TSTQuery;
  LcPos : Integer;
begin
  Lc_Qry := GeraQuery;
  Try
    Lc_Qry.SQL.Add(concat(
              'SELECT ARQ_CONTEUDO, ARQ_CODVCL ',
              'FROM TB_ARQUIVOS ',
              'WHERE ARQ_CODIGO=:ARQ_CODIGO '
    ));
    Lc_Qry.ParamByName('ARQ_CODIGO').AsInteger := pReg.Codigo;
    Lc_Qry.Active := True;
    Lc_Qry.FetchAll;
    exist := (Lc_Qry.RecordCount >0);
    if exist then
    Begin
      LcConteudo := (Lc_Qry.FieldByName('ARQ_CONTEUDO') as TBlobField).AsString;
      //Determina o nome do Arquivo
      case pReg.TipoDoArquivo of
        1:Begin
            obj.FolderName := 'NFE';  //1 - Arquivo de XML da Nota Fiscal Eletronica Própria
            LcPos := Pos('Id="NFe', LcConteudo) + 7;
            Obj.Filename := concat(Copy(LcConteudo,LcPos,44),'-nfe.xml');
           end;
        2:Begin
            obj.FolderName := 'CCE';  //2 - Arquivo de XML da Carta de Correção
            LcPos := Pos('infEvento Id="ID', LcConteudo) + 16;
            Obj.Filename := concat(Copy(LcConteudo,LcPos,52),'-cce.xml');
          end;
        3:Begin
            obj.FolderName := 'NFTE';  //3 - Arquivo de XML da Nota Fiscal Eletrônica de Terceiros
            LcPos := Pos('Id="NFe', LcConteudo) + 7;
            Obj.Filename := concat(Copy(LcConteudo,LcPos,44),'-nfe.xml');
          end;
        4:Begin
            obj.FolderName := 'NFCE';  //4 - Arquivo de XML da Nota Fiscal Consumidor Eletronica
            LcPos := Pos('Id="NFe', LcConteudo) + 7;
            Obj.Filename := concat(Copy(LcConteudo,LcPos,44),'-nfe.xml');
          end;
        5:Begin
            obj.FolderName := 'RPSE';  //5 - Arquivo de XML do Recibo Provisorio de Serviço
            Obj.Filename := concat('RPS-',getfilenameRPS(Lc_Qry.FieldByName('ARQ_CODVCL').asInteger),'-nfe.xml');
          end;
        6:Begin
            obj.FolderName := 'NFSE';  //6 - Arquivo de XML da Nota Fiscal de Serviço eletronica
            Obj.Filename := getfilenameNFSE(Lc_Qry.FieldByName('ARQ_CODVCL').asInteger);
          End;
        7:Begin
            obj.FolderName := 'MDFE';  //7 - Arquivo de XML da MFDE
          end;
      end;

      { Prepara o conteúdo binário, codificando-o como um texto }
      Obj.Content := EncodeBase64(LcConteudo);
    End;

  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerArquivo.getbyId;
begin
  _getByKey(Registro);
end;

procedure TControllerArquivo.getbyVinculo;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery();
    with Lc_Qry do
    Begin
      sql.Add(concat(
               'select * ',
               'from tb_arquivos ',
               'where arq_codvcl =:arq_codvcl ',
               'and arq_tipo =:arq_tipo '
      ));
      ParamByName('arq_codvcl').AsInteger := registro.CodigoVinculo;
      ParamByName('arq_tipo').AsInteger   := registro.TipoDoArquivo;
      Active := True;
      FetchAll;
      exist := (recordcount > 0);
      if exist then
        get(Lc_qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerArquivo.getfilenameNFSE(NOtaID: Integer): String;
var
  Lc_Qry : TSTQuery;
  LITem : TArquivo;
begin
  Lc_Qry := GeraQuery;
  Try
    Result := '';
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ',
                ' NFS_ARQUIVO ',
                'From TB_RETORNO_NFS ',
                'WHERE NFS_CODNFL=:NFS_CODNFL '
      ));
      ParamByName('NFS_CODNFL').AsInteger := NOtaID;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('NFS_ARQUIVO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerArquivo.getfilenameRPS(NOtaID: Integer): String;
var
  Lc_Qry : TSTQuery;
  LITem : TArquivo;
begin
  Lc_Qry := GeraQuery;
  Try
    Result := '';
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT ',
                ' NUMERO ',
                'From TB_RPS_NFSE  ',
                'WHERE TB_NOTAFISCAL_ID=:TB_NOTAFISCAL_ID '
      ));
      ParamByName('TB_NOTAFISCAL_ID').AsInteger := NOtaID;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('NUMERO').AsString;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerArquivo.getFirst: boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TArquivo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(Concat(
                'select First 1 * ',
                'FROM TB_ARQUIVOS aqr ',
                'order by arq_codigo '
      ));
      try
        Active := True;
        FetchAll;
        exist := (recordcount > 0);
        if exist then
          get(Lc_qry,Registro);
      Except
        Active := True;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerArquivo.getlist;
var
  Lc_Qry : TSTQuery;
  LITem : TArquivo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add( getListSQL );

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
        LITem := TArquivo.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerArquivo.getlistSimples(NFirst,NSkip:Integer);
var
  Lc_Qry : TSTQuery;
  LITem : TArquivo;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      if NFirst > 0 then
      Begin
        sql.add(Concat(
                  'select First ', IntToStr(NFirst),' skip', IntToStr(NSkip), ' * ',
                  'FROM TB_ARQUIVOS aqr ',
                  'order by arq_codigo '
        ));
      End
      else
      Begin
        sql.add(Concat(
                'SELECT first 50 * ',
                'FROM TB_ARQUIVOS aqr ',
                'order by arq_codigo '
        ));
      End;


      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TArquivo.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        try
          next;
        except
          break;
        end;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerArquivo.getListSQL: String;
Var
  LcDataStr:String;
begin
  LcDataStr := ' AND (NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM)';

  Result := Concat(
              'SELECT ',
              '  ARQ_CODIGO, ',
              '  ARQ_TIPO, ',
              '  ARQ_FORMATO, ',
              '  ARQ_CODVCL, ',
              '  ARQ_CHV_NFE ',
              'FROM TB_ARQUIVOS aqr ',
              '    INNER JOIN tb_retorno_nfe NFE ',
              '    ON (NFE.nfe_codigo = AQR.arq_codvcl) ',
              '    INNER JOIN TB_NOTA_FISCAL NF ',
              '    ON (NF.NFL_CODIGO = NFE.nfe_codnfl) ',
              'WHERE NF.nfl_modelo = ''55''  and aqr.arq_tipo =1 ');
  if FPeriodo then
    Result := Concat(Result, LcDataStr);

  Result := Concat(
              Result,
              'UNION ',
              'SELECT ',
              '  ARQ_CODIGO, ',
              '  ARQ_TIPO, ',
              '  ARQ_FORMATO, ',
              '  ARQ_CODVCL, ',
              '  ARQ_CHV_NFE ',
              'FROM TB_ARQUIVOS aqr ',
              '    INNER JOIN tb_carta_correcao cc ',
              '    ON (cc.cce_codigo = AQR.arq_codvcl) ',
              '    INNER JOIN TB_NOTA_FISCAL NF ',
              '    ON (NF.NFL_CODIGO = cc.cce_codnfl) ',
              'WHERE aqr.arq_tipo =2 ');
  if FPeriodo then
    Result := Concat(Result, LcDataStr);

  Result := Concat(
              Result,
              'UNION ',
              'SELECT ',
              '  ARQ_CODIGO, ',
              '  ARQ_TIPO, ',
              '  ARQ_FORMATO, ',
              '  ARQ_CODVCL, ',
              '  ARQ_CHV_NFE ',
              'FROM TB_ARQUIVOS aqr ',
              '    INNER JOIN TB_NOTA_FISCAL NF ',
              '    ON (NF.NFL_CODIGO = aqr.arq_codvcl) ',
              'WHERE aqr.arq_tipo =3 ');
  if FPeriodo then
    Result := Concat(Result, LcDataStr);

  Result := Concat(
              Result,
              'UNION ',
              'SELECT ',
              '  ARQ_CODIGO, ',
              '  ARQ_TIPO, ',
              '  ARQ_FORMATO, ',
              '  ARQ_CODVCL, ',
              '  ARQ_CHV_NFE ',
              'FROM TB_ARQUIVOS aqr ',
              '    INNER JOIN tb_retorno_nfc NFC ',
              '    ON (NFC.nfc_codigo = AQR.arq_codvcl) ',
              '    INNER JOIN TB_NOTA_FISCAL NF ',
              '    ON (NF.NFL_CODIGO = NFC.nfc_codnfl) ',
              'WHERE NF.nfl_modelo = ''65''  and aqr.arq_tipo =4 ');
  if FPeriodo then
    Result := Concat(Result, LcDataStr);

  Result := Concat(
              Result,
              'UNION ',
              'SELECT ',
              '  ARQ_CODIGO, ',
              '  ARQ_TIPO, ',
              '  ARQ_FORMATO, ',
              '  ARQ_CODVCL, ',
              '  ARQ_CHV_NFE ',
              'FROM TB_ARQUIVOS aqr ',
              '    INNER JOIN TB_NOTA_FISCAL NF ',
              '    ON (NF.NFL_CODIGO = aqr.arq_codvcl) ',
              'WHERE aqr.arq_tipo =6 '
  );
  if FPeriodo then
    Result := Concat(Result, LcDataStr);

end;

procedure TControllerArquivo.getSincronia;
begin
  _getByKey(Registro);
end;

function TControllerArquivo.insere: boolean;
begin
  Try
    insertObj(Registro);
    REsult := True;
  except
    REsult := False
  End;
end;

procedure TControllerArquivo.LoadFromFile(const FileName: string;
  BlobType: TBlobType);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream, BlobType);
  finally
    Stream.disposeOf;
  end;
end;

procedure TControllerArquivo.LoadFromStream(Stream: TStream;
  BlobType: TBlobType);
var
  Data: TArray<Byte>;
  Len: Integer;
begin
  Stream.Position := 0;
  Len := Stream.Size;
  SetLength(Data, Len);
  Stream.ReadBuffer(Data, Len);
//  Registro.Conteudo := Data;
end;

function TControllerArquivo.salva: boolean;
begin
  Try
    SaveObj(Registro);
    REsult := True;
  except
    REsult := False
  End;
end;

procedure TControllerArquivo.Salva_Arq_Banco(PathFile: String);
var
  Lc_Qry: TSTQuery;
BEGIN
  {
   1 - Arquivo de XML da Nota Fiscal Eletronica Própria
   2 - Arquivo de XML da Carta de Correção
   3 - Arquivo de XML da Nota Fiscal Eletrônica de Terceiros
   4 - Arquivo de XML da Nota Fiscal Consumidor Eletronica
   5 - Arquivo de XML do Recibo Provisorio de Serviço
   6 - Arquivo de XML da Nota Fiscal de Serviço eletronica
   7 - Arquivo de XML da MDFE
  }
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                'UPDATE OR INSERT INTO TB_ARQUIVOS (ARQ_TIPO, ARQ_FORMATO, ARQ_CODVCL, ARQ_CONTEUDO) '+
                '             VALUES (:ARQ_TIPO, :ARQ_FORMATO, :ARQ_CODVCL, :ARQ_CONTEUDO) '+
                '           MATCHING (ARQ_TIPO, ARQ_FORMATO, ARQ_CODVCL )'
      ));
      Try
        if FileExists(PathFile) then
        begin
          ParamByName('ARQ_TIPO').AsInteger   := Registro.TipoDoArquivo;
          ParamByName('ARQ_FORMATO').AsString := Registro.Formato;
          ParamByName('ARQ_CODVCL').AsInteger := Registro.CodigoVinculo;
          ParamByName('ARQ_CONTEUDO').LoadFromFile(PathFile,ftBlob);
          EXECSQL;
        end;
      Except
        on E:Exception do
        geralog('TControllerArquivo.Salva_Arq_Banco',E.Message);
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerArquivo.Salva_Arq_disco(PathFile:String);
var
  Lc_Qry: TSTQuery;
BEGIN
  {
   1 - Arquivo de XML da Nota Fiscal Eletronica Própria
   2 - Arquivo de XML da Carta de Correção
   3 - Arquivo de XML da Nota Fiscal Eletrônica de Terceiros
   4 - Arquivo de XML da Nota Fiscal Consumidor Eletronica
   5 - Arquivo de XML do Recibo Provisorio de Serviço
   6 - Arquivo de XML da Nota Fiscal de Serviço eletronica
   7 - Arquivo de XML da MFDE
  }
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.add(concat(
                'SELECT  ',
                '       ARQ_TIPO, ',
                '       ARQ_FORMATO, ',
                '       ARQ_CODVCL, ',
                '       ARQ_CONTEUDO ',
                'FROM TB_ARQUIVOS ',
                'WHERE (ARQ_TIPO=:ARQ_TIPO) ',
                '  AND (ARQ_FORMATO=:ARQ_FORMATO)',
                '  AND ((ARQ_CODVCL=:ARQ_CODVCL) ',
                '   OR (ARQ_CODVCL IS NULL)) '
      ));

      ParamByName('ARQ_TIPO').AsInteger := Registro.TipoDoArquivo;
      ParamByName('ARQ_FORMATO').AsString := Registro.Formato;
      ParamByName('ARQ_CODVCL').AsInteger := Registro.CodigoVinculo;
      Active := True;
      if RecordCount >0 then
      Begin
        Try
          (FieldByName('ARQ_CONTEUDO') as TBlobField).SaveToFile( PathFile);
        Except
          on E:Exception do
            geralog('TControllerArquivo.Salva_Arq_disco',E.Message);
        end;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerArquivo.VerificaCodigoVinculoCartaCorrecao(
  Fc_cd_Nota: Integer): Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Add('select CCE_CODIGO from TB_CARTA_CORRECAO WHERE CCE_CODNFL =:CCE_CODNFL');
      ParamByName('CCE_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('CCE_CODIGO').AsInteger
      else
        Result := 0;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerArquivo.VerificaCodigoVinculoNFCeArquivo(
  Fc_cd_Nota: Integer): Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select NFC_CODIGO from TB_RETORNO_NFC WHERE NFC_CODNFL =:NFC_CODNFL');
      ParamByName('NFC_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('NFC_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerArquivo.VerificaCodigoVinculoNFeArquivo(Fc_cd_Nota: Integer): Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('select NFE_CODIGO from TB_RETORNO_NFE WHERE NFE_CODNFL =:NFE_CODNFL');
      ParamByName('NFE_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('NFE_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
