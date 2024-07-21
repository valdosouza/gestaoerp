unit RN_Mailing;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,FireDAC.Stan.Param,
  StdCtrls,classes,db;


  function Fc_AtualizaMailing(Fc_CODEMP,
                              Fc_TIPO,
                              Fc_EMAIL,
                              Fc_NOME:String):Integer;
  procedure Pc_ListaEmailParaEnvio(Pc_cd_Empresa:String;Pc_Tipos : array of string;Pc_Lista:TStringList);
  function Fc_GeraAssinaturaEmail:String; //(Parent:TWinControl)
  function Fc_ValidaEmail(email:String):boolean;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet,Un_Regra_Negocio, RN_Endereco, RN_Crud,  main;

function Fc_AtualizaMailing(Fc_CODEMP,
                            Fc_TIPO,
                            Fc_EMAIL,
                            Fc_NOME:String):Integer;
Var
  Lc_Qry:TSTQuery;
  Lc_Codigo : Integer;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    if not DM.IB_Transacao.InTransaction then DM.IB_Transacao.StartTransaction;
    Lc_Codigo := StrToIntDef(TStringList(Fc_VerificaRegistro('tb_mailing',['MLG_CODEMP','MLG_TIPO'],[Fc_CODEMP,Fc_TIPO],['MLG_CODEMP','MLG_TIPO'])).Strings[0],0);
    if (Lc_Codigo > 0) then
    Begin //Atualiza
      SQL.Add('update tb_mailing set '+
              'MLG_EMAIL = :MLG_EMAIL, '+
              'MLG_NOME = :MLG_NOME '+
              'where  (MLG_CODEMP = :MLG_CODEMP) AND (MLG_TIPO = :MLG_TIPO)');
      end
    else
      Begin//Insere
      SQL.Add('insert into tb_mailing( '+
              '  MLG_CODEMP, '+
              '  MLG_TIPO, '+
              '  MLG_EMAIL, '+
              '  MLG_NOME) '+
              'values( '+
              '  :MLG_CODEMP, '+
              '  :MLG_TIPO, '+
              '  :MLG_EMAIL, '+
              '  :MLG_NOME)');
      end;
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros
    ParamByName('MLG_CODEMP').AsAnsiString := Fc_CODEMP;
    ParamByName('MLG_TIPO').AsAnsiString := Fc_TIPO;
    ParamByName('MLG_EMAIL').AsAnsiString := Fc_EMAIL;
    ParamByName('MLG_NOME').AsAnsiString := Fc_NOME;
      Try
        ExecSQL;
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.CommitRetaining;
        Result := StrToIntDef(Fc_CODEMP,0);
      except
        if DM.IB_Transacao.InTransaction then DM.IB_Transacao.RollbackRetaining;
        Result := 0;
      end;
    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);

end;

procedure Pc_ListaEmailParaEnvio(Pc_cd_Empresa:String;Pc_Tipos : array of string;Pc_Lista:TStringList);
Var
  Lc_Qry:TSTQuery;
  Lc_Codigo : Integer;
  Lc_I : Integer;
  Lc_SqlTxt : String;
Begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    CachedUpdates := True;
    Active := False;
    SQL.Clear;
    Lc_SqlTxt := 'SELECT DISTINCT MLG_EMAIL '+
                 'FROM TB_MAILING '+
                 'WHERE (MLG_CODEMP=:EMP_CODIGO) ';
    if (High(Pc_Tipos) =0) then
    Begin
      Lc_SqlTxt := Lc_SqlTxt + ' AND (MLG_TIPO like ''' + Pc_Tipos[0] + ''') ';
    end
    else

    Begin
      For Lc_I := 0 to High(Pc_Tipos) do
      Begin
        if (Lc_I =0) then
          Lc_SqlTxt := Lc_SqlTxt + ' AND ( (MLG_TIPO like ''' + Pc_Tipos[lc_I] + ''') '
        else
          Lc_SqlTxt := Lc_SqlTxt + ' OR  (MLG_TIPO like ''' + Pc_Tipos[lc_I] + ''') '
      end;
      Lc_SqlTxt := Lc_SqlTxt + ')';
    end;
    SQL.add(Lc_SqlTxt);
    ParamByName('EMP_CODIGO').AsAnsiString := Pc_cd_Empresa;
    Active := True;
    First;
    while not eof do
    Begin
      Pc_Lista.Add(' ' + FieldByName('MLG_EMAIL').AsAnsiString);
      next;
    end;
  end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


function Fc_GeraAssinaturaEmail:String;//(Parent:TWinControl)
Var
  Lc_Obs : TMemo;
  Lc_I : Integer;
  Lc_Texto: TMemoryStream;
  Lc_Qry: TSTQuery;
Begin
  Lc_Qry := TSTQuery.create(Application);
  with Lc_Qry do
  Begin
    Database := Dm.IBD_Gestao;
    Transaction := DM.IB_Transacao;
    ForcedRefresh := True;
    sql.Clear;
    SQL.Add('SELECT USU_ASSINATURA FROM TB_USUARIO WHERE USU_CODIGO=:USU_CODIGO');
    ParamByName('USU_CODIGO').AsInteger := GB_Cd_Usuario;
    Active := True;
    FetchAll;

    Result :=
    '<br> '+
    '<br> '+
    '<table style="text-align: left; width: 100%;" border="0" '+
    ' cellpadding="0" cellspacing="0"> '+
    '  <tbody> '+
    '    <tr> '+
    '      <td><span style="color: rgb(0, 0, 102);"><span '+
    ' style="font-size: 10pt; font-family: Arial;">';

    Result := '';
    if Length(Trim(FieldByName('USU_ASSINATURA').AsString))>0 then
    Begin
      Try
        Lc_Obs := TMemo.Create(Application);
        Lc_Obs.Parent := frMain;
        Lc_Obs.Top := 0;
        Lc_Obs.Left := 0;
        Lc_Obs.Width := 300;
        Lc_Obs.Visible := False;
        Lc_Texto := TMemoryStream.Create;
        Lc_Texto.LoadFromStream(CreateBlobStream(FieldByName('USU_ASSINATURA'), bmRead));
        Lc_Obs.Lines.LoadFromStream(lC_Texto);

        For Lc_I := 0 to Lc_Obs.Lines.Count-1 do
        Begin
          Result := Result  + Lc_Obs.Lines.Strings[LC_I] +  '<br>';
        end;
      Finally
        FreeAndNil(Lc_Texto);
        FreeAndNil(Lc_Obs);
      End;
    end;
    Result := Result  +
    '</span></span></td> '+
    '    </tr> '+
    '  </tbody> '+
    '</table> ';
  End;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;


function Fc_ValidaEmail(email:String):boolean;
begin
  Result := (Pos('@',email) >= 2) and
            (Pos('.',email) >= 0) and
            (Pos('.',email) < Length(email));

  if not Result then
  Begin
    MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'E-mail informado inválido.'+EOLN+
                   'Verifique e tente novamente.'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
  end;
end;

end.
