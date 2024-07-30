object Fm_ListaMedida: TFm_ListaMedida
  Left = 0
  Top = 0
  Width = 217
  Height = 35
  TabOrder = 0
  object Label21: TLabel
    Left = 4
    Top = -1
    Width = 39
    Height = 14
    Caption = 'Unidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Recipiente_Medida_1: TSpeedButton
    Left = 190
    Top = 12
    Width = 23
    Height = 21
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_Recipiente_Medida_1Click
  end
  object Dblcb_Medida: TDBLookupComboBox
    Left = 3
    Top = 12
    Width = 186
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyField = 'MED_CODIGO'
    ListField = 'MED_ABREVIATURA'
    ListSource = Ds_ListaMedida
    ParentFont = False
    TabOrder = 0
  end
  object Qr_ListaMedida: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_MEDIDA'
      'WHERE MED_ESPECIAL is null'
      'ORDER BY MED_ABREVIATURA')
    Left = 42
    Top = 24
  end
  object Ds_ListaMedida: TDataSource
    DataSet = Qr_ListaMedida
    Left = 106
    Top = 19
  end
end
