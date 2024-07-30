object Fm_ListaHistoricoBancario: TFm_ListaHistoricoBancario
  Left = 0
  Top = 0
  Width = 456
  Height = 41
  TabOrder = 0
  TabStop = True
  object Label26: TLabel
    Left = 0
    Top = 0
    Width = 456
    Height = 14
    Align = alTop
    Caption = 'Hist'#243'rico Lan'#231'amento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 104
  end
  object Sb_Historico: TSpeedButton
    AlignWithMargins = True
    Left = 429
    Top = 14
    Width = 24
    Height = 26
    Margins.Top = 0
    Margins.Bottom = 1
    Align = alRight
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    OnClick = Sb_HistoricoClick
    ExplicitLeft = 421
    ExplicitHeight = 21
  end
  object DBLCB_Historico: TDBLookupComboBox
    AlignWithMargins = True
    Left = 3
    Top = 17
    Width = 420
    Height = 21
    Align = alClient
    KeyField = 'HTB_CODIGO'
    ListField = 'HTB_DESCRICAO'
    ListSource = Ds_HistBancario
    TabOrder = 0
    OnKeyDown = DBLCB_HistoricoKeyDown
    ExplicitLeft = -1
    ExplicitWidth = 416
  end
  object Qr_HistBancario: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_HISTBANCARIO')
    Left = 207
    Top = 39
  end
  object Ds_HistBancario: TDataSource
    DataSet = Qr_HistBancario
    Left = 287
    Top = 39
  end
end
