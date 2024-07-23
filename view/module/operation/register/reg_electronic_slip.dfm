inherited RegElectronicSlip: TRegElectronicSlip
  Caption = 'Pesquisa de Cobran'#231'a em Boleto'
  ClientHeight = 383
  ClientWidth = 573
  ExplicitWidth = 585
  ExplicitHeight = 446
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 319
    Width = 573
    ExplicitTop = 310
    ExplicitWidth = 567
    inherited SB_Inserir: TSpeedButton
      Left = -54
      ExplicitLeft = -54
    end
    inherited SB_Alterar: TSpeedButton
      Left = 50
      ExplicitLeft = 50
    end
    inherited SB_Excluir: TSpeedButton
      Left = 154
      ExplicitLeft = 154
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 362
      ExplicitLeft = 362
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 466
      ExplicitLeft = 466
    end
    inherited SB_Gravar: TSpeedButton
      Left = 258
      ExplicitLeft = 258
    end
  end
  inherited pnl_fundo: TPanel
    Width = 573
    Height = 319
    ExplicitWidth = 567
    ExplicitHeight = 310
    object Pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 569
      Height = 315
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 563
      ExplicitHeight = 306
      object Label1: TLabel
        Left = 7
        Top = 0
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
        Top = 13
        Width = 24
        Height = 22
        Caption = '...'
      end
      object Label2: TLabel
        Left = 151
        Top = 38
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
      object Label4: TLabel
        Left = 422
        Top = 38
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
      object Label31: TLabel
        Left = 8
        Top = 112
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
      object Label5: TLabel
        Left = 6
        Top = 193
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
      object Label6: TLabel
        Left = 6
        Top = 229
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
      object Label7: TLabel
        Left = 6
        Top = 265
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
      object Label8: TLabel
        Left = 6
        Top = 343
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
      object Label10: TLabel
        Left = 6
        Top = 449
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
      object Label11: TLabel
        Left = 342
        Top = 150
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
      object Label12: TLabel
        Left = 7
        Top = 150
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
      object Label13: TLabel
        Left = 97
        Top = 75
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
      object Label14: TLabel
        Left = 94
        Top = 150
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
      object Label15: TLabel
        Left = 452
        Top = 150
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
      object Label_1: TLabel
        Left = 258
        Top = 75
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
      object Label17: TLabel
        Left = 256
        Top = 150
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
      object Label18: TLabel
        Left = 176
        Top = 150
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
      object Label19: TLabel
        Left = 5
        Top = 75
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
      object Label20: TLabel
        Left = 288
        Top = 38
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
      object Label3: TLabel
        Left = 150
        Top = 111
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
      object Label9: TLabel
        Left = 323
        Top = 75
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
      object Label16: TLabel
        Left = 406
        Top = 74
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
      object Dblcb_Carteira: TComboBox
        Left = 5
        Top = 14
        Width = 201
        Height = 21
        TabOrder = 0
      end
      object E_Cedente_Convenio: TEdit
        Left = 150
        Top = 52
        Width = 134
        Height = 21
        TabOrder = 2
      end
      object E_Varia_Carteira: TEdit
        Left = 419
        Top = 52
        Width = 107
        Height = 21
        TabOrder = 4
      end
      object Cb_Modelo_Boleto: TComboBox
        Left = 6
        Top = 126
        Width = 141
        Height = 21
        Style = csDropDownList
        TabOrder = 10
      end
      object E_Local_Pagamento: TEdit
        Left = 7
        Top = 208
        Width = 553
        Height = 21
        TabOrder = 18
      end
      object E_Inst_Pagamento_1: TEdit
        Left = 6
        Top = 245
        Width = 553
        Height = 21
        TabOrder = 20
      end
      object E_Inst_Pagamento_2: TEdit
        Left = 6
        Top = 281
        Width = 553
        Height = 21
        TabOrder = 22
      end
      object E_Path_Remessa_Retorno: TEdit
        Left = 6
        Top = 465
        Width = 528
        Height = 21
        TabOrder = 19
      end
      object E_Tx_Multa: TEdit
        Left = 340
        Top = 165
        Width = 110
        Height = 21
        TabOrder = 16
      end
      object E_Tx_Juros: TEdit
        Left = 5
        Top = 165
        Width = 84
        Height = 21
        TabOrder = 12
      end
      object Cb_Protesto: TComboBox
        Left = 97
        Top = 90
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
        Top = 358
        Width = 552
        Height = 90
        TabOrder = 21
      end
      object E_Tx_Mora: TEdit
        Left = 91
        Top = 165
        Width = 80
        Height = 21
        TabOrder = 13
      end
      object E_VL_Tarifa: TEdit
        Left = 451
        Top = 165
        Width = 110
        Height = 21
        TabOrder = 17
      end
      object E_Dias_Protesto: TEdit
        Left = 258
        Top = 90
        Width = 59
        Height = 21
        TabOrder = 7
      end
      object RG_Aceite: TRadioGroup
        Left = 7
        Top = 37
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
        Left = 255
        Top = 165
        Width = 83
        Height = 21
        TabOrder = 15
      end
      object E_VL_MORA_MIN: TEdit
        Left = 173
        Top = 165
        Width = 80
        Height = 21
        TabOrder = 14
      end
      object Cb_LayoutRemessa: TComboBox
        Left = 5
        Top = 90
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
        Left = 286
        Top = 52
        Width = 131
        Height = 21
        TabOrder = 3
      end
      object E_POSTO_BENEF: TEdit
        Left = 150
        Top = 126
        Width = 98
        Height = 21
        TabOrder = 11
      end
      object Cb_Negativacao: TComboBox
        Left = 323
        Top = 90
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
        Left = 406
        Top = 90
        Width = 59
        Height = 21
        TabOrder = 9
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 304
    Top = 40
  end
end
