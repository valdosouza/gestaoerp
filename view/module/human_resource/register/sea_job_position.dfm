inherited SeaJobPosition: TSeaJobPosition
  Caption = 'Pesquisa de cargos'
  ClientHeight = 528
  ClientWidth = 824
  ExplicitWidth = 830
  ExplicitHeight = 572
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 95
    Width = 818
    Height = 430
    ExplicitTop = 95
    ExplicitWidth = 818
    ExplicitHeight = 430
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 814
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 722
      Height = 412
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descric'#227'o'
          Width = 538
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 724
      Height = 412
      ExplicitLeft = 724
      ExplicitHeight = 412
      inherited Sb_Sair_0: TSpeedButton
        Top = 349
        ExplicitTop = 317
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 286
        ExplicitTop = 254
      end
      inherited SB_Buscar: TSpeedButton
        Top = 223
        ExplicitTop = 191
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 160
        ExplicitTop = 128
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 818
    Height = 86
    ExplicitWidth = 818
    ExplicitHeight = 86
    object Lb_Descricao: TLabel
      Left = 8
      Top = 3
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object E_Descricao: TEdit
      Left = 8
      Top = 19
      Width = 449
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
  end
  inherited cds_search: TClientDataSet
    object cds_searchCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cds_searchDescricao: TStringField
      FieldName = 'Descricao'
    end
  end
end
