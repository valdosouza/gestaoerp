object Fr_Testes: TFr_Testes
  Left = 0
  Top = 0
  Caption = 'Tela de Testes'
  ClientHeight = 323
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_FormaPagto: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 105
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    object Button6: TButton
      Left = 672
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Button6'
      TabOrder = 0
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 672
      Top = 47
      Width = 75
      Height = 25
      Caption = 'Button6'
      TabOrder = 1
      OnClick = Button7Click
    end
  end
  object Grp_Pagamento: TGroupBox
    Left = 0
    Top = 176
    Width = 800
    Height = 147
    Align = alBottom
    Caption = ' Totalizador '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label9: TLabel
      Left = 9
      Top = 80
      Width = 73
      Height = 15
      Caption = 'FALTA PAGAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 172
      Top = 80
      Width = 105
      Height = 15
      Caption = 'VALOR DO TROCO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LB_TL_RECEBIDO: TLabel
      Left = 175
      Top = 18
      Width = 118
      Height = 16
      Caption = 'VALOR  RECEBIDO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 9
      Top = 18
      Width = 86
      Height = 16
      Caption = 'VALOR TOTAL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Vl_Pagar: TEdit_Setes
      Left = 6
      Top = 97
      Width = 167
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
    end
    object E_VL_Troco: TEdit_Setes
      Left = 175
      Top = 97
      Width = 175
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = '0,00'
    end
    object e_vl_recebido: TEdit_Setes
      Left = 173
      Top = 35
      Width = 177
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
    end
    object E_VL_Total: TEdit_Setes
      Left = 7
      Top = 35
      Width = 164
      Height = 26
      TabStop = False
      Alignment = taRightJustify
      BevelInner = bvNone
      BevelOuter = bvSpace
      BevelKind = bkFlat
      Ctl3D = False
      DragMode = dmAutomatic
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 800
    Height = 71
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 2
    object Button1: TButton
      Left = 161
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Inlcuir Forma de Pagamento'
      TabOrder = 0
    end
    object E_Cd_FormaPagto: TEdit
      Left = 34
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object E_Descricao: TEdit
      Left = 34
      Top = 43
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object Button2: TButton
      Left = 257
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Frame 1'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 338
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Frame 2'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 257
      Top = 37
      Width = 75
      Height = 25
      Caption = 'Frame 3'
      TabOrder = 5
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 338
      Top = 37
      Width = 75
      Height = 25
      Caption = 'Button5'
      TabOrder = 6
      OnClick = Button5Click
    end
  end
end
