unit RN_PlanoContas;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,Un_Principal,ControllerBase;

   function Fc_ValorContaRealizada(Fc_Tipo,Fc_Plano,Fc_Campo:String;Fc_DataIni,Fc_DataFim:TDate):Real;
   function Fc_ValorContaPrevista(Fc_Plano:String;Fc_DataIni,Fc_DataFim:TDate):Real;
   procedure Pc_AtualizarPlanoContasFinanceiro(Pc_Plc_Credito,Pc_Plc_Debito, Pc_Cd_Financeiro:Integer);
   procedure Pc_AplicarPlanoContasFinanceiro(Pc_Cd_Financeiro:Integer);
   procedure Pc_AtualizarPlanoContasMovimentoFinanceiro(Pc_Plc_Credito,Pc_Plc_Debito, Pc_Cd_Movimento:Integer);
   procedure Pc_AplicarPlanoContasMovimentoFinanceiro(Pc_CentroCusto,Pc_ContaResultado,Pc_Cd_Movimento:Integer;Caption:String);
   function Fc_DetalhePLC_CaixaBanco(Fc_Plano:String;Fc_Tipo:String;Fc_Dt_Ini,Fc_Dt_Fim: Tdate):TSTQuery;
implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, un_Padrao,
  Un_Regra_Negocio, Un_Lanca_PlanoContas;



function Fc_ValorContaRealizada(Fc_Tipo,Fc_Plano,Fc_Campo:String;Fc_DataIni,Fc_DataFim:TDate):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if ( Fc_Tipo = 'R' ) then
      Begin
        SQL.Add('SELECT SUM(' + Fc_Campo + ') PLC_VALOR,SUM(MVF_VL_FUTURO) PLC_VL_FUTURO '+
                'FROM TB_MOVIM_FINANCEIRO tb_movimento '+
                '   INNER JOIN TB_PLANOCONTAS tb_planocontas '+
                '   ON  (tb_planocontas.PLC_CODIGO = tb_movimento.MVF_CODPLC_C) ');
      End
      else
      Begin
        SQL.Add('SELECT SUM(' + Fc_Campo + ') PLC_VALOR,SUM(MVF_VL_FUTURO) PLC_VL_FUTURO '+
                'FROM TB_MOVIM_FINANCEIRO tb_movimento '+
                '   INNER JOIN TB_PLANOCONTAS tb_planocontas '+
                '   ON  (tb_planocontas.PLC_CODIGO = tb_movimento.MVF_CODPLC_D) ');
      End;

      SQL.Add('Where PLC_CODPLANO like  :PLC_CODPLANO AND (MVF_DATA BETWEEN :DATAINI AND :DATAFIM) ');

      ParamByName('PLC_CODPLANO').AsAnsiString := Fc_Plano +'%';
      ParamByName('DATAINI').AsDate := Fc_DataIni;
      ParamByName('DATAFIM').AsDate := Fc_DataFim;
      Active := True;
      result := 0;
      if Fc_Campo = 'MVF_VL_CREDITO' then
      Begin
        if FieldByName('PLC_VL_FUTURO').AsFloat >= 0 then
          result := FieldByName('PLC_VALOR').AsFloat + FieldByName('PLC_VL_FUTURO').AsFloat
      End
      else
      Begin
        if FieldByName('PLC_VL_FUTURO').AsFloat <= 0 then
          result := FieldByName('PLC_VALOR').AsFloat + (FieldByName('PLC_VL_FUTURO').AsFloat * -1);

      End;



    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

function Fc_ValorContaPrevista(Fc_Plano:String;Fc_DataIni,Fc_DataFim:TDate):Real;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT SUM(FIN_VL_PARCELA) PLC_VALOR '+
              'FROM TB_FINANCEIRO tb_financeiro '+
              '   INNER JOIN TB_PLANOCONTAS tb_planocontas '+
              '   ON  (tb_planocontas.PLC_CODIGO = tb_financeiro.FIN_PLC_DEBITO) '+
              'where PLC_CODPLANO like  :PLC_CODPLANO AND (FIN_DT_VENCIMENTO BETWEEN :DATAINI AND :DATAFIM)');

      ParamByName('PLC_CODPLANO').AsAnsiString := Fc_Plano +'%';
      ParamByName('DATAINI').AsDate := Fc_DataIni;
      ParamByName('DATAFIM').AsDate := Fc_DataFim;
      Active := True;
      Result := FieldByName('PLC_VALOR').AsFloat;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_AtualizarPlanoContasFinanceiro(Pc_Plc_Credito,Pc_Plc_Debito, Pc_Cd_Financeiro:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_FINANCEIRO SET '+
              'FIN_PLC_CREDITO =:FIN_PLC_CREDITO, '+
              'FIN_PLC_DEBITO =:FIN_PLC_DEBITO '+
              'WHERE (FIN_CODIGO=:FIN_CODIGO)');
      ParamByName('FIN_PLC_CREDITO').AsInteger := Pc_Plc_Credito;
      ParamByName('FIN_PLC_DEBITO').AsInteger := Pc_Plc_Debito;
      ParamByName('FIN_CODIGO').AsInteger := Pc_Cd_Financeiro;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  end;
end;

procedure Pc_AplicarPlanoContasFinanceiro(Pc_Cd_Financeiro:Integer);
Var
  Lc_Form : TFr_Lanca_PlanoContas;
  Lc_Cta_Credito : Integer;
  Lc_Cta_Debito : Integer;
begin
  try
    Lc_Form := TFr_Lanca_PlanoContas.Create(nil);
    Lc_Form.Caption := 'Definição do Plano de Contas';
    Lc_Form.Lb_Instrucao.Caption := 'Por Favor informe em qual conta este lançamento está atrelado';
    Lc_Form.Fm_CentroResultado.Visible := False;
    Lc_Form.ShowModal;
    Lc_Cta_Credito := 0;
    Lc_Cta_Debito := 0;
    if (Lc_Form.Fm_CentroCusto.DBLCB_Plano.Text <> '') then
    Begin
      Lc_Cta_Credito := Lc_Form.Fm_CentroCusto.DBLCB_Plano.KeyValue;
      Lc_Cta_Debito :=  Lc_Form.Fm_CentroCusto.DBLCB_Plano.KeyValue;
    End;
  finally
    Lc_Form.DisposeOf;
    Pc_AtualizarPlanoContasFinanceiro(Lc_Cta_Credito,Lc_Cta_Debito, Pc_Cd_Financeiro);
  end;
end;

procedure Pc_AtualizarPlanoContasMovimentoFinanceiro(Pc_Plc_Credito,Pc_Plc_Debito, Pc_Cd_Movimento:Integer);
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('UPDATE TB_MOVIM_FINANCEIRO SET '+
              'MVF_CODPLC_C =:MVF_CODPLC_C, '+
              'MVF_CODPLC_D =:MVF_CODPLC_D '+
              'WHERE (MVF_CODIGO=:MVF_CODIGO)');
      ParamByName('MVF_CODPLC_C').AsInteger := Pc_Plc_Credito;
      ParamByName('MVF_CODPLC_D').AsInteger := Pc_Plc_Debito;
      ParamByName('MVF_CODIGO').AsInteger := Pc_Cd_Movimento;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;


procedure Pc_AplicarPlanoContasMovimentoFinanceiro(Pc_CentroCusto,Pc_ContaResultado,Pc_Cd_Movimento:Integer;Caption:String);
Var
  Lc_Form : TFr_Lanca_PlanoContas;
begin
  Try
    Lc_Form := TFr_Lanca_PlanoContas.Create(nil);
    Lc_Form.Caption := 'Definição do Plano de Contas';
    if ( Caption  <> '') then
      Lc_Form.Lb_Instrucao.Caption := Caption
    else
      Lc_Form.Lb_Instrucao.Caption := 'Por Favor informe em qual conta este lançamento está atrelado';
    Lc_Form.Fm_CentroResultado.E_Codigo_Plano.Text := IntToStr(Pc_ContaResultado);
    Lc_Form.Fm_CentroResultado.E_Codigo_PlanoExit(nil);

    Lc_Form.Fm_CentroCusto.E_Codigo_Plano.Text := IntToStr(Pc_CentroCusto);
    Lc_Form.Fm_CentroCusto.E_Codigo_PlanoExit(nil);

    Lc_Form.ShowModal;
    if (Lc_Form.Fm_CentroResultado.DBLCB_Plano.Text <> '') then
      Pc_ContaResultado := Lc_Form.Fm_CentroResultado.DBLCB_Plano.KeyValue;
    if (Lc_Form.Fm_CentroCusto.DBLCB_Plano.Text <> '') then
      Pc_CentroCusto := Lc_Form.Fm_CentroCusto.DBLCB_Plano.KeyValue;
  Finally
    if Lc_Form.Confirma then
    Begin
      Pc_AtualizarPlanoContasMovimentoFinanceiro(Pc_ContaResultado,Pc_CentroCusto, Pc_Cd_Movimento);
    End;
    Lc_Form.DisposeOf;
  End;
end;

function Fc_DetalhePLC_CaixaBanco(Fc_Plano:String;Fc_Tipo:String; Fc_Dt_Ini,Fc_Dt_Fim: Tdate):TSTQuery;
Var
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Result := LcBase.GeraQuery;
    with Result do
    Begin
      SQL.Add('SELECT '+
              'MVF_CODCTB, '+
              'MVF_HISTORISCO, '+
              'MVF_VL_CREDITO, '+
              'MVF_VL_DEBITO '+
              'FROM TB_MOVIM_FINANCEIRO tb_movim_financeiro ');
      if Fc_Tipo = 'C' then
      Begin
        SQL.Add('  INNER JOIN tb_planocontas '+
                '  ON (tb_planocontas.plc_codigo = tb_movim_financeiro.MVF_CODPLC_D) ');
      End
      else
      Begin
        SQL.Add('  INNER JOIN tb_planocontas '+
                '  ON (tb_planocontas.plc_codigo = tb_movim_financeiro.MVF_CODPLC_C) ');
      End;
      SQL.Add('WHERE (MVF_DATA BETWEEN :DATAINI AND :DATAFIM) '+
              '  AND (PLC_CODPLANO =:PLANO) AND (MVF_CODMHA =:MVF_CODMHA)');
      ParamByName('MVF_CODMHA').AsInteger := Gb_CodMha;
      ParamByName('DATAINI').AsDate := Fc_Dt_Ini;
      ParamByName('DATAFIM').AsDate := Fc_Dt_Fim;
      ParamByName('PLANO').AsAnsiString := Fc_Plano;
      Active := True;
    end;
  Finally
    LcBase.disposeOF;
  End;
end;

end.

