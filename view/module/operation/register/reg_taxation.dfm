inherited RegTaxation: TRegTaxation
  Caption = 'Cadastros de Tributa'#231#245'es para Nota Fiscal Eletr'#244'nica'
  ClientHeight = 489
  ClientWidth = 613
  ExplicitWidth = 619
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 425
    Width = 613
    ExplicitTop = 425
    ExplicitWidth = 613
    inherited SB_Inserir: TSpeedButton
      Left = -14
      ExplicitLeft = -14
    end
    inherited SB_Alterar: TSpeedButton
      Left = 90
      ExplicitLeft = 90
    end
    inherited SB_Excluir: TSpeedButton
      Left = 194
      ExplicitLeft = 194
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 402
      ExplicitLeft = 402
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 506
      ExplicitLeft = 506
    end
    inherited SB_Gravar: TSpeedButton
      Left = 298
      ExplicitLeft = 298
    end
  end
  inherited pnl_fundo: TPanel
    Width = 613
    Height = 425
    ExplicitWidth = 613
    ExplicitHeight = 425
    object pl_fundo: TPanel
      Left = 2
      Top = 2
      Width = 609
      Height = 421
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      DesignSize = (
        609
        421)
      object L_Aq_ICMS: TLabel
        Left = 302
        Top = 160
        Width = 66
        Height = 14
        Caption = 'Aliquota ICMS'
        FocusControl = E_Aq_ICMS
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Red_Base: TLabel
        Left = 485
        Top = 160
        Width = 103
        Height = 14
        Caption = 'Redu'#231#227'o da Base em'
        FocusControl = E_Red_Base
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 9
        Top = 499
        Width = 156
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'Observa'#231#245'es para a Nota Fiscal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 417
      end
      object Sb_Observacao: TSpeedButton
        Left = 575
        Top = 515
        Width = 23
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '...'
        ExplicitTop = 433
      end
      object L_Red_Aliq: TLabel
        Left = 376
        Top = 160
        Width = 92
        Height = 14
        Caption = 'Red na Aliquota em'
        FocusControl = E_Red_Aliq
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 11
        Top = 539
        Width = 177
        Height = 14
        Anchors = [akLeft, akBottom]
        Caption = 'C.F.O.P. - Descri'#231#227'o Situa'#231#227'o Normal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 457
      end
      object SB_Natureza: TSpeedButton
        Left = 574
        Top = 555
        Width = 24
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitTop = 473
      end
      object L_Situacao_Tributaria: TLabel
        Left = 5
        Top = 44
        Width = 206
        Height = 13
        Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Modal_ICMS_ST: TLabel
        Left = 300
        Top = 120
        Width = 213
        Height = 13
        Caption = 'Determina'#231#227'o da Base de C'#225'lculo - ICMS ST'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Modal_ICMS: TLabel
        Left = 8
        Top = 120
        Width = 196
        Height = 13
        Caption = 'Determina'#231#227'o da Base de C'#225'lculo - ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Desoneracao: TLabel
        Left = 8
        Top = 160
        Width = 117
        Height = 13
        Caption = 'Motivo da Desonera'#231#227'o '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L_Simples_Nacional: TLabel
        Left = 6
        Top = 83
        Width = 288
        Height = 13
        Caption = 'CSOSN - C'#243'digo de Situa'#231#227'o da Opera'#231#227'o Simples Nacional'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Sit_Trib_ICMS: TSpeedButton
        Left = 575
        Top = 59
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Sb_Sit_Trib_CSOSN: TSpeedButton
        Left = 575
        Top = 96
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Sb_Modal_ICMS: TSpeedButton
        Left = 274
        Top = 135
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Sb_Desoneracao: TSpeedButton
        Left = 274
        Top = 175
        Width = 23
        Height = 22
        Caption = '...'
      end
      object Sb_Modal_ICMS_St: TSpeedButton
        Left = 575
        Top = 135
        Width = 23
        Height = 22
        Caption = '...'
      end
      object L_Origem: TLabel
        Left = 5
        Top = 3
        Width = 106
        Height = 14
        Caption = 'Origem da Mercadoria'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Aq_ICMS: TEdit
        Left = 302
        Top = 176
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object E_Red_Base: TEdit
        Left = 483
        Top = 176
        Width = 115
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object DBLCB_Observacao: TComboBox
        Left = 6
        Top = 515
        Width = 566
        Height = 21
        Anchors = [akLeft, akBottom]
        TabOrder = 10
      end
      object E_Red_Aliq: TEdit
        Left = 373
        Top = 176
        Width = 108
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object DBLCB_Natureza: TComboBox
        Left = 8
        Top = 555
        Width = 563
        Height = 21
        Anchors = [akLeft, akBottom]
        TabOrder = 11
      end
      object Pnl_Outros: TGroupBox
        Left = 4
        Top = 283
        Width = 597
        Height = 132
        Caption = 'Outros Crit'#233'rios'
        TabOrder = 9
        object L_Transacao_Produto: TLabel
          Left = 377
          Top = 9
          Width = 182
          Height = 14
          Caption = 'Tipo da transa'#231#227'o do Produto/Servi'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object L_CodigoNCM: TLabel
          Left = 377
          Top = 87
          Width = 119
          Height = 14
          Caption = 'C'#243'd. Class. Fiscal (NCM)'
          FocusControl = E_CodigoNCM
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Sb_Classificacao: TSpeedButton
          Left = 502
          Top = 101
          Width = 23
          Height = 22
          Caption = '...'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          NumGlyphs = 2
          ParentFont = False
        end
        object dbcbx_sit_trb: TCheckBox
          Left = 8
          Top = 16
          Width = 317
          Height = 17
          Caption = 'Regra aplicada para produtos com Substitui'#231#227'o Tribut'#225'ria'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object chbx_Consumidor: TCheckBox
          Left = 8
          Top = 33
          Width = 317
          Height = 17
          Caption = 'Regra aplicada para Opera'#231#227'o com Consumidor Final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object chbx_micro: TCheckBox
          Left = 8
          Top = 49
          Width = 317
          Height = 17
          Caption = 'Regra aplicada para Empresa Optante pelo Simples Nacional'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object chbx_diferido: TCheckBox
          Left = 8
          Top = 64
          Width = 317
          Height = 17
          Caption = 'Imposto ICMS Diferido'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object chbx_destaque: TCheckBox
          Left = 8
          Top = 79
          Width = 317
          Height = 17
          Caption = 'Destacar valores na Nota'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object CHBX_ST_ICMS: TCheckBox
          Left = 8
          Top = 94
          Width = 270
          Height = 17
          Caption = 'Regra aplicada como Substituto Tribut'#225'rio - ICMS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object Cb_Transacao_Produto: TComboBox
          Left = 377
          Top = 29
          Width = 206
          Height = 21
          Style = csDropDownList
          TabOrder = 6
          Items.Strings = (
            '0 - Outras'
            '1 - Revenda'
            '2 - Produ'#231#227'o'
            '3 - Consignado'
            '4 - Industrializa'#231#227'o'
            '5 - Consumo Interno'
            '6 - Presta'#231#227'o de Servi'#231'o'
            '7 - Ativo Imobilizado')
        end
        object E_CodigoNCM: TEdit
          Left = 377
          Top = 101
          Width = 119
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          TabOrder = 7
        end
        object Chbx_Sentido: TCheckBox
          Left = 8
          Top = 110
          Width = 270
          Height = 17
          Caption = 'Utilizar CFOP de Entrada'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
      end
      object Dblcb_Situacao_tributaria: TComboBox
        Left = 5
        Top = 60
        Width = 566
        Height = 21
        TabOrder = 0
      end
      object Dblcb_Modal_ICMS_ST: TComboBox
        Left = 298
        Top = 133
        Width = 271
        Height = 21
        TabOrder = 3
      end
      object Dblcb_Modal_ICMS: TComboBox
        Left = 8
        Top = 136
        Width = 266
        Height = 21
        TabOrder = 2
      end
      object Dblcb_Desoneracao: TComboBox
        Left = 8
        Top = 176
        Width = 266
        Height = 21
        TabOrder = 4
      end
      object Dblcb_Simples_Nacional: TComboBox
        Left = 6
        Top = 98
        Width = 562
        Height = 21
        TabOrder = 1
      end
      object Pg_Outros: TPageControl
        Left = 8
        Top = 197
        Width = 592
        Height = 82
        ActivePage = tbs_ipi
        TabOrder = 8
        object tbs_ipi: TTabSheet
          Caption = 'IPI'
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_IPI: TLabel
              Left = 479
              Top = 6
              Width = 67
              Height = 14
              Caption = 'Aliquota de IPI'
              FocusControl = E_Aq_IPI
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Situacao_tributaria_IPI: TLabel
              Left = 5
              Top = 6
              Width = 170
              Height = 13
              Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Sit_Trib_IPI: TSpeedButton
              Left = 451
              Top = 22
              Width = 23
              Height = 22
              Caption = '...'
            end
            object E_Aq_IPI: TEdit
              Left = 477
              Top = 22
              Width = 100
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object Dblcb_Situacao_tributaria_IPI: TComboBox
              Left = 5
              Top = 22
              Width = 443
              Height = 21
              TabOrder = 0
            end
          end
        end
        object tbs_pis: TTabSheet
          Caption = 'PIS'
          ImageIndex = 1
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_PIS: TLabel
              Left = 479
              Top = 6
              Width = 57
              Height = 14
              Caption = 'Aliquota PIS'
              FocusControl = E_Aq_Pis
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Situacao_tributaria_PIS: TLabel
              Left = 5
              Top = 6
              Width = 170
              Height = 13
              Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Sit_Trib_PIS: TSpeedButton
              Left = 451
              Top = 22
              Width = 23
              Height = 22
              Caption = '...'
            end
            object E_Aq_Pis: TEdit
              Left = 477
              Top = 22
              Width = 100
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object Dblcb_Situacao_tributaria_PIS: TComboBox
              Left = 5
              Top = 22
              Width = 443
              Height = 21
              TabOrder = 0
            end
          end
        end
        object tbs_cofins: TTabSheet
          Caption = 'COFINS'
          ImageIndex = 2
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_Cofins: TLabel
              Left = 480
              Top = 6
              Width = 73
              Height = 14
              Caption = 'Aliquota Cofins'
              FocusControl = E_Aq_Cofins
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L__Situacao_tributaria_CFS: TLabel
              Left = 5
              Top = 6
              Width = 170
              Height = 13
              Caption = 'CST - C'#243'digo de Situa'#231#227'o Tribut'#225'ria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Sb_Sit_Trib_CFS: TSpeedButton
              Left = 451
              Top = 22
              Width = 23
              Height = 22
              Caption = '...'
            end
            object E_Aq_Cofins: TEdit
              Left = 477
              Top = 22
              Width = 100
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object Dblcb_Situacao_tributaria_CFS: TComboBox
              Left = 5
              Top = 22
              Width = 443
              Height = 21
              TabOrder = 0
            end
          end
        end
        object tbs_outros: TTabSheet
          Caption = 'Outros'
          ImageIndex = 3
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 584
            Height = 54
            Align = alClient
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object L_Aq_IRPJ: TLabel
              Left = 7
              Top = 6
              Width = 41
              Height = 14
              Caption = 'Al'#237'q IRPJ'
              FocusControl = E_Aq_IRPJ
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_CSLL: TLabel
              Left = 82
              Top = 6
              Width = 47
              Height = 14
              Caption = 'Al'#237'q CSLL'
              FocusControl = E_Aq_CSLL
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_Siscomex: TLabel
              Left = 154
              Top = 6
              Width = 89
              Height = 14
              Caption = 'Al'#237'quota Siscomex'
              FocusControl = E_Aq_Siscomex
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_Tec: TLabel
              Left = 261
              Top = 6
              Width = 31
              Height = 14
              Caption = 'Aliq I.I.'
              FocusControl = E_Aq_Tec
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_Aq_ISS: TLabel
              Left = 345
              Top = 6
              Width = 25
              Height = 14
              Caption = 'I.S.S.'
              FocusControl = E_Aq_ISS
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object L_AQ_AFRMM: TLabel
              Left = 424
              Top = 6
              Width = 89
              Height = 14
              Caption = 'Aliquota A.F.R.M.M'
              FocusControl = E_AQ_AFRMM
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object E_Aq_IRPJ: TEdit
              Left = 7
              Top = 22
              Width = 72
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object E_Aq_CSLL: TEdit
              Left = 80
              Top = 22
              Width = 71
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object E_Aq_Siscomex: TEdit
              Left = 152
              Top = 22
              Width = 103
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object E_Aq_Tec: TEdit
              Left = 256
              Top = 22
              Width = 81
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object E_Aq_ISS: TEdit
              Left = 340
              Top = 22
              Width = 81
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object E_AQ_AFRMM: TEdit
              Left = 422
              Top = 22
              Width = 103
              Height = 22
              CharCase = ecUpperCase
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
          end
        end
      end
      object Cb_Origem: TComboBox
        Left = 5
        Top = 16
        Width = 594
        Height = 22
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        Items.Strings = (
          '0 - Nacional, exceto as indicadas nos c'#243'digos 3, 4, 5 e 8;'
          
            '1 - Estrangeira - Importa'#231#227'o direta, exceto a indicada no c'#243'digo' +
            ' 6;'
          
            '2 - Estrangeira - Adquirida no mercado interno, exceto a indicad' +
            'a no c'#243'digo 7;'
          
            '3 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o super' +
            'ior a 40% e inferior ou igual a 70%;'
          
            '4 - Nacional, cuja prod. tenha sido feita em conf. os proc. prod' +
            'utivos b'#225'sicos conf as legisla'#231#245'es citadas nos Ajustes;'
          
            '5 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o infer' +
            'ior ou igual a 40%;'
          
            '6 - Estrangeira - Importa'#231#227'o direta, sem similar nacional,consta' +
            'nte em lista da CAMEX e g'#225's natural;'
          
            '7 - Estrangeira - Adquirida no mercado interno, sem similar naci' +
            'onal, constante lista CAMEX e g'#225's natural.'
          
            '8 - Nacional, mercadoria ou bem com Conte'#250'do de Importa'#231#227'o super' +
            'ior a 70%;')
      end
      object Chbx_Red_Base_ST: TCheckBox
        Left = 304
        Top = 200
        Width = 294
        Height = 17
        Caption = 'Propagar a redu'#231#227'o da Base de C'#225'lculo para a Base S.T'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 408
    Top = 216
  end
end
