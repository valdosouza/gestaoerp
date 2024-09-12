inherited RegConfigTag: TRegConfigTag
  Caption = 'Configurar Etiqueta'
  ClientHeight = 228
  ClientWidth = 598
  ExplicitWidth = 604
  ExplicitHeight = 272
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 164
    Width = 598
    ExplicitTop = 164
    ExplicitWidth = 598
    inherited SB_Inserir: TSpeedButton
      Left = -6
      ExplicitLeft = -6
    end
    inherited SB_Alterar: TSpeedButton
      Left = 98
      ExplicitLeft = 93
      ExplicitTop = 5
    end
    inherited SB_Excluir: TSpeedButton
      Left = 202
      Width = 95
      ExplicitLeft = 190
      ExplicitTop = 5
      ExplicitWidth = 95
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 400
      Width = 93
      ExplicitLeft = 393
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 495
      Width = 98
      ExplicitLeft = 500
      ExplicitTop = 5
      ExplicitWidth = 98
    end
    inherited SB_Gravar: TSpeedButton
      Left = 299
      Width = 99
      ExplicitLeft = 294
      ExplicitTop = 5
      ExplicitWidth = 99
    end
  end
  inherited pnl_fundo: TPanel
    Width = 598
    Height = 164
    ExplicitWidth = 598
    ExplicitHeight = 164
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 594
      Height = 160
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object Lb_Codigo: TLabel
        Left = 8
        Top = 9
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
      object Lb_Descricao: TLabel
        Left = 70
        Top = 8
        Width = 105
        Height = 14
        Caption = 'Descri'#231#227'o da Etiqueta'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Descricao: TEdit
        Left = 69
        Top = 23
        Width = 510
        Height = 21
        TabOrder = 0
      end
      object GroupBox2: TGroupBox
        Left = 133
        Top = 48
        Width = 225
        Height = 105
        Caption = 'Margens'
        TabOrder = 2
        object Lb_Superior: TLabel
          Left = 9
          Top = 16
          Width = 41
          Height = 14
          Caption = 'Superior'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Inferior: TLabel
          Left = 118
          Top = 17
          Width = 34
          Height = 14
          Caption = 'Inferior'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Direita: TLabel
          Left = 120
          Top = 56
          Width = 30
          Height = 14
          Caption = 'Direita'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Esquerda: TLabel
          Left = 9
          Top = 56
          Width = 46
          Height = 14
          Caption = 'Esquerda'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Superior: TEdit
          Left = 7
          Top = 31
          Width = 109
          Height = 21
          TabOrder = 0
        end
        object E_Inferior: TEdit
          Left = 119
          Top = 31
          Width = 100
          Height = 21
          TabOrder = 1
        end
        object E_Direita: TEdit
          Left = 121
          Top = 71
          Width = 100
          Height = 21
          TabOrder = 3
        end
        object E_Esquerda: TEdit
          Left = 7
          Top = 71
          Width = 109
          Height = 21
          TabOrder = 2
        end
      end
      object GroupBox3: TGroupBox
        Left = 360
        Top = 48
        Width = 222
        Height = 105
        Caption = 'Etiqueta'
        TabOrder = 3
        object Lb_Alt_Etiq: TLabel
          Left = 7
          Top = 16
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
        object Lb_Lar_Etiq: TLabel
          Left = 86
          Top = 17
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
        object Lb_Type_e_Size_Fonte: TLabel
          Left = 68
          Top = 56
          Width = 111
          Height = 14
          Caption = 'Fonte / Tipo e Tamanho'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_N_Coluna: TLabel
          Left = 7
          Top = 56
          Width = 47
          Height = 14
          Caption = 'N'#176' Coluna'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Lb_Dist_Coluna: TLabel
          Left = 154
          Top = 17
          Width = 57
          Height = 14
          Caption = 'Dist. Coluna'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object E_Alt_Etiq: TEdit
          Left = 6
          Top = 31
          Width = 77
          Height = 21
          TabOrder = 0
        end
        object E_Lar_Etiq: TEdit
          Left = 85
          Top = 31
          Width = 66
          Height = 21
          TabOrder = 1
        end
        object E_N_Coluna: TEdit
          Left = 6
          Top = 71
          Width = 59
          Height = 21
          TabOrder = 3
        end
        object E_TypeFonte: TEdit
          Left = 70
          Top = 71
          Width = 104
          Height = 21
          TabOrder = 4
        end
        object E_SizeFonte: TEdit
          Left = 178
          Top = 71
          Width = 37
          Height = 21
          TabOrder = 5
        end
        object E_Dist_Coluna: TEdit
          Left = 153
          Top = 31
          Width = 65
          Height = 21
          TabOrder = 2
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 48
        Width = 123
        Height = 105
        Caption = 'P'#225'gina'
        TabOrder = 1
        object Lb_Pg_Altura: TLabel
          Left = 9
          Top = 16
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
        object L_Pg_Largura: TLabel
          Left = 9
          Top = 56
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
        object E_Pg_Altura: TEdit
          Left = 7
          Top = 31
          Width = 109
          Height = 21
          TabOrder = 0
        end
        object E_Pg_Largura: TEdit
          Left = 7
          Top = 71
          Width = 109
          Height = 21
          TabOrder = 1
        end
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 23
        Width = 57
        Height = 22
        Color = clScrollBar
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 360
    Top = 65512
  end
end
