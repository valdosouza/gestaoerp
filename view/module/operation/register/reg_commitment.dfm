inherited RegCommitment: TRegCommitment
  Caption = 'Compromisso'
  ClientHeight = 283
  ClientWidth = 316
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 328
  ExplicitHeight = 346
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 219
    Width = 316
    ExplicitTop = 329
    ExplicitWidth = 546
    inherited SB_Inserir: TSpeedButton
      Left = -311
      ExplicitLeft = -75
    end
    inherited SB_Alterar: TSpeedButton
      Left = -207
      ExplicitLeft = 29
    end
    inherited SB_Excluir: TSpeedButton
      Left = 1
      ExplicitLeft = 349
    end
    inherited SB_Cancelar: TSpeedButton
      Left = -103
      ExplicitLeft = 341
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 209
      ExplicitLeft = 445
    end
    inherited SB_Gravar: TSpeedButton
      Left = 105
      ExplicitLeft = 429
      ExplicitTop = -11
    end
  end
  inherited pnl_fundo: TPanel
    Width = 316
    Height = 219
    ExplicitWidth = 546
    ExplicitHeight = 329
    object Label2: TLabel
      Left = 11
      Top = 8
      Width = 22
      Height = 14
      Caption = 'Data'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 104
      Top = 8
      Width = 23
      Height = 14
      Caption = 'Hora'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 169
      Top = 8
      Width = 63
      Height = 14
      Caption = 'Agenda Para'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 8
      Top = 53
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object w: TMemo
      Left = 11
      Top = 69
      Width = 294
      Height = 120
      MaxLength = 500
      TabOrder = 0
    end
    object E_Data: TDateTimePicker
      Left = 8
      Top = 24
      Width = 92
      Height = 24
      Date = 39488.000000000000000000
      Time = 0.445386284722189900
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object E_Hora: TDateTimePicker
      Left = 102
      Top = 24
      Width = 61
      Height = 24
      Date = 39488.000000000000000000
      Format = 'HH:mm'
      Time = 0.445386284722189900
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      TabOrder = 2
    end
    object Dblcb_Usuario: TComboBox
      Left = 169
      Top = 24
      Width = 144
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Items.Strings = (
        'op'#231'ao 1'
        'op'#231'ao 2')
    end
    object Chbx_Dia: TCheckBox
      Left = 8
      Top = 195
      Width = 56
      Height = 17
      Caption = 'Avisar'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
  end
end
