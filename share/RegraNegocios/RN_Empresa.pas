unit RN_Empresa;

interface

uses
  STDatabase, STQuery, SysUtils,ACBrValidador,STTransaction,
  Vcl.Samples.Gauges, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Forms, Vcl.Dialogs;

{----------------------------------------}
  type TRetornoDados = Record
      It_Dados : Array of Array of String;
  end;

   function Fc_BuscaCodigoEmpresa(FcDataBase : TSTDatabase;
                                  FcTransaction : TSTTransaction;
                                  Fc_CNPJ: String): Integer;
   function Fc_BuscaNomeEmpresa(Fc_Campo,Fc_cd_Empresa:String):String;
   function Fc_BuscaCodigoEndereco(FcDataBase : TSTDatabase;
                                   FcTransaction : TSTTransaction;
                                   Fc_cd_Empresa: Integer): Integer;

  function Fc_Valida_Dados_Empresa_NFE(Fc_Cd_Empresa:Integer): Boolean;
  function Fc_VerificaCNPJ_CPF(Fc_Cd_Codigo:Integer;fc_documento: string):Integer;
  function Fc_AbreTelaPesqEmpresa(Pc_Tipo_Empresa:Integer;CodigoVendedor:Integer):TRetornoDados;
  procedure Pc_AbreListaEmpresa(Tipo:Integer;Pc_Order:String);
  function Fc_LocalizaCodigoListaComboEmpresa(Fc_Tipo:Integer; Fc_Nm_Empresa:String;Fc_Chbx_Nome,Fc_Chbx_Fantasia:TCheckBox):String;
  procedure Pc_ListaEmpresaDbLookUpComboBox(Pc_Tipo:Integer;Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TDBLookupComboBox);
  Function Fc_AbreTelaEmpresa(Pc_Cd_Codigo:Integer):TRetornoDados;
  procedure Pc_ListaEmpresaComboBox(Pc_Tipo:Integer;Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TComboBox);
  procedure Pc_AtualizaUltimaMovimentacao(Pc_Data_Ini,Pc_Data_Fim:TDateTime;Pc_Progresso:TGAuge);
  function  Fc_Valida_Insc_Estadual(Fc_Numero,Fc_Estado,Fc_Tipo:String): Boolean;
  function Fc_EmpresaExiste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean):Integer;
  Function Fc_ObsEmpresaNotaFiscal(Fc_Cd_Cliente:Integer):String;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet,  Un_Regra_Negocio, RN_NotaFiscalEletronica3X,
    RN_Crud, UN_TabelasEmListas, RN_Cliente,RN_Fornecedor, RN_Transportadora,
      ControllerEmpresa,ControllerBase, UnFunctions;

function Fc_BuscaCodigoEmpresa(FcDataBase : TSTDatabase;
                               FcTransaction : TSTTransaction;
                               Fc_CNPJ: String): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select EMP_CODIGO FROM TB_EMPRESA WHERE EMP_CNPJ=:EMP_CNPJ');
      ParamByName('EMP_CNPJ').AsAnsiString := Fc_CNPJ;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('EMP_CODIGO').AsInteger
      else
        Result := 0;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_BuscaNomeEmpresa(Fc_Campo,Fc_cd_Empresa:String):String;
Var
  Lc_Qry:TSTQuery;
  LcBase : TControllerBase;
Begin
  if StrToIntDef(Trim(Fc_cd_Empresa),0) > 0 then
  Begin
    Try
      LcBase := TControllerBase.create(nil);
      Lc_Qry := LcBase.GeraQuery;
      with Lc_Qry do
      Begin
        SQL.Add('SELECT ' + Fc_Campo +'  FROM TB_EMPRESA WHERE EMP_CODIGO=:EMP_CODIGO ');
        ParamByName('EMP_CODIGO').AsAnsiString := Fc_cd_Empresa;
        Active := True;
        FetchAll;
        if (RecordCount>0) then
        Begin
          Result := FieldByname(fc_campo).AsAnsiString
        end
        else
        Begin
          MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                         'Empresa não localizada.' + EOLN +
                         'Verifique e tente novamente.' + EOLN ,
                         ['OK'], [bEscape], mpInformacao);
        end;
      end;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  end;
end;

function Fc_BuscaCodigoEndereco(FcDataBase : TSTDatabase;
                                FcTransaction : TSTTransaction;
                                Fc_cd_Empresa: Integer): Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select END_CODIGO FROM TB_ENDERECO WHERE END_CODEMP=:END_CODEMP');
      ParamByName('END_CODEMP').AsInteger := Fc_cd_Empresa;
      Active := True;
      FetchAll;
      IF (Recordcount > 0) then
        Result := FieldByName('END_CODIGO').AsInteger
      else
        Result := 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_Valida_Dados_Empresa_NFE(Fc_Cd_Empresa:Integer): Boolean;
Var
  lc_aux :String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Result := True;
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  with Lc_Qry do
  Begin
    Sql.Add('SELECT '+
            '  EMP_SUB_TRIB, '+
            '  EMP_INSC_EST, '+
            '  EMP_CNPJ, '+
            '  CDD_DESCRICAO, '+
            '  CDD_IBGE, '+
            '  END_CEP, '+
            '  END_ENDER, '+
            '  END_NUMERO, '+
            '  END_BAIRRO, '+
            '  END_FONE, '+
            '  END_FAX, '+
            '  END_COMERCIAL, '+
            '  END_COMPLEM, '+
            '  END_PAIS, '+
            '  UFE_SIGLA '+
            'FROM TB_EMPRESA tb_empresa '+
            '   INNER JOIN TB_ENDERECO tb_endereco '+
            '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO) '+
            '   INNER JOIN TB_CIDADE tb_cidade '+
            '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD) '+
            '   INNER JOIN TB_UF tb_uf '+
            '   ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE) '+
            '   INNER JOIN TB_PAIS tb_pais '+
            '   ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS) '+
            'WHERE (EMP_CODIGO=:EMP_CODIGO) AND (END_PRINCIPAL = ''S'') ');
    ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Empresa;
    Active := True;
    FetchAll;
    if recordcount = 0 then
    Begin
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Cadastro do cliente incompleto!'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      result := False;
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
      Exit;
    end;

    if FieldByName('END_PAIS').AsInteger = 1058 then
    Begin
      //valida O cnpj do Destinario
      Lc_Aux := FieldByName('EMP_CNPJ').AsAnsiString;
      If (Length(Lc_Aux) = 14) then
      Begin
        if not Fc_Valida_CNPJ(Lc_Aux,'Destinatário') then
        begin
          Result := False;
          LcBase.FinalizaQuery(Lc_Qry);
          LcBase.DisposeOf;
          exit;
        end;

        //Valida Inscrição do Destinatario
        Lc_Aux := RemoveCaracterInformado(FieldByName('EMP_INSC_EST').AsAnsiString,['.',',','/','-']);

        if not Fc_Valida_Insc_Estadual(Lc_Aux, FieldByName('UFE_SIGLA').AsAnsiString, 'Destinatário') then
        begin
          Result := False;
          LcBase.FinalizaQuery(Lc_Qry);
          LcBase.DisposeOf;
          exit;
        end;
      end
      else
      Begin
        if not Fc_Valida_CPF(Lc_Aux,'Destinatário') then
        begin
          Result := False;
          LcBase.FinalizaQuery(Lc_Qry);
          LcBase.DisposeOf;
          exit;
        end;
      end;

      //Valida Cidade do IBGE e se o endereço está completo
      if (Length(FieldByName('CDD_DESCRICAO').AsAnsiString) = 0) then
      begin
        MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'Cidade IBGE Destinatário não encontrado !'+EOLN+
                       'Verifique e tente novamente'+EOLN,
                       ['OK'],[bEscape],mpErro);
        Result := False;
        LcBase.FinalizaQuery(Lc_Qry);
        LcBase.DisposeOf;
        exit;
      end;
    end;

    //Valida o numero predial do endereco do Destinatario
    if (Length(FieldByName('END_ENDER').AsAnsiString) = 0) then
    begin
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Endereço do Destinatário não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
      Result := False;
      exit;
    end;

    //Valida o numero predial do endereco do Destinatario
    if (Length(FieldByName('END_NUMERO').AsAnsiString) = 0) then
    begin
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Número predial do Destinatário não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
      exit;
    end;

    //Valida o bairro  do emitente
    if (FieldByName('END_BAIRRO').AsAnsiString = '') then
    begin
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Bairro do Destinatário não encontrado !'+EOLN+
                     'Verifique e tente novamente'+EOLN,
                     ['OK'],[bEscape],mpErro);
      Result := False;
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
      exit;
    end;
  end;
  LcBase.FinalizaQuery(Lc_Qry);
  LcBase.DisposeOf;
end;


function Fc_VerificaCNPJ_CPF(Fc_Cd_Codigo:Integer;fc_documento: string):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt: String;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt:=' select EMP_CODIGO '+
                 'from tb_empresa    '+
                 'WHERE (EMP_CNPJ = :EMP_CNPJ) and (EMP_CODIGO<>:EMP_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      ParamByName('EMP_CODIGO').AsInteger:= Fc_Cd_Codigo;
      fc_documento := RemoveCaracterInformado(fc_documento, ['.',',','/','-']);
      ParamByName('EMP_CNPJ').AsAnsiString:= fc_documento;
      Active:=TRUE;
      FetchAll;
      if (RecordCount > 0) then
        Result:= FieldByName('EMP_CODIGO').AsInteger
      else
        Result:= 0;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_AbreTelaPesqEmpresa(Pc_Tipo_Empresa:Integer;CodigoVendedor:Integer ):TRetornoDados;
//Var
//  Lc_Form : TFr_Pesq_Empresa;
begin
  ShowMessage('Verificar');
//  Try
//    Lc_Form := TFr_Pesq_Empresa.Create(nil);
//    Lc_Form.It_Tipo_Empresa := Pc_Tipo_Empresa;
//    Lc_Form.ShowModal;
//    case Pc_Tipo_Empresa of
//      1:Pc_AbreListaCliente('EMP_NOME');
//      2:Pc_AbreListaFornecedor('EMP_NOME');
//      3:Pc_AbreListaTransportadora('EMP_NOME');
//    else
//      Pc_AbreListaEmpresa(-1,'EMP_NOME');
//    end;
//    SetLength(Result.It_Dados,2,2);
//    if Lc_Form.Qr_Pesquisa.RecordCount > 0 then
//    Begin
//      Result.It_Dados[0,0] := 'EMP_CODIGO';
//      Result.It_Dados[1,0] := Lc_Form.Qr_Pesquisa.FieldByName('EMP_CODIGO').AsAnsiString;
//      Result.It_Dados[0,1] := 'EMP_NOME';
//      Result.It_Dados[1,1] := Lc_Form.Qr_Pesquisa.FieldByName('EMP_NOME').AsAnsiString;
//    end;
//  Finally
//    Lc_Form.DisposeOf;
//  End;
end;

procedure Pc_AbreListaEmpresa(Tipo:Integer;Pc_Order:String);
Begin
  case Tipo of
    -1:DM_ListaConsultas.Pc_ListaEmpresas(Pc_Order);
     0:DM_ListaConsultas.Pc_ListaEstabelecimentos(Pc_Order);
     1:DM_ListaConsultas.Pc_ListaClientes(Pc_Order);
     2:DM_ListaConsultas.Pc_ListaFornecedores(Pc_Order);
     3:DM_ListaConsultas.Pc_ListaTranportadoras(Pc_Order);
  end;

end;

function Fc_LocalizaCodigoListaComboEmpresa(Fc_Tipo:Integer; Fc_Nm_Empresa:String;Fc_Chbx_Nome,Fc_Chbx_Fantasia:TCheckBox):String;
Begin
  Result := '';
  if Trim(Fc_Nm_Empresa) <> '' then
  Begin
    IF Fc_Chbx_Nome.Checked then
      Pc_AbreListaEmpresa(fc_Tipo,'EMP_NOME')
    else
      Pc_AbreListaEmpresa(fc_tipo,'EMP_FANTASIA');
    with DM_ListaConsultas.Qr_ListaEmpresa do
    Begin
      Active := true;
      First;
      if Fc_Chbx_Nome.Checked then
      Begin
        IF (Locate('EMP_NOME',Fc_Nm_Empresa,[])) then
          Result := FieldByName('EMP_CODIGO').AsAnsiString;
      end
      else
      Begin
        if (Locate('EMP_FANTASIA',Fc_Nm_Empresa,[])) then
          Result := FieldByName('EMP_CODIGO').AsAnsiString;
      end;
    end;
  end;
end;

procedure Pc_ListaEmpresaDbLookUpComboBox(Pc_Tipo:Integer;Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TDBLookupComboBox);
Begin
  if Pc_Check_On.Checked then
  Begin
    case Pc_Tipo of
       0:Pc_Lista.ListSource := DM_ListaConsultas.Ds_ListaEstabelecimento;
       1:Pc_Lista.ListSource := DM_ListaConsultas.Ds_ListaCliente;
       2:Pc_Lista.ListSource := DM_ListaConsultas.Ds_ListaFornecedor;
       3:Pc_Lista.ListSource := DM_ListaConsultas.Ds_ListaTransportadora;
    else
      Pc_Lista.ListSource := DM_ListaConsultas.Ds_ListaEmpresa;
    end;
    Pc_Lista.ListField := Pc_Order;
    Pc_AbreListaEmpresa(Pc_Tipo,Pc_Order);
    Pc_Check_Off.Checked := False;
    Pc_Check_Off.Enabled := true;
    Pc_Check_On.Checked := True;
    Pc_Check_On.Enabled := False;
  end;
end;

Function Fc_AbreTelaEmpresa(Pc_Cd_Codigo:Integer):TRetornoDados;
//Var
//  Lc_Form : TFr_Empresa;
Begin
  ShowMessage('Verificar');
//  Try
//    Lc_Form := TFr_Empresa.Create(nil);
//    Lc_Form.it_Menu := 'Empresas';
//    Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Codigo;
//    Lc_Form.ShowModal;
//    if Lc_Form.CodigoEmpresa > 0 then
//    Begin
//      SetLength(Result.It_Dados,2,2);
//      Result.It_Dados[0,0] := 'EMP_CODIGO';
//      Result.It_Dados[1,0] := IntToStr(Lc_Form.CodigoEmpresa);
//      Result.It_Dados[0,1] := 'EMP_NOME';
//      Result.It_Dados[1,1] := Lc_Form.NomeRazao;
//    end;
//  Finally
//    FreeAndNil(Lc_Form);
//  End;
end;

procedure Pc_ListaEmpresaComboBox(Pc_Tipo:Integer; Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TComboBox);
begin
  if Pc_Check_On.Checked then
  Begin
    Pc_AbreListaEmpresa(Pc_Tipo,Pc_Order);
    Pc_Check_Off.Checked := False;
    Pc_Check_Off.Enabled := true;
    Pc_Check_On.Checked := True;
    Pc_Check_On.Enabled := False;
    with DM_ListaConsultas.Qr_ListaEmpresa do
    Begin
      First;
      Pc_Lista.Clear;
      while not Eof do
      begin
        if Pc_Order = 'EMP_NOME' then
          Pc_Lista.Items.Add(FieldByName('EMP_NOME').AsAnsiString)
        else
          Pc_Lista.Items.Add(FieldByName('EMP_FANTASIA').AsAnsiString);
        Next;
      end;
    end;
  end;
end;

procedure Pc_AtualizaUltimaMovimentacao(Pc_Data_Ini,Pc_Data_Fim:TDateTime; Pc_Progresso:TGAuge);
Var
  lc_aux :String;
  Lc_Qry:TSTQuery;
  Lc_Upd:TSTQuery;
  LcBase : TControllerBase;
Begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Upd := LcBase.GeraQuery;
    with Lc_Upd do
    Begin
      Sql.Add('UPDATE TB_EMPRESA SET '+
              'EMP_DT_ULT_MOV =:EMP_DT_ULT_MOV '+
              'WHERE EMP_CODIGO=:EMP_CODIGO ');
    end;

    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Sql.Add(concat(
                'select NFL_CODEMP, max(NFL_DT_EMISSAO) DATA ',
                'FROM TB_NOTA_FISCAL ',
                'WHERE NFL_DT_EMISSAO BETWEEN :DATAINI AND :DATAFIM ',
                'GROUP BY 1 '
      ));
      ParamByName('DATAINI').AsDateTime := Pc_Data_Ini;
      ParamByName('DATAFIM').AsDateTime := Pc_Data_Fim;
      Active := True;
      FetchAll;
      Pc_Progresso.MinValue := 0;
      Pc_Progresso.MaxValue := RecordCount;
      Pc_Progresso.Progress := 0;
      Application.ProcessMessages;
      First;
      while not eof do
      Begin
        if not Lc_Upd.Transaction.InTransaction then Lc_Upd.Transaction.StartTransaction;
        Lc_Upd.Active := False;
        Lc_Upd.ParamByName('EMP_DT_ULT_MOV').AsDateTime := FieldByName('DATA').AsDateTime;
        Lc_Upd.ParamByName('EMP_CODIGO').AsInteger := FieldByName('NFL_CODEMP').AsInteger;
        Lc_Upd.ExecSQL;
        Lc_Upd.Transaction.Commit;
        next;
        Pc_Progresso.Progress := Pc_Progresso.Progress + 1;
        Application.ProcessMessages;
      end;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.FinalizaQuery(Lc_Upd);
    LcBase.DisposeOf;
  End;
end;

function  Fc_Valida_Insc_Estadual(Fc_Numero,Fc_Estado,Fc_Tipo:String): Boolean;
Var
  Lc_Val_Insc_Est:TACBrValidador;
Begin
  Result := True;
  if (Trim(Fc_Numero) <> '') then
  BEgin
    Lc_Val_Insc_Est := TACBrValidador.Create(nil);
    Lc_Val_Insc_Est.TipoDocto := docInscEst;
    Lc_Val_Insc_Est.IgnorarChar := './-';
    Lc_Val_Insc_Est.Documento := Fc_Numero;
    Lc_Val_Insc_Est.Complemento := Fc_Estado;

    if not Lc_Val_Insc_Est.Validar then
      Begin
      Result := False;
      MensagemPadrao('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Inscrição Estadual do ' + Fc_Tipo + ' é inválida.'+EOLN+
                     'Verifique antes de Continuar' + EOLN,
                     ['OK'],[bEscape],mpAlerta);
      end;
    FreeAndNil(Lc_Val_Insc_Est);
  end;
end;


function Fc_EmpresaExiste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean):Integer;
var
  Lc_SqlTxt: string;
  LcEmpresa : TControllerEmpresa;
begin
  try
    Result:= 0;
    LcEmpresa := TControllerEmpresa.Create(nil);
    LcEmpresa.Registro.CpfCNPJ := fc_documento;
    LcEmpresa.getByDocumento;
    if LcEmpresa.exist then
    Begin
      if (LcEmpresa.Registro.Codigo <> StrToIntDef(Trim(Fc_Cd_Codigo),0) ) then
      Begin
        if Msg then
        Begin
          MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                         'Uma Empresa com este CPF/CNPJ já existe.'+EOLN+
                          LcEmpresa.Registro.Codigo.ToString + ' - ' + LcEmpresa.Registro.NomeRazaoSocial +EOLN+
                         'Verifique e tente novamente.' +EOLN,
                         ['OK'], [bEscape], mpErro);
        End;
        Result:= LcEmpresa.Registro.Codigo;
      End;
    End;
  finally
    LcEmpresa.DisposeOf
  end;
end;


Function Fc_ObsEmpresaNotaFiscal(Fc_Cd_Cliente:Integer):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT CLI_OBS_NF '+
              'from TB_CLIENTE '+
              ' WHERE CLI_CODEMP =:EMP_CODIGO '+
              ' and ( CLI_OBS_NF is not null ) '+
              ' and ( CLI_OBS_NF <> '''' ) ');
      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
      Active := True;
      FetchAll;
      if not FieldByName('CLI_OBS_NF').isNull then
        Result := Trim(FieldByName('CLI_OBS_NF').AsAnsiString)
      else
        Result := '';
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

end.
