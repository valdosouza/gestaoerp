inherited SeaTaxation: TSeaTaxation
  Caption = 'Pesquisa de Tributa'#231#245'es para Nota Fiscal Eletr'#244'nica'
  ClientHeight = 347
  ClientWidth = 423
  ExplicitWidth = 435
  ExplicitHeight = 410
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 417
    Height = 265
    ExplicitTop = 79
    ExplicitWidth = 411
    ExplicitHeight = 256
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 413
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 321
      Height = 247
    end
    inherited pnl_pesq_right: TPanel
      Left = 323
      Height = 247
      ExplicitLeft = 317
      ExplicitHeight = 238
      inherited Sb_Sair_0: TSpeedButton
        Top = 184
        ExplicitTop = 184
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 121
        ExplicitTop = 121
      end
      inherited SB_Buscar: TSpeedButton
        Top = 58
        ExplicitTop = 58
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -5
        ExplicitTop = -5
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 417
    Height = 70
    ExplicitWidth = 411
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 413
      Height = 95
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 407
      DesignSize = (
        413
        95)
      object L_Busca_NCM: TLabel
        Left = 7
        Top = 21
        Width = 119
        Height = 14
        Caption = 'C'#243'd. Class. Fiscal (NCM)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object CHBX_BUSCA_CONSUMIDOR: TCheckBox
        Left = 156
        Top = 44
        Width = 254
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = 'Regra aplicada para venda ao Consumidor Final'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 150
      end
      object E_Busca_NCM: TEdit
        Left = 7
        Top = 41
        Width = 121
        Height = 22
        TabOrder = 0
      end
    end
  end
end
