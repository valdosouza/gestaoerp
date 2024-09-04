inherited RegNote: TRegNote
  Caption = 'Cadastro de Observa'#231#245'es'
  ClientHeight = 328
  ClientWidth = 592
  ExplicitWidth = 598
  ExplicitHeight = 372
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 264
    Width = 592
    ExplicitTop = 264
    ExplicitWidth = 592
    inherited SB_Inserir: TSpeedButton
      Left = 5
      Width = 104
      ExplicitLeft = 5
      ExplicitTop = 5
      ExplicitWidth = 104
    end
    inherited SB_Alterar: TSpeedButton
      Left = 111
      Width = 92
      ExplicitLeft = 69
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Excluir: TSpeedButton
      Left = 205
      Width = 90
      ExplicitLeft = 191
      ExplicitTop = 5
      ExplicitWidth = 90
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 391
      Width = 92
      ExplicitLeft = 381
      ExplicitTop = 5
      ExplicitWidth = 92
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 485
      ExplicitLeft = 485
    end
    inherited SB_Gravar: TSpeedButton
      Left = 297
      Width = 92
      ExplicitLeft = 277
      ExplicitTop = 5
      ExplicitWidth = 92
    end
  end
  inherited pnl_fundo: TPanel
    Width = 592
    Height = 264
    ExplicitWidth = 592
    ExplicitHeight = 264
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 588
      Height = 260
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object L_Name: TLabel
        Left = 8
        Top = 4
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
        Left = 61
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
      object L_Diferido: TLabel
        Left = 512
        Top = 3
        Width = 37
        Height = 14
        Caption = 'Diferido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 9
        Top = 196
        Width = 560
        Height = 14
        AutoSize = False
        Caption = 
          'Para Informar valores vari'#225'veis, utilize os caracteres coringas ' +
          '[1&&v | 2&&v | 3&&v | 4&&v ]'
        FocusControl = E_Descricao
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object L_TipoObs: TLabel
        Left = 9
        Top = 210
        Width = 97
        Height = 13
        Caption = 'Tipo de Observa'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object E_Codigo: TEdit
        Left = 8
        Top = 18
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
      object E_Descricao: TEdit
        Left = 59
        Top = 18
        Width = 447
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object DBCB_Diferido: TComboBox
        Left = 508
        Top = 18
        Width = 70
        Height = 21
        CharCase = ecUpperCase
        Sorted = True
        TabOrder = 2
        Items.Strings = (
          'N'#195'O'
          'SIM')
      end
      object Cb_Tipo_Obs: TComboBox
        Left = 9
        Top = 225
        Width = 568
        Height = 21
        Style = csDropDownList
        TabOrder = 3
        Items.Strings = (
          '<<N'#227'o tem a'#231#227'o ativa no sistema>>'
          
            'Nota Fiscal - Ser'#225' usada conforme determina'#231#227'o da regra de tribu' +
            'ta'#231#227'o'
          'Nota Fiscal - Regral Geral e vai ser impressa em todas as notas'
          'Pedido de Venda - Aviso importante para o Cliente'
          'Frente de Caixa ECF - Aviso importante para o consumidor')
      end
      object MM_Detalhe: TMemo
        Left = 8
        Top = 42
        Width = 570
        Height = 152
        TabOrder = 4
      end
    end
  end
end
