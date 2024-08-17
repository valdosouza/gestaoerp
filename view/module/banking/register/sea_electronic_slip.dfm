inherited SeaElectronicSlip: TSeaElectronicSlip
  Caption = 'Pesquisa de Cobran'#231'a em boleto'
  ClientHeight = 586
  ClientWidth = 575
  ExplicitWidth = 581
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 71
    Width = 569
    Height = 512
    ExplicitTop = 71
    ExplicitWidth = 569
    ExplicitHeight = 512
    inherited DBG_Pesquisa: TDBGrid
      Width = 473
      Height = 494
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'numerobanco'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'agencia'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'contacorrente'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'carteira'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'desccarteira'
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 475
      Height = 494
      ExplicitLeft = 475
      ExplicitHeight = 494
      inherited Sb_Sair_0: TSpeedButton
        Top = 431
        ExplicitTop = 431
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 368
        ExplicitTop = 368
      end
      inherited SB_Buscar: TSpeedButton
        Top = 305
        ExplicitTop = 305
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 242
        ExplicitTop = 242
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 569
    Height = 62
    ExplicitWidth = 569
    ExplicitHeight = 62
    object Grp_Parametros: TGroupBox
      Left = 2
      Top = 2
      Width = 565
      Height = 63
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Lb_BuscaBanco: TLabel
        Left = 5
        Top = 17
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
      object E_BuscaBanco: TEdit
        Left = 5
        Top = 32
        Width = 468
        Height = 22
        TabOrder = 0
      end
    end
  end
  inherited MnuBase: TMainMenu
    Left = 256
    Top = 8
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cds_searchnumerobanco: TStringField
      DisplayLabel = 'Banco'
      FieldName = 'numerobanco'
    end
    object cds_searchagencia: TStringField
      DisplayLabel = 'Ag'#234'ncia'
      FieldName = 'agencia'
      Size = 15
    end
    object cds_searchcontacorrente: TStringField
      DisplayLabel = 'Conta'
      FieldName = 'contacorrente'
      Size = 10
    end
    object cds_searchcarteira: TStringField
      DisplayLabel = 'N'#186' Carteira'
      FieldName = 'carteira'
    end
    object cds_searchdesccarteira: TStringField
      DisplayLabel = 'Descri'#231#227'o carteira'
      FieldName = 'desccarteira'
    end
  end
end
