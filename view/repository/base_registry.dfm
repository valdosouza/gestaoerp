inherited BaseRegistry: TBaseRegistry
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'BaseRegistry'
  ClientHeight = 415
  ClientWidth = 815
  Touch.InteractiveGestures = []
  Touch.InteractiveGestureOptions = []
  Touch.ParentTabletOptions = False
  Touch.TabletOptions = []
  ExplicitWidth = 821
  ExplicitHeight = 464
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_botao: TPanel [0]
    Left = 0
    Top = 351
    Width = 815
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object SB_Inserir: TSpeedButton
      AlignWithMargins = True
      Left = 188
      Top = 5
      Width = 102
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Inserir - F2'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_InserirClick
      ExplicitLeft = 288
      ExplicitTop = 6
    end
    object SB_Alterar: TSpeedButton
      AlignWithMargins = True
      Left = 292
      Top = 5
      Width = 102
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Alterar - F3'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_alterarClick
      ExplicitLeft = 291
      ExplicitTop = 6
    end
    object SB_Excluir: TSpeedButton
      AlignWithMargins = True
      Left = 396
      Top = 5
      Width = 102
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Excluir - F4'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_ExcluirClick
      ExplicitLeft = 492
      ExplicitTop = 6
    end
    object SB_Cancelar: TSpeedButton
      AlignWithMargins = True
      Left = 604
      Top = 5
      Width = 102
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Cancelar - F6'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_CancelarClick
      ExplicitLeft = 696
      ExplicitTop = 6
    end
    object SB_Sair_0: TSpeedButton
      AlignWithMargins = True
      Left = 708
      Top = 5
      Width = 102
      Height = 54
      Margins.Left = 1
      Align = alRight
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = Sb_Sair_0Click
      ExplicitLeft = 800
      ExplicitTop = 6
    end
    object SB_Gravar: TSpeedButton
      AlignWithMargins = True
      Left = 500
      Top = 5
      Width = 102
      Height = 54
      Margins.Left = 1
      Margins.Right = 1
      Align = alRight
      Caption = 'Gravar - F5'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Layout = blGlyphTop
      ParentFont = False
      OnClick = SB_gravarClick
      ExplicitLeft = 594
      ExplicitTop = 6
    end
  end
  object pnl_fundo: TPanel [1]
    Left = 0
    Top = 0
    Width = 815
    Height = 351
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
  end
end
