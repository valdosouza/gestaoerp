object DM_ListaConsultas: TDM_ListaConsultas
  OldCreateOrder = False
  Height = 542
  Width = 863
  object Qr_ListaNatureza: TSTQuery
    CachedUpdates = True
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      'NAT_CODIGO,'
      'NAT_CFOP,'
      'NAT_DESCRICAO,'
      'NAT_CFOP || '#39' - '#39' || NAT_DESCRICAO CFOP,'
      'NAT_RESUMIDO'
      'FROM TB_NATUREZA'
      'WHERE NAT_ATIVO = '#39'S'#39' '
      'ORDER BY NAT_CFOP')
    ForcedRefresh = False
    Left = 48
    Top = 59
    object Qr_ListaNaturezaNAT_CODIGO: TIntegerField
      FieldName = 'NAT_CODIGO'
      Origin = 'TB_NATUREZA.NAT_CODIGO'
      Required = True
    end
    object Qr_ListaNaturezaNAT_CFOP: TIBStringField
      FieldName = 'NAT_CFOP'
      Origin = 'TB_NATUREZA.NAT_CFOP'
      Size = 10
    end
    object Qr_ListaNaturezaNAT_DESCRICAO: TIBStringField
      FieldName = 'NAT_DESCRICAO'
      Origin = 'TB_NATUREZA.NAT_DESCRICAO'
      Size = 250
    end
    object Qr_ListaNaturezaCFOP: TIBStringField
      FieldName = 'CFOP'
      Size = 263
    end
    object Qr_ListaNaturezaNAT_RESUMIDO: TIBStringField
      FieldName = 'NAT_RESUMIDO'
      Origin = 'TB_NATUREZA.NAT_RESUMIDO'
      Size = 60
    end
  end
  object Ds_ListaNatureza: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaNatureza
    Left = 50
    Top = 104
  end
  object Qr_ListaCliente: TSTQuery
    CachedUpdates = True
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      '  EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CODVDOR,'
      '  EMP_DT_FUNDA,'
      '  EMP_MULTIPLICADOR,'
      '  EMP_CONSUMIDOR,'
      '  EMP_TIPO,'
      '  EMP_EMAIL,'
      '  EMP_DT_CADASTRO,'
      '  EMP_VL_CRED,'
      '  EMP_FORMDATA,'
      '  EMP_FORMDATA_E,'
      '  EMP_FORMDATA_C,'
      '  EMP_STCRED'
      'FROM TB_EMPRESA'
      '  INNER JOIN TB_CLIENTE'
      '  ON (CLI_CODEMP = EMP_CODIGO)'
      'WHERE CLI_ATIVO = '#39'S'#39
      'ORDER BY EMP_NOME')
    ForcedRefresh = False
    Left = 150
    Top = 58
  end
  object Ds_ListaCliente: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaCliente
    Left = 150
    Top = 106
  end
  object Qr_ListaFornecedor: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      '  EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CODVDOR,'
      '  EMP_DT_FUNDA,'
      '  EMP_MULTIPLICADOR,'
      '  EMP_CONSUMIDOR'
      'FROM TB_EMPRESA'
      '  INNER JOIN TB_CLIENTE'
      '  ON (CLI_CODEMP = EMP_CODIGO)'
      'WHERE CLI_ATIVO = '#39'S'#39
      'ORDER BY EMP_NOME')
    ForcedRefresh = False
    Left = 238
    Top = 58
  end
  object Ds_ListaFornecedor: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaFornecedor
    Left = 238
    Top = 106
  end
  object Qr_ListaEmpresa: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
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
    ForcedRefresh = False
    Left = 351
    Top = 59
  end
  object Ds_ListaEmpresa: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaEmpresa
    Left = 346
    Top = 111
  end
  object Qr_ListaProduto: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT PRO_CODIGO, PRO_DESCRICAO, PRO_CODIGOFAB, PRO_CODIGOFOR'
      'FROM TB_PRODUTO'
      'WHERE PRO_ATIVO = '#39'S'#39' AND PRO_FORA_LINHA = '#39'N'#39
      'ORDER BY PRO_DESCRICAO')
    ForcedRefresh = False
    Left = 442
    Top = 64
  end
  object Ds_ListaProduto: TDataSource
    AutoEdit = False
    DataSet = Qr_ListaProduto
    Left = 440
    Top = 110
  end
  object IBT_Consulta: TSTTransaction
    Left = 40
    Top = 8
  end
  object Qr_Kind_Lucratividade: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'select *'
      ' from TB_KIND_LUCRATIVIDADE'
      'order by DESCRIPTION')
    ForcedRefresh = False
    Left = 562
    Top = 64
  end
  object Ds_Kind_Lucratividade: TDataSource
    AutoEdit = False
    DataSet = Qr_Kind_Lucratividade
    Left = 552
    Top = 110
  end
  object Qr_ListaEventosNFe: TSTQuery
    AfterOpen = Qr_ListaEventosNFeAfterOpen
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_NFE_EVENTO'
      'ORDER BY NVT_DESCRICAO')
    ForcedRefresh = False
    Left = 50
    Top = 168
  end
  object Ds_ListaEventosNFe: TDataSource
    DataSet = Qr_ListaEventosNFe
    Left = 58
    Top = 216
  end
  object Qr_ListaMedida: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_MEDIDA'
      'WHERE MED_ESPECIAL is null'
      'ORDER BY MED_ABREVIATURA')
    ForcedRefresh = False
    Left = 170
    Top = 176
  end
  object Ds_ListaMedida: TDataSource
    DataSet = Qr_ListaMedida
    Left = 170
    Top = 220
  end
  object Qr_ListaMotoboy: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda, '
      'CLB_AQ_COM_SRV'
      'FROM TB_COLABORADOR tb_colaborador'
      '    INNER JOIN TB_CARGO tb_cargo'
      '    ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG)'
      'WHERE (CRG_DESCRICAO LIKE '#39'MOTOB%'#39') and (CLB_DEMISSAO IS NULL)'
      'ORDER BY CLB_NOME')
    ForcedRefresh = False
    Left = 261
    Top = 175
  end
  object DS_ListaMotoboy: TDataSource
    DataSet = Qr_ListaMotoboy
    Left = 264
    Top = 220
  end
  object Ds_ListaPreco: TDataSource
    DataSet = Qr_ListaPreco
    Left = 366
    Top = 225
  end
  object Qr_ListaPreco: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_TABELA_PRECO TP'
      'WHERE (TP.TPR_CODEMP =:EMPRESA) OR'
      '              (TP.TPR_CODEMP = 0) AND (TPR_CODIGO <> 2)'
      'ORDER BY TPR_PRINCIPAL DESC')
    ForcedRefresh = False
    Left = 362
    Top = 176
    ParamData = <
      item
        Name = 'EMPRESA'
      end>
  end
  object Qr_ListaEstabelecimento: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      '    EMP_CODIGO,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    EMP_PESSOA,'
      '    EMP_CNPJ,'
      '    EMP_INSC_EST,'
      '    EMP_INSC_MUN,'
      '    EMP_SUB_TRIB,'
      '    EMP_CRT,'
      '    END_CEP,'
      '    END_ENDER,'
      '    END_NUMERO, '
      '    END_BAIRRO,'
      '    END_FONE,'
      '    END_FAX,'
      '    END_CELULAR,'
      '   END_COMERCIAL,'
      '   END_PORTARIA,'
      '   END_CONTATO ,'
      '    END_COMPLEM,'
      '    EMP_EMAIL,'
      '    EMP_SITE,'
      '    EMP_CREA,'
      '    EMP_NUMINSC_SUBS,'
      '    CDD_IBGE,'
      '    END_CODCDD,'
      '    CDD_DESCRICAO,'
      '    END_CODUFE,'
      '    UFE_SIGLA,'
      '    UFE_CODIGO,'
      '   END_PAIS,'
      '    PAI_CODBACEN,'
      '    PAI_DESCRICAO  ,'
      'EMP_RESP_TEC,'
      'EMP_RESPONSAVEL'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      'WHERE (EMP_TIPO = 0) AND (END_PRINCIPAL = '#39'S'#39') ')
    ForcedRefresh = False
    Left = 703
    Top = 67
  end
  object Ds_ListaEstabelecimento: TDataSource
    DataSet = Qr_ListaEstabelecimento
    Left = 702
    Top = 114
  end
  object Qr_ListaTransportadora: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_TIPO,'
      '  EMP_NOME,'
      '  EMP_FANTASIA,'
      '  EMP_CNPJ,'
      '  EMP_INSC_EST,'
      '  EMP_STCRED,'
      '  EMP_OBSERV,'
      '  EMP_DT_CADASTRO,'
      '  EMP_PESSOA,'
      '  EMP_CONSUMIDOR,'
      '  EMP_MICRO,'
      '  EMP_VL_CRED,'
      '  EMP_CODVDOR,'
      '  EMP_ML_DRT,'
      '  EMP_CODBCO,'
      '  EMP_AGENCIA,'
      '  EMP_CONTABCO,'
      '  EMP_EMAIL,'
      '  EMP_SITE,'
      '  EMP_RAM_ATIV,'
      '  EMP_DT_FUNDA,'
      '  EMP_CODTRANSP,'
      '  EMP_MULTIPLICADOR,'
      '  END_ENDER,'
      '  END_NUMERO,'
      
        '  END_BAIRRO, END_CEP, CDD_DESCRICAO, END_COMPLEM, UFE_SIGLA, EN' +
        'D_FONE, END_FAX, END_TIPO,'
      '  EMP_RED_CONTRATO'
      'FROM TB_EMPRESA'
      '   LEFT OUTER JOIN TB_ENDERECO tb_endereco'
      '   ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '   INNER JOIN TB_CIDADE tb_cidade'
      '   ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '   INNER JOIN TB_UF tb_uf'
      '    ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (EMP_TIPO = 3)'
      'ORDER BY EMP_FANTASIA')
    ForcedRefresh = False
    Left = 491
    Top = 182
  end
  object Ds_ListaTransportadora: TDataSource
    DataSet = Qr_ListaTransportadora
    Left = 494
    Top = 233
  end
  object Qr_ListaVendedor: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT CLB_CODIGO, CLB_NOME, CLB_AQ_COM_vda, '
      'CLB_AQ_COM_SRV'
      'FROM TB_COLABORADOR tb_colaborador'
      '    INNER JOIN TB_CARGO tb_cargo'
      '    ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG)'
      
        'WHERE (CRG_DESCRICAO LIKE '#39'VENDEDOR%'#39') and (CLB_DEMISSAO IS NULL' +
        ')'
      'ORDER BY CLB_NOME')
    ForcedRefresh = False
    Left = 609
    Top = 180
  end
  object DS_ListaVendedor: TDataSource
    DataSet = Qr_ListaVendedor
    Left = 611
    Top = 232
  end
  object Qr_ListaBancos: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      ' EMP_CODIGO,'
      '  EMP_NOME,'
      '  EMP_NUMBCO,'
      '  EMP_FANTASIA,'
      '  (EMP_NUMBCO || '#39' - '#39' || EMP_FANTASIA) EMP_NOMEDOBANCO'
      'FROM TB_EMPRESA'
      'WHERE (EMP_TIPO = 4)'
      'ORDER BY EMP_NUMBCO')
    ForcedRefresh = False
    Left = 700
    Top = 180
  end
  object Ds_ListaBancos: TDataSource
    DataSet = Qr_ListaBancos
    Left = 706
    Top = 235
  end
  object Qr_ListaContabilidade: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT '
      '    EMP_CODIGO,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    EMP_PESSOA,'
      '    EMP_CNPJ,'
      '    EMP_INSC_EST,'
      '    EMP_INSC_MUN,'
      '    EMP_SUB_TRIB,'
      '    EMP_CRT,'
      '    END_CEP,'
      '    END_ENDER,'
      '    END_NUMERO, '
      '    END_BAIRRO,'
      '    END_FONE,'
      '    END_FAX,'
      '   END_COMERCIAL,'
      '    END_COMPLEM,'
      '    EMP_EMAIL,'
      '    EMP_SITE,'
      '    EMP_CREA,'
      '    EMP_NUMINSC_SUBS,'
      '    CDD_IBGE,'
      '    END_CODCDD,'
      '    CDD_DESCRICAO,'
      '    END_CODUFE,'
      '    UFE_SIGLA,'
      '    UFE_CODIGO,'
      '    PAI_CODBACEN,'
      '    PAI_DESCRICAO  ,'
      'EMP_RESP_TEC,'
      'EMP_RESPONSAVEL'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      'WHERE (END_PRINCIPAL = '#39'S'#39') And EMP_TIPO = 8')
    ForcedRefresh = False
    Left = 39
    Top = 291
  end
  object Ds_ListaContabilidade: TDataSource
    DataSet = Qr_ListaContabilidade
    Left = 42
    Top = 352
  end
  object Qr_ListaRamoAtividade: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'Select *'
      'from tb_Ramo_atividade'
      'order By 2')
    ForcedRefresh = False
    Left = 173
    Top = 298
  end
  object Ds_ListaRamoAtividade: TDataSource
    DataSet = Qr_ListaRamoAtividade
    Left = 173
    Top = 349
  end
  object Qr_ListaPlanoContasFinal: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT DISTINCT'
      '  PLC_CODIGO,'
      '  PLC_CODPLANO,'
      '  PLC_DESCRICAO,'
      '  PLC_CODPLANO || '#39' - '#39' || PLC_DESCRICAO COMPLETO,'
      '  PLC_NATUREZA,'
      '  PLC_TIPO'
      'FROM TB_PLANOCONTAS'
      'WHERE (PLC_TIPO = '#39'A'#39')'
      'ORDER BY 4')
    ForcedRefresh = False
    Left = 295
    Top = 298
  end
  object Ds_ListaPlanoContasFinal: TDataSource
    DataSet = Qr_ListaPlanoContasFinal
    Left = 295
    Top = 349
  end
end
