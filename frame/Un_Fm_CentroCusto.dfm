object Fm_CentroCusto: TFm_CentroCusto
  Left = 0
  Top = 0
  Width = 450
  Height = 62
  TabOrder = 0
  object Grb_Cta_CentroCusto: TGroupBox
    Left = 0
    Top = 0
    Width = 450
    Height = 62
    Align = alClient
    Caption = 'Plano de Contas - Centro de Custo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TabStop = True
    object Label13: TLabel
      Left = 10
      Top = 19
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 75
      Top = 19
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Plano: TSpeedButton
      Left = 412
      Top = 35
      Width = 24
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_PlanoClick
    end
    object DBLCB_Plano: TDBLookupComboBox
      Left = 72
      Top = 35
      Width = 336
      Height = 22
      KeyField = 'PLC_CODIGO'
      ListField = 'COMPLETO'
      ListSource = Ds_PlanoContas
      TabOrder = 1
      OnExit = DBLCB_PlanoExit
      OnKeyDown = DBLCB_PlanoKeyDown
    end
    object E_Codigo_Plano: TEdit_Setes
      Left = 7
      Top = 35
      Width = 62
      Height = 22
      TabOrder = 0
      Text = ''
      OnExit = E_Codigo_PlanoExit
    end
  end
  object Qr_PlanoContas: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT DISTINCT'
      '  PLC_CODIGO,'
      '  PLC_CODPLANO,'
      '  PLC_DESCRICAO,'
      '  PLC_CODPLANO || '#39' - '#39' || PLC_DESCRICAO COMPLETO,'
      '  PLC_NATUREZA,'
      '  PLC_TIPO'
      'FROM TB_PLANOCONTAS'
      'WHERE (PLC_NIVEL = '#39'A'#39')'
      'AND (PLC_TIPO = '#39'C'#39')'
      'ORDER BY 4')
    Left = 318
    Top = 11
  end
  object Ds_PlanoContas: TDataSource
    AutoEdit = False
    DataSet = Qr_PlanoContas
    Left = 366
    Top = 11
  end
end
