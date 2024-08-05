inherited RegExtMotive: TRegExtMotive
  Caption = 'Extintor - Cadastro de Motivos Reprova'#231#227'o/Condena'#231#227'o'
  ClientHeight = 172
  ClientWidth = 610
  ExplicitWidth = 616
  ExplicitHeight = 221
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 108
    Width = 610
    ExplicitTop = 108
    ExplicitWidth = 610
    inherited SB_Inserir: TSpeedButton
      Left = -17
      ExplicitLeft = -17
    end
    inherited SB_Alterar: TSpeedButton
      Left = 87
      ExplicitLeft = 87
    end
    inherited SB_Excluir: TSpeedButton
      Left = 191
      ExplicitLeft = 191
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 399
      ExplicitLeft = 399
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 503
      ExplicitLeft = 503
    end
    inherited SB_Gravar: TSpeedButton
      Left = 295
      ExplicitLeft = 295
    end
  end
  inherited pnl_fundo: TPanel
    Width = 610
    Height = 108
    ExplicitWidth = 610
    ExplicitHeight = 108
    object Label2: TLabel
      Left = 5
      Top = 4
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 46
      Width = 20
      Height = 14
      Caption = 'Tipo'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 155
      Top = 46
      Width = 31
      Height = 14
      Caption = 'Norma'
      FocusControl = E_Norma
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object E_Descricao: TEdit
      Left = 5
      Top = 20
      Width = 580
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DBCb_Tipo: TComboBox
      Left = 5
      Top = 60
      Width = 146
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      Items.Strings = (
        'CONDENA'#199#195'O'
        'REPROVA'#199#195'O')
    end
    object E_Norma: TEdit
      Left = 154
      Top = 60
      Width = 175
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited MnuBase: TMainMenu
    Left = 40
    Top = 88
  end
end
