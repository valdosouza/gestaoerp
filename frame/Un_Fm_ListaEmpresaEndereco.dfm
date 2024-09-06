object Fm_ListaEmpresaEndereco: TFm_ListaEmpresaEndereco
  Left = 0
  Top = 0
  Width = 487
  Height = 41
  TabOrder = 0
  object Label10: TLabel
    Left = 7
    Top = 1
    Width = 194
    Height = 14
    Caption = 'C'#243'digo / Nome da empresa para Entrega'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object DBLCB_Endereco: TDBLookupComboBox
    Left = 57
    Top = 17
    Width = 427
    Height = 23
    KeyField = 'END_CODIGO'
    ListField = 'ENDERECO'
    ListSource = Ds_Entrega
    TabOrder = 0
    OnClick = DBLCB_EnderecoClick
    OnKeyDown = DBLCB_EnderecoKeyDown
  end
  object E_Codigo: TEdit
    Left = 4
    Top = 17
    Width = 52
    Height = 21
    TabOrder = 1
    OnChange = E_CodigoChange
  end
  object Qr_Entrega: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT DISTINCT '
      '    END_CODIGO, '
      '    EMP_CODIGO,'
      '    (EMP_FANTASIA || '#39' - '#39' || END_ENDER) AS ENDERECO'
      'FROM TB_EMPRESA tb_empresa'
      '    INNER JOIN TB_ENDERECO tb_endereco'
      '    ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      'ORDER BY EMP_FANTASIA')
    ForcedRefresh = True
    Left = 159
    Top = 20
    object Qr_EntregaEND_CODIGO: TIntegerField
      FieldName = 'END_CODIGO'
      Origin = 'TB_ENDERECO.END_CODIGO'
      Required = True
    end
    object Qr_EntregaEMP_CODIGO: TIntegerField
      FieldName = 'EMP_CODIGO'
      Origin = 'TB_EMPRESA.EMP_CODIGO'
      Required = True
    end
  end
  object Ds_Entrega: TDataSource
    DataSet = Qr_Entrega
    Left = 263
    Top = 20
  end
end
