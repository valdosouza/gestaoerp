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
      ActivePage = tbs_FCP
      Align = alClient
      TabOrder = 1
      ExplicitTop = 100
      object tbs_st: TTabSheet
        Caption = 'Substitui'#231#227'o Tribut'#225'ria'
        object Pnl_ST: TPanel
          Left = 0
          Top = 0
          Width = 557
          Height = 222
          Align = alClient
          TabOrder = 0
          DesignSize = (
            557
            222)
          object Sb_Ins_Ncm: TSpeedButton
            Left = 5
            Top = 163
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 178
          end
          object Sb_Exc_Ncm: TSpeedButton
            Left = 208
            Top = 163
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 178
          end
          object Sb_Grv_Ncm: TSpeedButton
            Left = 106
            Top = 163
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Gravar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 178
          end
          object Dbg_ST: TDBGrid
            Left = 1
            Top = 1
            Width = 555
            Height = 153
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'MUN_CODIGONCM'
                Title.Caption = 'C'#243'd. Class. Fiscal (NCM)'
                Width = 122
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MUN_MR_VL_AGREGADO'
                Title.Caption = 'MVA. Original'
                Width = 135
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'MUN_ALIQ_INTERNA'
                Title.Caption = 'Aliq Interna'
                Width = 94
                Visible = True
              end>
          end
        end
      end
      object tbs_FCP: TTabSheet
        Caption = 'Aliq. Fundo Combate a Pobreza'
        ImageIndex = 1
        object Pnl_FCP: TPanel
          Left = 0
          Top = 0
          Width = 557
          Height = 222
          Align = alClient
          TabOrder = 0
          DesignSize = (
            557
            222)
          object Sb_Ins_Fcp: TSpeedButton
            Left = 5
            Top = 163
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Novo'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 178
          end
          object Sb_Exc_Fcp: TSpeedButton
            Left = 208
            Top = 163
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Excluir'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 178
          end
          object Sb_Grv_Fcp: TSpeedButton
            Left = 106
            Top = 163
            Width = 100
            Height = 38
            Anchors = [akLeft, akBottom]
            Caption = 'Gravar'
            Flat = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = False
            ExplicitTop = 178
          end
          object Dbg_Fcp: TDBGrid
            Left = 1
            Top = 1
            Width = 555
            Height = 153
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Visible = False
              end
              item
                Expanded = False
                FieldName = 'NCM'
                Width = 145
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ALIQUOTA'
                Title.Caption = 'Al'#237'quota'
                Width = 107
                Visible = True
              end>
          end
        end
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 480
    Top = 56
  end
end
