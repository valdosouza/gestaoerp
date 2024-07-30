object Fm_ListaMarcaProduto: TFm_ListaMarcaProduto
  Left = 0
  Top = 0
  Width = 340
  Height = 39
  TabOrder = 0
  object Label32: TLabel
    Left = 2
    Top = 0
    Width = 51
    Height = 14
    Caption = 'Fabricante'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Recipiente_Fabricante_3: TSpeedButton
    Left = 312
    Top = 13
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
    OnClick = Sb_Recipiente_Fabricante_3Click
  end
  object Dblcb_Marca: TDBLookupComboBox
    Left = 0
    Top = 13
    Width = 311
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    KeyField = 'MRC_CODIGO'
    ListField = 'MRC_DESCRICAO'
    ListSource = Ds_ListaMarca
    ParentFont = False
    TabOrder = 0
    OnKeyDown = Dblcb_MarcaKeyDown
  end
  object Qr_ListaMarca: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MARCA_PRODUTO'
      'ORDER BY MRC_DESCRICAO')
    Left = 65
    Top = 27
  end
  object Ds_ListaMarca: TDataSource
    DataSet = Qr_ListaMarca
    Left = 153
    Top = 25
  end
end
