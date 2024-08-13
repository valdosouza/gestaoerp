inherited Fr_Especie_Doc: TFr_Especie_Doc
  BorderIcons = [biSystemMenu]
  Caption = 'Esp'#233'cie de Documento'
  ClientHeight = 111
  ClientWidth = 624
  ExplicitWidth = 630
  ExplicitHeight = 160
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 47
    Width = 624
    ExplicitTop = 47
    ExplicitWidth = 624
    inherited SB_Inserir: TSpeedButton
      Left = -3
      ExplicitLeft = 114
    end
    inherited SB_Alterar: TSpeedButton
      Left = 101
      ExplicitLeft = 191
    end
    inherited SB_Excluir: TSpeedButton
      Left = 205
      ExplicitLeft = 268
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 413
      ExplicitLeft = 426
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 517
      ExplicitLeft = 505
    end
    inherited SB_Gravar: TSpeedButton
      Left = 309
      ExplicitLeft = 233
    end
  end
  inherited pnl_fundo: TPanel
    Width = 624
    Height = 47
    ExplicitWidth = 624
    ExplicitHeight = 47
    object L_Descricao: TLabel
      Left = 121
      Top = 2
      Width = 105
      Height = 14
      Caption = 'Descri'#231#227'o da Carteira'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Numero: TLabel
      Left = 5
      Top = 2
      Width = 37
      Height = 14
      Caption = 'N'#250'mero'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Sigla: TLabel
      Left = 59
      Top = 2
      Width = 23
      Height = 14
      Caption = 'Sigla'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 123
      Top = 20
      Width = 288
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object E_Numero: TEdit
      Left = 5
      Top = 20
      Width = 50
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object E_Sigla: TEdit
      Left = 57
      Top = 20
      Width = 60
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 88
  end
end
