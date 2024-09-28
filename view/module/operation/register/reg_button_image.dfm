inherited RegButtonImage: TRegButtonImage
  Caption = 'Cadastro de Bot'#227'o'
  ClientHeight = 287
  ClientWidth = 640
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 656
  ExplicitHeight = 346
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 223
    Width = 640
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 223
    ExplicitWidth = 640
    inherited SB_Inserir: TSpeedButton
      Left = 5
      Width = 105
      ExplicitLeft = 8
      ExplicitTop = 5
      ExplicitWidth = 105
    end
    inherited SB_Alterar: TSpeedButton
      Left = 112
      ExplicitLeft = 120
      ExplicitTop = -2
    end
    inherited SB_Excluir: TSpeedButton
      Left = 216
      ExplicitLeft = 216
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 424
      ExplicitLeft = 424
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 528
      Width = 107
      ExplicitLeft = 528
      ExplicitTop = 5
      ExplicitWidth = 107
    end
    inherited SB_Gravar: TSpeedButton
      Left = 320
      ExplicitLeft = 320
    end
  end
  inherited pnl_fundo: TPanel
    Width = 640
    Height = 223
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 640
    ExplicitHeight = 223
    object L_Codigo: TLabel
      Left = 5
      Top = 4
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Descricao: TLabel
      Left = 93
      Top = 4
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Path_Botao: TLabel
      Left = 5
      Top = 45
      Width = 126
      Height = 14
      Caption = 'Local da Imagem do Bot'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Load: TSpeedButton
      Left = 445
      Top = 62
      Width = 23
      Height = 22
      Hint = 'Adicionar Imagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000120B0000120B00000000000000000000008080008080
        008080008080007F7F0000010080800080800080800080800080800080800080
        80008080008080008080008080008080028181FFFFFFFEFEFE7E7F7F00808000
        8080008080008080008080008080008080008080008080008080008080008080
        008080007F7F0000010001FF0080800080800080800080800080800080800080
        80008080008080008080008080028181FFFFFFFEFEFE7E7E7E7F7F7F01818101
        8080018080018080018080018080018080018080018080008080008080008080
        007F7F0000010000FF0000FF008080008080008080008080007F7F007F7F007F
        7F007F7F007F7F008080028181FFFFFFFEFEFE7E7E7E7F7F7F807F7FFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE008080008080007F7F
        0000010000FF0000FF0000FF0000FF0000FF0000FF0000FE0000000101010100
        00010101010000000000FFFFFFFEFEFE7E7E7E7F7F7F7F7F7F7F7F7F7F7F7F7F
        7F7F7F7F7F7F7F7F7F7F7F7E7F7F7E7F7F7E7F7F7F7F7F7F7F7F007F7F000001
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FE010100FFFFFFFFFF
        FFFFFFFFFFFFFF000000FEFEFE7E7E7E7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
        7F7F7F7F7F7F7F7F7F7F7F008181008080018181FFFFFF7E7F7F0000010000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FE010100FFFFFFFEFE
        FEFEFEFEFEFEFE0000007E7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
        7F7F7F7F7F7F7F7F7F7F7FFFFFFFFEFEFE018080FFFFFF7E7E7E008080000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FE010100FFFFFF0000
        00010101FFFFFF0000000080807F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
        7F7F7F7F7F7F7F7F7F7F7F0080807F7F7F7F8080FFFFFF7E7F7F008080008080
        0000000000FF0000FF0000FF0000FE0101FF0101FF0101FE020201FFFFFFFFFF
        FFFFFFFFFEFEFE0000000080800080807F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7E
        7F7F7F7F7F7E7F7F7F8080FFFFFFFEFEFE008080FFFFFF7E7F7F008080008080
        0080800000000000FF0000FE010100FFFFFFFFFFFFFFFFFFFFFFFFFEFEFE0000
        00010101FFFFFF0000000080800080800080807F7F7F7F7F7F7F7F7F7F7F7F00
        81810181810180800080800180807F7F7F7F8080FFFFFF7E7F7F008080008080
        0080800080800000000000FE010100FFFFFFFEFEFEFEFEFEFEFEFEFFFFFFFFFF
        FFFFFFFFFEFEFE0000000080800080800080800080807F7F7F7F7F7F807F7FFF
        FFFFFFFFFFFEFEFE018080FFFFFFFEFEFE008080FFFFFF7E7F7F008080008080
        008080008080008080000000000000000000000000000000000000FFFFFF0000
        00010101FFFFFF0000000080800080800080800080800080807F7F7F7F7F7F7F
        7F7F7E7F7F7F7F7F7F7F7F0080807F7F7F7F8080FFFFFF7E7F7F008080008080
        008080008080008080008080008080010101FFFFFFFFFFFF000000FFFFFFFFFF
        FFFFFFFFFEFEFE0000000080800080800080800080800080800080800080807E
        7F7F018181FFFFFF7F7F7FFFFFFFFEFEFE008080FFFFFF7E7F7F008080008080
        008080008080008080008080008080008080000000FEFEFE000000FFFFFFBEBE
        BE000000FFFFFF00000000808000808000808000808000808000808000808000
        8080807F7FFEFEFE7E7F7F0080807F7F7F808080FFFFFF7E7F7F008080008080
        008080008080008080008080008080008080008080000000010101FFFFFFFEFE
        FEFFFFFFFDFDFD00000000808000808000808000808000808000808000808000
        80800080807F7F7F808080FFFFFFFFFFFFFFFFFFFEFEFE7E7F7F008080008080
        0080800080800080800080800080800080800080800080800000000000000000
        0000000000000000010100808000808000808000808000808000808000808000
        80800080800080807F7F7F7E7F7F7E7F7F7E7F7F7E7F7F7E7F7F008080008080
        0080800080800080800080800080800080800080800080800080800080800080
        8000808000808000808000808000808000808000808000808000808000808000
        8080008080008080008080008080008080008080008080008080}
      NumGlyphs = 2
      ParentFont = False
      Spacing = 0
    end
    object Sb_Path_Botao: TSpeedButton
      Left = 422
      Top = 62
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
    object Sb_unload: TSpeedButton
      Left = 470
      Top = 61
      Width = 23
      Height = 22
      Hint = 'Retirar Imagem'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentFont = False
      Spacing = 0
    end
    object L_Sequencia: TLabel
      Left = 499
      Top = 45
      Width = 51
      Height = 14
      Caption = 'Sequ'#234'ncia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Mrg_Botao: TLabel
      Left = 500
      Top = 10
      Width = 84
      Height = 14
      Caption = 'Margem do Bot'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Largura: TLabel
      Left = 447
      Top = 4
      Width = 38
      Height = 14
      Caption = 'Largura'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Altura: TLabel
      Left = 399
      Top = 4
      Width = 29
      Height = 14
      Caption = 'Altura'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 92
      Top = 20
      Width = 304
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_codigo: TEdit
      Left = 5
      Top = 20
      Width = 84
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object E_Path_Botao: TEdit
      Left = 5
      Top = 61
      Width = 413
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object E_Sequencia: TEdit
      Left = 500
      Top = 60
      Width = 58
      Height = 21
      TabOrder = 3
    end
    object UpDown1: TUpDown
      Left = 619
      Top = 7
      Width = 16
      Height = 21
      Associate = E_Mrg_Botao
      TabOrder = 4
    end
    object E_Mrg_Botao: TEdit
      Left = 588
      Top = 7
      Width = 31
      Height = 21
      TabOrder = 5
      Text = '0'
    end
    object E_Altura: TEdit
      Left = 399
      Top = 20
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object E_Largura: TEdit
      Left = 445
      Top = 20
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 86
      Width = 628
      Height = 129
      Caption = 'Pr'#233' Visualiza'#231#227'o do bot'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      object Sb_Amostra: TSpeedButton
        Left = 79
        Top = 16
        Width = 67
        Height = 56
        Caption = 'COCA'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = blGlyphTop
        Margin = 3
        ParentFont = False
        Spacing = 1
        Transparent = False
      end
      object E_Label: TMemo
        Left = 6
        Top = 16
        Width = 67
        Height = 56
        TabOrder = 0
      end
    end
  end
end
