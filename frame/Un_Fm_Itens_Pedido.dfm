object Fm_Itens_Pedido: TFm_Itens_Pedido
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object StrGrd_Itens_Pedido: TStringGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    Color = clMoneyGreen
    ColCount = 20
    DefaultColWidth = 70
    DefaultRowHeight = 18
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDrawCell = StrGrd_Itens_PedidoDrawCell
  end
  object Qr_ItensNota: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    OnCalcFields = Qr_ItensNotaCalcFields
    BufferChunks = 1000
    CachedUpdates = True
    ParamCheck = True
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
      'WHERE (ITF_CODPED = :PED_CODIGO) AND (ITF_OPER = :ITF_OPER)'
      'AND tb_produto.pro_tipo <> '#39'S'#39
      'Order by 1')
    Left = 384
    Top = 135
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PED_CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ITF_OPER'
        ParamType = ptUnknown
      end>
    object Qr_ItensNotaITF_CODIGO: TIntegerField
      FieldName = 'ITF_CODIGO'
      Origin = '"TB_ITENS_NFL"."ITF_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object Qr_ItensNotaITF_CODPRO: TIntegerField
      FieldName = 'ITF_CODPRO'
      Origin = '"TB_ITENS_NFL"."ITF_CODPRO"'
    end
    object Qr_ItensNotaPRO_CODIGOFAB: TIBStringField
      FieldName = 'PRO_CODIGOFAB'
      Origin = '"TB_PRODUTO"."PRO_CODIGOFAB"'
      Size = 50
    end
    object Qr_ItensNotaPRO_CODIGONCM: TIBStringField
      FieldName = 'PRO_CODIGONCM'
      Origin = '"TB_PRODUTO"."PRO_CODIGONCM"'
      Size = 50
    end
    object Qr_ItensNotaPRO_DESCRICAO: TIBStringField
      FieldName = 'PRO_DESCRICAO'
      Origin = '"TB_PRODUTO"."PRO_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensNotaIAV_DESCRICAO: TIBStringField
      FieldName = 'IAV_DESCRICAO'
      Origin = '"TB_ITENS_AVL"."IAV_DESCRICAO"'
      Size = 100
    end
    object Qr_ItensNotaEMB_ABREVIATURA: TIBStringField
      FieldName = 'EMB_ABREVIATURA'
      Origin = '"TB_EMBALAGEM"."EMB_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensNotaITF_QTDE: TIBBCDField
      FieldName = 'ITF_QTDE'
      Origin = '"TB_ITENS_NFL"."ITF_QTDE"'
      Precision = 18
      Size = 3
    end
    object Qr_ItensNotaITF_VL_CUSTO: TFMTBCDField
      FieldName = 'ITF_VL_CUSTO'
      Origin = '"TB_ITENS_NFL"."ITF_VL_CUSTO"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_VL_UNIT: TFMTBCDField
      FieldName = 'ITF_VL_UNIT'
      Origin = '"TB_ITENS_NFL"."ITF_VL_UNIT"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_AQ_COM: TIBBCDField
      FieldName = 'ITF_AQ_COM'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_COM"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaMED_ABREVIATURA: TIBStringField
      FieldName = 'MED_ABREVIATURA'
      Origin = '"TB_MEDIDA"."MED_ABREVIATURA"'
      Size = 5
    end
    object Qr_ItensNotaIAV_UNIDADE: TIBStringField
      FieldName = 'IAV_UNIDADE'
      Origin = '"TB_ITENS_AVL"."IAV_UNIDADE"'
      Size = 5
    end
    object Qr_ItensNotaITF_AQ_DESC: TIBBCDField
      FieldName = 'ITF_AQ_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_AQ_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaITF_VL_DESC: TIBBCDField
      FieldName = 'ITF_VL_DESC'
      Origin = '"TB_ITENS_NFL"."ITF_VL_DESC"'
      Precision = 18
      Size = 2
    end
    object Qr_ItensNotaPRO_VL_CUSTOMED: TFMTBCDField
      FieldName = 'PRO_VL_CUSTOMED'
      Origin = '"TB_PRODUTO"."PRO_VL_CUSTOMED"'
      Precision = 18
      Size = 6
    end
    object Qr_ItensNotaITF_VL_IPI: TFMTBCDField
      FieldName = 'ITF_VL_IPI'
      ProviderFlags = []
      Precision = 18
      Size = 11
    end
    object Qr_ItensNotaITF_VL_SUBTOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_SUBTOTAL'
      Calculated = True
    end
    object Qr_ItensNotaITF_VL_TOTAL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ITF_VL_TOTAL'
      Calculated = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 272
    Top = 160
    object CadastrodeProdutos1: TMenuItem
      Caption = 'Cadastro de Produtos'
      OnClick = CadastrodeProdutos1Click
    end
    object RegistraNmerodolote1: TMenuItem
      Caption = 'Registra N'#250'mero do lote'
    end
  end
end
