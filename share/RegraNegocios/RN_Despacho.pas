unit RN_Despacho;

interface

uses
  Forms, Controls,SysUtils, STQuery,STStoredProc, STDatabase,
  StdCtrls,classes,db,FireDAC.Stan.Param;

  procedure Pc_LancaDespacho(Pc_Qry: TSTQuery; Pc_Cd_pedido: Integer; Pc_Data_Prevista: Tdate);
  procedure Pc_AtualizaDespacho(Pc_Cd_Despacho,Pc_Cd_Pedido,Pc_Cd_Item,Pc_Cd_Produto:Integer;Pc_Data_Realizada: TDate;Pc_Qt_Produto:Real);
  procedure Pc_DeletaDespacho(Pc_Cd_Item,Pc_Cd_Despacho: Integer);
  procedure Pc_InsereDespacho(Pc_cd_Pedido:Integer;
                              Pc_cd_Item:Integer;
                              Pc_Cd_Produto:Integer;
                              Pc_Dt_Prevista : TDATE;
                              Pc_Qtde : Real;
                              Pc_Situacao : String);
  procedure Pc_AlteraQtdeDespacho(Pc_cd_Despacho:Integer;
                                  Pc_Qtde : Real);
  procedure Pc_ApagaDespachoMercadoria(Pc_cd_Pedido:Integer);


implementation

uses Un_DM, UN_Sistema, ControllerBase;

procedure Pc_LancaDespacho(Pc_Qry: TSTQuery; Pc_Cd_pedido: Integer; Pc_Data_Prevista: TDate);
begin
  Pc_Qry.Active := True;
  Pc_Qry.FetchAll;
  Pc_Qry.First;
  while not Pc_Qry.Eof do
    begin
    Pc_InsereDespacho(Pc_Qry.FieldByName('ITF_CODPED').AsInteger,
                      Pc_Qry.FieldByName('ITF_CODIGO').AsInteger,
                      Pc_Qry.FieldByName('ITF_CODPRO').AsInteger,
                      Pc_Data_Prevista,
                      Pc_Qry.FieldByName('ITF_QTDE').AsFloat,
                      'P');
    Pc_Qry.Next;
    end;
end;

procedure Pc_AtualizaDespacho(Pc_Cd_Despacho,Pc_Cd_Pedido,Pc_Cd_Item,Pc_Cd_Produto:Integer;Pc_Data_Realizada: TDate;Pc_Qt_Produto:Real);
Var
  Lc_Cd_Despacho_Ant : Integer;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('SELECT DSP_CODIGO FROM TB_DESPACHO '+
              'WHERE (DSP_CODITF =:ITF_CODIGO) '+
              '  AND (DSP_DT_REALIZADA =:DSP_DT_REALIZADA) '+
              '  AND (DSP_CODPED =:PED_CODIGO) '+
              '  AND (DSP_CODPRO=:PRO_CODIGO) '+
              '  AND (DSP_SITUACAO = ''S'') ');
      ParamByName('PED_CODIGO').AsInteger := Pc_Cd_Pedido;
      ParamByName('ITF_CODIGO').AsInteger := Pc_Cd_Item;
      ParamByName('PRO_CODIGO').AsInteger := Pc_Cd_Produto;
      ParamByName('DSP_DT_REALIZADA').AsDate := Pc_Data_Realizada;
      Active := True;
      FetchAll;
      if (recordcount > 0) then
      Begin
        //Guarda o codigo que vai ser atualizado
        Lc_Cd_Despacho_Ant := FieldbyName('DSP_CODIGO').AsInteger;
        //Deleta o Despacho atual
        Active := False;
        SQL.Clear;
        SQL.Add('DELETE FROM TB_DESPACHO WHERE DSP_CODIGO=:DSP_CODIGO ');
        ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
        ExecSQL;
        //Atualiza o Despacho anterior
        Active := False;
        SQL.Clear;
        SQL.Add(' update tb_despacho set '+
                ' dsp_qtde = dsp_qtde + :dsp_qtde '+
                ' where  dsp_codigo= :dsp_codigo ');
        ParamByName('dsp_codigo').AsInteger := Lc_Cd_Despacho_Ant;
        ParamByName('dsp_qtde').AsFloat     := Pc_Qt_Produto;
      end
      else
      Begin
        Active := False;
        SQL.Clear;
        SQL.Add(' update tb_despacho set '+
                ' dsp_qtde =:dsp_qtde, '+
                ' dsp_dt_realizada = :dsp_dt_realizada, '+
                ' DSP_SITUACAO = ''S'' '+
                ' where  dsp_codigo= :dsp_codigo ');
        ParamByName('dsp_codigo').AsInteger := Pc_Cd_Despacho;
        ParamByName('dsp_qtde').AsFloat     := Pc_Qt_Produto;
        ParamByName('dsp_dt_realizada').AsDate:= Pc_Data_Realizada;
      end;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_DeletaDespacho(Pc_Cd_Item,Pc_Cd_Despacho: Integer);
var
  Lc_Sql: String;
  Lc_Qtde : real;
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(Application);
  with Lc_Qry do
  Begin
    Database := DM.IBD_Gestao;
    Transaction := DM.IBT_Atualiza;

    Active := False;
    SQL.Clear;
    Lc_Sql := 'SELECT DSP_CODIGO, DSP_QTDE FROM TB_DESPACHO      '+
              'WHERE DSP_CODITF=:ITF_CODIGO ';
    SQL.Add(Lc_Sql);
    ParamByName('ITF_CODIGO').AsInteger := Pc_Cd_Item;
    Active := True;
    FetchAll;
    if (recordcount = 1) then
      Begin
      Active := False;
      SQL.Clear;
      Lc_Sql := 'UPDATE TB_DESPACHO SET     '+
                'DSP_SITUACAO = ''P'','+
                'DSP_IMPRESSO = NULL,'+
                'DSP_DT_REALIZADA = NULL '+
                'WHERE DSP_CODIGO=:DSP_CODIGO ';
      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
      ExecSQL;
      end
    else
      Begin
      if (recordcount > 1) then
        Begin
        First;
        //Localiza o Despacho no Lista
        Locate('DSP_CODIGO',Pc_Cd_Despacho,[]);
        //Guarda a Quantidade que foi despachada
        Lc_Qtde := FieldByname('DSP_QTDE').AsFloat;
        //Verifica se há um despacho pendente para adicionar a quantidade 
        Active := False;
        SQL.Clear;
        Lc_Sql := 'SELECT FIRST 1 DSP_CODIGO, DSP_QTDE FROM TB_DESPACHO      '+
                  'WHERE DSP_CODITF=:ITF_CODIGO and DSP_DT_REALIZADA IS NULL '+
                  'ORDER BY DSP_DT_PREVISTA DESC ';
        SQL.Add(Lc_Sql);
        ParamByName('ITF_CODIGO').AsInteger := Pc_Cd_Item;
        Active := True;
        FetchAll;
        if (recordcount > 0) then
          Begin
          //Guarda o Codigo do Despacho que vai receber a nova quantidade
          Pc_AlteraQtdeDespacho(FieldByName('DSP_CODIGO').AsInteger,(FieldByName('DSP_QTDE').AsInteger + Lc_Qtde));
          //Deleta o despacho que esta sendo cancelado
          Active := False;
          SQL.Clear;
          Lc_Sql := 'DELETE FROM TB_DESPACHO      '+
                    'WHERE DSP_CODIGO=:DSP_CODIGO ';
          SQL.Add(Lc_Sql);
          ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
          ExecSQL;
          end
        else
          Begin
          Active := False;
          SQL.Clear;
          Lc_Sql := 'UPDATE TB_DESPACHO SET     '+
                    'DSP_SITUACAO = ''P'','+
                    'DSP_DT_REALIZADA = NULL '+
                    'WHERE DSP_CODIGO=:DSP_CODIGO ';
          SQL.Add(Lc_Sql);
          ParamByName('DSP_CODIGO').AsInteger := Pc_Cd_Despacho;
          ExecSQL;
          end;
        end;
      end;

    end;
  Lc_Qry.Close;
  FreeAndNil(Lc_Qry);
end;

procedure Pc_InsereDespacho(Pc_cd_Pedido:Integer;
                            Pc_cd_Item:Integer;
                            Pc_Cd_Produto:Integer;
                            Pc_Dt_Prevista : TDATE;
                            Pc_Qtde : Real;
                            Pc_Situacao : String);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'INSERT INTO TB_DESPACHO( '+
                '  DSP_CODIGO,'+
                '  DSP_CODPED,'+
                '  DSP_CODITF,'+
                '  DSP_CODPRO,'+
                '  DSP_DT_PREVISTA, '+
                '  DSP_QTDE, '+
                '  DSP_SITUACAO) '+
                'VALUES ( '+
                '  :DSP_CODIGO, '+
                '  :DSP_CODPED,'+
                '  :DSP_CODITF, '+
                '  :DSP_CODPRO,'+
                '  :DSP_DT_PREVISTA, '+
                '  :DSP_QTDE, '+
                '  :DSP_SITUACAO)';

      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := LcBase.Generator('GN_DESPACHO');
      ParamByName('DSP_CODPED').AsInteger := Pc_Cd_Pedido;
      ParamByName('DSP_CODITF').AsInteger := Pc_Cd_Item;
      ParamByName('DSP_CODPRO').AsInteger := Pc_Cd_Produto;
      ParamByName('DSP_DT_PREVISTA').AsDate := Pc_Dt_Prevista;
      ParamByName('DSP_QTDE').AsFloat := Pc_Qtde;
      ParamByName('DSP_SITUACAO').AsString := Pc_Situacao;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_AlteraQtdeDespacho(Pc_cd_Despacho:Integer;
                                Pc_Qtde : Real);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  LcBase := TControllerBase.create(nil);
  Lc_Qry := LcBase.GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Lc_Sql := 'UPDATE TB_DESPACHO SET '+
                '  DSP_QTDE =:DSP_QTDE '+
                'WHERE DSP_CODIGO =:DSP_CODIGO ';

      SQL.Add(Lc_Sql);
      ParamByName('DSP_CODIGO').AsInteger := Pc_cd_Despacho;
      ParamByName('DSP_QTDE').AsFloat := Pc_Qtde;
      ExecSQL;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Pc_ApagaDespachoMercadoria(Pc_cd_Pedido:Integer);
var
  Lc_Sql: String;
  Lc_Qry : TSTQuery;
  Lc_Del : TSTQuery;
begin
  Lc_Qry := TSTQuery.Create(Application);
  Lc_Del := TSTQuery.Create(Application);
  Try
    with Lc_Qry do
    Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IBT_Atualiza;
      CachedUpdates := True;
      Active := False;
      SQL.Clear;
      Lc_Sql := 'SELECT ITF_CODIGO '+
                'FROM TB_ITENS_NFL '+
                'WHERE ITF_CODPED =:PED_CODIGO ';
      SQL.Add(Lc_Sql);
      ParamByName('PED_CODIGO').AsInteger := Pc_cd_Pedido;
      Active := TRUE;
      end;

    with Lc_Del do
      Begin
      Database := DM.IBD_Gestao;
      Transaction := DM.IBT_Atualiza;
      CachedUpdates := True;
      Active := False;
      SQL.Clear;
      Lc_Sql := 'DELETE FROM TB_DESPACHO '+
                'WHERE DSP_CODITF=:ITF_CODIGO ';
      SQL.Add(Lc_Sql);
      Lc_Qry.Active := True;
      Lc_Qry.First;
      while not Lc_Qry.Eof do
      Begin

        Active := fALSE;
        ParamByName('ITF_CODIGO').AsInteger := Lc_Qry.FieldByName('ITF_CODIGO').AsInteger;
        ExecSQL;
        if DM.IBT_Atualiza.active then DM.IBT_Atualiza.CommitRetaining;
        Lc_Qry.Next;
        end;
      end;
  Finally
    Lc_Qry.Close;
    FreeAndNil(Lc_Qry);
    Lc_Del.Close;
    FreeAndNil(Lc_Del);
  End;
end;

end.
