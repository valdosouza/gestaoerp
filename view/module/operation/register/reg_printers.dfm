inherited RegPrinters: TRegPrinters
  Caption = 'Cadastro de Impressoras'
  ClientHeight = 233
  ClientWidth = 622
  ExplicitWidth = 634
  ExplicitHeight = 296
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 169
    Width = 622
    ExplicitTop = 160
    ExplicitWidth = 616
    inherited SB_Inserir: TSpeedButton
      Left = -5
      ExplicitLeft = -5
    end
    inherited SB_Alterar: TSpeedButton
      Left = 99
      ExplicitLeft = 280
    end
    inherited SB_Excluir: TSpeedButton
      Left = 203
      ExplicitLeft = 203
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 411
      ExplicitLeft = 411
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 515
      ExplicitLeft = 515
    end
    inherited SB_Gravar: TSpeedButton
      Left = 307
      ExplicitLeft = 307
    end
  end
  inherited pnl_fundo: TPanel
    Width = 622
    Height = 169
    ExplicitWidth = 616
    ExplicitHeight = 160
    object SeaPrinters: TPanel
      Left = 2
      Top = 2
      Width = 618
      Height = 165
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 612
      ExplicitHeight = 156
      object Label1: TLabel
        Left = 8
        Top = 5
        Width = 121
        Height = 14
        Caption = 'Descri'#231#227'o da Impressora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 9
        Top = 46
        Width = 152
        Height = 14
        Caption = 'Caminho da Porta de Impress'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 84
        Width = 169
        Height = 14
        Caption = 'N'#250'mero de Salto Ap'#243's a Impress'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 188
        Top = 84
        Width = 172
        Height = 14
        Caption = 'N'#250'mero de Vias a serem Impressos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 368
        Top = 84
        Width = 94
        Height = 14
        Caption = 'N'#250'mero de Colunas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 6
        Top = 21
        Width = 42
        Height = 22
        Color = clMenu
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_Descricao: TEdit
        Left = 49
        Top = 21
        Width = 562
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_Caminho: TEdit
        Left = 5
        Top = 61
        Width = 604
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
      object Chbx_Tipo: TCheckBox
        Left = 7
        Top = 140
        Width = 310
        Height = 17
        Caption = 'Est'#225' impressora '#233' a principal pnde o pedido sair'#225' completo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object E_Salto: TEdit
        Left = 4
        Top = 99
        Width = 177
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object E_Vias: TEdit
        Left = 184
        Top = 99
        Width = 179
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object E_Colunas: TEdit
        Left = 364
        Top = 99
        Width = 168
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 24
    Top = 168
  end
end
