object Fm_ListaColaboradores: TFm_ListaColaboradores
  Left = 0
  Top = 0
  Width = 258
  Height = 38
  TabOrder = 0
  object Label19: TLabel
    Left = 0
    Top = 0
    Width = 258
    Height = 14
    Align = alTop
    Caption = 'Vendedor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 47
  end
  object Sb_Cadastro: TSpeedButton
    AlignWithMargins = True
    Left = 232
    Top = 14
    Width = 23
    Height = 21
    Margins.Top = 0
    Align = alRight
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_CadastroClick
    ExplicitTop = 10
    ExplicitHeight = 20
  end
  object Dblcb_Vendedor: TDBLookupComboBox
    Left = 0
    Top = 14
    Width = 229
    Height = 21
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'CLB_CODIGO'
    ListField = 'CLB_NOME'
    ListSource = DS_ListaVendedor
    ParentFont = False
    TabOrder = 0
    OnKeyDown = Dblcb_VendedorKeyDown
  end
  object Qr_ListaVendedor: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = IBT_Lista
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda, '
      'CLB_AQ_COM_SRV'
      'FROM TB_COLABORADOR tb_colaborador'
      '    INNER JOIN TB_CARGO tb_cargo'
      '    ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG)'
      
        'WHERE (CRG_DESCRICAO LIKE '#39'VENDEDOR%'#39') and (CLB_DEMISSAO IS NULL' +
        ')'
      'ORDER BY CLB_NOME')
    Left = 41
    Top = 36
  end
  object DS_ListaVendedor: TDataSource
    DataSet = Qr_ListaVendedor
    Left = 129
    Top = 32
  end
  object IBT_Lista: TSTTransaction
    DefaultDatabase = DM.IBD_Gestao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'wait')
    Left = 44
    Top = 91
  end
end
