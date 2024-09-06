object Fm_ListaEstoques: TFm_ListaEstoques
  Left = 0
  Top = 0
  Width = 230
  Height = 36
  TabOrder = 0
  DesignSize = (
    230
    36)
  object Label1: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 0
    Width = 225
    Height = 14
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Estoque'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 39
  end
  object Sb_Cadastro: TSpeedButton
    Left = 207
    Top = 14
    Width = 23
    Height = 22
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
    ExplicitLeft = 204
    ExplicitTop = 17
    ExplicitHeight = 19
  end
  object Dblcb_Estoque: TDBLookupComboBox
    Left = 3
    Top = 14
    Width = 195
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    KeyField = 'ETS_CODIGO'
    ListField = 'ETS_DESCRICAO'
    ListSource = Ds_Estoques
    TabOrder = 0
    OnKeyDown = Dblcb_EstoqueKeyDown
  end
  object ChBx_Estoques: TCheckBox
    Left = 124
    Top = 0
    Width = 103
    Height = 14
    Anchors = [akTop, akRight]
    Caption = 'Selecionar todos'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ChBx_EstoquesClick
  end
  object Qr_Estoques: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT ETS_CODMHA, ETS_CODIGO, ETS_DESCRICAO, ETS_PRINCIPAL'
      'FROM TB_ESTOQUES'
      'WHERE'
      'ETS_CODMHA = :ETS_CODMHA'
      'ORDER BY ETS_PRINCIPAL DESC, ETS_DESCRICAO ASC'
      '')
    ForcedRefresh = True
    Left = 71
    Top = 8
    ParamData = <
      item
        Name = 'ETS_CODMHA'
      end>
    object Qr_EstoquesETS_CODMHA: TIntegerField
      FieldName = 'ETS_CODMHA'
      Origin = '"TB_ESTOQUES"."ETS_CODMHA"'
      Required = True
    end
    object Qr_EstoquesETS_CODIGO: TIntegerField
      FieldName = 'ETS_CODIGO'
      Origin = '"TB_ESTOQUES"."ETS_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object Ds_Estoques: TDataSource
    DataSet = Qr_Estoques
    Left = 103
    Top = 8
  end
end
