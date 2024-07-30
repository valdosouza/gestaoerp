object Fm_ListaProdutos: TFm_ListaProdutos
  Left = 0
  Top = 0
  Width = 499
  Height = 43
  TabOrder = 0
  DesignSize = (
    499
    43)
  object Label3: TLabel
    Left = 106
    Top = 1
    Width = 104
    Height = 14
    Caption = 'Descri'#231#227'o do Produto'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 5
    Top = 1
    Width = 73
    Height = 14
    Caption = 'C'#243'digo Produto'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Produto: TSpeedButton
    Left = 468
    Top = 15
    Width = 24
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    OnClick = Sb_ProdutoClick
  end
  object E_Cd_Produto: TMaskEdit
    Left = 3
    Top = 16
    Width = 97
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = ''
    OnExit = E_Cd_ProdutoExit
  end
  object E_Busca_Produto: TEdit
    Left = 102
    Top = 16
    Width = 362
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
end
