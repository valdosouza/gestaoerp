inherited SeaTaxation: TSeaTaxation
  Caption = 'Pesquisa de Tributa'#231#245'es para Nota Fiscal Eletr'#244'nica'
  ClientHeight = 347
  ClientWidth = 812
  ExplicitWidth = 818
  ExplicitHeight = 391
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 79
    Width = 806
    Height = 265
    ExplicitTop = 79
    ExplicitWidth = 806
    ExplicitHeight = 265
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 802
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 710
      Height = 247
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'NAT_CFOP'
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UFE_SIGLA'
          Width = 23
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_CONSUMIDOR'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_MICRO'
          Width = 101
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_CST'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_ST_CIMS'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_AQ_ICMS'
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_RD_BS_ICMS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_RD_AQ_ICMS'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBS_DESCRICAO'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TRB_CODIGONCM'
          Width = 69
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 712
      Height = 247
      ExplicitLeft = 712
      ExplicitHeight = 247
      inherited Sb_Sair_0: TSpeedButton
        Top = 184
        ExplicitTop = 184
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 121
        ExplicitTop = 121
      end
      inherited SB_Buscar: TSpeedButton
        Top = 58
        ExplicitTop = 58
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = -5
        ExplicitTop = -5
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 806
    Height = 70
    ExplicitWidth = 806
    ExplicitHeight = 70
    object GroupBox2: TGroupBox
      Left = 2
      Top = 2
      Width = 802
      Height = 95
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        802
        95)
      object L_Busca_NCM: TLabel
        Left = 7
        Top = 21
        Width = 119
        Height = 14
        Caption = 'C'#243'd. Class. Fiscal (NCM)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object CHBX_BUSCA_CONSUMIDOR: TCheckBox
        Left = 545
        Top = 44
        Width = 254
        Height = 17
        Anchors = [akRight, akBottom]
        Caption = 'Regra aplicada para venda ao Consumidor Final'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object E_Busca_NCM: TEdit
        Left = 7
        Top = 41
        Width = 121
        Height = 22
        TabOrder = 0
      end
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchNAT_CFOP: TStringField
      DisplayLabel = 'CFOP'
      FieldName = 'NAT_CFOP'
      Size = 10
    end
    object cds_searchUFE_SIGLA: TStringField
      DisplayLabel = 'UF'
      FieldName = 'UFE_SIGLA'
      Size = 2
    end
    object cds_searchTRB_CONSUMIDOR: TStringField
      DisplayLabel = 'Consumidor'
      FieldName = 'TRB_CONSUMIDOR'
      Size = 1
    end
    object cds_searchTRB_MICRO: TStringField
      DisplayLabel = 'Micro Empresa'
      FieldName = 'TRB_MICRO'
      Size = 1
    end
    object cds_searchTRB_CST: TStringField
      DisplayLabel = 'CST'
      FieldName = 'TRB_CST'
      Size = 2
    end
    object cds_searchTRB_ST_CIMS: TStringField
      DisplayLabel = 'Subs Trib'
      FieldName = 'TRB_ST_CIMS'
      Size = 1
    end
    object cds_searchTRB_AQ_ICMS: TFloatField
      DisplayLabel = 'Aliquota'
      FieldName = 'TRB_AQ_ICMS'
    end
    object cds_searchTRB_RD_BS_ICMS: TFloatField
      DisplayLabel = 'Red. Base'
      FieldName = 'TRB_RD_BS_ICMS'
    end
    object cds_searchTRB_RD_AQ_ICMS: TFloatField
      DisplayLabel = 'Red. Aliquota'
      FieldName = 'TRB_RD_AQ_ICMS'
    end
    object cds_searchOBS_DESCRICAO: TStringField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'OBS_DESCRICAO'
      Size = 50
    end
    object cds_searchTRB_CODIGONCM: TStringField
      DisplayLabel = 'C'#243'digo NCM'
      FieldName = 'TRB_CODIGONCM'
      Size = 50
    end
  end
end
