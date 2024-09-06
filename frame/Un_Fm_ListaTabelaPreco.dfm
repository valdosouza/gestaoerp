object Fm_ListaTabelaPreco: TFm_ListaTabelaPreco
  Left = 0
  Top = 0
  Width = 248
  Height = 37
  TabOrder = 0
  DesignSize = (
    248
    37)
  object Label53: TLabel
    Left = 0
    Top = 0
    Width = 77
    Height = 14
    Caption = 'Tabela de Pre'#231'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Preco: TSpeedButton
    Left = 221
    Top = 13
    Width = 25
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    OnClick = Sb_PrecoClick
    ExplicitLeft = 282
  end
  object Dblcb_Lista: TDBLookupComboBox
    Left = 0
    Top = 13
    Width = 219
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'TPR_CODIGO'
    ListField = 'TPR_NOME'
    ListSource = Ds_Tabelas
    TabOrder = 0
    OnKeyDown = Dblcb_ListaKeyDown
  end
  object Qr_Tabelas: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'select  * from TB_TABELA_PRECO'
      'ORDER BY TPR_NOME')
    ForcedRefresh = True
    Left = 99
    Top = 40
  end
  object Ds_Tabelas: TDataSource
    DataSet = Qr_Tabelas
    Left = 163
    Top = 39
  end
end
