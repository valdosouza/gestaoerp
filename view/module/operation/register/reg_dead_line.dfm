inherited RegDeadLine: TRegDeadLine
  Caption = 'Cadastro de Formas de Pagto'
  ClientHeight = 122
  ClientWidth = 585
  ExplicitWidth = 591
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 58
    Width = 585
    ExplicitTop = 55
    ExplicitWidth = 585
    inherited SB_Inserir: TSpeedButton
      Left = 6
      Width = 94
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Alterar: TSpeedButton
      Left = 102
      Width = 94
      ExplicitLeft = 109
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Excluir: TSpeedButton
      Left = 198
      Width = 94
      ExplicitLeft = 213
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 390
      Width = 94
      ExplicitLeft = 421
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 486
      Width = 94
      ExplicitLeft = 525
      ExplicitTop = 5
      ExplicitWidth = 94
    end
    inherited SB_Gravar: TSpeedButton
      Left = 294
      Width = 94
      ExplicitLeft = 317
      ExplicitTop = 5
      ExplicitWidth = 94
    end
  end
  inherited pnl_fundo: TPanel
    Width = 585
    Height = 58
    ExplicitTop = -1
    ExplicitWidth = 585
    ExplicitHeight = 58
    object Lb_Codigo: TLabel
      Left = 4
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Descricao: TLabel
      Left = 132
      Top = 8
      Width = 158
      Height = 14
      Caption = 'Prazos de Pagamentos (dd/dd...)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_VL_MMINIMO: TLabel
      Left = 490
      Top = 8
      Width = 85
      Height = 14
      AutoSize = False
      Caption = 'Vlr. M'#237'nimo'
      FocusControl = E_VL_MMINIMO
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Nr_Parcelas: TLabel
      Left = 56
      Top = 8
      Width = 68
      Height = 14
      Caption = 'Parcelas(001)'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Codigo: TEdit
      Left = 5
      Top = 24
      Width = 49
      Height = 22
      Color = clScrollBar
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_VL_MMINIMO: TEdit_Setes
      Left = 490
      Top = 24
      Width = 90
      Height = 22
      Alignment = taRightJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object E_Nr_Parcelas: TMaskEdit
      Left = 56
      Top = 24
      Width = 74
      Height = 21
      Hint = 'Exemplo: 001, 002, formato num'#233'rico com 3 casas.'
      EditMask = '000'
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '   '
    end
    object E_Descricao: TEdit
      Left = 132
      Top = 24
      Width = 355
      Height = 21
      Hint = 'Exemplo: 030/060/090/120'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  inherited MnuBase: TMainMenu
    Left = 352
    Top = 8
  end
end
