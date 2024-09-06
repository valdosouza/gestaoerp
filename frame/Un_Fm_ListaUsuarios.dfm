object Fm_ListaUsuarios: TFm_ListaUsuarios
  Left = 0
  Top = 0
  Width = 220
  Height = 78
  TabOrder = 0
  DesignSize = (
    220
    78)
  object Label19: TLabel
    Left = 3
    Top = 0
    Width = 47
    Height = 14
    Caption = 'Vendedor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Medida: TSpeedButton
    Left = 190
    Top = 13
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_MedidaClick
    ExplicitLeft = 216
  end
  object Dblcb_Lista: TDBLookupComboBox
    Left = 2
    Top = 14
    Width = 188
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'USU_CODIGO'
    ListField = 'USU_LOGIN'
    ListSource = DS_Lista
    TabOrder = 0
  end
  object Qr_Lista: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Listas
    SQL.Strings = (
      'SELECT USU_CODIGO, USU_LOGIN, USU_LEVEL, USU_NOME'
      'FROM TB_USUARIO    '
      'WHERE (USU_ATIVO = '#39'S'#39')'
      'ORDER BY USU_LOGIN')
    ForcedRefresh = True
    Left = 41
    Top = 36
  end
  object DS_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 129
    Top = 32
  end
end
