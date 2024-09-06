object Fr_envia_email: TFr_envia_email
  Left = 528
  Top = 245
  BorderStyle = bsDialog
  Caption = 'Progresso de Envio de e-mail no Gest'#227'o'
  ClientHeight = 199
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 379
    Height = 199
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      379
      199)
    object Sb_Cancelar: TSpeedButton
      Left = 302
      Top = 170
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      Flat = True
      OnClick = Sb_CancelarClick
      ExplicitTop = 143
    end
    object RE_Status: TRichEdit
      Left = 2
      Top = 2
      Width = 375
      Height = 162
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
