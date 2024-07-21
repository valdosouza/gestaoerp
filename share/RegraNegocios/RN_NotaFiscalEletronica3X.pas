unit RN_NotaFiscalEletronica3X;

interface

uses
  STDatabase, STQuery, SysUtils, ControllerItensNfl,ControllerBase,
  Classes, System.Math,ACBrNFeDANFeESCPOS,FireDAC.Stan.Param,
  ACBrNFe, pcnConversao, ACBrNFeDANFEClass, pcnNFeW, pcnLeitor,ACBrDFeSSL,
  ACBrNFeNotasFiscais, pcnNFe, ACBrNFeWebServices,pcnConversaoNFe,
  ACBrNFeDANFeRLClass, ACBrPosPrinter,
  ACBrValidador, Vcl.StdCtrls, Vcl.ExtCtrls, blcksock, Vcl.Dialogs,
  Winapi.Windows, Printers, Xml.XMLDoc;

  function Fc_VerificaCodigoVinculoNFeArquivo(Fc_cd_Nota:Integer):Integer;
  function Fc_VerificaCodigoVinculoCartaCorrecao(Fc_cd_Nota:Integer):Integer;
  function Fc_VerificaCodigoVinculoNFCeArquivo(Fc_cd_Nota:Integer):Integer;

  function Fc_VerificaExistenciaArquivoNFEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
  function Fc_VerificaExistenciaArquivoNFCEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):boolean;

  procedure Pc_VerificaExistenciaArquivoCartaXML(Pc_Tipo:Integer;Pc_Cd_Carta:Integer;Pc_Path,Pc_FileXMl:String);
  
  procedure Pc_AtivaConfiguracaoNFe;

  //Validações

  function Fc_VerificaNotaXMLCompra(Pc_Cd_Nota:Integer):Integer;


  Function Fc_ValidaEnvioNfePDF(Fc_Cd_Cliente:Integer):Boolean;
  function Fc_Valida_enderecoPedido(Pc_cd_Endereco:Integer;Pc_Endereco:String): Boolean;

  procedure Pc_GravaEvento(Pc_Codigo        : Integer;
                           Pc_NUMERO        : Integer;
                           Pc_CHAVE         : String;
                           Pc_CODNVT        : Integer;
                           Pc_DATA          : TDateTime;
                           Pc_SEQUENCIA     : String;
                           Pc_SIT_NFE       : String;
                           Pc_SIT_CONF      : String;
                           Pc_TP_NF         : String;
                           Pc_JUSTIFICATIVA : String;
                           PC_STATUS        : String);
  function Fc_BuscaEventoManifestacao(Fc_Chave:String):Boolean;
  function Fc_BuscaCodigoDescricaoCFOP(Fc_CFOP:String):TStringList;
  function Fc_BuscaCodigoReferenciaCFOP(Fc_CFOP:String):TStringList;
  function Fc_BuscaCodigoReferenciaCST(Fc_CST:String):Integer;
  function Fc_BuscaCodigoReferenciaCSOSN(Fc_CSOSN:String):Integer;
  procedure Pc_VincularCodigosCFOP(Fc_Cd_CFOP_Origem,Fc_Cd_CFOP_Destino:String);


  function Fc_Valida_CNPJ (Fc_Numero,Fc_Tipo : string) : Boolean;
  function Fc_Valida_CPF (Fc_Numero,Fc_Tipo : string) : Boolean;

  function Fc_Valida_Tel_Endereco(Fc_cd_endereco:Integer): Boolean;


  procedure Pc_SalvarArquivoTexto(Pc_Path,Pc_File, Texto:String);
  function Fc_AnexarXmlNFe(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
  function DefineTipoCertificadoConfig(Tipo:Integer):String;

implementation

uses Un_DM, UN_Sistema, UN_MSG, Un_Regra_Negocio, main, RN_Permissao,RN_Estoque,
    RN_Empresa, ACBrNFeConfiguracoes, RN_Mailing, RN_NotaFiscal, UNFunctions;


function Fc_VerificaCodigoVinculoNFeArquivo(Fc_cd_Nota:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery; 
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NFE_CODIGO from TB_RETORNO_NFE WHERE NFE_CODNFL =:NFE_CODNFL';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFE_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('NFE_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_VerificaCodigoVinculoCartaCorrecao(Fc_cd_Nota:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select CCE_CODIGO from TB_CARTA_CORRECAO WHERE CCE_CODNFL =:CCE_CODNFL';
      SQL.Add(Lc_SqlTxt);
      ParamByName('CCE_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('CCE_CODIGO').AsInteger
      else
        Result := 0;
    end;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

end;

function Fc_VerificaCodigoVinculoNFCeArquivo(Fc_cd_Nota:Integer):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NFC_CODIGO from TB_RETORNO_NFC WHERE NFC_CODNFL =:NFC_CODNFL';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFC_CODNFL').AsInteger := Fc_cd_Nota;
      Active := True;
      FetchAll;
      if (recordcount>0) then
        Result := FieldByName('NFC_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_VerificaExistenciaArquivoNFEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
Var
  Lc_Cd_Vinculo : Integer;
Begin
  Result := True;
  case pc_tipo of
    1: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(Pc_Cd_Nota);
    2: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoCartaCorrecao(Pc_Cd_Nota);
    3: Lc_Cd_Vinculo := Pc_Cd_Nota;
  end;

  //Salva o Arquivo XML da NOta no diretorio
  if (Lc_Cd_Vinculo > 0 ) then
  Begin
    Pc_Salva_Arq_Disco(Pc_Tipo,
                       'XML',
                       Lc_Cd_Vinculo ,
                       Pc_Path + '\' +  Pc_FileXML);
    //Se o Arquivo não existir e se o conteudo é maior do zero
    if (not FileExists(Pc_Path + '\' +  Pc_FileXML)) or (Fc_BuscaTamArquivo(Pc_Path + '\' +  Pc_FileXML) = 0) then
    Begin
      Result := False;
    end;
  end
  else
  Begin
    Result := False;
  end;
end;

function Fc_VerificaExistenciaArquivoNFCEXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):boolean;
Var
  Lc_Cd_Vinculo : Integer;
Begin
  Result := True;
  Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNFCeArquivo(Pc_Cd_Nota);
  //Salva o Arquivo XML da NOta no diretorio
  if (Lc_Cd_Vinculo > 0 ) then
  Begin
    Pc_Salva_Arq_Disco(Pc_Tipo,
                       'XML',
                       Lc_Cd_Vinculo ,
                       Pc_Path + '\' +  Pc_FileXML);
    //Se o Arquivo não existir e se o conteudo é maior do zero
    if (not FileExists(Pc_Path + '\' +  Pc_FileXML)) or (Fc_BuscaTamArquivo(Pc_Path + '\' +  Pc_FileXML) = 0) then
    Begin
      Result := False;
    end;
  end
  else
  Begin
    Result := False;
  end;
end;

procedure Pc_VerificaExistenciaArquivoCartaXML(Pc_Tipo:Integer;Pc_Cd_Carta:Integer;Pc_Path,Pc_FileXMl:String);
Begin
  //Salva o Arquivo XML da NOta no diretorio
  Pc_Salva_Arq_Disco(Pc_Tipo,
                     'XML',
                     Pc_Cd_Carta ,
                     Pc_Path + '\' +  Pc_FileXML);
  //Se o Arquivo não existir e se o conteudo é maior do zero
  if (not FileExists(Pc_Path + '\' +  Pc_FileXML)) or (Fc_BuscaTamArquivo(Pc_Path + '\' +  Pc_FileXML) = 0) then
    Begin


    end;
end;






procedure Pc_AtivaConfiguracaoNFe;
Begin
  with DM.Qr_Nf_Eletronica do
  Begin
    Active := False;
    ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
    Active := True;
    FetchAll;
    First;
  end;
end;

function Fc_VerificaNotaXMLCompra(Pc_Cd_Nota:Integer):Integer;
Var
  Lc_SqlTxt : String;
  qr_aux:TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    qr_aux := LcBase.GeraQuery;
    with qr_aux do
    BEgin
      SQL.Clear;
      Lc_SqlTxt := 'SELECT NFL_CODIGO '+
                   'FROM TB_NOTA_FISCAL '+
                   '  INNER JOIN TB_PEDIDO '+
                   '  ON (PED_CODIGO = NFL_CODPED) '+
                   'WHERE (NFL_CODIGO=:NFL_CODIGO) AND (PED_TIPO = ''2'')';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NFL_CODIGO').AsInteger := Pc_Cd_Nota;
      Active := True;
      FetchAll;
      result := FieldByName('NFL_CODIGO').AsInteger;
    end;
  Finally
    qr_aux.Close;
    qr_aux.DisposeOf;
  End;

end;






Function Fc_ValidaEnvioNfePDF(Fc_Cd_Cliente:Integer):Boolean;
Var
  Lc_SqlTxt : String;
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    //faz a cnsulta na tabela de retono
    Result := True;
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'SELECT CLI_JUST_XML_NFE '+
                   'FROM TB_CLIENTE '+
                   'WHERE CLI_CODEMP=:EMP_CODIGO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
      Active := True;
      FetchAll;
      First;
      Result := (FieldByName('CLI_JUST_XML_NFE').AsString <> 'S');
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_Valida_enderecoPedido(Pc_cd_Endereco:Integer;Pc_Endereco:String): Boolean;
Var
  Lc_Qry:TSTQuery;
  Lc_Bairro : String;
  Lc_Cep : String;
  Lc_Numero : String;
  Lc_Endereco : String;
  LcBase : TControllerBase;
Begin
  Result:=true;
  if (Trim(Pc_Endereco) = '') then
  Begin
    MensagemPadrao(' Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   ' Endereço de entrega não informado.'+EOLN+EOLN+
                   ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result := False;
    exit;
  end;

  if (Pc_cd_Endereco = 0) then
  Begin
    MensagemPadrao(' Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   ' Verifique os dados do endereço.'+EOLN+EOLN+
                   ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    result := False;
    exit;
  end;

  try
    //faz a cnsulta na tabela de retono
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT end_bairro,end_cep, end_numero, end_ender FROM tb_endereco ');
      SQL.Add(' WHERE end_codigo =:end_codigo  ');
      ParamByName('end_codigo').AsInteger:= Pc_cd_Endereco;
      Active:=true;
      Lc_Bairro := trim(FieldByName('end_bairro').AsString);
      Lc_Cep := trim(FieldByName('end_cep').AsString);
      Lc_Numero := Trim(FieldByName('end_numero').AsString);
      Lc_Endereco := trim(FieldByName('end_ender').AsString);
    End;
  finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;

  If  Lc_Bairro = '' then
  Begin
      MensagemPadrao(' Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     ' O Bairro do endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

  If Lc_Cep = '' then
  Begin
      MensagemPadrao(' Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     ' O CEP do endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

  If Lc_Numero = '' then
  Begin
      MensagemPadrao(' Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     ' O Número do endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

  If Lc_Endereco = '' then
  Begin
      MensagemPadrao(' Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                     ' O endereço de Entrega não foi informado.'+EOLN+EOLN+
                     ' Favor preecher os dados e tentar novamente'+EOLN+EOLN,
                     ['OK'],[bEscape],mpAlerta);
      Result := False;
      exit;
  end;

end;

procedure Pc_GravaEvento(Pc_Codigo        : Integer;
                         Pc_NUMERO        : Integer;
                         Pc_CHAVE         : String;
                         Pc_CODNVT        : Integer;
                         Pc_DATA          : TDateTime;
                         Pc_SEQUENCIA     : String;
                         Pc_SIT_NFE       : String;
                         Pc_SIT_CONF      : String;
                         Pc_TP_NF         : String;
                         Pc_JUSTIFICATIVA : String;
                         PC_STATUS        : String);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'insert into "TB_NFE_LOTE_EVENTO"( '+
                   '   "NLT_CODIGO" '+
                   ' , "NLT_NUMERO" '+
                   ' , "NLT_CHAVE" '+
                   ' , "NLT_CODNVT" '+
                   ' , "NLT_DATA" '+
                   ' , "NLT_SEQUENCIA" '+
                   ' , "NLT_SIT_NFE" '+
                   ' , "NLT_SIT_CONF" '+
                   ' , "NLT_TP_NF" '+
                   ' , "NLT_JUSTIFICATIVA" '+
                   ' , "NLT_STATUS" '+
                   ' )values( '+
                   '   :"NLT_CODIGO" '+
                   ' , :"NLT_NUMERO" '+
                   ' , :"NLT_CHAVE" '+
                   ' , :"NLT_CODNVT" '+
                   ' , :"NLT_DATA" '+
                   ' , :"NLT_SEQUENCIA" '+
                   ' , :"NLT_SIT_NFE" '+
                   ' , :"NLT_SIT_CONF" '+
                   ' , :"NLT_TP_NF" '+
                   ' , :"NLT_JUSTIFICATIVA" '+
                   ' , :"NLT_STATUS") ';
      SQL.Add(Lc_SqlTxt);

      ParamByName('NLT_CODIGO').AsInteger := Fc_Generator('GN_NFE_LOTE_EVENTO','TB_NFE_LOTE_EVENTO','NLT_CODIGO');
      ParamByName('NLT_NUMERO').AsInteger := Pc_NUMERO;
      ParamByName('NLT_CHAVE').AsString := Pc_CHAVE;
      ParamByName('NLT_CODNVT').AsInteger := Pc_CODNVT;
      ParamByName('NLT_DATA').AsDateTime := Pc_DATA;
      ParamByName('NLT_SEQUENCIA').AsString := Pc_SEQUENCIA;
      ParamByName('NLT_SIT_NFE').AsString := Pc_SIT_NFE;
      ParamByName('NLT_SIT_CONF').AsString := Pc_SIT_CONF;
      ParamByName('NLT_TP_NF').AsString := Pc_TP_NF;
      ParamByName('NLT_JUSTIFICATIVA').AsString := Pc_JUSTIFICATIVA;
      ParamByName('NLT_STATUS').AsString := PC_STATUS;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaEventoManifestacao(Fc_Chave:String):Boolean;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    Result := False;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NLT_CODIGO from TB_NFE_LOTE_EVENTO '+
                   ' WHERE NLT_CHAVE =:NLT_CHAVE';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NLT_CHAVE').AsString := Fc_Chave;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaCodigoDescricaoCFOP(Fc_CFOP:String):TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    Result := TStringList.Create;
    Result.Clear;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select NAT_CODIGO, NAT_CFOP, NAT_DESCRICAO from TB_NATUREZA '+
                   ' WHERE NAT_CFOP =:NAT_CFOP';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NAT_CFOP').AsString := Fc_CFOP;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Begin
        Result.Add(FieldByname('NAT_CODIGO').AsString);
        Result.Add(FieldByname('NAT_CFOP').AsString);
        Result.Add(FieldByname('NAT_DESCRICAO').AsString);
        end
      else
        Begin
        Result.Add('');
        Result.Add('');
        Result.Add('');
        end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaCodigoReferenciaCFOP(Fc_CFOP:String):TStringList;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  TRy
    Result := TStringList.Create;
    Result.Clear;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select DISTINCT NAT_CODIGO, NAT_CFOP, NAT_DESCRICAO '+
                   'FROM tb_natureza '+
                   '   INNER JOIN TB_CFOP_CFOP '+
                   '   ON (NAT_CODIGO = NAT_CODDEST) '+
                   'WHERE NAT_CODORIG =:NAT_CODORIG ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NAT_CODORIG').AsString := Fc_CFOP;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Begin
        Result.Add(FieldByname('NAT_CODIGO').AsString);
        Result.Add(FieldByname('NAT_CFOP').AsString);
        Result.Add(FieldByname('NAT_DESCRICAO').AsString);
        end
      else
        Begin
        Result.Add('');
        Result.Add('');
        Result.Add('');
        end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaCodigoReferenciaCST(Fc_CST:String):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select TBi_CODIGO '+
                   'FROM TB_TRIB_ICMS_NR  '+
                   'WHERE TBI_GRUPO =:TBI_GRUPO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('TBI_GRUPO').ASString := Fc_CST;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('TBI_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaCodigoReferenciaCSOSN(Fc_CSOSN:String):Integer;
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'select TBi_CODIGO '+
                   'FROM TB_TRIB_ICMS_SN  '+
                   'WHERE TBI_GRUPO =:TBI_GRUPO ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('TBI_GRUPO').ASString := Fc_CSOSN;
      Active := True;
      FetchAll;
      if (RecordCount > 0) then
        Result := FieldByname('TBI_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_VincularCodigosCFOP(Fc_Cd_CFOP_Origem,Fc_Cd_CFOP_Destino:String);
Var
  Lc_Qry : TSTQuery;
  Lc_SqlTxt : String;
  Lc_FileStream : TFileStream;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Clear;
      Lc_SqlTxt := 'UPDATE OR INSERT INTO TB_CFOP_CFOP (NAT_CODORIG, NAT_CODDEST) '+
                   ' VALUES (:NAT_CODORIG, :NAT_CODDEST) '+
                   ' MATCHING (NAT_CODORIG, NAT_CODDEST) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('NAT_CODORIG').AsString := Fc_Cd_CFOP_Origem;
      ParamByName('NAT_CODDEST').AsString := Fc_Cd_CFOP_Destino;
      ExecSQL;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;





function Fc_Valida_CNPJ (Fc_Numero,Fc_Tipo : string) : Boolean;
Begin
  Result := True;
  if not (TestaCgc(TRIM(Fc_Numero))) then
  begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   ' Número de C.N.P.J. do ' + Fc_Tipo +'Inválido.' + EOLN +
                   ' Verifique o C.N.P.J.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    Result := False;
    exit;
  end;
end;

function Fc_Valida_CPF (Fc_Numero,Fc_Tipo : string) : Boolean;
Begin
  Result := True;
  if not (TestaCpf(TRIM(Fc_Numero))) then
  begin
    MensagemPadrao(' Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   ' Número de C.P.F. do ' + Fc_Tipo +' Inválido.' + EOLN +
                   ' Verifique o C.P.F.' + EOLN,
                   ['OK'], [bEscape], mpErro);
     Result := False;
     exit;
  end;
end;



function Fc_Valida_Tel_Endereco(Fc_cd_endereco:Integer): Boolean;
var
  Lc_Qry : TSTQuery;
  Lc_aux:String;
  LcBase : TControllerBase;
begin
  TRy
    Result:=true;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Sql.Clear;
      SQL.Add('select end_fone from tb_endereco where end_codigo =:end_codigo');
      ParamByName('end_codigo').AsInteger:= Fc_cd_endereco;
      Active:=True;
      Lc_Aux := TRim(fieldbyname('END_FONE').AsString);
      Lc_Aux := RemoveCaracterInformado(Lc_Aux, ['.',',','/','-','(',')']);
      if(trim(Lc_Aux) <> '') and (Length(trim(Lc_Aux)) < 10) then
        Result:=false;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_SalvarArquivoTexto(Pc_Path,Pc_File, Texto:String);
var
  txt: textfile;
  Lc_Memo:TStringList;
begin
  Try
    Lc_Memo := TStringList.Create;
    Lc_Memo.Append(Texto);
    Lc_Memo.SaveToFile(Pc_Path + '\' + Pc_File);
  Finally
    Lc_Memo.DisposeOf;
  End;
end;

function Fc_AnexarXmlNFe(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXMl:String):Boolean;
Var
  Lc_Cd_Vinculo : Integer;
Begin
  Result := False;
  case pc_tipo of
    1: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoNfeArquivo(Pc_Cd_Nota);
    2: Lc_Cd_Vinculo := Fc_VerificaCodigoVinculoCartaCorrecao(Pc_Cd_Nota);
    3: Lc_Cd_Vinculo := Pc_Cd_Nota;
    4: Lc_Cd_Vinculo := Pc_Cd_Nota;
    5: Lc_Cd_Vinculo := Pc_Cd_Nota;
    6: Lc_Cd_Vinculo := Pc_Cd_Nota;
  end;

  //Salva o Arquivo XML da NOta no diretorio
  if (Lc_Cd_Vinculo > 0 ) then
  Begin
    Try
      Result := True;
      Pc_Insere_Arq_Banco(Pc_Path,
                          Pc_FileXMl,
                          Pc_Tipo,
                          'XML',
                          Lc_Cd_Vinculo);
    Except
      Result := False;
    End;
  End;

End;

function DefineTipoCertificadoConfig(Tipo:Integer):String;
Begin
  if  Tipo = 0 then
  BEgin
    Result :=
          concat('O certificado deve estar na pasta do Sistema.',#13,
                 'O nome do certificado deve ser ',
                 'cert_',
                 DM.Qr_Estabelecimento.FieldByName('EMP_CNPJ').AsString,
                 '.pfx'
          );
  End
  else
  Begin
    Result :=
          concat('Verifique a instalação dos drives do dispositivo.',#13,
                 'Utilize o botão "Carregar o certificado".'
          );
  End;
End;


end.



