inherited RegElectronicSlip: TRegElectronicSlip
  Caption = 'Cadastro para Cobran'#231'a em Boleto'
  ClientHeight = 572
  ClientWidth = 632
  ExplicitWidth = 638
  ExplicitHeight = 616
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 508
    Width = 632
    ExplicitTop = 508
    ExplicitWidth = 632
    inherited SB_Inserir: TSpeedButton
      Left = 5
      ExplicitLeft = -47
    end
    inherited SB_Alterar: TSpeedButton
      Left = 109
      ExplicitLeft = 57
    end
    inherited SB_Excluir: TSpeedButton
      Left = 213
      ExplicitLeft = 161
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 421
      ExplicitLeft = 369
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 525
      ExplicitLeft = 473
    end
    inherited SB_Gravar: TSpeedButton
      Left = 317
      ExplicitLeft = 265
    end
  end
  inherited pnl_fundo: TPanel
    Width = 632
    Height = 508
    ExplicitWidth = 632
    ExplicitHeight = 508
    object Pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 628
      Height = 504
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Carteira: TLabel
        Left = 5
        Top = 41
        Width = 103
        Height = 14
        Caption = 'Carteira de Cobran'#231'a'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Carteira: TSpeedButton
        Left = 213
        Top = 54
        Width = 24
        Height = 22
        Caption = '...'
      end
      object L_Cedente_Convenio: TLabel
        Left = 149
        Top = 79
        Width = 116
        Height = 14
        Caption = 'C'#243'd Cedente / Conv'#234'nio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Varia_Carteira: TLabel
        Left = 420
        Top = 79
        Width = 99
        Height = 14
        Caption = 'Varia'#231#227'o da Carteira'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Modelo_Boleto: TLabel
        Left = 5
        Top = 153
        Width = 82
        Height = 14
        Caption = 'Modelo do Boleto'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object L_Local_Pagamneto: TLabel
        Left = 5
        Top = 234
        Width = 107
        Height = 14
        Caption = 'Local para Pagamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Inst_Pagamento_1: TLabel
        Left = 5
        Top = 270
        Width = 245
        Height = 14
        Caption = 'Instru'#231#227'o para Pagamento 1 - Remessa Registrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Inst_Pagamento_2: TLabel
        Left = 5
        Top = 306
        Width = 245
        Height = 14
        Caption = 'Instru'#231#227'o para Pagamento 2 - Remessa Registrada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_IntrucaoAdicional: TLabel
        Left = 5
        Top = 344
        Width = 90
        Height = 14
        Caption = 'Instru'#231#227'o adicional'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Remessa_Retorno: TLabel
        Left = 5
        Top = 450
        Width = 270
        Height = 14
        Caption = 'Local de armazenamento arquivos de Remessa/Retorno'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Path_remessa: TSpeedButton
        Left = 566
        Top = 466
        Width = 24
        Height = 22
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Tx_Multa: TLabel
        Left = 340
        Top = 191
        Width = 46
        Height = 14
        Caption = 'Multa (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Tx_Juros: TLabel
        Left = 5
        Top = 191
        Width = 74
        Height = 14
        Caption = 'Juros /M'#234's (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Protesto: TLabel
        Left = 95
        Top = 116
        Width = 72
        Height = 14
        Caption = 'Protestar T'#237'tulo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vl_Tarifa: TLabel
        Left = 450
        Top = 191
        Width = 55
        Height = 14
        Caption = 'Valor Tarifa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Dias_Protesto: TLabel
        Left = 256
        Top = 116
        Width = 38
        Height = 14
        Caption = 'Nr Dias '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Tx_Desconto: TLabel
        Left = 254
        Top = 191
        Width = 67
        Height = 14
        Caption = 'Desconto (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vl_Mora_Min: TLabel
        Left = 174
        Top = 191
        Width = 59
        Height = 14
        Caption = 'Mora M'#237'nima'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_LayoutRemessa: TLabel
        Left = 5
        Top = 116
        Width = 81
        Height = 14
        Caption = 'Layout Remessa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_CodTransmissao: TLabel
        Left = 286
        Top = 79
        Width = 98
        Height = 14
        Caption = 'C'#243'digo Transmiss'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Posto_Benef: TLabel
        Left = 148
        Top = 152
        Width = 87
        Height = 14
        Caption = 'Posto Benefici'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Negativacao: TLabel
        Left = 321
        Top = 116
        Width = 74
        Height = 14
        Caption = 'Negativar T'#237'tulo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Dias_Negativacao: TLabel
        Left = 404
        Top = 115
        Width = 38
        Height = 14
        Caption = 'Nr Dias '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Tx_Mora: TLabel
        Left = 93
        Top = 191
        Width = 63
        Height = 14
        Caption = 'Mora/Dia (%)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object cb_Carteira: TComboBox
        Left = 5
        Top = 55
        Width = 201
        Height = 21
        TabOrder = 0
      end
      object E_Cedente_Convenio: TEdit
        Left = 148
        Top = 93
        Width = 134
        Height = 21
        TabOrder = 2
      end
      object E_Varia_Carteira: TEdit
        Left = 417
        Top = 93
        Width = 107
        Height = 21
        TabOrder = 4
      end
      object Cb_Modelo_Boleto: TComboBox
        Left = 5
        Top = 167
        Width = 141
        Height = 21
        Style = csDropDownList
        TabOrder = 10
      end
      object E_Local_Pagamento: TEdit
        Left = 5
        Top = 249
        Width = 555
        Height = 21
        TabOrder = 18
      end
      object E_Inst_Pagamento_1: TEdit
        Left = 5
        Top = 286
        Width = 555
        Height = 21
        TabOrder = 19
      end
      object E_Inst_Pagamento_2: TEdit
        Left = 5
        Top = 322
        Width = 555
        Height = 21
        TabOrder = 20
      end
      object E_Path_Remessa_Retorno: TEdit
        Left = 5
        Top = 466
        Width = 555
        Height = 21
        TabOrder = 22
      end
      object E_Tx_Multa: TEdit
        Left = 338
        Top = 206
        Width = 110
        Height = 21
        TabOrder = 16
      end
      object E_Tx_Juros: TEdit
        Left = 5
        Top = 206
        Width = 84
        Height = 21
        TabOrder = 12
      end
      object Cb_Protesto: TComboBox
        Left = 95
        Top = 131
        Width = 158
        Height = 21
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 6
        Text = '1 - Protestar (Dias Corridos)'
        Items.Strings = (
          '0 -  Sem instru'#231#227'o'
          '1 - Protestar (Dias Corridos)'
          '2 - Protestar (Dias '#218'teis)'
          '3 - N'#227'o protestar')
      end
      object DBMemo1: TMemo
        Left = 5
        Top = 359
        Width = 555
        Height = 90
        TabOrder = 21
      end
      object E_Tx_Mora: TEdit
        Left = 89
        Top = 206
        Width = 80
        Height = 21
        TabOrder = 13
      end
      object E_VL_Tarifa: TEdit
        Left = 449
        Top = 206
        Width = 111
        Height = 21
        TabOrder = 17
      end
      object E_Dias_Protesto: TEdit
        Left = 256
        Top = 131
        Width = 59
        Height = 21
        TabOrder = 7
      end
      object RG_Aceite: TRadioGroup
        Left = 5
        Top = 78
        Width = 137
        Height = 35
        Caption = 'Aceite'
        Columns = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Items.Strings = (
          'SIM'
          'N'#195'O')
        ParentFont = False
        TabOrder = 1
      end
      object E_Tx_Desconto: TEdit
        Left = 253
        Top = 206
        Width = 83
        Height = 21
        TabOrder = 15
      end
      object E_VL_MORA_MIN: TEdit
        Left = 174
        Top = 206
        Width = 80
        Height = 21
        TabOrder = 14
      end
      object Cb_LayoutRemessa: TComboBox
        Left = 5
        Top = 131
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 5
        Text = 'c240'
        Items.Strings = (
          'c240'
          'c400')
      end
      object E_CodTransmissao: TEdit
        Left = 284
        Top = 93
        Width = 131
        Height = 21
        TabOrder = 3
      end
      object E_POSTO_BENEF: TEdit
        Left = 148
        Top = 167
        Width = 98
        Height = 21
        TabOrder = 11
      end
      object Cb_Negativacao: TComboBox
        Left = 321
        Top = 131
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 8
        Text = 'N'#227'o'
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
      object E_Dias_Negativacao: TEdit
        Left = 404
        Top = 131
        Width = 59
        Height = 21
        TabOrder = 9
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 576
    Top = 8
  end
end
