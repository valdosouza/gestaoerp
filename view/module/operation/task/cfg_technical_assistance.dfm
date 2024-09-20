inherited CfgTechnicalAssistance: TCfgTechnicalAssistance
  Caption = 'Configura'#231#227'o de Acompanhamento de Assist'#234'ncia T'#233'cnica'
  ClientHeight = 178
  ClientWidth = 480
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 496
  ExplicitHeight = 237
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 114
    Width = 480
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 136
    ExplicitWidth = 480
    inherited SB_Inserir: TSpeedButton
      Left = -93
      ExplicitLeft = -93
    end
    inherited SB_Alterar: TSpeedButton
      Left = 11
      Width = 74
      ExplicitLeft = -17
      ExplicitTop = 5
      ExplicitWidth = 74
    end
    inherited SB_Excluir: TSpeedButton
      Left = 87
      ExplicitLeft = 87
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 295
      Width = 103
      ExplicitLeft = 322
      ExplicitTop = 5
      ExplicitWidth = 103
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 400
      Width = 75
      ExplicitLeft = 400
      ExplicitTop = 5
      ExplicitWidth = 75
    end
    inherited SB_Gravar: TSpeedButton
      Left = 191
      ExplicitLeft = 191
    end
  end
  inherited pnl_fundo: TPanel
    Width = 480
    Height = 114
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 480
    ExplicitHeight = 136
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
    object Btn_Ok_Local: TButton
      Left = 244
      Top = 83
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 1
      ExplicitTop = 105
    end
    object Btn_Cn_Local: TButton
      Left = 323
      Top = 83
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 2
      ExplicitTop = 105
    end
    object Btn_Ap_Local: TButton
      Left = 398
      Top = 83
      Width = 79
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Aplicar'
      TabOrder = 3
      ExplicitTop = 105
    end
  end
  inherited MnuBase: TMainMenu
    Left = 328
    Top = 8
  end
end
