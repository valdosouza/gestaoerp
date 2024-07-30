object FmItemIfoodAgora: TFmItemIfoodAgora
  Tag = 150
  Left = 0
  Top = 0
  Width = 270
  Height = 111
  Color = clWhite
  ParentBackground = False
  ParentColor = False
  PopupMenu = ItemMenu
  TabOrder = 0
  DesignSize = (
    270
    111)
  object E_Nome: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 264
    Height = 18
    AutoSize = False
    Caption = 'Florisvaldo Domingues de Souza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object E_Numero: TLabel
    Left = 95
    Top = 27
    Width = 64
    Height = 23
    Caption = '#9845'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object e_Situacao: TLabel
    Left = 5
    Top = 51
    Width = 240
    Height = 23
    Caption = 'Cancelamento solicitado.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lb_Pedido: TLabel
    Left = 5
    Top = 27
    Width = 84
    Height = 23
    Caption = 'Pedido N'#186
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Bve_Panel: TBevel
    Left = 0
    Top = 109
    Width = 270
    Height = 2
    Align = alBottom
    Shape = bsBottomLine
    Style = bsRaised
    ExplicitTop = 0
  end
  object E_OrderType: TLabel
    Left = 3
    Top = 80
    Width = 74
    Height = 23
    Caption = 'Entrega'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnl_visualizar: TPanel
    AlignWithMargins = True
    Left = 193
    Top = 80
    Width = 74
    Height = 29
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    Color = clRed
    ParentBackground = False
    TabOrder = 0
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 70
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object btn_visualizar: TSpeedButton
        Left = 1
        Top = 1
        Width = 68
        Height = 23
        Align = alClient
        Caption = 'Visualizar'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 100
        ExplicitHeight = 32
      end
    end
  end
  object ItemMenu: TPopupMenu
    Left = 216
    object AtualizarStatus: TMenuItem
      Caption = 'Atualizar Status'
    end
  end
end
