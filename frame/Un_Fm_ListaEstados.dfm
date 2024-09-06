object Fm_ListaEstados: TFm_ListaEstados
  Left = 0
  Top = 0
  Width = 98
  Height = 37
  TabOrder = 0
  DesignSize = (
    98
    37)
  object Label23: TLabel
    Left = 4
    Top = 0
    Width = 16
    Height = 14
    Caption = 'U.F'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Uf: TSpeedButton
    Left = 71
    Top = 13
    Width = 23
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    OnClick = Sb_UfClick
    ExplicitLeft = 60
  end
  object DBLCB_UF: TDBLookupComboBox
    Left = 3
    Top = 13
    Width = 65
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'UFE_CODIGO'
    ListField = 'UFE_SIGLA'
    ListSource = Ds_Uf
    TabOrder = 0
    OnKeyDown = DBLCB_UFKeyDown
  end
  object Qr_Uf: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT * '
      'FROM TB_UF'
      'ORDER BY UFE_SIGLA'
      '')
    ForcedRefresh = True
    Left = 13
    Top = 39
  end
  object Ds_Uf: TDataSource
    DataSet = Qr_Uf
    Left = 47
    Top = 40
  end
end
