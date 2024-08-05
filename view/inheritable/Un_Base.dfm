object Fr_Base: TFr_Base
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Base'
  ClientHeight = 399
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MnuBase
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MnuBase: TMainMenu
    Left = 64
    Top = 24
    object arefas1: TMenuItem
      Caption = 'Tarefas'
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
end
