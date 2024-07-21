inherited SeaJobPosition: TSeaJobPosition
  Caption = 'Pesquisa de cargos'
  ClientHeight = 460
  ClientWidth = 746
  ExplicitWidth = 752
  ExplicitHeight = 509
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 59
    Width = 740
    Height = 398
    ExplicitTop = 59
    ExplicitWidth = 740
    ExplicitHeight = 398
    inherited DBG_Pesquisa: TDBGrid
      Width = 644
      Height = 380
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
      Left = 646
      Height = 380
      ExplicitLeft = 646
      ExplicitHeight = 380
      inherited Sb_Sair_0: TSpeedButton
        Top = 317
        ExplicitTop = 317
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 254
        ExplicitTop = 254
      end
      inherited SB_Buscar: TSpeedButton
        Top = 191
        ExplicitTop = 191
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 128
        ExplicitTop = 128
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 740
    Height = 50
    ExplicitWidth = 740
    ExplicitHeight = 50
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
