inherited RegProfile: TRegProfile
  Caption = 'Cadastro de Perfil'
  ClientHeight = 151
  ClientWidth = 567
  ExplicitWidth = 573
  ExplicitHeight = 195
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 87
    Width = 567
    ExplicitTop = 87
    ExplicitWidth = 567
    inherited SB_Inserir: TSpeedButton
      Left = 1
      Width = 89
      ExplicitLeft = -16
      ExplicitTop = 5
      ExplicitWidth = 89
    end
    inherited SB_Alterar: TSpeedButton
      Left = 92
      Width = 94
      ExplicitLeft = 88
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 188
      Width = 94
      ExplicitLeft = 184
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 380
      Width = 94
      ExplicitLeft = 376
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 476
      Width = 86
      ExplicitLeft = 472
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Gravar: TSpeedButton
      Left = 284
      Width = 94
      ExplicitLeft = 280
      ExplicitTop = 5
      ExplicitWidth = 94
    end
  end
  inherited pnl_fundo: TPanel
    Width = 567
    Height = 87
    ExplicitWidth = 567
    ExplicitHeight = 87
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
    object SB_Permissao: TSpeedButton
      Left = 453
      Top = 4
      Width = 105
      Height = 42
      Caption = 'Permiss'#245'es - F8'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5000555555555555577755555555555550B0555555555555F7F7555555555550
        00B05555555555577757555555555550B3B05555555555F7F557555555555000
        3B0555555555577755755555555500B3B0555555555577555755555555550B3B
        055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
        555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
        55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
        555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
        55555575FFFF7755555555570000755555555557777775555555}
      Layout = blGlyphTop
      NumGlyphs = 2
      ParentFont = False
      OnClick = SB_PermissaoClick
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
      TabOrder = 0
    end
    object E_Descricao: TEdit
      Left = 57
      Top = 24
      Width = 390
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
