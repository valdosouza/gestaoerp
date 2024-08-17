inherited RegUf: TRegUf
  Caption = 'Casdastro de Estados'
  ClientWidth = 569
  ExplicitWidth = 575
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Width = 569
    ExplicitWidth = 569
    inherited SB_Inserir: TSpeedButton
      Left = 1
      Width = 88
      ExplicitLeft = -13
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Alterar: TSpeedButton
      Left = 91
      Width = 92
      ExplicitLeft = 71
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Excluir: TSpeedButton
      Left = 185
      Width = 92
      ExplicitLeft = 165
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 379
      Width = 91
      ExplicitLeft = 358
      ExplicitTop = 5
      ExplicitWidth = 91
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 472
      Width = 92
      ExplicitLeft = 472
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Gravar: TSpeedButton
      Left = 279
      Width = 98
      ExplicitLeft = 265
      ExplicitTop = 5
      ExplicitWidth = 98
    end
  end
  inherited pnl_fundo: TPanel
    Width = 569
    ExplicitWidth = 569
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 565
      Height = 97
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Codigo: TLabel
        Left = 8
        Top = 8
        Width = 33
        Height = 14
        Caption = 'C'#243'digo'
        FocusControl = E_Codigo
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Descricao: TLabel
        Left = 57
        Top = 8
        Width = 49
        Height = 14
        Caption = 'Descri'#231#227'o'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Sigla: TLabel
        Left = 521
        Top = 8
        Width = 23
        Height = 14
        Caption = 'Sigla'
        FocusControl = E_Sigla
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Sub_Tributario: TLabel
        Left = 165
        Top = 49
        Width = 181
        Height = 14
        Caption = 'Insc. Estadual do Substituto Tribut'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Aliq_Interna: TLabel
        Left = 6
        Top = 49
        Width = 54
        Height = 14
        Caption = 'Aliq Interna'
        FocusControl = E_Aliq_Interna
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Aliq_Interstadual: TLabel
        Left = 75
        Top = 49
        Width = 86
        Height = 14
        Caption = 'Aliq. Interestadual'
        FocusControl = E_Aliq_Interestadual
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 24
        Width = 49
        Height = 22
        Color = clScrollBar
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_Descricao: TEdit
        Left = 57
        Top = 24
        Width = 463
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
      object E_Sigla: TEdit
        Left = 522
        Top = 24
        Width = 31
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
      object E_Sub_tributario: TEdit
        Left = 165
        Top = 65
        Width = 196
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
      object E_Aliq_Interna: TEdit
        Left = 6
        Top = 65
        Width = 67
        Height = 22
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object E_Aliq_Interestadual: TEdit
        Left = 75
        Top = 65
        Width = 88
        Height = 22
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
    object Pg_Itens: TPageControl
      Left = 2
      Top = 99
      Width = 565
      Height = 250
      ActivePage = tbs_st
      Align = alClient
      TabOrder = 1
      object tbs_st: TTabSheet
        Caption = 'Substitui'#231#227'o Tribut'#225'ria'
        object Pnl_ST: TPanel
          Left = 0
          Top = 0
          Width = 557
          Height = 172
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Dbg_MVA: TDBGrid
            Left = 2
            Top = 2
            Width = 553
            Height = 168
            Align = alClient
            DataSource = ds_MVA
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'MUN_CODUFE'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'MUN_CODMHA'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'MUN_CODIGONCM'
                Title.Caption = 'C'#243'digo NCM'
                Width = 152
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MUN_MR_VL_AGREGADO'
                Title.Caption = 'MVA Original'
                Width = 87
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MUN_ALIQ_INTERNA'
                Title.Caption = 'Aliq. Interna'
                Width = 94
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MUN_MVA_AJUSTADO'
                Visible = False
              end>
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 172
          Width = 557
          Height = 50
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = 'Panel2'
          TabOrder = 1
          object Sb_Ins_MVa: TSpeedButton
            Left = 2
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Novo'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_MVaClick
            ExplicitLeft = -4
            ExplicitTop = 4
          end
          object Sb_Grv_MVa: TSpeedButton
            Left = 302
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Gravar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Grv_MVaClick
            ExplicitLeft = 107
            ExplicitTop = 12
            ExplicitHeight = 38
          end
          object Sb_Exc_MVa: TSpeedButton
            Left = 202
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Excluir'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_MVaClick
            ExplicitLeft = 179
            ExplicitTop = 4
          end
          object Sb_Edit_MVa: TSpeedButton
            Left = 102
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Alterar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Edit_MVaClick
            ExplicitLeft = 110
            ExplicitTop = 4
          end
          object Sb_Can_MVa: TSpeedButton
            Left = 402
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Cancelar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Can_MVaClick
            ExplicitLeft = 408
            ExplicitTop = 4
          end
        end
      end
      object tbs_FCP: TTabSheet
        Caption = 'Aliq. Fundo Combate a Pobreza'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Pnl_FCP: TPanel
          Left = 0
          Top = 0
          Width = 557
          Height = 172
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object Dbg_Fcp: TDBGrid
            Left = 2
            Top = 2
            Width = 553
            Height = 168
            Align = alClient
            DataSource = ds_FCP
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'TB_STATE_ID'
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'NCM'
                Width = 141
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ALIQUOTA'
                Title.Caption = 'Al'#237'quota'
                Visible = True
              end>
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 172
          Width = 557
          Height = 50
          Align = alBottom
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Caption = 'Panel1'
          TabOrder = 1
          object Sb_Ins_Fcp: TSpeedButton
            Left = 2
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Novo'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Ins_FcpClick
            ExplicitLeft = 21
            ExplicitTop = 3
            ExplicitHeight = 38
          end
          object Sb_Grv_Fcp: TSpeedButton
            Left = 302
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Gravar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Grv_FcpClick
            ExplicitLeft = 106
            ExplicitTop = 3
            ExplicitHeight = 38
          end
          object Sb_Exc_Fcp: TSpeedButton
            Left = 202
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Excluir'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Exc_FcpClick
            ExplicitLeft = 179
            ExplicitTop = -6
          end
          object Sb_Edit_Fcp: TSpeedButton
            Left = 102
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Alterar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Edit_FcpClick
            ExplicitLeft = 110
            ExplicitTop = 4
          end
          object Sb_Can_Fcp: TSpeedButton
            Left = 402
            Top = 2
            Width = 100
            Height = 46
            Align = alLeft
            Caption = 'Cancelar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            OnClick = Sb_Can_FcpClick
            ExplicitLeft = 330
            ExplicitTop = 9
          end
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 392
    Top = 64
  end
  object ds_MVA: TDataSource
    AutoEdit = False
    DataSet = cds_MVA
    Left = 120
    Top = 226
  end
  object cds_FCP: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 178
    object cds_FCPTB_STATE_ID: TIntegerField
      FieldName = 'TB_STATE_ID'
      Required = True
    end
    object cds_FCPNCM: TWideStringField
      FieldName = 'NCM'
      Required = True
      Size = 10
    end
    object cds_FCPALIQUOTA: TBCDField
      FieldName = 'ALIQUOTA'
      Precision = 18
      Size = 2
    end
  end
  object ds_FCP: TDataSource
    AutoEdit = False
    DataSet = cds_FCP
    Left = 224
    Top = 234
  end
  object cds_MVA: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 176
    object cds_MVAMUN_CODUFE: TIntegerField
      FieldName = 'MUN_CODUFE'
    end
    object cds_MVAMUN_CODIGONCM: TStringField
      FieldName = 'MUN_CODIGONCM'
      Size = 15
    end
    object cds_MVAMUN_MR_VL_AGREGADO: TFloatField
      FieldName = 'MUN_MR_VL_AGREGADO'
    end
    object cds_MVAMUN_ALIQ_INTERNA: TFloatField
      FieldName = 'MUN_ALIQ_INTERNA'
    end
    object cds_MVAMUN_CODMHA: TIntegerField
      FieldName = 'MUN_CODMHA'
    end
    object cds_MVAMUN_MVA_AJUSTADO: TFloatField
      FieldName = 'MUN_MVA_AJUSTADO'
    end
  end
end
