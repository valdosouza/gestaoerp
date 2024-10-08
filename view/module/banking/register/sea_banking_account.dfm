inherited SeaBankingAccount: TSeaBankingAccount
  Caption = 'Cadastro de Contas de Banc'#225'rias'
  ClientHeight = 326
  ClientWidth = 632
  ExplicitWidth = 638
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 626
    Height = 252
    ExplicitTop = 71
    ExplicitWidth = 626
    ExplicitHeight = 252
    inherited DBG_Pesquisa: TDBGrid
      Width = 530
      Height = 234
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'agencia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'contacorrente'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numerobanco'
          Width = 278
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 532
      Height = 234
      ExplicitLeft = 532
      ExplicitHeight = 234
      inherited Sb_Sair_0: TSpeedButton
        Top = 171
        ExplicitTop = 171
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 108
        ExplicitTop = 108
      end
      inherited SB_Buscar: TSpeedButton
        Top = 45
        ExplicitTop = 45
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -18
        ExplicitTop = -18
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 626
    Height = 62
    ExplicitWidth = 626
    ExplicitHeight = 62
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 622
      Height = 61
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Lb_BuscaAgencia: TLabel
        Left = 8
        Top = 16
        Width = 40
        Height = 14
        Caption = 'Ag'#234'ncia'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_BuscaConta: TLabel
        Left = 99
        Top = 16
        Width = 73
        Height = 14
        Caption = 'Conta Corrente'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_BuscaBanco: TLabel
        Left = 229
        Top = 16
        Width = 76
        Height = 14
        Caption = 'Nome do Banco'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaAgencia: TEdit
        Left = 8
        Top = 32
        Width = 89
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_BuscaConta: TEdit
        Left = 99
        Top = 32
        Width = 129
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_BuscaBanco: TEdit
        Left = 229
        Top = 32
        Width = 382
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 488
    Top = 32
  end
  inherited ds_search: TDataSource
    Top = 250
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchagencia: TStringField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'agencia'
      Size = 10
    end
    object cds_searchconta: TStringField
      DisplayLabel = 'Conta Corrente'
      FieldName = 'contacorrente'
      Size = 10
    end
    object cds_searchnumerobanco: TStringField
      DisplayLabel = 'N'#250'mero Banco'
      FieldName = 'numerobanco'
    end
  end
end
