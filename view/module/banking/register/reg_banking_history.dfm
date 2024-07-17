inherited RegBankingHistory: TRegBankingHistory
  Caption = 'Cadastro de Hist'#243'rico Bancario'
  ClientHeight = 203
  ClientWidth = 617
  ExplicitWidth = 629
  ExplicitHeight = 266
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 200
    Width = 617
    Height = 3
    ExplicitTop = 191
    ExplicitWidth = 611
    ExplicitHeight = 3
    inherited SB_Inserir: TSpeedButton
      Left = -10
      Height = 1
      ExplicitLeft = -10
      ExplicitHeight = 1
    end
    inherited SB_Alterar: TSpeedButton
      Left = 94
      Height = 1
      ExplicitLeft = 94
      ExplicitHeight = 1
    end
    inherited SB_Excluir: TSpeedButton
      Left = 198
      Height = 1
      ExplicitLeft = 198
      ExplicitHeight = 1
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 406
      Height = 1
      ExplicitLeft = 406
      ExplicitHeight = 1
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 510
      Height = 1
      ExplicitLeft = 510
      ExplicitHeight = 1
    end
    inherited SB_Gravar: TSpeedButton
      Left = 302
      Height = 1
      ExplicitLeft = 302
      ExplicitHeight = 1
    end
  end
  inherited pnl_fundo: TPanel
    Width = 617
    Height = 200
    ExplicitWidth = 611
    ExplicitHeight = 191
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 613
      Height = 196
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 3
      object Label1: TLabel
        Left = 8
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
      object Label2: TLabel
        Left = 58
        Top = 8
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
      object E_Codigo: TEdit
        Left = 8
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
      object E_Descricao: TEdit
        Left = 58
        Top = 24
        Width = 543
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
      object PNL_BOTOES: TPanel
        Left = 2
        Top = 126
        Width = 609
        Height = 68
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        ExplicitTop = 117
        ExplicitWidth = 603
        DesignSize = (
          609
          68)
        object SpeedButton1: TSpeedButton
          Left = 6
          Top = 8
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Inserir - F2'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_InserirClick
        end
        object SpeedButton2: TSpeedButton
          Left = 84
          Top = 8
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_alterarClick
        end
        object SpeedButton3: TSpeedButton
          Left = 162
          Top = 8
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Excluir - F4'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_ExcluirClick
        end
        object SpeedButton4: TSpeedButton
          Left = 240
          Top = 8
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Gravar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_gravarClick
        end
        object SpeedButton5: TSpeedButton
          Left = 312
          Top = 6
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Cancelar - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_CancelarClick
        end
        object Sb_Pesquisar: TSpeedButton
          Left = 396
          Top = 8
          Width = 78
          Height = 54
          Anchors = [akBottom]
          Caption = 'Pesquisar- F7'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
        end
        object SpeedButton6: TSpeedButton
          Left = 474
          Top = 8
          Width = 78
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_0Click
        end
      end
    end
  end
end
