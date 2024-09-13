inherited BaseRegistry1: TBaseRegistry1
  Caption = 'Cadastro de Revestimento dos Produtos'
  ClientHeight = 121
  ClientWidth = 596
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 612
  ExplicitHeight = 180
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 57
    Width = 596
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 73
    ExplicitWidth = 596
    inherited SB_Inserir: TSpeedButton
      Left = -2
      Width = 87
      ExplicitLeft = 50
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Alterar: TSpeedButton
      Left = 87
      ExplicitLeft = 87
    end
    inherited SB_Excluir: TSpeedButton
      Left = 191
      ExplicitLeft = 191
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 399
      ExplicitLeft = 399
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 503
      Width = 88
      ExplicitLeft = 584
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Gravar: TSpeedButton
      Left = 295
      ExplicitLeft = 295
    end
  end
  inherited pnl_fundo: TPanel
    Width = 596
    Height = 57
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 596
    ExplicitHeight = 73
    object L_Descricao: TLabel
      Left = 5
      Top = 4
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
    object E_Descricao: TEdit
      Left = 5
      Top = 21
      Width = 580
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
  end
end
