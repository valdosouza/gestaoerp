inherited RegGroupMenu: TRegGroupMenu
  Caption = ' Cadastro de Grupo e SubGrupo do Card'#225'pio'
  ClientHeight = 479
  ClientWidth = 579
  ExplicitWidth = 591
  ExplicitHeight = 542
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 415
    Width = 579
    ExplicitTop = 406
    ExplicitWidth = 573
    inherited SB_Inserir: TSpeedButton
      Left = -1
      Width = 98
      ExplicitLeft = 15
      ExplicitTop = 5
      ExplicitWidth = 98
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      Width = 96
      ExplicitLeft = 121
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Excluir: TSpeedButton
      Left = 197
      Width = 92
      ExplicitLeft = 213
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 377
      Width = 98
      ExplicitLeft = 391
      ExplicitTop = 5
      ExplicitWidth = 98
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 477
      Width = 97
      ExplicitLeft = 482
      ExplicitTop = 5
      ExplicitWidth = 97
    end
    inherited SB_Gravar: TSpeedButton
      Left = 291
      Width = 84
      ExplicitLeft = 293
      ExplicitTop = 5
      ExplicitWidth = 84
    end
  end
  inherited pnl_fundo: TPanel
    Width = 579
    Height = 415
    ExplicitWidth = 573
    ExplicitHeight = 406
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 575
      Height = 210
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 569
      ExplicitHeight = 201
      object Label3: TLabel
        Left = 72
        Top = 5
        Width = 100
        Height = 14
        Caption = 'Descri'#231#227'o do Grupo '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 464
        Top = 5
        Width = 89
        Height = 14
        Caption = 'Desconto Especial'
        FocusControl = E_Vl_Desconto
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 9
        Top = 5
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
      object E_Descricao: TEdit
        Left = 72
        Top = 21
        Width = 390
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_Vl_Desconto: TEdit
        Left = 464
        Top = 21
        Width = 92
        Height = 21
        TabOrder = 1
      end
      object DBRG_Tamanhos: TRadioGroup
        Left = 423
        Top = 45
        Width = 136
        Height = 56
        Caption = 'M'#250'ltiplos Tamanhos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Sim'
          'N'#227'o')
        ParentFont = False
        TabOrder = 2
      end
      object DBRG_Interface: TRadioGroup
        Left = 209
        Top = 45
        Width = 212
        Height = 56
        Caption = 'Controle de Interface'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Utilizar Lista Simples'
          'Utilizar Bot'#245'es com Imagem')
        ParentFont = False
        TabOrder = 3
      end
      object DBRG_Composicao: TRadioGroup
        Left = 8
        Top = 45
        Width = 199
        Height = 56
        Caption = 'Estoque por Composi'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'N'#227'o Utilizar este Recurso'
          'Baixar somente os Itens')
        ParentFont = False
        TabOrder = 4
      end
      object ChBx_Propag_Tamanho: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 129
        Width = 565
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alBottom
        Caption = 
          'Propagar a cria'#231#227'o de produtos para cada tamanho criado, incluin' +
          'do atualiza'#231#227'o de valores'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        ExplicitTop = 120
        ExplicitWidth = 559
      end
      object ChBx_Agrupar_Abas: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 148
        Width = 565
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alBottom
        Caption = 'Mostrar os subgrupos em uma aba apenas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ExplicitTop = 139
        ExplicitWidth = 559
      end
      object E_Sequencia: TEdit
        Left = 8
        Top = 21
        Width = 62
        Height = 22
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object ChBx_Ativo: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 188
        Width = 565
        Height = 17
        Margins.Top = 1
        Align = alBottom
        Caption = 'Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        ExplicitTop = 179
        ExplicitWidth = 559
      end
      object ChBx_show_descktop: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 167
        Width = 565
        Height = 17
        Margins.Top = 1
        Align = alBottom
        Caption = 'Mostrar no Atendimento Desktop'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        ExplicitTop = 158
        ExplicitWidth = 559
      end
      object Chbx_Ifood: TCheckBox
        AlignWithMargins = True
        Left = 5
        Top = 110
        Width = 565
        Height = 17
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alBottom
        Caption = 'Enviar registro de Categoria para o Ifood'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        ExplicitTop = 101
        ExplicitWidth = 559
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 212
      Width = 575
      Height = 201
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Panel1'
      TabOrder = 1
      ExplicitTop = 203
      ExplicitWidth = 569
      DesignSize = (
        575
        201)
      object Sb_SubGrupos: TSpeedButton
        Left = 440
        Top = 168
        Width = 93
        Height = 27
        Anchors = [akRight, akBottom]
        Caption = 'Editar Subgrupos'
        ExplicitLeft = 461
      end
    end
  end
end
