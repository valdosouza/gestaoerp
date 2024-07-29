inherited RegBankingAccount: TRegBankingAccount
  Caption = 'Cadastro de Contas Banc'#225'rias '
  ClientHeight = 217
  ClientWidth = 628
  ExplicitWidth = 640
  ExplicitHeight = 280
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 153
    Width = 628
    ExplicitTop = 144
    ExplicitWidth = 622
    inherited SB_Inserir: TSpeedButton
      Left = 1
      ExplicitLeft = 1
    end
    inherited SB_Alterar: TSpeedButton
      Left = 105
      ExplicitLeft = 105
    end
    inherited SB_Excluir: TSpeedButton
      Left = 209
      ExplicitLeft = 209
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 417
      ExplicitLeft = 417
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 521
      ExplicitLeft = 521
    end
    inherited SB_Gravar: TSpeedButton
      Left = 313
      ExplicitLeft = 313
    end
  end
  inherited pnl_fundo: TPanel
    Width = 628
    Height = 153
    ExplicitWidth = 622
    ExplicitHeight = 144
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 624
      Height = 149
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 618
      ExplicitHeight = 140
      object Lb_Codigo: TLabel
        Left = 8
        Top = 6
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
      object Lb_DtAbert: TLabel
        Left = 532
        Top = 8
        Width = 67
        Height = 14
        Caption = 'Data Abertura'
        FocusControl = E_DtAbert
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Banco: TLabel
        Left = 8
        Top = 48
        Width = 31
        Height = 14
        Caption = 'Banco'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Agencia: TLabel
        Left = 380
        Top = 48
        Width = 40
        Height = 14
        Caption = 'Ag'#234'ncia'
        FocusControl = E_agencia
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Conta: TLabel
        Left = 486
        Top = 48
        Width = 28
        Height = 14
        Caption = 'Conta'
        FocusControl = E_conta
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Fone: TLabel
        Left = 8
        Top = 90
        Width = 24
        Height = 14
        Caption = 'Fone'
        FocusControl = E_fone
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Fax: TLabel
        Left = 96
        Top = 90
        Width = 18
        Height = 14
        Caption = 'Fax'
        FocusControl = E_Fax
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Gerente: TLabel
        Left = 184
        Top = 90
        Width = 39
        Height = 14
        Caption = 'Gerente'
        FocusControl = E_Gerente
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Limite: TLabel
        Left = 457
        Top = 91
        Width = 27
        Height = 14
        Caption = 'Limite'
        FocusControl = E_Limite
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_DataVencto: TLabel
        Left = 522
        Top = 90
        Width = 62
        Height = 14
        Caption = 'Data Vencto.'
        FocusControl = E_DtVencto
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Empresa: TLabel
        Left = 68
        Top = 7
        Width = 63
        Height = 14
        Caption = 'Raz'#227'o Social'
        FocusControl = E_Codigo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_DV: TLabel
        Left = 451
        Top = 48
        Width = 20
        Height = 14
        Caption = 'D.V.'
        FocusControl = E_agencia
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_DV_2: TLabel
        Left = 580
        Top = 48
        Width = 20
        Height = 14
        Caption = 'D.V.'
        FocusControl = E_agencia
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 24
        Width = 57
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 0
      end
      object E_DtAbert: TEdit
        Left = 532
        Top = 24
        Width = 79
        Height = 21
        TabOrder = 2
      end
      object E_agencia: TEdit
        Left = 379
        Top = 64
        Width = 69
        Height = 21
        TabOrder = 4
      end
      object E_conta: TEdit
        Left = 484
        Top = 64
        Width = 93
        Height = 21
        TabOrder = 6
      end
      object E_fone: TEdit
        Left = 8
        Top = 106
        Width = 84
        Height = 21
        TabOrder = 8
      end
      object E_Fax: TEdit
        Left = 93
        Top = 106
        Width = 84
        Height = 21
        TabOrder = 9
      end
      object E_Gerente: TEdit
        Left = 178
        Top = 106
        Width = 273
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 10
      end
      object E_Limite: TEdit
        Left = 451
        Top = 106
        Width = 68
        Height = 21
        TabOrder = 11
      end
      object E_DtVencto: TEdit
        Left = 521
        Top = 106
        Width = 90
        Height = 21
        TabOrder = 12
      end
      object DBLCB_Banco: TComboBox
        Left = 8
        Top = 64
        Width = 368
        Height = 21
        TabOrder = 3
      end
      object DBLCB_Empresa: TComboBox
        Left = 65
        Top = 24
        Width = 465
        Height = 21
        TabOrder = 1
      end
      object DBEdit1: TEdit
        Left = 450
        Top = 64
        Width = 32
        Height = 21
        TabOrder = 5
      end
      object DBEdit2: TEdit
        Left = 579
        Top = 64
        Width = 32
        Height = 21
        TabOrder = 7
      end
    end
  end
end
