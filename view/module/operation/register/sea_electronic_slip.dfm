inherited SeaElectronicSlip: TSeaElectronicSlip
  Caption = 'Pesquisa de Cobran'#231'a em boleto'
  ClientHeight = 586
  ClientWidth = 575
  ExplicitWidth = 587
  ExplicitHeight = 649
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 569
    Height = 512
    ExplicitTop = 71
    ExplicitWidth = 563
    ExplicitHeight = 503
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 565
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 473
      Height = 494
    end
    inherited pnl_pesq_right: TPanel
      Left = 475
      Height = 494
      ExplicitLeft = 469
      ExplicitHeight = 485
      inherited Sb_Sair_0: TSpeedButton
        Top = 431
        ExplicitTop = 431
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 368
        ExplicitTop = 368
      end
      inherited SB_Buscar: TSpeedButton
        Top = 305
        ExplicitTop = 305
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 242
        ExplicitTop = 242
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
      object Lb_BuscaBanco: TLabel
        Left = 5
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
        Left = 5
        Top = 32
        Width = 557
        Height = 22
        TabOrder = 0
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 96
    Top = 65528
  end
end
