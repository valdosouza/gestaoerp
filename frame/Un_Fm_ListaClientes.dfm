inherited Fm_ListaClientes: TFm_ListaClientes
  Width = 539
  Height = 46
  ExplicitWidth = 539
  ExplicitHeight = 46
  inherited SB_Empresas: TSpeedButton
    Left = 488
    Height = 23
    ExplicitLeft = 488
    ExplicitHeight = 23
  end
  inherited Sb_Pesq_Empresa: TSpeedButton
    Left = 513
    Height = 23
    ExplicitLeft = 513
    ExplicitHeight = 23
  end
  inherited DBLCB_Empresa: TDBLookupComboBox
    Width = 410
    ListSource = Ds_ListaEmpresa
    ExplicitWidth = 410
  end
  inherited E_Cd_Empresa: TMaskEdit
    Height = 23
    ExplicitHeight = 23
  end
  inherited Panel1: TPanel
    Width = 539
    ExplicitWidth = 539
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
