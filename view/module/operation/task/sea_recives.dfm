inherited SeaRecives: TSeaRecives
  Caption = 'Pesquisa de Recibo'
  ClientHeight = 298
  ClientWidth = 648
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 660
  ExplicitHeight = 361
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 73
    Width = 642
    Height = 222
    ExplicitTop = 71
    ExplicitWidth = 636
    ExplicitHeight = 242
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 638
      Height = 16
      ExplicitTop = 0
      ExplicitWidth = 638
      ExplicitHeight = 16
    end
    inherited DBG_Pesquisa: TDBGrid
      Top = 18
      Width = 546
      Height = 202
    end
    inherited pnl_pesq_right: TPanel
      Left = 548
      Top = 18
      Height = 202
      ExplicitLeft = 542
      ExplicitHeight = 224
      inherited Sb_Sair_0: TSpeedButton
        Top = 139
        ExplicitTop = 170
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 76
        ExplicitTop = 107
      end
      inherited SB_Buscar: TSpeedButton
        Top = 13
        ExplicitTop = 44
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -50
        ExplicitTop = -19
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 642
    Height = 64
    ExplicitWidth = 642
    ExplicitHeight = 64
    object GroupBox4: TGroupBox
      Left = 2
      Top = -1
      Width = 638
      Height = 63
      Align = alBottom
      Caption = ' Digite sua op'#231#227'o de busca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitTop = -6
      object Label50: TLabel
        Left = 174
        Top = 15
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
      object Label51: TLabel
        Left = 555
        Top = 15
        Width = 25
        Height = 14
        Caption = 'Valor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaValor: TMaskEdit
        Tag = 32
        Left = 552
        Top = 34
        Width = 81
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = ''
      end
      object E_BuscaNumero: TMaskEdit
        Tag = 32
        Left = 172
        Top = 34
        Width = 81
        Height = 22
        TabOrder = 3
        Text = ''
      end
      object chck_dataBusca: TCheckBox
        Left = 7
        Top = 14
        Width = 97
        Height = 17
        Caption = 'Por Data'
        TabOrder = 0
      end
      object E_Data_Ini: TDateTimePicker
        Left = 7
        Top = 34
        Width = 79
        Height = 22
        Date = 39580.000000000000000000
        Time = 0.356281493062852000
        TabOrder = 1
      end
      object E_Data_Fim: TDateTimePicker
        Left = 88
        Top = 33
        Width = 82
        Height = 22
        Date = 39580.000000000000000000
        Time = 0.356281493062852000
        TabOrder = 2
      end
      object e_nomebusca: TEdit
        Left = 254
        Top = 34
        Width = 297
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 4
      end
      object chck_buscaEmitente: TCheckBox
        Left = 256
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Emitente'
        TabOrder = 6
      end
      object chck_buscaSacado: TCheckBox
        Left = 327
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Sacado'
        TabOrder = 7
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 168
    Top = 65528
  end
end
