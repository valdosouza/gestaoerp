inherited RegElectronicSlip: TRegElectronicSlip
  Caption = 'Cadastro para Cobran'#231'a em Boleto'
  ClientHeight = 575
  ClientWidth = 573
  ExplicitWidth = 579
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 511
    Width = 573
    ExplicitTop = 548
    ExplicitWidth = 573
    inherited SB_Inserir: TSpeedButton
      Left = 0
      Width = 93
      ExplicitLeft = -3
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Alterar: TSpeedButton
      Left = 95
      Width = 93
      ExplicitLeft = 93
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Excluir: TSpeedButton
      Left = 190
      Width = 93
      ExplicitLeft = 189
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 380
      Width = 93
      ExplicitLeft = 381
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 475
      Width = 93
      ExplicitLeft = 477
      ExplicitTop = 5
      ExplicitWidth = 93
    end
    inherited SB_Gravar: TSpeedButton
      Left = 285
      Width = 93
      ExplicitLeft = 287
      ExplicitTop = 5
      ExplicitWidth = 93
    end
  end
  inherited pnl_fundo: TPanel
    Width = 573
    Height = 511
    ExplicitWidth = 573
    ExplicitHeight = 548
    object L_Cedente_Convenio: TLabel
      Left = 151
      Top = 91
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
      Left = 422
      Top = 91
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
      Left = 7
      Top = 165
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
      Left = 7
      Top = 246
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
      Left = 7
      Top = 282
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
      Left = 7
      Top = 318
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
      Left = 7
      Top = 356
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
      Left = 7
      Top = 462
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
      Left = 568
      Top = 472
      Width = 24
      Height = 22
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      OnClick = Sb_Path_remessaClick
    end
    object L_Tx_Multa: TLabel
      Left = 342
      Top = 203
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
      Left = 7
      Top = 203
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
      Left = 97
      Top = 128
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
      Left = 452
      Top = 203
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
      Left = 258
      Top = 128
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
      Left = 256
      Top = 203
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
      Left = 176
      Top = 203
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
      Left = 7
      Top = 128
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
      Left = 288
      Top = 91
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
      Left = 150
      Top = 164
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
      Left = 323
      Top = 128
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
      Left = 406
      Top = 127
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
      Left = 95
      Top = 203
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
    object E_Cedente_Convenio: TEdit
      Left = 150
      Top = 105
      Width = 134
      Height = 21
      TabOrder = 4
    end
    object E_Varia_Carteira: TEdit
      Left = 419
      Top = 105
      Width = 107
      Height = 21
      TabOrder = 6
    end
    object Cb_Modelo_Boleto: TComboBox
      Left = 7
      Top = 179
      Width = 141
      Height = 21
      Style = csDropDownList
      TabOrder = 12
    end
    object E_Local_Pagamento: TEdit
      Left = 7
      Top = 261
      Width = 555
      Height = 21
      TabOrder = 20
    end
    object E_Inst_Pagamento_1: TEdit
      Left = 7
      Top = 298
      Width = 555
      Height = 21
      TabOrder = 21
    end
    object E_Inst_Pagamento_2: TEdit
      Left = 7
      Top = 334
      Width = 555
      Height = 21
      TabOrder = 22
    end
    object E_Path_Remessa_Retorno: TEdit
      Left = 7
      Top = 482
      Width = 555
      Height = 21
      TabOrder = 24
    end
    object E_Tx_Multa: TEdit
      Left = 340
      Top = 218
      Width = 110
      Height = 21
      Alignment = taRightJustify
      TabOrder = 18
    end
    object E_Tx_Juros: TEdit
      Left = 7
      Top = 218
      Width = 84
      Height = 21
      Alignment = taRightJustify
      TabOrder = 14
    end
    object Cb_Protesto: TComboBox
      Left = 97
      Top = 143
      Width = 158
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 8
      Text = '1 - Protestar (Dias Corridos)'
      Items.Strings = (
        '0 -  Sem instru'#231#227'o'
        '1 - Protestar (Dias Corridos)'
        '2 - Protestar (Dias '#218'teis)'
        '3 - N'#227'o protestar')
    end
    object M_IntrucaoAdicional: TMemo
      Left = 7
      Top = 371
      Width = 555
      Height = 90
      TabOrder = 23
    end
    object E_Tx_Mora: TEdit
      Left = 91
      Top = 218
      Width = 80
      Height = 21
      Alignment = taRightJustify
      TabOrder = 15
    end
    object E_VL_Tarifa: TEdit
      Left = 451
      Top = 218
      Width = 111
      Height = 21
      Alignment = taRightJustify
      TabOrder = 19
    end
    object E_Dias_Protesto: TEdit
      Left = 258
      Top = 143
      Width = 59
      Height = 21
      TabOrder = 9
    end
    object RG_Aceite: TRadioGroup
      Left = 7
      Top = 90
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
      TabOrder = 3
      TabStop = True
    end
    object E_Tx_Desconto: TEdit
      Left = 255
      Top = 218
      Width = 83
      Height = 21
      Alignment = taRightJustify
      TabOrder = 17
    end
    object E_VL_MORA_MIN: TEdit
      Left = 169
      Top = 218
      Width = 80
      Height = 21
      Alignment = taRightJustify
      TabOrder = 16
    end
    object Cb_LayoutRemessa: TComboBox
      Left = 7
      Top = 143
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 7
      Text = 'c240'
      Items.Strings = (
        'c240'
        'c400')
    end
    object E_CodTransmissao: TEdit
      Left = 286
      Top = 105
      Width = 131
      Height = 21
      TabOrder = 5
    end
    object E_POSTO_BENEF: TEdit
      Left = 150
      Top = 179
      Width = 98
      Height = 21
      TabOrder = 13
    end
    object Cb_Negativacao: TComboBox
      Left = 323
      Top = 143
      Width = 77
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 10
      Text = 'N'#227'o'
      Items.Strings = (
        'N'#227'o'
        'Sim')
    end
    object E_Dias_Negativacao: TEdit
      Left = 406
      Top = 143
      Width = 59
      Height = 21
      TabOrder = 11
    end
    inline Fm_ListaContaBancaria: TFm_ListaContaBancaria
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 563
      Height = 44
      Align = alTop
      TabOrder = 0
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 563
      inherited L_ContaBancaria: TLabel
        Width = 563
      end
      inherited Sb_ContaBancaria: TSpeedButton
        Left = 536
        ExplicitLeft = 535
      end
      inherited DBLCB_ContaBancaria: TDBLookupComboBox
        Width = 527
        OnClick = Fm_ListaContaBancariaDBLCB_ContaBancariaClick
        ExplicitWidth = 527
      end
    end
    inline Fm_ListaEspecieDoc: TFm_ListaEspecieDoc
      Left = 244
      Top = 46
      Width = 221
      Height = 44
      TabOrder = 2
      TabStop = True
      ExplicitLeft = 244
      ExplicitTop = 46
    end
    inline Fm_BillingPortfolio: TFmBillingPortfolio
      Left = 5
      Top = 49
      Width = 233
      Height = 41
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 5
      ExplicitTop = 49
      ExplicitWidth = 233
      ExplicitHeight = 41
      inherited L_Carteira: TLabel
        Width = 233
        ExplicitLeft = 0
        ExplicitTop = 0
      end
      inherited pnl_linha_1: TPanel
        Width = 233
        inherited Sb_Carteira: TSpeedButton
          Left = 209
        end
        inherited Dblcb_Lista: TDBLookupComboBox
          Width = 209
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 576
    Top = 8
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.*'
    Filter = 'Todos os Arquivos (*.*)|*.*'
    Title = 'Selecione a NFe'
    Left = 360
    Top = 384
  end
end
