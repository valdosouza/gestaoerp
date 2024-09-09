inherited RegProductBrand: TRegProductBrand
  Caption = 'Cadastro de Marca de Produto'
  ClientHeight = 187
  ClientWidth = 615
  ExplicitWidth = 621
  ExplicitHeight = 231
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 123
    Width = 615
    ExplicitTop = 229
    ExplicitWidth = 615
    inherited SB_Inserir: TSpeedButton
      Left = 17
      Width = 87
      ExplicitLeft = 2
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Alterar: TSpeedButton
      Left = 106
      ExplicitLeft = 106
    end
    inherited SB_Excluir: TSpeedButton
      Left = 210
      ExplicitLeft = 210
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 418
      ExplicitLeft = 418
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 522
      Width = 88
      ExplicitLeft = 508
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Gravar: TSpeedButton
      Left = 314
      ExplicitLeft = 314
    end
  end
  inherited pnl_fundo: TPanel
    Width = 615
    Height = 123
    ExplicitWidth = 615
    ExplicitHeight = 229
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 615
    Height = 123
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitTop = -1
    ExplicitHeight = 162
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
      Left = 57
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
      Width = 537
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
    inline Fm_ListaFornecedores1: TFm_ListaFornecedores
      Left = 6
      Top = 52
      Width = 442
      Height = 41
      TabOrder = 2
      ExplicitLeft = 6
      ExplicitTop = 52
    end
  end
  inherited MnuBase: TMainMenu
    Left = 264
    Top = 0
  end
end
