object Fr_PesqEndereco: TFr_PesqEndereco
  Left = 278
  Top = 210
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pesquisa de Endere'#231'os'
  ClientHeight = 431
  ClientWidth = 892
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 892
    Height = 48
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Label3: TLabel
      Left = 87
      Top = 4
      Width = 58
      Height = 13
      Caption = '&Descri'#231#227'o'
      FocusControl = E_busca_Endereco
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 489
      Top = 4
      Width = 40
      Height = 13
      Caption = '&Cidade'
      FocusControl = E_busca_Cidade
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 828
      Top = 4
      Width = 17
      Height = 13
      Caption = '&UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 7
      Top = 4
      Width = 26
      Height = 13
      Caption = 'Tipo'
      FocusControl = E_Busca_Tipo
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object E_busca_Endereco: TMaskEdit
      Left = 86
      Top = 18
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 30
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object E_busca_Cidade: TMaskEdit
      Left = 488
      Top = 18
      Width = 336
      Height = 21
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 30
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object DBLCB_busca_Estado: TDBLookupComboBox
      Left = 825
      Top = 18
      Width = 64
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      KeyField = 'UFE_CODIGO'
      ListField = 'UFE_SIGLA'
      ListSource = DM.Ds_UF
      ParentFont = False
      TabOrder = 3
    end
    object E_Busca_Tipo: TMaskEdit
      Left = 6
      Top = 18
      Width = 76
      Height = 21
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 30
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
  end
  object StrGrd_Logradouro: TStringGrid
    Left = 0
    Top = 48
    Width = 892
    Height = 342
    Align = alClient
    Color = clCream
    ColCount = 6
    DefaultColWidth = 40
    DefaultRowHeight = 18
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 1
    ExplicitHeight = 337
    ColWidths = (
      40
      40
      40
      40
      40
      40)
    RowHeights = (
      18
      18)
  end
  object Panel4: TPanel
    Left = 0
    Top = 390
    Width = 892
    Height = 41
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitTop = 385
    DesignSize = (
      892
      41)
    object Sb_ok: TBitBtn
      Left = 642
      Top = 6
      Width = 82
      Height = 31
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object Sb_Cancela: TBitBtn
      Left = 723
      Top = 5
      Width = 82
      Height = 31
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object Sb_Busca: TBitBtn
      Left = 806
      Top = 5
      Width = 82
      Height = 31
      Anchors = [akRight, akBottom]
      Caption = '&Buscar'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
        44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
        00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
        33833F333383F33300003333AA463362A433333333383F333833F33300003333
        6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
        33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
        6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
        000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
        333383333333F3330000333333322AAA4333333333333833333F333300003333
        333322A4333333333333338333F333330000333333344A433333333333333338
        3F333333000033333336A24333333333333333833F333333000033333336AA43
        33333333333333833F3333330000333333336663333333333333333888333333
        0000}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = Sb_BuscaClick
    end
  end
end
