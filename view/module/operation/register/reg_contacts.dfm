inherited RegContacts: TRegContacts
  Caption = 'RegContacts'
  ClientHeight = 456
  ClientWidth = 596
  ExplicitWidth = 602
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 392
    Width = 596
    ExplicitTop = 198
    ExplicitWidth = 526
    inherited SB_Inserir: TSpeedButton
      Left = 5
      Width = 96
      ExplicitLeft = 6
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Alterar: TSpeedButton
      Left = 103
      Width = 96
      ExplicitLeft = 104
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Excluir: TSpeedButton
      Left = 201
      Width = 96
      ExplicitLeft = 202
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 397
      Width = 96
      ExplicitLeft = 398
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 495
      Width = 96
      ExplicitLeft = 496
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Gravar: TSpeedButton
      Left = 299
      Width = 96
      ExplicitLeft = 300
      ExplicitTop = 5
      ExplicitWidth = 96
    end
  end
  inherited pnl_fundo: TPanel
    Width = 596
    Height = 392
    ExplicitTop = -1
    ExplicitWidth = 558
    ExplicitHeight = 354
    object L_Codigo: TLabel
      Left = 5
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
    object L_Nome: TLabel
      Left = 5
      Top = 49
      Width = 27
      Height = 14
      Caption = 'Nome'
      FocusControl = E_Nome
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Sexo: TLabel
      Left = 442
      Top = 8
      Width = 25
      Height = 14
      Caption = 'Sexo'
      FocusControl = CB_Sexo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Aniversario: TLabel
      Left = 526
      Top = 8
      Width = 56
      Height = 14
      Caption = 'Anivers'#225'rio'
      FocusControl = E_Aniver
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Data: TLabel
      Left = 56
      Top = 8
      Width = 44
      Height = 14
      Caption = 'Cadastro'
      FocusControl = E_Data
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Empresa: TLabel
      Left = 140
      Top = 8
      Width = 42
      Height = 14
      Caption = 'Empresa'
      FocusControl = CB_Empresa
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Cargo: TLabel
      Left = 315
      Top = 49
      Width = 29
      Height = 14
      Caption = 'Cargo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Cep: TLabel
      Left = 5
      Top = 89
      Width = 19
      Height = 14
      Caption = 'Cep'
      FocusControl = E_Cep
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Cep: TSpeedButton
      Left = 76
      Top = 104
      Width = 23
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFFFFFFFFFFFFFF000000000000
        000077777777777777770FFFFFFFFFFFFFF07F3333FFF33333370FFFF777FFFF
        FFF07F333777333333370FFFFFFFFFFFFFF07F3333FFFFFF33370FFFF777777F
        FFF07F33377777733FF70FFFFFFFFFFF99907F3FFF33333377770F777FFFFFFF
        9CA07F77733333337F370FFFFFFFFFFF9A907FFFFFFFFFFF7FF7000000000000
        0000777777777777777733333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      Layout = blGlyphTop
      Margin = 0
      NumGlyphs = 2
      OnClick = Sb_CepClick
    end
    object L_Endereco: TLabel
      Left = 101
      Top = 89
      Width = 46
      Height = 14
      Caption = 'Endere'#231'o'
      FocusControl = E_Endereco
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Complemento: TLabel
      Left = 456
      Top = 89
      Width = 64
      Height = 14
      Caption = 'Complemento'
      FocusControl = E_Complemento
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_UF: TLabel
      Left = 390
      Top = 130
      Width = 13
      Height = 14
      Caption = 'UF'
      FocusControl = CB_UF
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Bairro: TLabel
      Left = 5
      Top = 129
      Width = 29
      Height = 14
      Caption = 'Bairro'
      FocusControl = E_Bairro
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Cidade: TLabel
      Left = 207
      Top = 129
      Width = 33
      Height = 14
      Caption = 'Cidade'
      FocusControl = E_Cidade
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Pais: TLabel
      Left = 445
      Top = 129
      Width = 20
      Height = 14
      Caption = 'Pais'
      FocusControl = E_Pais
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Fone: TLabel
      Left = 5
      Top = 168
      Width = 24
      Height = 14
      Caption = 'Fone'
      FocusControl = E_Fone
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Ramal: TLabel
      Left = 79
      Top = 168
      Width = 29
      Height = 14
      Caption = 'Ramal'
      FocusControl = E_Ramal
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Email: TLabel
      Left = 227
      Top = 168
      Width = 34
      Height = 14
      Caption = 'E - Mail'
      FocusControl = E_Email
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Celular: TLabel
      Left = 153
      Top = 168
      Width = 33
      Height = 14
      Caption = 'Celular'
      FocusControl = E_Celular
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_MSN: TLabel
      Left = 5
      Top = 207
      Width = 313
      Height = 14
      Caption = 'Ferramenta de mensagem: Teams / Skype / Telegram / WhatsApp'
      FocusControl = E_MSN
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Contato: TSpeedButton
      Left = 565
      Top = 64
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = Sb_ContatoClick
    end
    object E_Codigo: TEdit
      Left = 5
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
    object E_Nome: TEdit
      Left = 5
      Top = 64
      Width = 308
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object E_Aniver: TMaskEdit
      Left = 526
      Top = 24
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      EditMask = '00/00;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      Text = '  /  '
    end
    object E_Data: TDateTimePicker
      Left = 56
      Top = 24
      Width = 81
      Height = 22
      Date = 39580.356281493060000000
      Time = 39580.356281493060000000
      TabOrder = 1
    end
    object CB_Empresa: TComboBox
      Left = 139
      Top = 24
      Width = 302
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CB_Cargo: TComboBox
      Left = 315
      Top = 64
      Width = 247
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object E_Endereco: TEdit
      Left = 101
      Top = 104
      Width = 352
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object CB_Sexo: TComboBox
      Left = 442
      Top = 24
      Width = 82
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'M'
        'F')
    end
    object E_Cep: TEdit
      Left = 5
      Top = 104
      Width = 68
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object E_Complemento: TEdit
      Left = 456
      Top = 104
      Width = 132
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object CB_UF: TComboBox
      Left = 390
      Top = 144
      Width = 54
      Height = 21
      Style = csDropDownList
      TabOrder = 12
      Items.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
    end
    object E_Bairro: TEdit
      Left = 5
      Top = 144
      Width = 200
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object E_Cidade: TEdit
      Left = 208
      Top = 144
      Width = 180
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object E_Pais: TEdit
      Left = 445
      Top = 144
      Width = 143
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object E_Fone: TEdit
      Left = 5
      Top = 183
      Width = 72
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object E_Ramal: TEdit
      Left = 79
      Top = 183
      Width = 72
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object E_Email: TEdit
      Left = 227
      Top = 183
      Width = 254
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
    object E_Celular: TEdit
      Left = 153
      Top = 183
      Width = 72
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
    end
    object CHK_Contato: TCheckBox
      Left = 488
      Top = 185
      Width = 100
      Height = 17
      Caption = 'Contato Principal'
      TabOrder = 18
    end
    object E_MSN: TEdit
      Left = 5
      Top = 223
      Width = 476
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
    end
    object PG_Informacoes: TPageControl
      Left = 2
      Top = 251
      Width = 592
      Height = 139
      ActivePage = TabSheet1
      Align = alBottom
      Style = tsFlatButtons
      TabOrder = 20
      ExplicitLeft = 0
      ExplicitWidth = 653
      object TabSheet1: TTabSheet
        Caption = 'Observa'#231#227'o'
        ExplicitWidth = 546
        object ME_Observ: TMemo
          Left = 0
          Top = 0
          Width = 584
          Height = 108
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
          ExplicitLeft = 176
          ExplicitTop = 3
          ExplicitWidth = 185
          ExplicitHeight = 89
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 496
    Top = 360
  end
end
