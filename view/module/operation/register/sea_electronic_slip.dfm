inherited SeaElectronicSlip: TSeaElectronicSlip
  Caption = 'Cadastro de Cobran'#231'a em Boleto'
  ClientHeight = 352
  ClientWidth = 575
  ExplicitWidth = 587
  ExplicitHeight = 415
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 569
    Height = 278
    ExplicitTop = 71
    ExplicitWidth = 563
    ExplicitHeight = 269
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 565
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 473
      Height = 260
    end
    inherited pnl_pesq_right: TPanel
      Left = 475
      Height = 260
      ExplicitLeft = 469
      ExplicitHeight = 251
      inherited Sb_Sair_0: TSpeedButton
        Top = 197
        ExplicitTop = 197
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 134
        ExplicitTop = 134
      end
      inherited SB_Buscar: TSpeedButton
        Top = 71
        ExplicitTop = 71
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 8
        ExplicitTop = 8
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 569
    Height = 62
    ExplicitWidth = 563
    ExplicitHeight = 62
    object Grp_Parametros: TGroupBox
      Left = 2
      Top = 2
      Width = 565
      Height = 63
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 559
      object Label55: TLabel
        Left = 3
        Top = 17
        Width = 31
        Height = 14
        Caption = 'Banco'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaBanco: TEdit
        Left = 3
        Top = 29
        Width = 559
        Height = 22
        TabOrder = 0
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 56
    Top = 88
  end
end
