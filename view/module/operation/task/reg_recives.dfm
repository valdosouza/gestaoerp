inherited RegRecives: TRegRecives
  Caption = 'Cadastro de Recibo'
  ClientHeight = 295
  ClientWidth = 648
  ExplicitLeft = 3
  ExplicitTop = 3
  ExplicitWidth = 660
  ExplicitHeight = 358
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 235
    Width = 648
    Height = 60
    ExplicitTop = 239
    ExplicitWidth = 648
    ExplicitHeight = 60
    inherited SB_Inserir: TSpeedButton
      Left = 21
      Height = 50
      ExplicitLeft = 21
    end
    inherited SB_Alterar: TSpeedButton
      Left = 125
      Height = 50
      ExplicitLeft = 125
    end
    inherited SB_Excluir: TSpeedButton
      Left = 229
      Height = 50
      ExplicitLeft = 229
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 437
      Height = 50
      ExplicitLeft = 437
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 541
      Height = 50
      ExplicitLeft = 541
    end
    inherited SB_Gravar: TSpeedButton
      Left = 333
      Height = 50
      ExplicitLeft = 333
    end
  end
  inherited pnl_fundo: TPanel
    Width = 648
    Height = 235
    ExplicitWidth = 642
    ExplicitHeight = 230
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 644
      Height = 231
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 638
      ExplicitHeight = 226
      object Label12: TLabel
        Left = 4
        Top = 3
        Width = 48
        Height = 14
        Caption = 'N'#186' Recibo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 222
        Top = 5
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
      object Label4: TLabel
        Left = 7
        Top = 176
        Width = 96
        Height = 14
        Caption = 'Assinatura Emitente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 123
        Top = 3
        Width = 25
        Height = 14
        Caption = 'Valor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 5
        Top = 43
        Width = 55
        Height = 14
        Caption = 'Sacado de '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 84
        Width = 57
        Height = 14
        Caption = 'Referente '#224
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Numero: TEdit
        Left = 4
        Top = 18
        Width = 113
        Height = 21
        TabOrder = 0
      end
      object E_Vl_Recibo: TEdit
        Left = 119
        Top = 18
        Width = 99
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
      end
      object E_Emitente: TEdit
        Left = 4
        Top = 193
        Width = 630
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 5
      end
      object E_Sacado: TEdit
        Left = 4
        Top = 58
        Width = 630
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object E_Referencia: TMemo
        Left = 4
        Top = 97
        Width = 630
        Height = 77
        TabOrder = 4
      end
      object Tpk_Data: TDateTimePicker
        Left = 219
        Top = 18
        Width = 93
        Height = 22
        Date = 40527.000000000000000000
        Time = 0.438675127319584100
        TabOrder = 2
      end
    end
  end
end
