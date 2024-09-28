inherited CfgTechnicalAssistance: TCfgTechnicalAssistance
  Caption = 'Configura'#231#227'o de Acompanhamento de Assist'#234'ncia T'#233'cnica'
  ClientHeight = 130
  ClientWidth = 478
  ExplicitWidth = 484
  ExplicitHeight = 179
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 66
    Width = 478
    ExplicitTop = 114
    ExplicitWidth = 480
    inherited SB_Inserir: TSpeedButton
      Left = 3
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Alterar: TSpeedButton
      Left = 15
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 15
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Excluir: TSpeedButton
      Left = 27
      Width = 10
      Align = alLeft
      Visible = False
      ExplicitLeft = 27
      ExplicitTop = 5
      ExplicitWidth = 10
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 293
      Width = 103
      ExplicitLeft = 322
      ExplicitTop = 5
      ExplicitWidth = 103
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 398
      Width = 75
      ExplicitLeft = 400
      ExplicitTop = 5
      ExplicitWidth = 75
    end
    inherited SB_Gravar: TSpeedButton
      Left = 189
      ExplicitLeft = 191
    end
  end
  inherited pnl_fundo: TPanel
    Width = 478
    Height = 66
    ExplicitWidth = 480
    ExplicitHeight = 114
    object L_ModeloImpressao: TLabel
      Left = 11
      Top = 8
      Width = 108
      Height = 14
      Caption = 'Modelos de Impress'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Cbx_ModeloImpressao: TComboBox
      Left = 7
      Top = 28
      Width = 463
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'MODELO 1  - GENIO'
      Items.Strings = (
        'MODELO 1  - GENIO'
        'MODELO 2  - BALAN'#199'AS PINHAIS')
    end
  end
  inherited MnuBase: TMainMenu
    Left = 328
    Top = 8
  end
end
