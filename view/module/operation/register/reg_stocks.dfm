inherited RegStocks: TRegStocks
  Caption = 'Cadastro de Estoques'
  ClientHeight = 172
  ClientWidth = 641
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 657
  ExplicitHeight = 231
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 108
    Width = 641
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 108
    ExplicitWidth = 638
    inherited SB_Inserir: TSpeedButton
      Left = 2
      Width = 78
      ExplicitLeft = -6
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    inherited SB_Alterar: TSpeedButton
      Left = 82
      Width = 78
      ExplicitLeft = 73
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    inherited SB_Excluir: TSpeedButton
      Left = 162
      Width = 78
      ExplicitLeft = 154
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 322
      Width = 78
      ExplicitLeft = 312
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 558
      Width = 78
      ExplicitLeft = 549
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    inherited SB_Gravar: TSpeedButton
      Left = 242
      Width = 78
      ExplicitLeft = 230
      ExplicitTop = 5
      ExplicitWidth = 78
    end
    object Sb_Pesquisar: TSpeedButton
      AlignWithMargins = True
      Left = 401
      Top = 3
      Width = 78
      Height = 58
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Pesquisar- F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      ExplicitLeft = 395
      ExplicitTop = -5
    end
    object Sb_Iten_Estoque: TSpeedButton
      AlignWithMargins = True
      Left = 479
      Top = 3
      Width = 78
      Height = 58
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Estoque - F8'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00370777033333
        3330337F3F7F33333F3787070003333707303F737773333373F7007703333330
        700077337F3333373777887007333337007733F773F333337733700070333333
        077037773733333F7F37703707333300080737F373333377737F003333333307
        78087733FFF3337FFF7F33300033330008073F3777F33F777F73073070370733
        078073F7F7FF73F37FF7700070007037007837773777F73377FF007777700730
        70007733FFF77F37377707700077033707307F37773F7FFF7337080777070003
        3330737F3F7F777F333778080707770333333F7F737F3F7F3333080787070003
        33337F73FF737773333307800077033333337337773373333333}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      Transparent = False
      ExplicitLeft = 470
      ExplicitTop = 4
    end
  end
  inherited pnl_fundo: TPanel
    Width = 641
    Height = 108
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 638
    ExplicitHeight = 108
    object L_Codigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Descricao: TLabel
      Left = 57
      Top = 8
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_Estoque: TCheckBox
      Left = 8
      Top = 48
      Width = 106
      Height = 17
      Caption = 'Estoque Principal'
      TabOrder = 0
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 24
      Width = 49
      Height = 22
      Color = clScrollBar
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Descricao: TEdit
      Left = 58
      Top = 24
      Width = 573
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited MnuBase: TMainMenu
    Left = 152
  end
end
