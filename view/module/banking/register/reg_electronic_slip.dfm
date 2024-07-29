inherited RegElectronicSlip: TRegElectronicSlip
  Caption = 'Cadastro para Cobran'#231'a em Boleto'
  ClientHeight = 553
  ClientWidth = 580
  ExplicitWidth = 592
  ExplicitHeight = 616
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 489
    Width = 580
    ExplicitTop = 480
    ExplicitWidth = 574
    inherited SB_Inserir: TSpeedButton
      Left = -47
      ExplicitLeft = -47
    end
    inherited SB_Alterar: TSpeedButton
      Left = 57
      ExplicitLeft = 57
    end
    inherited SB_Excluir: TSpeedButton
      Left = 161
      ExplicitLeft = 161
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 369
      ExplicitLeft = 369
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 473
      ExplicitLeft = 473
    end
    inherited SB_Gravar: TSpeedButton
      Left = 265
      ExplicitLeft = 265
    end
  end
  inherited pnl_fundo: TPanel
    Width = 580
    Height = 489
    ExplicitWidth = 574
    ExplicitHeight = 480
    object Pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 576
      Height = 485
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 570
      ExplicitHeight = 476
      object Lb_Carteira: TLabel
        Left = 15
        Top = 16
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
        Left = 208
        Top = 53
        Width = 24
        Height = 22
        Caption = '...'
      end
      object Lb_Cedente_Convenio: TLabel
        Left = 159
        Top = 54
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
      object Lb_Varia_Carteira: TLabel
        Left = 430
        Top = 54
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
      object Lb_Modelo_Boleto: TLabel
        Left = 16
        Top = 128
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
      object Lb_Local_Pagamneto: TLabel
        Left = 14
        Top = 209
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
      object Lb_Inst_Pagamento_1: TLabel
        Left = 14
        Top = 245
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
      object Lb_Inst_Pagamento_2: TLabel
        Left = 14
        Top = 281
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
      object Lb_IntrucaoAdicional: TLabel
        Left = 14
        Top = 319
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
      object Lb_Remessa_Retorno: TLabel
        Left = 14
        Top = 425
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
        Left = 536
        Top = 464
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
      object Lb_Tx_Multa: TLabel
        Left = 350
        Top = 166
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
      object Lb_Tx_Juros: TLabel
        Left = 15
        Top = 166
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
      object Lb_Protesto: TLabel
        Left = 105
        Top = 91
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
      object Lb_Vl_Tarifa: TLabel
        Left = 460
        Top = 166
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
      object Lb_Dias_Protesto: TLabel
        Left = 266
        Top = 91
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
      object Lb_Tx_Desconto: TLabel
        Left = 264
        Top = 166
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
      object Lb_Vl_Mora_Min: TLabel
        Left = 184
        Top = 166
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
      object Lb_LayoutRemessa: TLabel
        Left = 13
        Top = 91
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
      object Lb_CodTransmissao: TLabel
        Left = 296
        Top = 54
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
      object Lb_Posto_Benef: TLabel
        Left = 158
        Top = 127
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
      object Lb_Negativacao: TLabel
        Left = 331
        Top = 91
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
      object Lb_Dias_Negativacao: TLabel
        Left = 414
        Top = 90
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
      object Lb_Tx_Mora: TLabel
        Left = 103
        Top = 166
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
      object Dblcb_Carteira: TComboBox
        Left = 13
        Top = 30
        Width = 201
        Height = 21
        TabOrder = 0
      end
      object E_Cedente_Convenio: TEdit
        Left = 158
        Top = 68
        Width = 134
        Height = 21
        TabOrder = 2
      end
      object E_Varia_Carteira: TEdit
        Left = 427
        Top = 68
        Width = 107
        Height = 21
        TabOrder = 4
      end
      object Cb_Modelo_Boleto: TComboBox
        Left = 14
        Top = 142
        Width = 141
        Height = 21
        Style = csDropDownList
        TabOrder = 10
      end
      object E_Local_Pagamento: TEdit
        Left = 15
        Top = 224
        Width = 553
        Height = 21
        TabOrder = 18
      end
      object E_Inst_Pagamento_1: TEdit
        Left = 14
        Top = 261
        Width = 553
        Height = 21
        TabOrder = 20
      end
      object E_Inst_Pagamento_2: TEdit
        Left = 14
        Top = 297
        Width = 553
        Height = 21
        TabOrder = 22
      end
      object E_Path_Remessa_Retorno: TEdit
        Left = 14
        Top = 441
        Width = 528
        Height = 21
        TabOrder = 19
      end
      object E_Tx_Multa: TEdit
        Left = 348
        Top = 181
        Width = 110
        Height = 21
        TabOrder = 16
      end
      object E_Tx_Juros: TEdit
        Left = 13
        Top = 181
        Width = 84
        Height = 21
        TabOrder = 12
      end
      object Cb_Protesto: TComboBox
        Left = 105
        Top = 106
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
        Left = 13
        Top = 334
        Width = 552
        Height = 90
        TabOrder = 21
      end
      object E_Tx_Mora: TEdit
        Left = 99
        Top = 181
        Width = 80
        Height = 21
        TabOrder = 13
      end
      object E_VL_Tarifa: TEdit
        Left = 459
        Top = 181
        Width = 110
        Height = 21
        TabOrder = 17
      end
      object E_Dias_Protesto: TEdit
        Left = 266
        Top = 106
        Width = 59
        Height = 21
        TabOrder = 7
      end
      object RG_Aceite: TRadioGroup
        Left = 15
        Top = 53
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
        Left = 263
        Top = 181
        Width = 83
        Height = 21
        TabOrder = 15
      end
      object E_VL_MORA_MIN: TEdit
        Left = 181
        Top = 181
        Width = 80
        Height = 21
        TabOrder = 14
      end
      object Cb_LayoutRemessa: TComboBox
        Left = 13
        Top = 106
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
        Left = 294
        Top = 68
        Width = 131
        Height = 21
        TabOrder = 3
      end
      object E_POSTO_BENEF: TEdit
        Left = 158
        Top = 142
        Width = 98
        Height = 21
        TabOrder = 11
      end
      object Cb_Negativacao: TComboBox
        Left = 331
        Top = 106
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
        Left = 414
        Top = 106
        Width = 59
        Height = 21
        TabOrder = 9
      end
    end
  end
end
