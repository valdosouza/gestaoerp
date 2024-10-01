inherited RegElectronicCard: TRegElectronicCard
  Caption = 'Cadastro de Cart'#245'es Eletr'#244'nicos'
  ClientHeight = 249
  ClientWidth = 566
  ExplicitWidth = 572
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 185
    Width = 566
    ExplicitTop = 329
    ExplicitWidth = 560
    inherited SB_Inserir: TSpeedButton
      Left = 17
      Width = 86
      ExplicitLeft = 51
      ExplicitTop = 5
      ExplicitWidth = 86
    end
    inherited SB_Alterar: TSpeedButton
      Left = 105
      Width = 87
      ExplicitLeft = 130
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Excluir: TSpeedButton
      Left = 194
      Width = 93
      ExplicitLeft = 212
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 378
      Width = 87
      ExplicitLeft = 386
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 467
      Width = 94
      ExplicitLeft = 464
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Gravar: TSpeedButton
      Left = 289
      Width = 87
      ExplicitLeft = 285
      ExplicitTop = 5
      ExplicitWidth = 87
    end
  end
  inherited pnl_fundo: TPanel
    Width = 566
    Height = 185
    ExplicitWidth = 560
    ExplicitHeight = 329
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 562
      Height = 181
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 556
      ExplicitHeight = 325
      object Label1: TLabel
        Left = 8
        Top = 4
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
      object Label6: TLabel
        Left = 6
        Top = 106
        Width = 152
        Height = 14
        Caption = 'Nome de Contato da Operadora'
        FocusControl = E_Contato
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 346
        Top = 105
        Width = 24
        Height = 14
        Caption = 'Fone'
        FocusControl = E_Contato
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 454
        Top = 105
        Width = 86
        Height = 14
        Caption = 'V'#225'lidade Contrato'
        FocusControl = E_Contato
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 20
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
      object grbx_vista: TGroupBox
        Left = 165
        Top = 46
        Width = 193
        Height = 58
        Caption = 'Pagamento '#224' vista'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label4: TLabel
          Left = 5
          Top = 13
          Width = 88
          Height = 14
          AutoSize = False
          Caption = 'Taxa de Desconto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label8: TLabel
          Left = 96
          Top = 13
          Width = 84
          Height = 14
          AutoSize = False
          Caption = 'Prazo Pagamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object E_Aliq_Cred: TEdit
          Left = 4
          Top = 29
          Width = 90
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
        object E_Prz_Cred: TEdit
          Left = 95
          Top = 29
          Width = 90
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
      object grbx_parcela: TGroupBox
        Left = 368
        Top = 46
        Width = 188
        Height = 58
        Caption = 'Pagamento Parcelado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Label9: TLabel
          Left = 4
          Top = 12
          Width = 88
          Height = 14
          AutoSize = False
          Caption = 'Taxa de Desconto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label5: TLabel
          Left = 95
          Top = 11
          Width = 84
          Height = 14
          AutoSize = False
          Caption = 'Prazo Pagamento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object E_Aliq_Debi: TEdit
          Left = 3
          Top = 28
          Width = 90
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
        object E_Prz_DEbi: TEdit
          Left = 93
          Top = 28
          Width = 90
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
      object E_Contato: TEdit
        Left = 6
        Top = 121
        Width = 339
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
      object E_Fone: TEdit
        Left = 345
        Top = 121
        Width = 107
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
      object E_Validade: TEdit
        Left = 452
        Top = 121
        Width = 101
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object dbrg_tipo: TRadioGroup
        Left = 7
        Top = 46
        Width = 155
        Height = 58
        Caption = 'Tipo do Cart'#227'o'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Cr'#233'dito'
          'D'#233'bito')
        ParentFont = False
        TabOrder = 1
      end
    end
  end
end
