inherited SeaTechnicalAssistance: TSeaTechnicalAssistance
  Caption = 'Busca de Acompanhamento de Assist'#234'ncia T'#233'cnica'
  ClientHeight = 345
  ClientWidth = 788
  ExplicitWidth = 794
  ExplicitHeight = 394
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 782
    Height = 271
    ExplicitTop = 71
    ExplicitWidth = 782
    ExplicitHeight = 271
    inherited DBG_Pesquisa: TDBGrid
      Width = 686
      Height = 253
    end
    inherited pnl_pesq_right: TPanel
      Left = 688
      Height = 253
      ExplicitLeft = 688
      ExplicitHeight = 253
      inherited Sb_Sair_0: TSpeedButton
        Top = 190
        ExplicitTop = 190
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 127
        ExplicitTop = 127
      end
      inherited SB_Buscar: TSpeedButton
        Top = 64
        ExplicitTop = 64
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 1
        ExplicitTop = 1
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 782
    Height = 62
    ExplicitLeft = 91
    ExplicitTop = 107
    ExplicitWidth = 782
    ExplicitHeight = 62
    object L_BuscaNumero: TLabel
      Left = 7
      Top = 17
      Width = 91
      Height = 14
      AutoSize = False
      Caption = 'N'#250'mero Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_BuscaSituacao: TLabel
      Left = 446
      Top = 15
      Width = 42
      Height = 14
      Anchors = [akTop]
      Caption = 'Situa'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_BuscaNumero: TMaskEdit
      Left = 6
      Top = 31
      Width = 93
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object ChBx_Busca_Nome: TCheckBox
      Left = 106
      Top = 14
      Width = 121
      Height = 17
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object E_BuscaCliente: TMaskEdit
      Left = 102
      Top = 31
      Width = 341
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object ChBx_Busca_Fantasia: TCheckBox
      Left = 236
      Top = 14
      Width = 120
      Height = 17
      Caption = 'Apelido/Fantasia'
      TabOrder = 3
    end
    object DBLCB_BuscaSituacao: TComboBox
      Left = 446
      Top = 31
      Width = 329
      Height = 21
      TabOrder = 4
    end
  end
end
