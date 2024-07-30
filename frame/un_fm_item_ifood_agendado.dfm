object FmItemIfoodAgendado: TFmItemIfoodAgendado
  Left = 0
  Top = 0
  Width = 270
  Height = 87
  Color = clWhite
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  DesignSize = (
    270
    87)
  object E_Nome: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 264
    Height = 48
    Align = alTop
    AutoSize = False
    Caption = 'Descri'#231#227'o do pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 5
    ExplicitTop = 5
    ExplicitHeight = 18
  end
  object Bve_Panel: TBevel
    Left = 0
    Top = 85
    Width = 270
    Height = 2
    Align = alBottom
    Shape = bsBottomLine
    Style = bsRaised
    ExplicitTop = 55
  end
  object pnl_visualizar: TPanel
    AlignWithMargins = True
    Left = 191
    Top = 56
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
    ExplicitTop = 25
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
end
