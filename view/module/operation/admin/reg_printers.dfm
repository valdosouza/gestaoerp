inherited RegPrinters: TRegPrinters
  Caption = 'Cadastro de Impressoras'
  ClientHeight = 233
  ClientWidth = 622
  ExplicitWidth = 628
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 169
    Width = 622
    ExplicitTop = 169
    ExplicitWidth = 622
    inherited SB_Inserir: TSpeedButton
      Left = -5
      ExplicitLeft = -5
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      ExplicitLeft = 280
    end
    inherited SB_Excluir: TSpeedButton
      Left = 203
      ExplicitLeft = 203
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 411
      ExplicitLeft = 411
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 515
      ExplicitLeft = 515
    end
    inherited SB_Gravar: TSpeedButton
      Left = 307
      ExplicitLeft = 307
    end
  end
  inherited pnl_fundo: TPanel
    Width = 622
    Height = 169
    ExplicitWidth = 622
    ExplicitHeight = 169
    object SeaPrinters: TPanel
      Left = 2
      Top = 2
      Width = 618
      Height = 165
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Descricao: TLabel
        Left = 5
        Top = 5
        Width = 121
        Height = 14
        Caption = 'Descri'#231#227'o da Impressora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Caminho: TLabel
        Left = 5
        Top = 45
        Width = 152
        Height = 14
        Caption = 'Caminho da Porta de Impress'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Salto: TLabel
        Left = 5
        Top = 84
        Width = 169
        Height = 14
        Caption = 'N'#250'mero de Salto Ap'#243's a Impress'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vias: TLabel
        Left = 184
        Top = 84
        Width = 172
        Height = 14
        Caption = 'N'#250'mero de Vias a serem Impressos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Colunas: TLabel
        Left = 366
        Top = 84
        Width = 94
        Height = 14
        Caption = 'N'#250'mero de Colunas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 5
        Top = 21
        Width = 42
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
      object E_Descricao: TEdit
        Left = 49
        Top = 21
        Width = 560
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
      object E_Caminho: TEdit
        Left = 5
        Top = 60
        Width = 604
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
      object Ch_Tipo: TCheckBox
        Left = 5
        Top = 140
        Width = 310
        Height = 17
        Caption = 'Est'#225' impressora '#233' a principal onde o pedido sair'#225' completo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object E_Salto: TEdit
        Left = 5
        Top = 99
        Width = 177
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 3
      end
      object E_Vias: TEdit
        Left = 184
        Top = 99
        Width = 179
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 4
      end
      object E_Colunas: TEdit
        Left = 366
        Top = 99
        Width = 168
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 552
    Top = 88
  end
end
