inherited SeaPrinters: TSeaPrinters
  Caption = 'Pesquisa de Impressora'
  ClientHeight = 392
  ClientWidth = 586
  ExplicitWidth = 598
  ExplicitHeight = 455
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 580
    Height = 310
    ExplicitTop = 79
    ExplicitWidth = 574
    ExplicitHeight = 301
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 576
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 484
      Height = 292
    end
    inherited pnl_pesq_right: TPanel
      Left = 486
      Height = 292
      ExplicitLeft = 480
      ExplicitHeight = 283
      inherited Sb_Sair_0: TSpeedButton
        Top = 229
        ExplicitTop = 229
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 166
        ExplicitTop = 166
      end
      inherited SB_Buscar: TSpeedButton
        Top = 103
        ExplicitTop = 103
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 40
        ExplicitTop = 40
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 580
    Height = 70
    ExplicitWidth = 574
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 576
      Height = 65
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 570
      object Label28: TLabel
        Left = 11
        Top = 16
        Width = 99
        Height = 14
        Caption = 'Nome da impressora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaImpressora: TEdit
        Left = 8
        Top = 32
        Width = 529
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
end
