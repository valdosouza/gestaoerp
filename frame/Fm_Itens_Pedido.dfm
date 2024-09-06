object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 64
    ExplicitTop = 32
    ExplicitWidth = 320
    ExplicitHeight = 120
  end
  object Qr_ItensNota: TSTQuery
    CachedUpdates = True
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT'
      '  ITF_CODIGO,'
      '  ITF_CODPRO,'
      '  PRO_CODIGOFAB,'
      '  PRO_CODIGONCM,'
      '  PRO_DESCRICAO,'
      ' IAV_DESCRICAO,'
      '  EMB_ABREVIATURA,'
      '  ITF_QTDE,'
      '  ITF_VL_CUSTO,'
      '  ITF_VL_UNIT,'
      '  ITF_AQ_COM,'
      '  MED_ABREVIATURA,'
      '  IAV_UNIDADE,'
      '  ITF_AQ_DESC,'
      '  ITF_VL_DESC,'
      '  PRO_VL_CUSTOMED,'
      
        '  ( ((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC)  * ITF_AQ_IPI)/100 ' +
        'ITF_VL_IPI,'
      '  ((ITF_QTDE * ITF_VL_UNIT) ) ITF_VL_SUBTOTAL,'
      '  ((ITF_QTDE * ITF_VL_UNIT) - ITF_VL_DESC) ITF_VL_TOTAL'
      'FROM TB_ITENS_NFL Tb_itens_nfl'
      '   INNER JOIN TB_PRODUTO Tb_produto'
      '   ON  (Tb_produto.PRO_CODIGO = Tb_itens_nfl.ITF_CODPRO)'
      '   INNER JOIN TB_MEDIDA tb_medida'
      '   ON  (tb_medida.MED_CODIGO = tb_produto.PRO_CODMED)'
      '   INNER JOIN tb_embalagem tb_embalagem'
      '   on tb_embalagem.emb_codigo = tb_produto.pro_codemb'
      '  LEFT OUTER  JOIN TB_ITENS_AVL'
      '  ON (IAV_CODITF = ITF_CODIGO)'
      ''
      'WHERE (ITF_CODPED = :PED_CODIGO) AND (ITF_OPER <> :ITF_OPER)'
      'AND tb_produto.pro_tipo <> '#39'S'#39)
    ForcedRefresh = True
    Left = 432
    Top = 143
    ParamData = <
      item
        Name = 'PED_CODIGO'
      end
      item
        Name = 'ITF_OPER'
      end>
  end
end
