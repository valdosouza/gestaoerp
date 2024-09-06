object Fm_ListaTecnicos: TFm_ListaTecnicos
  Left = 0
  Top = 0
  Width = 182
  Height = 38
  TabOrder = 0
  DesignSize = (
    182
    38)
  object Label19: TLabel
    Left = 3
    Top = 0
    Width = 38
    Height = 14
    Caption = 'T'#233'cnico'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Medida: TSpeedButton
    Left = 155
    Top = 12
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
  end
  object Dblcb_Lista: TDBLookupComboBox
    Left = 3
    Top = 14
    Width = 152
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'CLB_CODIGO'
    ListField = 'CLB_NOME'
    ListSource = DS_Lista
    TabOrder = 0
  end
  object Qr_Lista: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Listas
    SQL.Strings = (
      'SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda, '
      'CLB_AQ_COM_SRV'
      'FROM TB_COLABORADOR tb_colaborador'
      '    INNER JOIN TB_CARGO tb_cargo'
      '    ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG)'
      
        'WHERE (CRG_DESCRICAO LIKE '#39'VENDEDOR%'#39') and (CLB_DEMISSAO IS NULL' +
        ')'
      'ORDER BY CLB_NOME')
    ForcedRefresh = True
    Left = 41
    Top = 36
  end
  object DS_Lista: TDataSource
    AutoEdit = False
    DataSet = Qr_Lista
    Left = 129
    Top = 32
  end
end
