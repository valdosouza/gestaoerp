unit RN_Fornecedor;

interface
uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,DBCtrls,RN_Empresa, Vcl.Dialogs;



  procedure Pc_AbreListaFornecedor(Pc_Order:String);
  procedure Pc_ListaFornecedorDbLookUpComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TDBLookupComboBox);
  procedure Pc_ListaFornecedorComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TComboBox);
  function Fc_BuscaNomeFornecedor(Fc_Campo,Fc_cd_Empresa:String):String;
  Function Fc_AbreTelaFornecedor(Pc_Cd_Codigo:Integer):TRetornoDados;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, Un_Regra_Negocio, RN_Endereco, RN_Crud,
    UN_TabelasEmListas,ControllerBase;



procedure Pc_AbreListaFornecedor(Pc_Order:String);
Begin
  DM_ListaConsultas.Pc_ListaFornecedores(Pc_Order);
end;

procedure Pc_ListaFornecedorDbLookUpComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TDBLookupComboBox);
Begin
  if Pc_Check_On.Checked then
  Begin
    Pc_AbreListaFornecedor(Pc_Order);
    Pc_Lista.ListField := Pc_Order;
    Pc_Check_Off.Checked := False;
    Pc_Check_Off.Enabled := true;
    Pc_Check_On.Checked := True;
    Pc_Check_On.Enabled := False;
  end;
end;

procedure Pc_ListaFornecedorComboBox(Pc_Order:String;Pc_Check_On,Pc_Check_Off:TCheckBox;Pc_Lista:TComboBox);
begin
  if Pc_Check_On.Checked then
  Begin
    Pc_AbreListaFornecedor(Pc_Order);
    Pc_Check_Off.Checked := False;
    Pc_Check_Off.Enabled := true;
    Pc_Check_On.Checked := True;
    Pc_Check_On.Enabled := False;
    with DM_ListaConsultas.Qr_ListaFornecedor do
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


function Fc_BuscaNomeFornecedor(Fc_Campo,Fc_cd_Empresa:String):String;
Var
  Lc_Qry : TSTQuery;
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
                '  INNER JOIN TB_FORNECEDOR '+
                ' ON (FOR_CODEMP = EMP_CODIGO) '+
                'WHERE EMP_CODIGO=:EMP_CODIGO ');
        ParamByName('EMP_CODIGO').AsAnsiString := Fc_cd_Empresa;
        Active := True;
        FetchAll;
        if (RecordCount>0) then
        Begin
          Result := FieldByname(FC_CAMPO).AsAnsiString
        end
        else
        Begin
          MensagemPadrao('Mensagem', 'I N F O R M A Ç Ã O!.' + EOLN + EOLN +
                         'Fornecedor não localizado.' + EOLN +
                         'Verifique e tente novamente.' + EOLN ,
                         ['OK'], [bEscape], mpInformacao);
        end;
      End;
    Finally
      LcBase.FinalizaQuery(Lc_Qry);
      LcBase.DisposeOf;
    End;
  end;
end;


Function Fc_AbreTelaFornecedor(Pc_Cd_Codigo:Integer):TRetornoDados;
//Var
//  Lc_Form : TFr_Fornecedor;
Begin
  ShowMessage('Verificar');
//  Try
//    Lc_Form := TFr_Fornecedor.Create(nil);
//    Lc_Form.it_Menu := 'Fornecedores';
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
//    Lc_Form.DisposeOf;
//  End;
end;

end.
