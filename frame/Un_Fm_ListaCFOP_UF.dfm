object Fm_ListaCFOP_UF: TFm_ListaCFOP_UF
  Left = 0
  Top = 0
  Width = 604
  Height = 45
  TabOrder = 0
  object Label25: TLabel
    Left = 202
    Top = 6
    Width = 94
    Height = 14
    Caption = 'Descri'#231#227'o do CFOP'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object RG_Tipo_S_E: TRadioGroup
    Left = 4
    Top = 0
    Width = 128
    Height = 45
    Caption = 'Tipo da Opera'#231#227'o'
    Columns = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Sa'#237'da'
      'Entrada')
    ParentFont = False
    TabOrder = 0
    OnClick = RG_Tipo_S_EClick
  end
  object Dblcb_Lista: TDBLookupComboBox
    Left = 202
    Top = 20
    Width = 395
    Height = 23
    KeyField = 'NAT_CODIGO'
    ListField = 'CFOP'
    ListSource = Ds_Filtra_CFOP
    TabOrder = 1
    OnKeyDown = Dblcb_ListaKeyDown
  end
  object Qr_Filtra_CFOP: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = IBT_Lista
    SQL.Strings = (
      'SELECT '
      'NAT_CODIGO,'
      'NAT_CFOP,'
      'NAT_DESCRICAO,'
      'NAT_CFOP || '#39' - '#39' || NAT_DESCRICAO CFOP,'
      'NAT_RESUMIDO'
      'FROM TB_NATUREZA'
      'WHERE NAT_ATIVO = '#39'S'#39
      '  AND NAT_SENTIDO =:NAT_SENTIDO'
      '  AND NAT_ALCADA=:NAT_ALCADA'
      'ORDER BY NAT_CFOP')
    ForcedRefresh = True
    Left = 214
    Top = 92
    ParamData = <
      item
        Name = 'NAT_SENTIDO'
      end
      item
        Name = 'NAT_ALCADA'
      end>
  end
  object Ds_Filtra_CFOP: TDataSource
    DataSet = Qr_Filtra_CFOP
    Left = 214
    Top = 148
  end
  object IBT_Lista: TSTTransaction
    Left = 324
    Top = 129
  end
end
