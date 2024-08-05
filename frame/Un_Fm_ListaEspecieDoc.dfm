object Fm_ListaEspecieDoc: TFm_ListaEspecieDoc
  Left = 0
  Top = 0
  Width = 221
  Height = 44
  TabOrder = 0
  object L_Especie_Doc: TLabel
    Left = 1
    Top = 1
    Width = 116
    Height = 14
    Caption = 'Esp'#233'cide de Documento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_EspecieDoc: TSpeedButton
    Left = 191
    Top = 15
    Width = 24
    Height = 22
    Caption = '...'
    OnClick = Sb_EspecieDocClick
  end
  object Dblcb_Especie_Doc: TDBLookupComboBox
    Left = 1
    Top = 15
    Width = 187
    Height = 21
    KeyField = 'EPD_CODIGO'
    ListField = 'SIGDESC'
    ListSource = Ds_EspecieDoc
    TabOrder = 0
  end
  object Qr_EspecieDoc: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      
        'SELECT EPD_CODIGO, EPD_NUMERO, EPD_SIGLA,  (EPD_SIGLA || '#39' - '#39' |' +
        '| EPD_DESCRICAO) SIGDESC'
      'FROM TB_ESPECIE_DOC'
      'ORDER BY EPD_DESCRICAO')
    ForcedRefresh = True
    Left = 17
    Top = 27
  end
  object Ds_EspecieDoc: TDataSource
    DataSet = Qr_EspecieDoc
    Left = 89
    Top = 25
  end
end
