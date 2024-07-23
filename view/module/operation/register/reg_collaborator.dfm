inherited RegCollaborator: TRegCollaborator
  Caption = 'Cadastro de Colaborador'
  ClientWidth = 653
  ExplicitWidth = 665
  ExplicitHeight = 470
  TextHeight = 13
  inherited pnl_botao: TPanel
    Width = 653
    ExplicitTop = 334
    ExplicitWidth = 647
    inherited SB_Inserir: TSpeedButton
      Left = 26
      ExplicitLeft = 26
    end
    inherited SB_Alterar: TSpeedButton
      Left = 130
      ExplicitLeft = 130
    end
    inherited SB_Excluir: TSpeedButton
      Left = 234
      ExplicitLeft = 234
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 442
      ExplicitLeft = 442
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 546
      ExplicitLeft = 546
    end
    inherited SB_Gravar: TSpeedButton
      Left = 338
      ExplicitLeft = 338
    end
  end
  inherited pnl_fundo: TPanel
    Top = 175
    Width = 653
    Height = 168
    ExplicitTop = 175
    ExplicitWidth = 647
    ExplicitHeight = 159
  end
  object pnl_fundos: TPanel [2]
    Left = 0
    Top = 0
    Width = 653
    Height = 175
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitWidth = 647
    object Lb_Nome: TLabel
      Left = 68
      Top = 8
      Width = 27
      Height = 14
      Caption = 'Nome'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Endereco: TLabel
      Left = 108
      Top = 48
      Width = 46
      Height = 14
      Caption = 'Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Bairro: TLabel
      Left = 424
      Top = 47
      Width = 29
      Height = 14
      Caption = 'Bairro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Cep: TLabel
      Left = 7
      Top = 46
      Width = 25
      Height = 14
      Caption = 'C.E.P'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Fone: TLabel
      Left = 9
      Top = 127
      Width = 24
      Height = 14
      Caption = 'Fone'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Email: TLabel
      Left = 364
      Top = 87
      Width = 30
      Height = 14
      Caption = 'E_mail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Codigo: TLabel
      Left = 7
      Top = 8
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
    object Lb_Celular: TLabel
      Left = 102
      Top = 127
      Width = 33
      Height = 14
      Caption = 'Celular'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Adimissao: TLabel
      Left = 466
      Top = 127
      Width = 48
      Height = 14
      Caption = 'Admiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Demissao: TLabel
      Left = 550
      Top = 127
      Width = 47
      Height = 14
      Caption = 'Demiss'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Sexo: TLabel
      Left = 595
      Top = 7
      Width = 25
      Height = 14
      Caption = 'Sexo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Cargo: TLabel
      Left = 186
      Top = 127
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
    object SB_Cargo: TSpeedButton
      Left = 435
      Top = 140
      Width = 24
      Height = 22
      Caption = '...'
    end
    object Sb_Cep: TSpeedButton
      Left = 76
      Top = 61
      Width = 25
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
    end
    object Lb_UF: TLabel
      Left = 9
      Top = 86
      Width = 16
      Height = 14
      Caption = 'U.F'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Lb_Cidade: TLabel
      Left = 63
      Top = 85
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Endereco: TSpeedButton
      Left = 392
      Top = 62
      Width = 25
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
    end
    object E_Celular: TMaskEdit
      Left = 100
      Top = 140
      Width = 85
      Height = 22
      EditMask = '!\(##\) ####-####;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 14
      ParentFont = False
      TabOrder = 10
      Text = ''
    end
    object E_Nome: TEdit
      Left = 69
      Top = 23
      Width = 527
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
    object E_Endereco: TEdit
      Left = 105
      Top = 61
      Width = 283
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object E_Bairro: TEdit
      Left = 422
      Top = 61
      Width = 221
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
    object E_Cep: TEdit
      Left = 6
      Top = 61
      Width = 63
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object E_Fone: TMaskEdit
      Left = 7
      Top = 140
      Width = 92
      Height = 22
      EditMask = '!\(##\) ####-####;0;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 14
      ParentFont = False
      TabOrder = 9
      Text = ''
    end
    object E_Email: TEdit
      Left = 359
      Top = 102
      Width = 284
      Height = 22
      CharCase = ecLowerCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object E_Codigo: TEdit
      Left = 7
      Top = 23
      Width = 62
      Height = 22
      Color = clMenu
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Demissao: TEdit
      Left = 545
      Top = 140
      Width = 91
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object DBCB_Sexo: TComboBox
      Left = 597
      Top = 23
      Width = 47
      Height = 22
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Items.Strings = (
        'M'
        'F'
        'H')
    end
    object DBLCB_Cargo: TComboBox
      Left = 185
      Top = 140
      Width = 246
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object DBLCB_UF: TComboBox
      Left = 7
      Top = 101
      Width = 52
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object DBLCB_Cidade: TComboBox
      Left = 61
      Top = 101
      Width = 296
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object e_ADMISSAO: TDateTimePicker
      Left = 462
      Top = 140
      Width = 81
      Height = 22
      Date = 39580.000000000000000000
      Time = 0.356281493062852000
      TabOrder = 13
    end
  end
  object PG_Informacoes: TPageControl [3]
    Left = 0
    Top = 175
    Width = 653
    Height = 168
    ActivePage = TBS_documentos
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    ExplicitWidth = 647
    ExplicitHeight = 159
    object TabSheet3: TTabSheet
      Caption = 'Observa'#231#227'o'
      object ME_Observ: TMemo
        Left = 0
        Top = 0
        Width = 645
        Height = 137
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TBS_documentos: TTabSheet
      Caption = 'Documentos'
      ImageIndex = 1
      object pnl_documentos: TPanel
        Left = 0
        Top = 0
        Width = 645
        Height = 137
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_Secao: TLabel
          Left = 590
          Top = 7
          Width = 31
          Height = 14
          Caption = 'Se'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_DataNasc: TLabel
          Left = 5
          Top = 7
          Width = 81
          Height = 14
          Caption = 'Data Nascimento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Identidade: TLabel
          Left = 219
          Top = 7
          Width = 49
          Height = 14
          Caption = 'Identidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Pis: TLabel
          Left = 340
          Top = 7
          Width = 23
          Height = 14
          Caption = 'P.I.S.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Tit_Eleit: TLabel
          Left = 456
          Top = 7
          Width = 72
          Height = 14
          Caption = 'T'#237'tulo de Eleitor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Zona: TLabel
          Left = 557
          Top = 7
          Width = 25
          Height = 14
          Caption = 'Zona'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Pai: TLabel
          Left = 5
          Top = 47
          Width = 59
          Height = 14
          Caption = 'Nome do Pai'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Mae: TLabel
          Left = 315
          Top = 47
          Width = 65
          Height = 14
          Caption = 'Nome da M'#227'e'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Salario: TLabel
          Left = 260
          Top = 84
          Width = 90
          Height = 14
          Caption = 'Sal'#225'rio/Pro-Labore'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Militar: TLabel
          Left = 5
          Top = 82
          Width = 82
          Height = 14
          Caption = 'Certificado Militar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Secao: TEdit
          Left = 588
          Top = 23
          Width = 41
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object E_Identidade: TEdit
          Left = 216
          Top = 23
          Width = 121
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object E_Pis: TEdit
          Left = 338
          Top = 23
          Width = 117
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object E_Tit_Eleit: TEdit
          Left = 455
          Top = 23
          Width = 99
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object E_Zona: TEdit
          Left = 554
          Top = 23
          Width = 32
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object E_Pai: TEdit
          Left = 5
          Top = 59
          Width = 310
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
        object E_Mae: TEdit
          Left = 312
          Top = 59
          Width = 317
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
        object E_DataNasc: TDateTimePicker
          Left = 5
          Top = 23
          Width = 84
          Height = 22
          Date = 39580.000000000000000000
          Time = 0.356281493062852000
          TabOrder = 0
        end
        object E_Salario: TEdit
          Left = 256
          Top = 96
          Width = 94
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object dbcert_militar: TEdit
          Left = 6
          Top = 96
          Width = 248
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object Chbx_CPF: TCheckBox
          Left = 93
          Top = 6
          Width = 42
          Height = 17
          Caption = 'CPF / '
          TabOrder = 11
        end
        object chbx_CNPJ: TCheckBox
          Left = 142
          Top = 6
          Width = 42
          Height = 17
          Caption = 'CNPJ'
          TabOrder = 12
        end
        object E_Cpf_CNPJ: TMaskEdit
          Left = 90
          Top = 23
          Width = 122
          Height = 21
          EditMask = '###.###.###-##;0;_'
          MaxLength = 14
          TabOrder = 1
          Text = ''
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Comiss'#227'o'
      ImageIndex = 2
      object Pnl_Com_Vda: TPanel
        Left = 0
        Top = 0
        Width = 241
        Height = 137
        Align = alLeft
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Lb_AQ_COm: TLabel
          Left = 5
          Top = 4
          Width = 107
          Height = 14
          Caption = ' Aliq. Comiss'#227'o Venda'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_AQ_COm: TEdit
          Left = 5
          Top = 19
          Width = 93
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object dbbx_comissaoProd: TCheckBox
          Left = 6
          Top = 42
          Width = 175
          Height = 17
          Caption = 'Recebo comiss'#227'o por Produto'
          TabOrder = 1
        end
        object Rg_FmaCalcComVda: TRadioGroup
          Left = 5
          Top = 60
          Width = 228
          Height = 60
          Caption = 'Forma de C'#225'lculo da Comiss'#227'o na Venda'
          ItemIndex = 0
          Items.Strings = (
            'Pela al'#237'quota do pr'#243'prio cadastro'
            'Pela soma da al'#237'quota no item de venda')
          TabOrder = 2
        end
      end
      object Pnl_Com_Srv: TPanel
        Left = 241
        Top = 0
        Width = 240
        Height = 137
        Align = alLeft
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object Lb_Vl_AQ_SRV: TLabel
          Left = 9
          Top = 4
          Width = 110
          Height = 14
          Caption = ' Aliq.Comiss'#227'o Servi'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object dbbx_comissaoSrv: TCheckBox
          Left = 10
          Top = 42
          Width = 175
          Height = 17
          Caption = 'Recebo Comiss'#227'o por Servi'#231'o'
          TabOrder = 0
        end
        object e_VL_AQ_SRV: TEdit
          Left = 9
          Top = 19
          Width = 93
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Rg_FmaCalcComSrv: TRadioGroup
          Left = 5
          Top = 61
          Width = 228
          Height = 60
          Caption = 'Forma de C'#225'lculo da Comiss'#227'o no Servi'#231'o'
          ItemIndex = 0
          Items.Strings = (
            'Pela al'#237'quota do pr'#243'prio cadastro'
            'Pela soma da al'#237'quota no item de servi'#231'o')
          TabOrder = 2
        end
      end
    end
    object tbs_Outras: TTabSheet
      Caption = 'Outras Informa'#231#245'es'
      ImageIndex = 3
      object Pnl_Outra_Inf: TPanel
        Left = 0
        Top = 0
        Width = 645
        Height = 137
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        ExplicitWidth = 639
        ExplicitHeight = 128
        object Lb_Usuario: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 138
          Height = 14
          Caption = 'Nome do Usuario no Sistema'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object DBLCB_Usuario: TComboBox
          AlignWithMargins = True
          Left = 5
          Top = 25
          Width = 220
          Height = 21
          TabOrder = 0
        end
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 192
    Top = 65528
  end
end
