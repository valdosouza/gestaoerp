object Fm_ListaGrupoSubGrupo: TFm_ListaGrupoSubGrupo
  Left = 0
  Top = 0
  Width = 393
  Height = 75
  TabOrder = 0
  object Label12: TLabel
    Left = 4
    Top = 0
    Width = 30
    Height = 14
    Caption = 'Grupo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 6
    Top = 36
    Width = 47
    Height = 14
    Caption = 'Subgrupo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object SB_Grupos: TSpeedButton
    Left = 366
    Top = 50
    Width = 23
    Height = 22
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
  end
  object DBLCB_Grupo: TDBLookupComboBox
    Left = 3
    Top = 14
    Width = 386
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyField = 'GRP_CODIGO'
    ListField = 'GRP_DESCRICAO'
    ListSource = Ds_Grupo
    ParentFont = False
    TabOrder = 0
    OnExit = DBLCB_GrupoExit
  end
  object DBLCB_SubGrupo: TDBLookupComboBox
    Left = 3
    Top = 50
    Width = 362
    Height = 22
    DataField = 'PRO_CODSBG'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyField = 'SBG_CODIGO'
    ListField = 'SBG_DESCRICAO'
    ListSource = Ds_SubGrupo
    ParentFont = False
    TabOrder = 1
  end
  object Qr_Grupo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TB_GRUPOS'
      'where GRP_COMPOSICAO IS NOT NULL'
      'ORDER BY GRP_DESCRICAO')
    Left = 391
    Top = 6
  end
  object Qr_SubGrupo: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    AfterScroll = Qr_SubGrupoAfterScroll
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = Ds_Grupo
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TB_SUBGRUPOS'
      'WHERE'
      '    SBG_CODGRP =:GRP_CODIGO '
      '  AND  SBG_ATIVO = '#39'S'#39
      'ORDER BY SBG_DESCRICAO')
    Left = 426
    Top = 6
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GRP_CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
  end
  object Ds_Grupo: TDataSource
    DataSet = Qr_Grupo
    Left = 391
    Top = 55
  end
  object Ds_SubGrupo: TDataSource
    DataSet = Qr_SubGrupo
    Left = 426
    Top = 55
  end
end
