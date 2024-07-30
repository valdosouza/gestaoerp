object Fm_MetodoPagamento: TFm_MetodoPagamento
  Left = 0
  Top = 0
  Width = 526
  Height = 73
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 73
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    inline Fm_FormaPagto: TFm_FormaPagto
      Left = 2
      Top = 2
      Width = 325
      Height = 69
      Align = alLeft
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 325
      ExplicitHeight = 69
      inherited Lb_FormaPagamento: TLabel
        Top = 2
        Width = 319
        Height = 19
        Margins.Top = 2
        Margins.Bottom = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ExplicitTop = 2
        ExplicitWidth = 151
        ExplicitHeight = 19
      end
      inherited pnl_Forma: TPanel
        Top = 23
        Width = 325
        Height = 46
        ExplicitTop = 23
        ExplicitWidth = 325
        ExplicitHeight = 46
        inherited SB_FormaPag: TSpeedButton
          Left = 298
          Top = 3
          Height = 34
          Align = alNone
          ExplicitLeft = 298
          ExplicitTop = 3
          ExplicitHeight = 34
        end
        inherited DBLCB_FormaPagto: TDBLookupComboBox
          Width = 319
          Height = 41
          Font.Height = -27
          ParentFont = False
          OnExit = Fm_FormaPagtoDBLCB_FormaPagtoExit
          ExplicitWidth = 319
          ExplicitHeight = 41
        end
      end
    end
    object pnl_Valor: TPanel
      Left = 327
      Top = 2
      Width = 118
      Height = 69
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Lb_Inf_Valor: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 2
        Width = 113
        Height = 19
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Informe o Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object E_valor: TEdit
        AlignWithMargins = True
        Left = 3
        Top = 26
        Width = 112
        Height = 40
        Align = alClient
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0,00'
        ExplicitHeight = 41
      end
    end
    object pnl_parcela: TPanel
      Left = 445
      Top = 2
      Width = 79
      Height = 69
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object Lb_Parcela: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 2
        Width = 73
        Height = 19
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Parcelas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 57
      end
      object Cb_Parcela: TComboBox
        AlignWithMargins = True
        Left = 3
        Top = 26
        Width = 73
        Height = 41
        Align = alClient
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = '1'
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5')
      end
    end
  end
end
