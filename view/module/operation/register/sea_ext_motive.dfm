inherited SeaExtMotive: TSeaExtMotive
  Caption = 'Extintor - Pesquisa de Motivos Reprova'#231#227'o/Condena'#231#227'o'
  ClientHeight = 374
  ClientWidth = 753
  ExplicitWidth = 765
  ExplicitHeight = 437
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 69
    Width = 747
    Height = 302
    ExplicitTop = 69
    ExplicitWidth = 741
    ExplicitHeight = 293
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 743
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 651
      Height = 284
    end
    inherited pnl_pesq_right: TPanel
      Left = 653
      Height = 284
      ExplicitLeft = 647
      ExplicitHeight = 275
      inherited Sb_Sair_0: TSpeedButton
        Top = 221
        ExplicitTop = 221
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 158
        ExplicitTop = 158
      end
      inherited SB_Buscar: TSpeedButton
        Top = 95
        ExplicitTop = 95
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 32
        ExplicitTop = 32
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 747
    Height = 60
    ExplicitWidth = 741
    ExplicitHeight = 60
    object Label3: TLabel
      Left = 8
      Top = 8
      Width = 20
      Height = 14
      Caption = 'Tipo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label28: TLabel
      Left = 131
      Top = 8
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object CB_BuscaTipo: TComboBox
      Left = 6
      Top = 24
      Width = 118
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'CONDENA'#199#195'O'
      Items.Strings = (
        'CONDENA'#199#195'O'
        'REPROVA'#199#195'O')
    end
    object E_BuscaDescricao: TEdit
      Left = 126
      Top = 24
      Width = 459
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
