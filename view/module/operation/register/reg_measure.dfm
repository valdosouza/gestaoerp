inherited RegMeasure: TRegMeasure
  Caption = 'Cadastro de Medidas\Unidades'
  ClientHeight = 192
  ClientWidth = 598
  ExplicitWidth = 604
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 128
    Width = 598
    ExplicitTop = 156
    ExplicitWidth = 598
    inherited SB_Inserir: TSpeedButton
      Left = 5
      Width = 88
      ExplicitLeft = -9
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Alterar: TSpeedButton
      Left = 95
      ExplicitLeft = 95
    end
    inherited SB_Excluir: TSpeedButton
      Left = 199
      ExplicitLeft = 199
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 407
      Width = 96
      ExplicitLeft = 401
      ExplicitTop = 5
      ExplicitWidth = 96
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 505
      Width = 88
      ExplicitLeft = 491
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Gravar: TSpeedButton
      Left = 303
      ExplicitLeft = 303
    end
  end
  inherited pnl_fundo: TPanel
    Width = 598
    Height = 128
    ExplicitWidth = 598
    ExplicitHeight = 156
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 594
      Height = 124
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitHeight = 152
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
        Left = 58
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
      object L_Abreviatura: TLabel
        Left = 8
        Top = 56
        Width = 57
        Height = 14
        Caption = 'Abreviatura'
        FocusControl = E_Abreviatura
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Escala: TLabel
        Left = 78
        Top = 56
        Width = 32
        Height = 14
        Caption = 'Escala'
        FocusControl = E_Escala
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object L_Proporcao: TLabel
        Left = 183
        Top = 56
        Width = 50
        Height = 14
        Caption = 'Propor'#231#227'o'
        FocusControl = E_Proporcao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object L_MedidaGrupo: TLabel
        Left = 288
        Top = 56
        Width = 76
        Height = 14
        Caption = 'Grupo Card'#225'pio'
        FocusControl = E_MedidaGRupo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Visible = False
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
        Left = 58
        Top = 24
        Width = 519
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 1
      end
      object E_Abreviatura: TEdit
        Left = 8
        Top = 72
        Width = 69
        Height = 21
        MaxLength = 5
        TabOrder = 2
      end
      object E_Escala: TEdit
        Left = 78
        Top = 72
        Width = 103
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        Visible = False
      end
      object E_Proporcao: TEdit
        Left = 183
        Top = 72
        Width = 103
        Height = 21
        NumbersOnly = True
        TabOrder = 4
        Visible = False
      end
      object E_MedidaGRupo: TEdit
        Left = 288
        Top = 72
        Width = 289
        Height = 21
        MaxLength = 100
        TabOrder = 5
        Visible = False
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 464
    Top = 8
  end
end
