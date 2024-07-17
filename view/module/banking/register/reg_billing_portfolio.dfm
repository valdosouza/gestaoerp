inherited RegBillingPortifolio: TRegBillingPortifolio
  Caption = 'Cadastro de Carteiras de Cobran'#231'a '
  ClientHeight = 206
  ClientWidth = 494
  ExplicitWidth = 506
  ExplicitHeight = 269
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 142
    Width = 494
    ExplicitTop = 133
    ExplicitWidth = 488
    inherited SB_Inserir: TSpeedButton
      Left = 12
      Width = 77
      ExplicitLeft = 40
      ExplicitTop = 5
      ExplicitWidth = 77
    end
    inherited SB_Alterar: TSpeedButton
      Left = 91
      Width = 77
      ExplicitLeft = 83
      ExplicitTop = 5
      ExplicitWidth = 77
    end
    inherited SB_Excluir: TSpeedButton
      Left = 170
      Width = 77
      ExplicitLeft = 186
      ExplicitTop = 5
      ExplicitWidth = 77
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 328
      Width = 77
      ExplicitLeft = 356
      ExplicitTop = 5
      ExplicitWidth = 77
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 407
      Width = 82
      ExplicitLeft = 412
      ExplicitTop = 5
      ExplicitWidth = 82
    end
    inherited SB_Gravar: TSpeedButton
      Left = 249
      Width = 77
      ExplicitLeft = 277
      ExplicitTop = 5
      ExplicitWidth = 77
    end
  end
  inherited pnl_fundo: TPanel
    Width = 494
    Height = 142
    ExplicitWidth = 488
    ExplicitHeight = 133
    object Pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 490
      Height = 138
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 484
      ExplicitHeight = 129
      object Label_1: TLabel
        Left = 5
        Top = 40
        Width = 73
        Height = 14
        Caption = 'C'#243'digo/N'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 5
        Top = 4
        Width = 31
        Height = 14
        Caption = 'Banco'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 5
        Top = 77
        Width = 105
        Height = 14
        Caption = 'Descri'#231#227'o da Carteira'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Numero: TEdit
        Left = 5
        Top = 55
        Width = 165
        Height = 21
        TabOrder = 1
      end
      object DBLCB_Banco: TComboBox
        Left = 5
        Top = 19
        Width = 385
        Height = 21
        TabOrder = 0
      end
      object E_Descricao: TEdit
        Left = 7
        Top = 92
        Width = 474
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object Rg_Tp_Emissao: TRadioGroup
        Left = 178
        Top = 48
        Width = 141
        Height = 41
        Caption = 'Emiss'#227'o '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Cliente'
          'Banco')
        TabOrder = 3
      end
    end
  end
end
