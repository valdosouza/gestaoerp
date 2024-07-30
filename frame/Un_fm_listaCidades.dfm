object FmListaCidades: TFmListaCidades
  Left = 0
  Top = 0
  Width = 138
  Height = 112
  TabOrder = 0
  DesignSize = (
    138
    112)
  object Municipio: TLabel
    Left = 4
    Top = 0
    Width = 44
    Height = 14
    Caption = 'Munic'#237'pio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Cidade: TSpeedButton
    Left = 114
    Top = 11
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    ExplicitLeft = 60
  end
  object DBLCB_CIDADE: TDBLookupComboBox
    Left = 2
    Top = 13
    Width = 108
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'CDD_CODIGO'
    ListField = 'CDD_DESCRICAO'
    ListSource = Ds_Cidade
    TabOrder = 0
    ExplicitWidth = 110
  end
  object Qr_Cidade: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_CIDADE'
      '')
    Left = 13
    Top = 39
  end
  object Ds_Cidade: TDataSource
    DataSet = Qr_Cidade
    Left = 47
    Top = 40
  end
end
