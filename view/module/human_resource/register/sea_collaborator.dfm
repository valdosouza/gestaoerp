inherited SeaCollaborator: TSeaCollaborator
  Caption = 'Pesquisa de Colaborador'
  ClientWidth = 663
  ExplicitWidth = 669
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 135
    Width = 657
    Height = 368
    ExplicitTop = 136
    ExplicitWidth = 657
    ExplicitHeight = 367
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 653
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 561
      Height = 350
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
      Columns = <
        item
          Expanded = False
          FieldName = 'nome'
          Width = 177
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPFCNPJ'
          Title.Caption = 'CPF / CNPJ'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CargoDescricao'
          Width = 191
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 563
      Height = 350
      ExplicitLeft = 563
      ExplicitHeight = 349
      inherited Sb_Sair_0: TSpeedButton
        Top = 287
        ExplicitTop = 279
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 224
        ExplicitTop = 216
      end
      inherited SB_Buscar: TSpeedButton
        Top = 161
        ExplicitTop = 153
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 98
        ExplicitTop = 90
      end
      object Chbx_Demitidos: TCheckBox
        Left = 12
        Top = 11
        Width = 80
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Demitidos'
        TabOrder = 0
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Top = 56
    Width = 657
    Height = 73
    ExplicitTop = 376
    ExplicitWidth = 657
    ExplicitHeight = 73
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 647
      Height = 59
      Align = alTop
      Caption = ' Digite sua op'#231#227'o de busca '
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 52
      ExplicitWidth = 653
      object Lb_CPF: TLabel
        Left = 5
        Top = 16
        Width = 24
        Height = 14
        Caption = 'C.P.F'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Nome: TLabel
        Left = 121
        Top = 16
        Width = 30
        Height = 14
        Caption = 'Nome '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Lb_Cargo: TLabel
        Left = 387
        Top = 16
        Width = 29
        Height = 14
        Caption = 'Cargo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_BuscaCPF: TEdit
        Left = 3
        Top = 32
        Width = 116
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
      object E_BuscaNome: TEdit
        Left = 121
        Top = 32
        Width = 266
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
      object E_BuscaCargo: TEdit
        Left = 387
        Top = 32
        Width = 254
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
  inline Fm_LME: TFm_ListaMultiEmpresa [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 657
    Height = 47
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 10
    ExplicitTop = 10
    ExplicitWidth = 653
    inherited L_Carteira: TLabel
      Width = 634
      ExplicitTop = 0
      ExplicitWidth = 634
    end
    inherited pnl_linha_1: TPanel
      Width = 657
      ExplicitTop = 20
      ExplicitWidth = 653
      inherited Sb_Carteira: TSpeedButton
        Left = 633
        ExplicitLeft = 629
      end
      inherited Dblcb_Lista: TDBLookupComboBox
        Width = 633
        ExplicitWidth = 629
      end
    end
  end
  inherited MnuBase: TMainMenu [3]
    Left = 528
    Top = 160
  end
  inherited ds_search: TDataSource [4]
  end
  inherited cds_search: TClientDataSet
    object cds_searchcodigo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'codigo'
    end
    object cds_searchnome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
    end
    object cds_searchCPFCNPJ: TStringField
      FieldName = 'CPFCNPJ'
      Size = 14
    end
    object cds_searchCargoDescricao: TStringField
      DisplayLabel = 'Cargo Descri'#231#227'o'
      FieldName = 'CargoDescricao'
    end
  end
end
