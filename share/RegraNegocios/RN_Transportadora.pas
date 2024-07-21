unit RN_Transportadora;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,FireDAC.Stan.Param,
  StdCtrls,classes,db, RN_Empresa, Vcl.Dialogs;

   procedure Pc_AbreListaTransportadora(Pc_Order:String);
   function Fc_MostraPesoPedido(Fc_cd_Pedido:Integer):Real;
   function Fc_TransportadoraExiste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean):Integer;
   Function Fc_AbreTelaTransportadora(Pc_Cd_Codigo:Integer):TRetornoDados;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, ControllerBase,Un_Regra_Negocio,
      RN_Crud,  UN_TabelasEmListas, UnFunctions;

procedure Pc_AbreListaTransportadora(Pc_Order:String);
Begin
  DM_ListaConsultas.Pc_ListaTransportadora(Pc_Order);
End;

function Fc_MostraPesoPedido(Fc_cd_Pedido:Integer):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT Sum(tb_produto.pro_peso * itf_qtde) PESO '+
              'from tb_itens_nfl '+
              '  inner join tb_produto '+
              '  on (pro_codigo = itf_codpro) '+
              'where ITF_CODPED=:PED_CODIGO');
      ParamByName('PED_CODIGO').AsInteger := Fc_cd_Pedido;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByname('PESO').AsFloat;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_TransportadoraExiste(Fc_Cd_Codigo,fc_documento: string;Msg:Boolean):Integer;
var
  Lc_SqlTxt: string;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      Lc_SqlTxt:=' select EMP_CODIGO,EMP_NOME '+
                 'from tb_empresa    '+
                 '  inner join tb_transportadora '+
                 '  on (TRP_CODEMP = EMP_CODIGO )'+
                 'WHERE (EMP_CNPJ = :EMP_CNPJ)';
      IF (Trim(Fc_Cd_Codigo) <> '') then
        Lc_SqlTxt:= Lc_SqlTxt + ' and (EMP_CODIGO<>:EMP_CODIGO) ';
      SQL.Add(Lc_SqlTxt);
      IF (Trim(Fc_Cd_Codigo) <> '') then
        ParamByName('EMP_CODIGO').AsAnsiString:= Fc_Cd_Codigo;
      fc_documento := RemoveCaracterInformado(fc_documento, ['.',',','/','-']);
      ParamByName('EMP_CNPJ').AsAnsiString:= fc_documento;
      Active:=TRUE;
      FetchAll;
      if (RecordCount > 0) then
      Begin
        if msg then
        Begin
          MensagemPadrao('Mensagem','A T E N Ç Ã O!.'+EOLN+EOLN+
                         'Uma Transportadora com este CPF/CNPJ já existe.'+EOLN+
                          FieldByName('EMP_CODIGO').AsAnsiString + ' - ' + FieldByName('EMP_NOME').AsAnsiString+EOLN+
                         'Verifique e tente novamente.' +EOLN,
                         ['OK'], [bEscape], mpErro);
        End;
        Result:= FieldByName('EMP_CODIGO').AsInteger
      end
      else
      Begin
        Result:= 0;
      end;
      if DM.IBT_Consulta.InTransaction then DM.IBT_Consulta.CommitRetaining;
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_AbreTelaTransportadora(Pc_Cd_Codigo:Integer):TRetornoDados;
//Var
//  Lc_Form : TFr_Transportadora;
Begin
  ShowMessage('Verificar');
//  Try
//    Lc_Form := TFr_Transportadora.Create(Application);
//    Lc_Form.it_Menu := 'Transportadora';
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
