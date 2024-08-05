inherited RegJobPosition: TRegJobPosition
  Caption = 'Cadastro de Cargos'
  ClientHeight = 121
  ClientWidth = 622
  ExplicitWidth = 628
  ExplicitHeight = 170
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 57
    Width = 622
    ExplicitTop = 57
    ExplicitWidth = 622
    inherited SB_Inserir: TSpeedButton
      Left = -5
      ExplicitLeft = -5
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      ExplicitLeft = 99
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
    Height = 57
    ExplicitWidth = 622
    ExplicitHeight = 57
    object L_Descricao: TLabel
      Left = 83
      Top = 4
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object L_ID: TLabel
      Left = 7
      Top = 4
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object E_Descricao: TEdit
      Left = 83
      Top = 19
      Width = 526
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object E_ID: TEdit
      Left = 7
      Top = 19
      Width = 73
      Height = 21
      TabOrder = 1
    end
  end
  inherited MnuBase: TMainMenu
    Left = 448
    Top = 0
  end
end
