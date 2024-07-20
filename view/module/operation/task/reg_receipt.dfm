inherited RegReceipt: TRegReceipt
  Caption = 'Cadastro de Recibo'
  ClientHeight = 304
  ClientWidth = 656
  ExplicitWidth = 662
  ExplicitHeight = 353
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 244
    Width = 656
    Height = 60
    ExplicitTop = 235
    ExplicitWidth = 648
    ExplicitHeight = 60
    inherited SB_Inserir: TSpeedButton
      Left = 29
      Height = 50
      ExplicitLeft = 21
      ExplicitHeight = 50
    end
    inherited SB_Alterar: TSpeedButton
      Left = 133
      Height = 50
      ExplicitLeft = 125
      ExplicitHeight = 50
    end
    inherited SB_Excluir: TSpeedButton
      Left = 237
      Height = 50
      ExplicitLeft = 229
      ExplicitHeight = 50
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 445
      Height = 50
      ExplicitLeft = 437
      ExplicitHeight = 50
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 549
      Height = 50
      ExplicitLeft = 541
      ExplicitHeight = 50
    end
    inherited SB_Gravar: TSpeedButton
      Left = 341
      Height = 50
      ExplicitLeft = 333
      ExplicitHeight = 50
    end
  end
  inherited pnl_fundo: TPanel
    Width = 656
    Height = 244
    ExplicitWidth = 648
    ExplicitHeight = 235
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 652
      Height = 240
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 644
      ExplicitHeight = 231
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
        Date = 40527.438675127320000000
        Time = 40527.438675127320000000
        TabOrder = 2
      end
    end
  end
end
