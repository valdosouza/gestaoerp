inherited Fm_MetodoPagamentoParcelado: TFm_MetodoPagamentoParcelado
  Width = 570
  Height = 54
  ExplicitWidth = 570
  ExplicitHeight = 54
  inherited Panel1: TPanel
    Width = 570
    Height = 54
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 570
    ExplicitHeight = 54
    inherited Fm_FormaPagto: TFm_FormaPagto
      Left = 121
      Width = 269
      Height = 50
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 121
      ExplicitWidth = 269
      ExplicitHeight = 50
      inherited Lb_FormaPagamento: TLabel
        Width = 263
        Height = 16
        Font.Color = clNavy
        Font.Height = -13
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 123
        ExplicitHeight = 16
      end
      inherited pnl_Forma: TPanel
        Top = 20
        Width = 269
        Height = 30
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 20
        ExplicitWidth = 269
        ExplicitHeight = 30
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 263
          Height = 23
          Align = alTop
          Font.Height = -12
          ExplicitWidth = 263
          ExplicitHeight = 22
        end
      end
    end
    inherited pnl_Valor: TPanel
      Left = 390
      Width = 114
      Height = 50
      Align = alRight
      TabOrder = 2
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 390
      ExplicitWidth = 114
      ExplicitHeight = 50
      inherited Lb_Inf_Valor: TLabel
        Width = 30
        Height = 16
        Caption = 'Valor'
        Font.Color = clNavy
        Font.Height = -13
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 30
        ExplicitHeight = 16
      end
      inherited E_valor: TEdit
        Top = 23
        Width = 108
        Height = 22
        Align = alTop
        Font.Height = -12
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 3
        ExplicitWidth = 108
        ExplicitHeight = 22
      end
    end
    inherited pnl_parcela: TPanel
      Left = 504
      Width = 64
      Height = 50
      Align = alRight
      TabOrder = 3
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 504
      ExplicitWidth = 64
      ExplicitHeight = 50
      inherited Lb_Parcela: TLabel
        Width = 58
        Height = 16
        Font.Color = clNavy
        Font.Height = -13
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 48
        ExplicitHeight = 16
      end
      inherited Cb_Parcela: TComboBox
        Top = 23
        Width = 58
        Height = 22
        Align = alTop
        Font.Height = -12
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 3
        ExplicitWidth = 58
        ExplicitHeight = 22
      end
    end
    object pnl_data: TPanel
      Left = 2
      Top = 2
      Width = 119
      Height = 50
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 2
        Width = 67
        Height = 16
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object E_Data: TDateTimePicker
        AlignWithMargins = True
        Left = 3
        Top = 23
        Width = 113
        Height = 22
        Align = alTop
        Date = 39580.000000000000000000
        Time = 39580.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = E_DataExit
        ExplicitTop = 3
      end
    end
  end
end
