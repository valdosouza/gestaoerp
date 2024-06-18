unit RN_NotaFiscalServico;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, OleCtrls, SHDocVw, IniFiles,
  DB, STDataSet, STQuery, Grids, DBGrids, Menus, Mask, Printers,ACBrNFeDANFeESCPOS,
  ACBrNFe, pcnConversao, ACBrNFeDANFEClass, pcnNFeW, pcnLeitor,blcksock,ACBrDFeSSL,
  ACBrNFeNotasFiscais, pcnNFe, ACBrNFeWebServices,pcnConversaoNFe,
  ACBrNFeDANFeRLClass, QuickRpt,ACBrPosPrinter,ControllerBase,
  FavoritoButtons,  Gauges, STDatabase,ACBrValidador;


  procedure Pc_AbreTelaPesqNF_Srv;
  procedure Pc_AbreTelaNF_Srv(PC_Cd_Nota:Integer);
  function Fc_ChamarGeraNFSE(Fc_Operacao:String;
                             Fc_Cd_Nota:Integer):Boolean;

  function Fc_VerificaExistenciaArquivoXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXML:String):Boolean;

  procedure Pc_EnviaEmailNFSe(Pc_cd_Empresa,Pc_Nr_Nota,Pc_Link,Pc_Path,Pc_FileXML,Pc_FilePDF,Pc_Corpo:String);
  Function Fc_ExisteInscrMunicipal(Fc_Cd_Empresa:Integer):Boolean;
  function Fc_NFSEletronicaAtivada():Boolean;
  function DefineTipoCertificadoConfig(Tipo:Integer):String;

  procedure Pc_AtivaConfiguracaoNFSe;
implementation

uses Un_DM, UN_Sistema, UN_MSG, un_Padrao,
  Un_Fc_Sored_Procedures, Un_Pesq_Nf_Srv,Un_NF_SRV, un_geranfe_Srv, Un_Regra_Negocio, UN_Principal,
  RN_Mailing, Un_envia_email;



procedure Pc_AbreTelaPesqNF_Srv;
Var
  Lc_Form : TFr_Pesq_NF_Srv;
begin
  try
    Lc_Form := TFr_Pesq_NF_Srv.Create(nil);
    Lc_Form.ShowModal;
  finally
    Lc_Form.disposeOf
  end;

end;


procedure Pc_AbreTelaNF_Srv(PC_Cd_Nota:Integer);
Var
  Lc_Form: TFr_NF_SRV;
Begin
  TRy
    TRy
      Lc_Form := TFr_NF_SRV.Create(nil);
      Lc_Form.It_Cd_Nota := PC_Cd_Nota;
      Lc_Form.ShowModal;
    except
      on E : Exception do
        MensagemPadrao('Mensagem ', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                       'Por favor Informe este erro ao Desenvolvedor.' + EOLN +
                       E.Message + EOLN,
                       ['OK'], [bEscape], mpErro);
    end;
  Finally
    Lc_Form.DisposeOf;
  End;
end;

function Fc_ChamarGeraNFSE(Fc_Operacao:String;
                           Fc_Cd_Nota:Integer):Boolean;
Var
  Lc_Form : TFr_geranfe_Srv;
  LC_I : Integer;
begin
  Try
    Lc_Form := TFr_geranfe_Srv.Create(nil);
    with Lc_Form do
    Begin
      RetNFse.Registro.CodigoNotaFiscal := Fc_Cd_Nota;
      RetNFse.Registro.CodigoEstabelecimento := Gb_CodMha;
      For LC_I:=1 to pg_Principal.PageCount do
        pg_Principal.Pages[LC_I-1].TabVisible:=False;
      //Pc_AtivaDadosUsuarios;
      MnuTarefas.Visible := False;
      pg_Principal.ActivePage := tbs_NFS_e;
      if Fc_Operacao = 'NFS-e' then
      Begin
        It_Tipo_Operacao := 'NFS-e';
      end;
      if Fc_Operacao = 'Config' then
      Begin
        It_Tipo_Operacao := 'Config';
        MnuTarefas.Visible := True;
        pg_Principal.ActivePage := tbs_config;
      end;
      ShowModal;
    end;
  Finally
    FreeAndNil(Lc_Form);
    SetWindowPos(Gb_Handle,Hwnd_TopMost,0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or  SWP_SHOWWINDOW);
  End;
end;





function Fc_VerificaExistenciaArquivoXML(Pc_Tipo:Integer;Pc_Cd_Nota:Integer;Pc_Path,Pc_FileXML:String):Boolean;
Begin
  Result := True;
  //Salva o Arquivo XML da NOta no diretorio
  if (Pc_Cd_Nota > 0 ) then
  Begin
    if not DirectoryExists(Pc_Path) then ForceDirectories(Pc_Path);
    Pc_Salva_Arq_Disco(Pc_Tipo,
                       'XML',
                       Pc_Cd_Nota,
                       concat(Pc_Path,'\', Pc_FileXML));
    //Se o Arquivo não existir e se o conteudo é maior do zero
    if (not FileExists(concat(Pc_Path,'\', Pc_FileXML))) or (Fc_BuscaTamArquivo(concat(Pc_Path,'\', Pc_FileXML)) = 0) then
    Begin
      Result := False;
    end;
  end
  else
  Begin
    Result := False;
  end;
end;


procedure Pc_EnviaEmailNFSe(Pc_cd_Empresa,Pc_Nr_Nota,Pc_Link,Pc_Path,Pc_FileXML,Pc_FilePDF,Pc_Corpo:String);
Var
  Lc_Aux : String;
  Lc_Destinatario : TStringList;
  Lc_AssuntoEmail : string;
  Lc_Corpo : String;
  lc_anexo :TStringList;
  LcEnviaemail : TFr_envia_email;
begin
  Lc_Destinatario := TStringList.Create;
  Lc_Anexo        := TStringList.Create;
  //Envia email para a propria empresa
  if DM.Qr_Nf_Eletronica.FieldByName('NFE_COPIA_EMAIL').AsString = 'S' then
    Pc_ListaEmailParaEnvio(DM.Qr_Estabelecimento.FieldByName('EMP_CODIGO').AsString,['PRINCIPAL%','NF-e%'],Lc_Destinatario) ;
  //Verifica se o cliente Possue email
  Pc_ListaEmailParaEnvio(Pc_cd_Empresa,['PRINCIPAL%','NF-e%'],Lc_Destinatario) ;
  //Verifica se o contador Possue email
  if Length(DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString)>0 then
    Lc_Destinatario.Add(' ' + DM.Qr_Nf_Eletronica.FieldByName('NFE_EMAIL_CONTADOR').AsString);

  //Verifica se o email do Destinatario informado e mostra o imput
  if Lc_Destinatario.Count = 0 then
    Begin
    InputQuery('Enviar Email', 'Email de destino',Lc_Aux );
    if Length(Trim(Lc_Aux))>0 then Lc_Destinatario.Add(' '+Lc_Aux)
    end;

  if Lc_Destinatario.Count = 0 then
    Begin
    MensagemPadrao('Mensagem de erro', 'A T E N Ç Ã O!.' + EOLN + EOLN +
                   'e-mail não encontrado no Cadastro e/ou não informado.' + EOLN +
                   '          Verifique  e tente novamente.' + EOLN,
                   ['OK'], [bEscape], mpErro);
    exit;
    end;
  Try
    LcEnviaemail := TFr_envia_email.create(nil);
      with LcEnviaemail do
      Begin
        Lc_AssuntoEmail := 'Envio de NFS-e Nº '+ Pc_Nr_Nota;
        if (Trim(Pc_FileXML)<> '') then
          lc_anexo.Add(Pc_Path + '\' +  Pc_FileXML)
        else
          lc_anexo.Add('Sem anexo');
        if (Trim(Pc_FilePDF)<> '') then
          lc_anexo.Add(Pc_Path + '\' +  Pc_FilePDF)
        else
          lc_anexo.Add('Sem anexo');
        if (Fc_Tb_Geral('L','GRL_G_EMAIL_SISTEMANFE','S') = 'S') then
          It_Tipo_Envio := 'N'
        else
          It_Tipo_Envio := 'S';
        It_Assunto := Lc_AssuntoEmail;
        It_Destino := Lc_Destinatario;
        It_Corpo := Pc_Corpo;
        It_Anexo   := lc_anexo;
        ShowModal;
      end;
  Finally
    Lc_Destinatario.disposeOf;
    lc_anexo.disposeOf;
    FreeAndNil(LcEnviaemail);
  End;
end;

Function Fc_ExisteInscrMunicipal(Fc_Cd_Empresa:Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select EMP_NOME,EMP_INSC_MUN '+
               'from tb_empresa '+
               'where EMP_CODIGO = :EMP_CODIGO');

      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Empresa;
      Open;
      FetchAll;
      if (Trim(FieldByName('EMP_INSC_MUN').AsString) <> '') then
      Begin
        Result:= true;
      end
      else
      Begin
        MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'Por favor antes de proseguir preencha o campo '+EOLN+
                       'Inscrição Municipal da empresa '+ FieldByName('EMP_INSC_MUN').AsString +EOLN+
                       'Verique e tente novamente'+EOLN,
                       ['OK'], [bEscape], mpAlerta);
        Result:=false;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_NFSEletronicaAtivada():Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select NFS_CODEMP '+
               'from TB_NFS_ELETRONICA '+
               'where ( NFS_CODEMP = :EMP_CODIGO )'+
               '  and ( NFS_CERTIFICADO is not null ) '+
               '  and ( NFS_CERTIFICADO <> '''' )');

      ParamByName('EMP_CODIGO').AsInteger := Gb_CodMha;
      active := True;
      FetchAll;
      Result := (recordCount > 0 ) ;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

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



procedure Pc_AtivaConfiguracaoNFSe;
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

end.





