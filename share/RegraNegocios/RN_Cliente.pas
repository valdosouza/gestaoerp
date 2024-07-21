unit RN_Cliente;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,FireDAC.Stan.Param,
  StdCtrls,classes,db,DBCtrls, RN_Empresa, Vcl.Dialogs;


   function Fc_InsereClienteAuto(Fc_CODEMP:String):Integer;

   Function Fc_EnviarSomenteXmlNfe(Fc_Cd_Cliente:Integer):Boolean;
   function Fc_ClienteExiste(Fc_Cd_Codigo,fc_documento: string):Integer;
   procedure Pc_AbreListaCliente(Pc_Order:String);
   procedure Pc_ListaClienteDbLookUpComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TDBLookupComboBox);
   procedure Pc_ListaClienteComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TComboBox);
   function Fc_PosicionaCliente(Pc_Campo,Pc_Valor:String):Boolean;
   function Fc_BuscaNomeCliente(Fc_Campo,Fc_cd_Empresa:String):String;
   Function Fc_AbreTelaCliente(Pc_Cd_Codigo:Integer):TRetornoDados;
   function Fc_LocalizaCodigoListaComboCliente(Fc_Nm_Empresa:String;Fc_Chbx_Nome,Fc_Chbx_Fantasia:TCheckBox):String;
   function Cliente_Valida_Limite(Cd_Cliente,Cd_FormaPagto : Integer; ValorPedido:Real):Boolean;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, Un_Regra_Negocio, RN_Endereco, RN_Crud,
    UN_TabelasEmListas, ControllerBase,ControllerFormaPagamento, UnFunctions;





function Fc_InsereClienteAuto(Fc_CODEMP:String):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('insert into "TB_CLIENTE"( '+
                '  "CLI_CODEMP" '+
                ', "CLI_ATIVO" '+
                ', "CLI_IND_IE_DEST") '+
                'values( '+
                '  :"CLI_CODEMP" '+
                ', :"CLI_ATIVO" '+
                ', :"CLI_IND_IE_DEST") ');
    //Tratamento de Algumas Variaveis

    //Passagem de Parametros

      ParamByName('CLI_CODEMP').AsString := Fc_CODEMP;
      ParamByName('CLI_ATIVO').AsString := 'S';
      ParamByName('CLI_IND_IE_DEST').AsString := '0';
      Try
        ExecSQL;
        Result := StrToIntDef(Fc_CODEMP,0);
      except
        Result := 0;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;


Function Fc_EnviarSomenteXmlNfe(Fc_Cd_Cliente:Integer):Boolean;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT CLI_JUST_XML_NFE from TB_CLIENTE WHERE CLI_CODEMP =:EMP_CODIGO ');
      ParamByName('EMP_CODIGO').AsInteger := Fc_Cd_Cliente;
      Active := True;
      Result := (FieldByName('CLI_JUST_XML_NFE').AsString = 'S');
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

function Fc_ClienteExiste(Fc_Cd_Codigo,fc_documento: string):Integer;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_SqlTxt : String;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt:=' select EMP_CODIGO,EMP_NOME '+
                 'from tb_empresa    '+
                 '  inner join tb_cliente '+
                 '  on (CLI_CODEMP = EMP_CODIGO )'+
                 'WHERE (EMP_CNPJ = :EMP_CNPJ) ';
      IF (Trim(Fc_Cd_Codigo) <> '') then
        Lc_SqlTxt:= Lc_SqlTxt + ' and (EMP_CODIGO<>:EMP_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      IF (Trim(Fc_Cd_Codigo) <> '') then
        ParamByName('EMP_CODIGO').AsString:= Fc_Cd_Codigo;
      fc_documento := RemoveCaracterInformado(fc_documento, ['.',',','/','-']);
      ParamByName('EMP_CNPJ').AsString:= fc_documento;
      Active:=TRUE;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                       'Um Cliente com este CPF/CNPJ já existe.'+EOLN+
                        FieldByName('EMP_CODIGO').AsString + ' - ' + FieldByName('EMP_NOME').AsString+EOLN+
                       'Verifique e tente novamente.' +EOLN,
                       ['OK'], [bEscape], mpErro);
        Result:= FieldByName('EMP_CODIGO').AsInteger
      end
      else
      Begin
        Result:= 0;
      end;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_AbreListaCliente(Pc_Order:String);
Begin
  DM_ListaConsultas.Pc_ListaClientes(Pc_Order);
end;

procedure Pc_ListaClienteDbLookUpComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TDBLookupComboBox);
Begin
  if Pc_Check_On.Checked then
  Begin
    Pc_AbreListaCliente(Pc_Order);
    Pc_Lista.ListField := Pc_Order;
    Pc_Check_Off.Checked := False;
    Pc_Check_Off.Enabled := true;
    Pc_Check_On.Checked := True;
    Pc_Check_On.Enabled := False;
  end;
end;

procedure Pc_ListaClienteComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TComboBox);
Var
  Lc_Filter: TStrings;
begin
  if Pc_Check_On.Checked then
  Begin
    Try
      Lc_Filter := TStringList.Create;
      Pc_AbreListaCliente(Pc_Order);
      Pc_Check_Off.Checked := False;
      Pc_Check_Off.Enabled := true;
      Pc_Check_On.Checked := True;
      Pc_Check_On.Enabled := False;
      with Pc_Lista, DM_ListaConsultas.Qr_ListaCliente do
      Begin
        First;
        disablecontrols;
        Pc_Lista.Items.beginUpdate;
        Lc_Filter.Clear;
        while not Eof do
        begin
          if Pc_Order = 'EMP_NOME' then
            Lc_Filter.Add(FieldByName('EMP_NOME').AsString)
          else
            Lc_Filter.Add(FieldByName('EMP_FANTASIA').AsString);

          Next;
        end;
        Pc_Lista.Items.Assign(Lc_Filter);
        Pc_Lista.Items.endUpdate;
        enablecontrols;
      end;
    Finally
       Lc_Filter.free;
    End;
  end;
end;

function Fc_PosicionaCliente(Pc_Campo,Pc_Valor:String):Boolean;
Begin
  with DM_ListaConsultas.Qr_ListaCliente do
  Begin
    if not active then active := True;
    First;
    result := Locate(Pc_Campo, Pc_Valor, []);
  end;
end;

function Fc_BuscaNomeCliente(Fc_Campo,Fc_cd_Empresa:String):String;
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
        SQL.Add('SELECT ' + Fc_Campo  +
                ' FROM TB_EMPRESA '+
                '  INNER JOIN TB_CLIENTE '+
                ' ON (CLI_CODEMP = EMP_CODIGO) '+
                'WHERE EMP_CODIGO=:EMP_CODIGO ');
        ParamByName('EMP_CODIGO').AsString := Fc_cd_Empresa;
        Active := True;
        FetchAll;
        if (RecordCount>0) then
        Begin
          Result := Copy(FieldByname(FC_CAMPO).AsString,1,100);
        end
        else
        Begin
          MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                         'Cliente não localizado.' + EOLN +
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

Function Fc_AbreTelaCliente(Pc_Cd_Codigo:Integer):TRetornoDados;
//Var
//  Lc_Form : TFr_Cliente;
Begin
  ShowMessage('Verificar');
//  Try
//    Lc_Form := TFr_Cliente.Create(nil);
//    Lc_Form.it_Menu := 'Clientes';
//    Lc_Form.Empresa.Registro.Codigo := Pc_Cd_Codigo;
//    Lc_Form.ShowModal;
//    Pc_AbreListaCliente('EMP_NOME');
//    if Lc_Form.CodigoEmpresa > 0 then
//    Begin
//      SetLength(Result.It_Dados,2,2);
//      Result.It_Dados[0,0] := 'EMP_CODIGO';
//      Result.It_Dados[1,0] := IntToStr(Lc_Form.CodigoEmpresa);
//      Result.It_Dados[0,1] := 'EMP_NOME';
//      Result.It_Dados[1,1] := Lc_Form.NomeRazao;
//    end;
//  Finally
//    Lc_Form.DisposeOf;
//  End;
end;

function Fc_LocalizaCodigoListaComboCliente(Fc_Nm_Empresa:String;Fc_Chbx_Nome,Fc_Chbx_Fantasia:TCheckBox):String;
Begin
  Result := '';
  if Trim(Fc_Nm_Empresa) <> '' then
  Begin
    IF Fc_Chbx_Nome.Checked then
      Pc_AbreListaEmpresa(-1,'EMP_NOME')
    else
      Pc_AbreListaEmpresa(-1,'EMP_FANTASIA');
    with DM_ListaConsultas.Qr_ListaCliente do
    Begin
      Active := true;
      First;
      if Fc_Chbx_Nome.Checked then
      Begin
        IF (Locate('EMP_NOME',Fc_Nm_Empresa,[])) then
          Result := FieldByName('EMP_CODIGO').AsString;
      end
      else
      Begin
        if (Locate('EMP_FANTASIA',Fc_Nm_Empresa,[])) then
          Result := FieldByName('EMP_CODIGO').AsString;
      end;
    end;
  end;
end;

function Cliente_Valida_Limite(Cd_Cliente,Cd_FormaPagto : Integer; ValorPedido:Real):Boolean;
Var
  lc_MSG : String;
  lc_vl_Pre_saldo : Real;
  lc_vl_Pos_saldo : Real;
  Lc_Forma: TControllerFormaPagamento;
Begin
  lc_MSG:='';
  Result := True;
  //VerIfica o Saldo restante do Cliente
  If (Fc_Tb_Geral('L','FIN_G_BLOQ_LIMITE','') = 'S')then
  Begin
    Try
      Lc_Forma := TControllerFormaPagamento.create(nil);
      //Caso o limite não seja liberado para esta forma de pagamento prossegue
      if not Lc_Forma.ValidaLimiteFormaPagamento(Cd_FormaPagto) then
      Begin
        lc_vl_Pre_saldo := Fc_LimitedeCredito(cd_Cliente);
        lc_vl_Pos_saldo := lc_vl_Pre_saldo - ( Fc_SaldoCLiente(cd_Cliente) + ValorPedido);
        If ( lc_vl_Pos_saldo < 0 ) then
        Begin
          lc_MSG:='O cliente excedeu seu limite em R$:' +FormatFloat('#,##0.00',lc_vl_Pos_saldo) ;
          MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                         lc_MSG+EOLN,
                      ['OK'],[bEscape],mpErro);
          Result := False;
        end;
        If ( lc_vl_Pre_saldo<=0) then
        Begin
          lc_MSG:='O cliente Atingiu o limite de Crédito disponível' ;
          MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                         lc_MSG+EOLN,
                      ['OK'],[bEscape],mpErro);
          Result := False;
        end;
        If (lc_vl_Pos_saldo >0) then
        Begin
          lc_MSG:='O cliente tem saldo de limite de R$:' +FormatFloat('#,##0.00',lc_vl_Pos_saldo) ;
          MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                         lc_MSG+EOLN,
                       ['OK'],[bEscape],mpInformacao);
        end;
      end;
    Finally
      Lc_Forma.disposeOf;
    End;
  end;
end;

end.

