unit RN_NotaFiscal;

interface

uses
  STDatabase, STQuery, SysUtils, Classes, Vcl.Controls,STTransaction,
  System.Math, Vcl.Graphics,ControllerBase, Vcl.Dialogs,FireDAC.Stan.Param;

  Function Fc_ObsVeiculoNotaFiscal(Fc_Cd_Pedido:Integer):String;
  procedure Fc_ImpostoAproximado(Lista: TStringList;Fc_CodigoNCM:String; Fc_Origem:String);
  Function Fc_Obs_ImpostoAproximado(Fc_Transacao : TSTTransaction; Fc_Cd_NotaFiscal:Integer):TStringList;

  procedure Pc_AbreTelaNotaFiscal(PC_Cd_Nota:Integer;Parent:TwinControl);

implementation

uses Un_DM, UN_Sistema, UN_MSG, STDataSet, Un_stored_Procedures, RN_Pedido;

procedure Pc_AbreTelaNotaFiscal(PC_Cd_Nota:Integer;Parent:TwinControl);
//Var
//  Lc_Form: TFr_Nota_Fiscal;
Begin
  ShowMessage('Verificar');
//  try
//    Lc_Form := TFr_Nota_Fiscal.Create(Parent);
//    Lc_Form.It_Cd_Nota := PC_Cd_Nota;
//    Lc_Form.ShowModal;
//  finally
//    FreeAndNil(Lc_Form);
//  end;
end;

Function Fc_ObsVeiculoNotaFiscal(Fc_Cd_Pedido:Integer):String;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' SELECT MRC_DESCRICAO,MOD_DESCRICAO,VEI_PLACA ',
                ' FROM TB_VEHICLE_SO OS ',
                '   INNER JOIN TB_VEICULO tb_veiculo ',
                '   ON (tb_veiculo.VEI_PLACA = OS.TB_VEHICLE_ID) ',
                '   INNER JOIN TB_MARCA_VEICULO tb_marca ',
                '   ON (tb_marca.MRC_CODIGO = tb_veiculo.VEI_CODMRC) ',
                '   INNER JOIN TB_MODELO tb_modelo ',
                '   ON (tb_modelo.MOD_CODIGO = tb_veiculo.VEI_CODMOD) ',
                ' WHERE TB_ORDER_ID =:PED_CODIGO '
          ));
      ParamByName('PED_CODIGO').AsInteger:= Fc_Cd_Pedido;
      Active := True;
      FetchAll;
      if ( RecordCount > 0 ) then
      Begin
        Result := concat(
                   'PLACA  : ' + Copy(FieldByName('VEI_PLACA').AsAnsiString,1,3) + '-' + Copy(FieldByName('VEI_PLACA').AsAnsiString,4,4),' | ',
                   'MARCA  : ' + FieldByName('MRC_DESCRICAO').AsAnsiString ,' | ',
                   'MODELO : ' + FieldByName('MOD_DESCRICAO').AsAnsiString
                   );
      End;
    End;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

procedure Fc_ImpostoAproximado(Lista: TStringList;Fc_CodigoNCM:String; Fc_Origem:String);
Var
  Lc_Qry:TSTQuery;
  Lc_Campo : String;
  LcBase : TControllerBase;
begin
  Try
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      if (Fc_Origem = '0') then
        Lc_Campo := 'NCM_AQ_NAC'
      else
        Lc_Campo := 'NCM_AQ_IMP';

      SQL.Add('select ' + Lc_Campo + ' , NCM_AQ_ESTADUAL, NCM_AQ_MUNICIPAL FROM tb_ncm WHERE tb_ncm.ncm_n_ncm =:NCM_N_NCM');
      ParamByName('NCM_N_NCM').AsString := Fc_CodigoNCM;
      Active := True;
      Lista.Clear;
      Lista.Append(FieldByName(Lc_Campo).AsString);
      Lista.Append(FieldByName('NCM_AQ_ESTADUAL').AsString);
      Lista.Append(FieldByName('NCM_AQ_MUNICIPAL').AsString);
      Lista.Append(FloatToStr(FieldByName(Lc_Campo).AsFloat + FieldByName('NCM_AQ_ESTADUAL').AsFloat + FieldByName('NCM_AQ_MUNICIPAL').AsFloat));
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;
end;

Function Fc_Obs_ImpostoAproximado(Fc_Transacao : TSTTransaction; Fc_Cd_NotaFiscal:Integer):TStringList;
Var
  Lc_Qry : TSTQuery;
  LcBase : TControllerBase;
  Lc_Campo : String;
  Lc_Vl_Produto:Real;
  Lc_Vl_Base : Real;
  Lc_Imp_Aprox : TStringList;

  Lc_Tx_Imp_Nacional : real;
  Lc_Tx_Imp_Estadual : real;
  Lc_Tx_Imp_Municipal : real;

  Lc_Vl_Imp_Nacional : real;
  Lc_Vl_Imp_Estadual : real;
  Lc_Vl_Imp_Municipal : real;
  Lc_Obs : String;
Begin
  Try
    Result := TStringList.Create;
    Result.Clear;
    LcBase := TControllerBase.create(nil);
    Lc_Qry := LcBase.GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('select ITF_VL_UNIT, ITF_QTDE, ITF_VL_DESC,PRO_CODIGONCM,PRO_ORIGEM '+
              'FROM TB_NOTA_FISCAL '+
              '  INNER JOIN tb_itens_nfl '+
              '  ON (ITF_CODNFL = NFL_CODIGO) '+
              '  INNER JOIN TB_PRODUTO '+
              '  ON (PRO_CODIGO = ITF_CODPRO) '+
              'WHERE NFL_CODIGO =:NFL_CODIGO ');
      ParamByName('NFL_CODIGO').AsInteger := Fc_Cd_NotaFiscal;
      Active := True;
      First;
      Lc_Vl_Produto := 0;

      Lc_Vl_Base := 0;

      Lc_Tx_Imp_Nacional := 0;
      Lc_Tx_Imp_Estadual := 0;
      Lc_Tx_Imp_Municipal := 0;

      Lc_Vl_Imp_Nacional := 0;
      Lc_Vl_Imp_Estadual := 0;
      Lc_Vl_Imp_Municipal := 0;

      Lc_Imp_Aprox := TStringList.Create;
      while not eof do
      Begin
         Fc_ImpostoAproximado(Lc_Imp_Aprox,FieldByName('PRO_CODIGONCM').AsString,
                                             FieldByName('PRO_ORIGEM').AsString);
        Lc_Tx_Imp_Nacional  := StrToFloatDef(Lc_Imp_Aprox.Strings[0],0);
        Lc_Tx_Imp_Estadual  := StrToFloatDef(Lc_Imp_Aprox.Strings[1],0);
        Lc_Tx_Imp_Municipal := StrToFloatDef(Lc_Imp_Aprox.Strings[2],0);

        Lc_Vl_Base := ( (FieldByName('ITF_VL_UNIT').AsFloat * FieldByName('ITF_QTDE').AsFloat) - FieldByName('ITF_VL_DESC').AsFloat);
        Lc_Vl_Produto := Lc_Vl_Produto + Lc_Vl_Base;

        Lc_Vl_Imp_Nacional  := Lc_Vl_Imp_Nacional + (Lc_Vl_Base * (Lc_Tx_Imp_Nacional / 100));
        Lc_Vl_Imp_Estadual  := Lc_Vl_Imp_Estadual + (Lc_Vl_Base * (Lc_Tx_Imp_Estadual / 100));
        Lc_Vl_Imp_Municipal := Lc_Vl_Imp_Municipal + (Lc_Vl_Base * (Lc_Tx_Imp_Municipal / 100));

        next;
      end;
      FreeAndNil(Lc_Imp_Aprox);
    end;

    //Verifica a media dos impostos
    Lc_Tx_Imp_Nacional  := (RoundTo((Lc_Vl_Imp_Nacional / Lc_Vl_Produto),-4))*100;
    Lc_Tx_Imp_Estadual  := (RoundTo((Lc_Vl_Imp_Estadual / Lc_Vl_Produto),-4))*100;
    Lc_Tx_Imp_Municipal := (RoundTo((Lc_Vl_Imp_Municipal / Lc_Vl_Produto),-4))*100;

    Result.Append(FloatToStr(RoundTo(Lc_Vl_Imp_Nacional,-4)));
    Result.Append(FloatToStr(RoundTo(Lc_Vl_Imp_Estadual,-4)));
    Result.Append(FloatToStr(RoundTo(Lc_Vl_Imp_Municipal,-4)));
    Result.Append(FloatToStr(RoundTo(Lc_vl_Imp_Nacional + Lc_vl_Imp_Estadual + Lc_vl_Imp_Municipal,-4)));


    //Registra a Observação
    Lc_Obs := '';
    if (Lc_Vl_Imp_Nacional > 0) then
    Begin
      Lc_Obs := 'Valor aprox Imp. Nacional R$ ' + FloatToStrF(Lc_Vl_Imp_Nacional,ffFixed,10,2) + ' ('+ FloatToStrF(Lc_Tx_Imp_Nacional,ffFixed,10,2) +')%'
    end;
    if (Lc_Vl_Imp_Estadual > 0) then
    Begin
      Lc_Obs := Lc_Obs + '| Imp. Estadual R$ ' + FloatToStrF(Lc_Vl_Imp_Estadual,ffFixed,10,2) + ' ('+ FloatToStrF(Lc_Tx_Imp_Estadual,ffFixed,10,2) +')%'
    end;
    if (Lc_Vl_Imp_Municipal > 0) then
    Begin
      Lc_Obs := Lc_Obs + '| Imp. Municipal R$ ' + FloatToStrF(Lc_Vl_Imp_Municipal,ffFixed,10,2) + ' ('+ FloatToStrF(Lc_Tx_Imp_Municipal,ffFixed,10,2) +')%'
    end;


    if (Trim(Lc_Obs)<> '') then
    Begin
      Pc_Observacao(Fc_Transacao,
                    'I',
                    0,
                    0,
                    Fc_Cd_NotaFiscal,
                    'A',
                    Lc_Obs);
    end;
  Finally
    LcBase.FinalizaQuery(Lc_Qry);
    LcBase.DisposeOf;
  End;

end;

end.
