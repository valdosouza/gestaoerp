inherited Fm_ListaFornecedores: TFm_ListaFornecedores
  Width = 442
  Height = 41
  ExplicitWidth = 442
  ExplicitHeight = 41
  inherited SB_Empresas: TSpeedButton
    Left = 391
    Height = 18
    Anchors = [akRight, akBottom]
    ExplicitLeft = 389
    ExplicitHeight = 18
  end
  inherited Sb_Pesq_Empresa: TSpeedButton
    Left = 416
    Height = 18
    Anchors = [akRight, akBottom]
    ExplicitLeft = 414
    ExplicitHeight = 18
  end
  inherited DBLCB_Empresa: TDBLookupComboBox
    Width = 313
    ListSource = Ds_ListaEmpresa
    ExplicitWidth = 319
  end
  inherited E_Cd_Empresa: TMaskEdit
    Height = 18
    ExplicitHeight = 18
  end
  inherited Panel1: TPanel
    Width = 442
    ExplicitWidth = 442
  end
  object Qr_ListaEmpresa: TSTQuery
    Database = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_EMAIL,'
      '  EMP_CODVDOR,'
      '  EMP_MULTIPLICADOR,'
      '  EMP_DT_CADASTRO,'
      '  EMP_VL_CRED,'
      '  EMP_FORMDATA,'
      '  EMP_FORMDATA_E,'
      '  EMP_FORMDATA_C'
      'FROM TB_EMPRESA'
      'ORDER BY EMP_NOME')
    Left = 111
    Top = 27
  end
  object Ds_ListaEmpresa: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaEmpresa
    Left = 218
    Top = 31
  end
end
