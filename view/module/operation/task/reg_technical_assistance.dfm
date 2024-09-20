inherited RegTechnicalAssistance: TRegTechnicalAssistance
  Caption = 'Cadastro de Acompanhamento de Assist'#234'ncia T'#233'cnica'
  ClientHeight = 558
  ClientWidth = 786
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 802
  ExplicitHeight = 617
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 494
    Width = 786
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 494
    ExplicitWidth = 786
    inherited SB_Inserir: TSpeedButton
      Left = 159
      ExplicitLeft = 159
    end
    inherited SB_Alterar: TSpeedButton
      Left = 263
      ExplicitLeft = 263
    end
    inherited SB_Excluir: TSpeedButton
      Left = 367
      ExplicitLeft = 367
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 575
      ExplicitLeft = 575
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 679
      ExplicitLeft = 679
    end
    inherited SB_Gravar: TSpeedButton
      Left = 471
      ExplicitLeft = 471
    end
  end
  inherited pnl_fundo: TPanel
    Width = 786
    Height = 494
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 786
    ExplicitHeight = 494
    object Pnl_Abertura: TPanel
      Left = 2
      Top = 2
      Width = 782
      Height = 50
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Prazo: TLabel
        Left = 691
        Top = 4
        Width = 28
        Height = 14
        Caption = 'Prazo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SB_Cliente: TSpeedButton
        Left = 637
        Top = 19
        Width = 24
        Height = 22
        Caption = '...'
      end
      object L_Numero: TLabel
        Left = 9
        Top = 3
        Width = 44
        Height = 14
        Caption = 'N'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Lb_Numero: TLabel
        Left = 6
        Top = 19
        Width = 58
        Height = 19
        Alignment = taCenter
        Caption = '0000/07'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object L_Pedido: TLabel
        Left = 89
        Top = 3
        Width = 91
        Height = 14
        AutoSize = False
        Caption = 'N'#250'mero Pedido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Codcli: TLabel
        Left = 184
        Top = 3
        Width = 119
        Height = 14
        Caption = 'C'#243'digo / Nome do Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Sb_Pesq_Cliente: TSpeedButton
        Left = 661
        Top = 19
        Width = 23
        Height = 22
        Glyph.Data = {
          E6010000424DE60100000000000036000000280000000C0000000C0000000100
          180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF285A9F626F8DFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2963AC7EE3FA18
          79DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF296CBA7FE3FA
          177FE4C9D5E9FFFFFFFFFFFFFFFFFFF7F6F7E6E5E6FFFFFFFFFFFF447DC57EE3
          FA177FE4C9D8ECFFFFFFFFFFFFEFEEEF66574AFBDCACFFEECDC0C8A6483C489C
          A1B62372CBC9DBF1FFFFFFFFFFFFFFFFFF8D734FF5BC91FFD8B6FFEED2FFF9E0
          FFFEF0463C49FFFFFFFFFFFFFFFFFFFFFFFF8F8792E1A87DDDA479FFD7B5FFED
          D4FFF7E1FFFDEDCCD6C0FFFFFFFFFFFFFFFFFFFFFFFF7C6A78DAA176DAA176FD
          C498FFEFE0FFEED6FFF4DAFFF2CFD6D5D8FFFFFFFFFFFFFFFFFF827788D0976C
          FFE1CBFFF9F5FFCBA3FFE4CBFFE7CDFFECC2F1F1F2FFFFFFFFFFFFFFFFFFDFDC
          E0BF8656FCC398FFE5D2FBC297ECB388FFC99E8C8171FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF9C929FBF8857D69D72DBA277EAB186AB976FE9E8EBFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFE4E0E49D91A0A1939DA69FABFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF}
      end
      object E_Prazo: TDateTimePicker
        Left = 688
        Top = 19
        Width = 87
        Height = 21
        Date = 39580.000000000000000000
        Time = 0.356281493062852000
        TabOrder = 3
      end
      object E_Pedido: TEdit
        Left = 87
        Top = 19
        Width = 95
        Height = 21
        AutoSize = False
        TabOrder = 0
      end
      object chbx_Fantasia: TCheckBox
        Left = 434
        Top = 3
        Width = 121
        Height = 17
        Caption = 'Apelido/Fantasia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object chbx_Nome: TCheckBox
        Left = 307
        Top = 3
        Width = 121
        Height = 17
        Caption = 'Nome/Raz'#227'o Social'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 5
      end
      object DBLCB_Empresa: TComboBox
        Left = 284
        Top = 19
        Width = 350
        Height = 21
        TabOrder = 2
      end
      object E_Codcli: TEdit
        Left = 184
        Top = 19
        Width = 98
        Height = 21
        TabOrder = 1
      end
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 52
      Width = 782
      Height = 225
      Align = alTop
      Caption = 'Rela'#231#227'o das Etapas'
      TabOrder = 1
      object DBG_Produtos: TDBGrid
        Left = 5
        Top = 15
        Width = 767
        Height = 200
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Lucida Console'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowSelect]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clNavy
        TitleFont.Height = -11
        TitleFont.Name = 'Arial'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IAS_ETAPA'
            Title.Caption = 'Etapa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IAS_DATA'
            Title.Alignment = taCenter
            Title.Caption = 'Data'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SIT_DESCRICAO'
            Title.Caption = 'Situa'#231#227'o'
            Width = 352
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IAS_DT_PREVISTA'
            Title.Alignment = taCenter
            Title.Caption = 'Data Prevista'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IAS_DT_REALIZADA'
            Title.Alignment = taCenter
            Title.Caption = 'Data Realizada'
            Width = 100
            Visible = True
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 2
      Top = 277
      Width = 782
      Height = 215
      Align = alClient
      Caption = 'Detalhamento da Assistencia'
      TabOrder = 2
      DesignSize = (
        782
        215)
      object L_Etapa: TLabel
        Left = 7
        Top = 16
        Width = 91
        Height = 14
        AutoSize = False
        Caption = 'Etapa N'#186
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Dt_Registro: TLabel
        Left = 59
        Top = 16
        Width = 65
        Height = 14
        Caption = 'Data Registro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Dt_Prevista: TLabel
        Left = 148
        Top = 16
        Width = 64
        Height = 14
        Caption = 'Data Prevista'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vl_Custo: TLabel
        Left = 679
        Top = 16
        Width = 74
        Height = 14
        AutoSize = False
        Caption = 'Custo Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Vl_Cliente: TLabel
        Left = 584
        Top = 16
        Width = 74
        Height = 14
        AutoSize = False
        Caption = 'Custo Cliente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Situacao: TLabel
        Left = 236
        Top = 16
        Width = 42
        Height = 14
        Anchors = [akTop]
        Caption = 'Situa'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Dt_Realizada: TLabel
        Left = 630
        Top = 168
        Width = 91
        Height = 14
        AutoSize = False
        Caption = 'Data Realizada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_Descritivo: TLabel
        Left = 8
        Top = 55
        Width = 223
        Height = 14
        Caption = 'Descreva Detalhadamento a a'#231#227'o desta Etapa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object spb_situacao: TSpeedButton
        Left = 555
        Top = 30
        Width = 23
        Height = 22
        Caption = '...'
      end
      object L_Hr_Prevista: TLabel
        Left = 726
        Top = 168
        Width = 26
        Height = 14
        Caption = 'Hora '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Etapa: TEdit
        Left = 5
        Top = 31
        Width = 49
        Height = 21
        TabStop = False
        AutoSize = False
        DragMode = dmAutomatic
        TabOrder = 0
      end
      object E_Dt_Registro: TDateTimePicker
        Left = 57
        Top = 31
        Width = 87
        Height = 21
        Date = 39580.000000000000000000
        Time = 0.356281493062852000
        TabOrder = 1
      end
      object E_Descritivo: TMemo
        Left = 3
        Top = 70
        Width = 774
        Height = 90
        Lines.Strings = (
          'Memo1')
        TabOrder = 6
      end
      object E_Vl_Custo: TEdit
        Left = 676
        Top = 31
        Width = 98
        Height = 21
        AutoSize = False
        TabOrder = 5
      end
      object E_Vl_Cliente: TEdit
        Left = 582
        Top = 31
        Width = 92
        Height = 21
        AutoSize = False
        TabOrder = 4
      end
      object DBLCB_Situacao: TComboBox
        Left = 232
        Top = 31
        Width = 322
        Height = 21
        TabOrder = 3
      end
      object E_Dt_Realizada: TMaskEdit
        Left = 628
        Top = 183
        Width = 94
        Height = 21
        AutoSize = False
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 7
        Text = '  /  /    '
      end
      object E_Dt_Prevista: TDateTimePicker
        Left = 144
        Top = 31
        Width = 87
        Height = 21
        Date = 39580.000000000000000000
        Time = 0.356281493062852000
        TabOrder = 2
      end
      object E_Hr_Prevista: TEdit
        Left = 724
        Top = 183
        Width = 50
        Height = 22
        Color = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        Text = '00:00'
      end
    end
  end
end
