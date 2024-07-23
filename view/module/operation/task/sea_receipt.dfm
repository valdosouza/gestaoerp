inherited SeaReceipt: TSeaReceipt
  Caption = 'Pesquisa de Recibo'
  ClientHeight = 375
  ClientWidth = 678
  ExplicitWidth = 684
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 13
  inherited Pnl_Fundo: TPanel
    Top = 73
    Width = 672
    Height = 299
    ExplicitTop = 73
    ExplicitWidth = 672
    ExplicitHeight = 299
    inherited Lb_ResultadoPesquisa: TLabel
      Width = 668
    end
    inherited DBG_Pesquisa: TDBGrid
      Width = 576
      Height = 281
      Columns = <
        item
          Expanded = False
          FieldName = 'rec_codigo'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'rec_numero'
          Title.Caption = 'N'#250'mero'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rec_data'
          Title.Caption = 'Data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rec_valor'
          Title.Caption = 'Valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rec_emitente'
          Title.Caption = 'Emitente'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rec_sacado'
          Title.Caption = 'Sacado'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rec_obs'
          Title.Caption = 'Refer'#234'ncia'
          Visible = True
        end>
    end
    inherited pnl_pesq_right: TPanel
      Left = 578
      Height = 281
      ExplicitLeft = 578
      ExplicitHeight = 281
      inherited Sb_Sair_0: TSpeedButton
        Top = 218
        ExplicitTop = 170
      end
      inherited SB_Visualizar: TSpeedButton
        Top = 155
        ExplicitTop = 107
      end
      inherited SB_Buscar: TSpeedButton
        Top = 92
        ExplicitTop = 44
      end
      inherited SB_Cadastrar: TSpeedButton
        Top = 29
        ExplicitTop = -19
      end
    end
  end
  inherited Pnl_Parametros: TPanel
    Width = 672
    Height = 64
    ExplicitWidth = 672
    ExplicitHeight = 64
    object GroupBox4: TGroupBox
      Left = 2
      Top = -1
      Width = 668
      Height = 63
      Align = alBottom
      Caption = ' Digite sua op'#231#227'o de busca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label50: TLabel
        Left = 174
        Top = 15
        Width = 37
        Height = 14
        Caption = 'N'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label51: TLabel
        Left = 555
        Top = 15
        Width = 25
        Height = 14
        Caption = 'Valor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Valor: TEdit
        Tag = 32
        Left = 552
        Top = 34
        Width = 81
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
      object E_Numero: TEdit
        Tag = 32
        Left = 172
        Top = 34
        Width = 81
        Height = 22
        TabOrder = 1
      end
      object Chkx_Periodo: TCheckBox
        Left = 7
        Top = 14
        Width = 97
        Height = 17
        Caption = 'Por Data'
        TabOrder = 2
      end
      object E_Data_Ini: TDateTimePicker
        Left = 7
        Top = 34
        Width = 79
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 3
      end
      object E_Data_Fim: TDateTimePicker
        Left = 88
        Top = 33
        Width = 82
        Height = 22
        Date = 39580.356281493060000000
        Time = 39580.356281493060000000
        TabOrder = 4
      end
      object e_nome: TEdit
        Left = 254
        Top = 34
        Width = 297
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 5
      end
      object chck_Emitente: TCheckBox
        Left = 256
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Emitente'
        TabOrder = 6
      end
      object chck_buscaSacado: TCheckBox
        Left = 327
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Sacado'
        TabOrder = 7
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 168
    Top = 8
  end
  inherited cds_search: TClientDataSet
    object cds_searchrec_codigo: TIntegerField
      DisplayWidth = 10
      FieldName = 'rec_codigo'
    end
    object cds_searchrec_numero: TStringField
      DisplayWidth = 12
      FieldName = 'rec_numero'
      Size = 50
    end
    object cds_searchrec_data: TDateField
      DisplayWidth = 15
      FieldName = 'rec_data'
    end
    object cds_searchrec_emitente: TStringField
      DisplayWidth = 100
      FieldName = 'rec_emitente'
      Size = 100
    end
    object cds_searchrec_sacado: TStringField
      DisplayWidth = 100
      FieldName = 'rec_sacado'
      Size = 100
    end
    object cds_searchrec_valor: TFloatField
      DisplayWidth = 10
      FieldName = 'rec_valor'
    end
    object cds_searchrec_obs: TStringField
      DisplayWidth = 500
      FieldName = 'rec_obs'
      Size = 500
    end
  end
end
