inherited SeaCfop: TSeaCfop
  Caption = 'Pesquisa de Natureza de Opera'#231#245'es - CFOP'
  ClientHeight = 389
  ClientWidth = 579
  ExplicitWidth = 585
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Width = 573
    Height = 271
    ExplicitWidth = 573
    ExplicitHeight = 251
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 569
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 477
      Height = 253
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'Cfop'
          Title.Caption = 'CFOP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 346
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 479
      Height = 253
      ExplicitLeft = 479
      ExplicitHeight = 233
      inherited Sb_Sair_0: TSpeedButton
        Top = 190
        ExplicitTop = 170
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 127
        ExplicitTop = 107
      end
      inherited SB_Buscar: TSpeedButton
        Top = 64
        ExplicitTop = 44
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 1
        ExplicitTop = -19
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 573
    ExplicitWidth = 573
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 569
      Height = 98
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object L_BuscaDescricao: TLabel
        Left = 86
        Top = 16
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
      object L_BuscaCFOP: TLabel
        Left = 6
        Top = 16
        Width = 37
        Height = 14
        Caption = 'C.F.O.P.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaDescricao: TMaskEdit
        Left = 85
        Top = 30
        Width = 472
        Height = 22
        TabOrder = 1
        Text = ''
      end
      object E_BuscaCFOP: TMaskEdit
        Left = 4
        Top = 30
        Width = 75
        Height = 22
        TabOrder = 0
        Text = ''
      end
      object Rg_Busca_Sentido: TRadioGroup
        Left = 3
        Top = 58
        Width = 131
        Height = 33
        Caption = 'Sentido  '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Entrada'
          'Sa'#237'da')
        TabOrder = 2
      end
      object Rg_busca_Alcada: TRadioGroup
        Left = 140
        Top = 58
        Width = 252
        Height = 33
        Hint = 'Sim: Dentro do estado'#13'N'#227'o: Fora do estado'
        Caption = 'Al'#231'ada - Abrang'#234'ncia'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Estadual'
          'Nacional'
          'Exterior')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object Rg_Busca_ativo: TRadioGroup
        Left = 398
        Top = 58
        Width = 161
        Height = 33
        Caption = 'Ativo'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        TabOrder = 4
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 384
    Top = 88
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchdescricao: TStringField
      FieldName = 'descricao'
    end
    object cds_searchCfop: TStringField
      FieldName = 'Cfop'
      Size = 10
    end
    object cds_searchSentido: TStringField
      FieldName = 'Sentido'
      Size = 1
    end
    object cds_searchAlcada: TStringField
      FieldName = 'Alcada'
      Size = 1
    end
    object cds_searchAtivo: TStringField
      FieldName = 'Ativo'
      Size = 1
    end
  end
end
