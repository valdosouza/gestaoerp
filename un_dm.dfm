object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 801
  Width = 1528
  object IBD_Gestao: TSTDatabase
    Params.Strings = (
      'Database=D:\Modelos\erp\Database\IBGCOM.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=NOTEVALDO'
      'Protocol=TCPIP'
      'Port=3060'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    DatabaseName = 'NOTEVALDO/3060:D:\Modelos\erp\Database\IBGCOM.FDB'
    Left = 36
    Top = 6
  end
  object IB_Transacao: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 73
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 112
    Top = 80
  end
  object DriverLink: TFDPhysFBDriverLink
    Left = 96
    Top = 8
  end
  object Qr_Cargo: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CARGO'
      'ORDER BY CRG_DESCRICAO')
    ForcedRefresh = False
    Left = 1031
    Top = 70
  end
  object Qr_Grupo: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'select * from TB_GRUPOS'
      'where GRP_COMPOSICAO IS NULL'
      'ORDER BY GRP_DESCRICAO')
    ForcedRefresh = False
    Left = 487
    Top = 6
  end
  object Qr_SubGrupo: TSTQuery
    MasterSource = Ds_Grupo
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_SUBGRUPOS'
      'WHERE'
      '    SBG_CODGRP =:GRP_CODIGO '
      'ORDER BY SBG_DESCRICAO')
    ForcedRefresh = False
    Left = 570
    Top = 6
    ParamData = <
      item
        Name = 'GRP_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
  end
  object Ds_Grupo: TDataSource
    DataSet = Qr_Grupo
    Left = 487
    Top = 55
  end
  object Ds_SubGrupo: TDataSource
    DataSet = Qr_SubGrupo
    Left = 570
    Top = 55
  end
  object Qr_Observacao: TSTQuery
    MasterSource = Ds_Grupo
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * '
      'FROM TB_OBSERVACAO'
      'WHERE OBS_CODMHA =:OBS_CODMHA'
      'ORDER BY OBS_DESCRICAO')
    ForcedRefresh = False
    Left = 919
    Top = 70
    ParamData = <
      item
        Name = 'OBS_CODMHA'
      end>
  end
  object Qr_Empresas: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
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
      '  EMP_RED_CONTRATO,'
      '  EMP_FORMDATA,'
      '  EMP_RESP_TEC'
      'FROM TB_EMPRESA'
      'WHERE EMP_ATIVA = '#39'S'#39
      'ORDER BY EMP_NOME')
    ForcedRefresh = False
    Left = 825
    Top = 127
  end
  object Qr_Prazo: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_PRAZO'
      'ORDER BY PRZ_PRAZO')
    ForcedRefresh = False
    Left = 1024
    Top = 124
  end
  object Qr_Endereco: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT '
      '  END_CODIGO,'
      '  END_CODEMP,'
      '  END_CNPJ,'
      '  END_TIPO,'
      '  END_ENDER,'
      '  END_NUMERO,'
      '  END_COMPLEM,'
      '  END_BAIRRO,'
      '  END_CEP,'
      '  END_CODCDD,'
      '  CDD_DESCRICAO,'
      '  END_REGIAO,'
      '  END_CODUFE,'
      '  UFE_SIGLA,'
      '  END_CONTATO,'
      '  END_FONE,'
      '  END_FAX,'
      '  END_CELULAR,'
      '  END_PAIS,'
      '  END_COMERCIAL,'
      '  END_PORTARIA,'
      '  END_PRINCIPAL,'
      
        '  tb_endereco.end_ender || '#39', '#39'|| tb_endereco.end_numero || '#39'  '#39 +
        ' || coalesce(tb_endereco.end_complem,'#39#39')   END_COMPLETO,'
      '  END_WHATSUP'
      'FROM TB_ENDERECO'
      '         INNER JOIN TB_CIDADE tb_cidade'
      '         ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '         INNER JOIN TB_UF tb_uf'
      '         ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      'WHERE (END_CODEMP =:EMP_CODIGO)'
      'order by END_PRINCIPAL desc')
    ForcedRefresh = False
    Left = 341
    Top = 107
    ParamData = <
      item
        Name = 'EMP_CODIGO'
      end>
  end
  object Qr_Impostos: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_IMPOSTOS')
    ForcedRefresh = False
    Left = 1029
    Top = 4
  end
  object Sp_Balancete: TSTStoredProc
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    StoredProcName = 'SP_BALANCETE'
    ForcedRefresh = False
    Left = 1229
    Top = 6
  end
  object Qr_Colaborador: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_COLABORADOR'
      'WHERE (CLB_DEMISSAO IS NULL)'
      'Order By CLB_NOME')
    ForcedRefresh = False
    Left = 570
    Top = 107
  end
  object Qr_MarcaVeiculo: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MARCA_VEICULO'
      'ORDER BY MRC_DESCRICAO')
    ForcedRefresh = False
    Left = 661
    Top = 107
  end
  object Qr_Modelo: TSTQuery
    MasterSource = Ds_MarcaVeiculo
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MODELO'
      'WHERE (MOD_CODMRC=:MRC_CODIGO)'
      'ORDER BY MOD_DESCRICAO')
    ForcedRefresh = False
    Left = 341
    Top = 6
    ParamData = <
      item
        Name = 'MRC_CODIGO'
        DataType = ftInteger
        Size = 4
      end>
  end
  object Ds_MarcaVeiculo: TDataSource
    AutoEdit = False
    DataSet = Qr_MarcaVeiculo
    Left = 661
    Top = 161
  end
  object Ds_Modelo: TDataSource
    DataSet = Qr_Modelo
    Left = 341
    Top = 55
  end
  object Qr_Tp_Veiculo: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_TP_VEICULO'
      'ORDER BY TPV_DESCRICAO')
    ForcedRefresh = False
    Left = 666
    Top = 220
  end
  object Qr_MarcaProduto: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_MARCA_PRODUTO'
      'ORDER BY MRC_DESCRICAO')
    ForcedRefresh = False
    Left = 249
    Top = 107
  end
  object Qr_ListaUsuario: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_USUARIO'
      'WHERE USU_ATIVO = '#39'S'#39
      'ORDER BY USU_NOME')
    ForcedRefresh = False
    Left = 1113
    Top = 126
  end
  object Qr_Cartao: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * '
      'FROM TB_CARTAOELETRONICO'
      'ORDER BY CTE_DESCRICAO')
    ForcedRefresh = False
    Left = 815
    Top = 8
  end
  object Qr_Situacao: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_SITUACAO'
      'WHERE SIT_MODULO=:SIT_MODULO'
      'ORDER BY SIT_DESCRICAO')
    ForcedRefresh = False
    Left = 823
    Top = 238
    ParamData = <
      item
        Name = 'SIT_MODULO'
      end>
  end
  object Qr_UF: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_UF'
      'Order By UFE_SIGLA')
    ForcedRefresh = False
    Left = 733
    Top = 119
  end
  object Qr_Pais: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT '
      'PAI_CODBACEN,'
      'PAI_DESCRICAO'
      'from TB_PAIS'
      'ORDER BY PAI_DESCRICAO')
    ForcedRefresh = False
    Left = 733
    Top = 6
  end
  object Qr_Cidades: TSTQuery
    MasterSource = Ds_UF
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'select * from TB_CIDADE'
      'WHERE CDD_UF=:UFE_SIGLA'
      'ORDER BY CDD_DESCRICAO')
    ForcedRefresh = False
    Left = 733
    Top = 222
    ParamData = <
      item
        Name = 'UFE_SIGLA'
        DataType = ftFixedWideChar
        Size = 6
      end>
  end
  object Ds_UF: TDataSource
    DataSet = Qr_UF
    Left = 733
    Top = 163
  end
  object Ds_Cidades: TDataSource
    DataSet = Qr_Cidades
    Left = 733
    Top = 267
  end
  object ds_Pais: TDataSource
    DataSet = Qr_Pais
    Left = 733
    Top = 51
  end
  object Qr_Estoques: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT ETS_CODMHA, ETS_CODIGO, ETS_DESCRICAO, ETS_PRINCIPAL'
      'FROM TB_ESTOQUES'
      'WHERE'
      'ETS_CODMHA = :ETS_CODMHA'
      'ORDER BY ETS_PRINCIPAL DESC, ETS_DESCRICAO ASC'
      '')
    ForcedRefresh = False
    Left = 412
    Top = 107
    ParamData = <
      item
        Name = 'ETS_CODMHA'
      end>
  end
  object Ds_Estoques: TDataSource
    DataSet = Qr_Estoques
    Left = 412
    Top = 161
  end
  object Ds_Tabelas: TDataSource
    DataSet = Qr_Tabelas
    Left = 661
    Top = 63
  end
  object Qr_Impressora: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_IMPRESSORA')
    ForcedRefresh = False
    Left = 935
    Top = 184
  end
  object Qr_Embalagem: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * FROM TB_embalagem')
    ForcedRefresh = False
    Left = 412
    Top = 218
  end
  object Ds_Embalagem: TDataSource
    DataSet = Qr_Embalagem
    Left = 412
    Top = 269
  end
  object Ds_marcaProduto: TDataSource
    DataSet = Qr_MarcaProduto
    Left = 249
    Top = 161
  end
  object Qr_Tp_Extintor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_TP_EXTINTOR')
    ForcedRefresh = False
    Left = 749
    Top = 499
  end
  object Qr_Nvl_Manut: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_NVL_MANUT')
    ForcedRefresh = False
    Left = 858
    Top = 347
  end
  object Qr_Filtra_CFOP: TSTQuery
    Connection = IBD_Gestao
    SQL.Strings = (
      'SELECT '
      'NAT_CODIGO,'
      'NAT_CFOP,'
      'NAT_DESCRICAO,'
      'NAT_CFOP || '#39' - '#39' || NAT_DESCRICAO CFOP,'
      'NAT_RESUMIDO'
      'FROM TB_NATUREZA'
      'WHERE NAT_ATIVO = '#39'S'#39
      '  AND NAT_SENTIDO =:NAT_SENTIDO'
      '  AND NAT_ALCADA=:NAT_ALCADA'
      'ORDER BY NAT_CFOP')
    ForcedRefresh = False
    Left = 929
    Top = 246
    ParamData = <
      item
        Name = 'NAT_SENTIDO'
      end
      item
        Name = 'NAT_ALCADA'
      end>
  end
  object Qr_Modal_Frete: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'select '
      '   MDF_CODIGO,'
      '  MDF_GRUPO'
      '  ,MDF_GRUPO || '#39' - '#39' || MDF_DESCRICAO DESCRICAO'
      'from "TB_MODAL_FRETE"'
      'WHERE MDF_CODIGO > 0'
      'order by'
      '"TB_MODAL_FRETE"."MDF_CODIGO"')
    ForcedRefresh = False
    Left = 821
    Top = 72
  end
  object Sp_Financeiro: TSTStoredProc
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    ForcedRefresh = False
    Left = 1229
    Top = 203
  end
  object Qr_Color: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'Select id , description'
      'from tb_color'
      'Order By description')
    ForcedRefresh = False
    Left = 412
    Top = 6
  end
  object Ds_Color: TDataSource
    DataSet = Qr_Color
    Left = 412
    Top = 55
  end
  object Sp_NotaFiscal: TSTStoredProc
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    StoredProcName = 'SP_NOTA_FISCAL'
    ForcedRefresh = False
    Left = 1229
    Top = 51
  end
  object Sp_Itens_Nfl: TSTStoredProc
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    StoredProcName = 'SP_ITENS_NFL'
    ForcedRefresh = False
    Left = 1229
    Top = 99
    ParamData = <
      item
        Name = 'ITF_OPER_REG'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODIGO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODPED'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODNFL'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODPRO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_QTDE'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ITF_VL_CUSTO'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ITF_VL_UNIT'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_COM'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_OPER'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_DESC'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_VL_DESC'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_ESTOQUE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_DESPACHO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_IPI'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_ICMS'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODEST'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODTPR'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_ALTURA'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_LARGURA'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_SENTIDO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_IMP_APROX'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object Sp_Itens_CTC: TSTStoredProc
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    StoredProcName = 'SP_ITENS_ICT'
    ForcedRefresh = False
    Left = 1229
    Top = 155
  end
  object Qr_ImagenBotao: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT OPF_IMAGEM  '
      'FROM TB_OPER_INTERFACE '
      'WHERE OPF_DESCRICAO =:OPF_DESCRICAO ')
    ForcedRefresh = False
    Left = 1112
    ParamData = <
      item
        Name = 'OPF_DESCRICAO'
      end>
  end
  object Sp_Comissao: TSTStoredProc
    Connection = IBD_Gestao
    StoredProcName = 'SP_RESERVA'
    ForcedRefresh = False
    Left = 1229
    Top = 262
  end
  object qr_trib_pis: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT TBP_CODIGO, TBP_GRUPO,'
      'TBP_GRUPO || '#39' - '#39' || TBP_DESCRICAO DESCRICAO'
      'FROM TB_TRIB_PIS'
      ''
      '')
    ForcedRefresh = False
    Left = 487
    Top = 107
  end
  object ds_trib_pis: TDataSource
    DataSet = qr_trib_pis
    Left = 487
    Top = 161
  end
  object Qr_Uf_Mva_NCM: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      
        'SELECT UFE_CODIGO, UFE_ALIQ_INTERNA, UFE_SIGLA, UFE_MR_VL_AGREGA' +
        'DO, MUN_CODIGONCM, MUN_MR_VL_AGREGADO, UFE_ALIQ_INT_EST,UFE_TX_F' +
        'CP'
      'FROM TB_UF'
      '  LEFT OUTER JOIN TB_MVA_UF_NCM '
      '  ON (MUN_CODUFE = UFE_CODIGO)'
      'WHERE UFE_CODIGO=:UFE_CODIGO'
      'Order By UFE_SIGLA')
    ForcedRefresh = False
    Left = 1114
    Top = 68
    ParamData = <
      item
        Name = 'UFE_CODIGO'
      end>
  end
  object Qr_Especie_Doc_Cobranca: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'Select *'
      'from TB_ESPECIE_DOC '
      'ORDER BY EPD_DESCRICAO')
    ForcedRefresh = False
    Left = 927
    Top = 123
  end
  object Qr_Carteira_Cobranca: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CARTEIRA_COBRANCA'
      'WHERE CTR_CODBCO=:CTR_CODBCO')
    ForcedRefresh = False
    Left = 913
    Top = 3
    ParamData = <
      item
        Name = 'CTR_CODBCO'
      end>
  end
  object Qr_Negocio: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT *'
      'FROM TB_NEGOCIO'
      'ORDER BY NEG_DESCRICAO')
    ForcedRefresh = False
    Left = 335
    Top = 218
  end
  object Ds_Negocio: TDataSource
    DataSet = Qr_Negocio
    Left = 336
    Top = 283
  end
  object Qr_Ext_ListaTipoExtintor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT'
      '  ETP_CODIGO,'
      '  ETP_DESCRICAO,'
      '  ETP_DESC_INMETRO,'
      '  ETP_CAPACIDADE,'
      '  ETP_CODMED,'
      '  ETP_CLASSE,'
      '  ETP_VENC_INSPECAO,'
      '  ETP_VENC_NIVEL_2,'
      '  ETP_VENC_NIVEL_3,'
      '  ETP_VENC_CARGA,'
      '  ETP_TX_TOL_CARGA_MIN,'
      '  ETP_TX_TOL_CARGA_MAX,'
      '  ETP_TX_TOL_CARGA_MIN_MAN,'
      '  ETP_TX_TOL_CARGA_MAX_MAN,'
      '  ETP_TX_TOL_PERDA_MASSA,'
      '  ETP_TX_VOL_HIDRAULICO,'
      '  ETP_TX_EXP_PERMANENTE,'
      '  ETP_TEMPO_DE_DESCARGA,'
      '  ETP_ALCANCE_DO_JATO,'
      '  ETO_TX_REN_DA_CARGA,'
      
        '   ETP_DESCRICAO || '#39' - '#39'  || ETP_CLASSE  || '#39' - '#39'  || ETP_CAPAC' +
        'IDADE   || '#39' '#39'  || MED_ABREVIATURA  DESC_COMPLETA,'
      '   ETP_DESCRICAO || '#39' - '#39'  || ETP_CLASSE  DESC_RESUMIDA'
      'from  TB_EXT_TIPO'
      '  INNER JOIN TB_MEDIDA'
      '  ON (MED_CODIGO = ETP_CODMED)'
      'ORDER BY ETP_DESCRICAO')
    ForcedRefresh = False
    Left = 488
    Top = 343
  end
  object Ds_Ext_ListaTipoExtintor: TDataSource
    DataSet = Qr_Ext_ListaTipoExtintor
    Left = 488
    Top = 399
  end
  object Qr_Ext_LocalExtintor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT'
      '  ELZ_CODIGO,'
      '  ELZ_NIVEL ,'
      '  ELZ_DESCRICAO'
      'FROM TB_EXT_LOCALIZACAO'
      'WHERE ELZ_CODEMP=:ELZ_CODEMP'
      'ORDER BY ELZ_DESCRICAO')
    ForcedRefresh = False
    Left = 256
    Top = 447
    ParamData = <
      item
        Name = 'ELZ_CODEMP'
      end>
  end
  object Ds_Ext_LocalExtintor: TDataSource
    DataSet = Qr_Ext_LocalExtintor
    Left = 256
    Top = 495
  end
  object Qr_Ext_Nivel_Manutencao: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT'
      '    ENM_CODIGO,'
      '    ENM_DESCRICAO'
      'FROM TB_EXT_NIVEL_MANUT'
      'ORDER BY ENM_DESCRICAO')
    ForcedRefresh = False
    Left = 376
    Top = 451
  end
  object Ds_Ext_Nivel_Manutencao: TDataSource
    DataSet = Qr_Ext_Nivel_Manutencao
    Left = 376
    Top = 499
  end
  object Qr_Ext_EnsaiadoPor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'Select '
      '  ENS_CODIGO,'
      '  ENS_NOME'
      'from TB_EXT_ENSAIADOR '
      'ORDER BY ENS_NOME')
    ForcedRefresh = False
    Left = 496
    Top = 451
  end
  object Ds_Ext_EnsaiadoPor: TDataSource
    DataSet = Qr_Ext_EnsaiadoPor
    Left = 496
    Top = 499
  end
  object Qr_Ext_Tecnico_Insp: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT CLB_CODIGO, CLB_NOME'
      'FROM TB_COLABORADOR tb_colaborador'
      '    INNER JOIN TB_CARGO tb_cargo'
      '    ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG)'
      
        'WHERE (CRG_DESCRICAO LIKE '#39'VENDEDOR%'#39') and (CLB_DEMISSAO IS NULL' +
        ')'
      'ORDER BY CLB_NOME')
    ForcedRefresh = False
    Left = 747
    Top = 344
  end
  object Ds_Ext_Tecnico_Insp: TDataSource
    DataSet = Qr_Ext_Tecnico_Insp
    Left = 749
    Top = 397
  end
  object Qr_Ext_Motivo: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'Select '
      '  EMC_CODIGO,'
      '  EMC_TIPO,'
      '  EMC_NORMA,'
      '  EMC_DESCRICAO'
      'from TB_EXT_MOTIVOS ')
    ForcedRefresh = False
    Left = 608
    Top = 456
  end
  object Ds_Ext_Motivo: TDataSource
    AutoEdit = False
    DataSet = Qr_Ext_Motivo
    Left = 608
    Top = 504
  end
  object Qr_Revestimento: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'Select '
      '  RVT_CODIGO,'
      '  RVT_DESCRICAO'
      'from TB_REVESTIMENTO '
      'ORDER BY   RVT_DESCRICAO')
    ForcedRefresh = False
    Left = 249
    Top = 218
  end
  object Ds_Revestimento: TDataSource
    AutoEdit = False
    DataSet = Qr_Revestimento
    Left = 249
    Top = 269
  end
  object qr_category: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT * '
      'FROM TB_CATEGORY '
      'ORDER BY POSIT_LEVEL')
    ForcedRefresh = False
    Left = 570
    Top = 224
  end
  object ds_category: TDataSource
    DataSet = qr_category
    Left = 573
    Top = 277
  end
  object Qr_Carteiras: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      
        'SELECT CTB_CODIGO, EMP_NUMBCO, EMP_FANTASIA, CTB_AGENCIA,  CTB_A' +
        'G_DV, CTB_CONTA,CTB_CC_DV,'
      
        '(EMP_NUMBCO || '#39' - '#39' || EMP_FANTASIA || '#39' | AG: '#39' || CTB_AGENCIA' +
        ' || '#39' | CC: '#39' || CTB_CONTA || '#39'-'#39' || CTB_CC_DV || '#39'-'#39' || CTR_DES' +
        'CRICAO) CTB_COMPLETO,'
      'tb_boleto_eletronico.ble_aceite,'
      'tb_carteira_cobranca.CTR_CODIGO,'
      'tb_carteira_cobranca.CTR_NUMERO,'
      'tb_boleto_eletronico.BLE_CODIGO,'
      'tb_boleto_eletronico.BLE_TX_DESCONTO, '
      'tb_boleto_eletronico.BLE_TX_JUROS, '
      'tb_boleto_eletronico.BLE_TX_MORA, '
      'tb_boleto_eletronico.BLE_VL_MORA_MIN,'
      'tb_boleto_eletronico.BLE_TX_MULTA,'
      'tb_boleto_eletronico.BLE_PROTESTO,'
      'tb_boleto_eletronico.BLE_VL_TARIFA,'
      'tb_boleto_eletronico.ble_localpag,'
      'tb_boleto_eletronico.ble_instrucoes,'
      'tb_boleto_eletronico.ble_instr_1,'
      'tb_boleto_eletronico.ble_instr_2,'
      'CTR_TIPO_EMISSAO,'
      'BLE_DIAS_PROTESTO,'
      'BLE_DIAS_NEGATIVACAO,'
      'BLE_NEGATIVACAO'
      ''
      'FROM TB_BOLETO_ELETRONICO tb_boleto_eletronico'
      '  INNER JOIN TB_CONTABANCARIA tb_contabancaria'
      
        '  ON (tb_boleto_eletronico.BLE_CODCTB = tb_contabancaria.ctb_cod' +
        'igo)'
      '  INNER JOIN TB_EMPRESA tb_banco'
      '  ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO )'
      '  INNER JOIN tb_carteira_cobranca tb_carteira_cobranca'
      
        '  ON (tb_carteira_cobranca.ctr_codigo = tb_boleto_eletronico.ble' +
        '_codctr)'
      ''
      ''
      'WHERE (CTB_CODMHA=:CTB_CODMHA)')
    ForcedRefresh = False
    Left = 490
    Top = 228
    ParamData = <
      item
        Name = 'CTB_CODMHA'
      end>
  end
  object Ds_Carteiras: TDataSource
    AutoEdit = False
    DataSet = Qr_Carteiras
    Left = 488
    Top = 272
  end
  object Ds_Endereco: TDataSource
    AutoEdit = False
    DataSet = Qr_Endereco
    Left = 341
    Top = 161
  end
  object Qr_Estabelecimento: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
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
      'EMP_RESPONSAVEL,'
      '  EMP_TIP_FAT'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      'WHERE (EMP_TIPO = 0) AND (END_PRINCIPAL = '#39'S'#39') AND '
      '  (EMP_CODIGO=:EMP_CODIGO)')
    ForcedRefresh = False
    Left = 1119
    Top = 187
    ParamData = <
      item
        Name = 'EMP_CODIGO'
        DataType = ftInteger
      end>
  end
  object Qr_Nf_Eletronica: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'select '
      '   NFE_CODEMP'
      '   ,NFE_AMBIENTE'
      '   ,NFE_EMISSAO'
      '   ,NFE_CERTIFICADO'
      '   ,NFE_REPOSITORIO'
      '   ,NFE_REPOSITORIO_NFCE'
      '   ,NFE_DFE_VISUALIZAR'
      '   ,NFE_DFE_ORIENTACAO'
      '   ,NFE_DFE_FAT'
      '   ,NFE_DFE_DUP'
      '   ,NFE_DFE_TIPO'
      '   ,NFE_EMAIL_CONTADOR'
      '   ,NFE_COPIA_EMAIL'
      '   ,NFE_IDTOKEN'
      '   ,NFE_TOKEN'
      '   ,NFE_POS_CANH'
      '  ,NFE_VERSAO'
      'from TB_NF_ELETRONICA'
      'WHERE NFE_CODEMP=:EMP_CODIGO')
    ForcedRefresh = False
    Left = 1023
    Top = 181
    ParamData = <
      item
        Name = 'EMP_CODIGO'
      end>
  end
  object Qr_Ext_TipoExtintor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT'
      '    ETP_CODIGO,'
      '    ETP_DESCRICAO,'
      '    ETP_DESC_INMETRO,'
      '    ETP_CAPACIDADE,'
      '    MED_DESCRICAO,'
      '    ETP_VENC_INSPECAO,'
      '    ETP_VENC_NIVEL_2, '
      '    ETP_VENC_NIVEL_3, '
      '    ETP_VENC_CARGA,'
      '    ETP_TX_TOL_PERDA_MASSA,'
      '   ETP_TX_VOL_HIDRAULICO,'
      '   ETP_TX_EXP_PERMANENTE,'
      
        '   ETP_DESCRICAO || '#39' - '#39'  || ETP_CLASSE  || '#39' - '#39'  || ETP_CAPAC' +
        'IDADE   || '#39' '#39'  || MED_ABREVIATURA  DESC_COMPLETA'
      'from  TB_EXT_TIPO'
      '  INNER JOIN TB_MEDIDA'
      '  ON (MED_CODIGO = ETP_CODMED)'
      'WHERE ETP_CODIGO=:ETP_CODIGO'
      'ORDER BY ETP_DESCRICAO')
    ForcedRefresh = False
    Left = 744
    Top = 455
    ParamData = <
      item
        Name = 'ETP_CODIGO'
      end>
  end
  object Ds_Colaborador: TDataSource
    DataSet = Qr_Colaborador
    Left = 570
    Top = 161
  end
  object Qr_Ext_ListaGrandezas: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT '
      '    EGZ_CODIGO,'
      '    EGZ_DESCRICAO,'
      '    (EGZ_SEQUENCIA || '#39' - '#39' || EGZ_DESCRICAO) EGZ_COMPLETA'
      'FROM TB_EXT_GRANDEZA'
      'ORDER BY EGZ_SEQUENCIA ')
    ForcedRefresh = False
    Left = 258
    Top = 339
  end
  object Ds_Ext_ListaGrandezas: TDataSource
    DataSet = Qr_Ext_ListaGrandezas
    Left = 256
    Top = 384
  end
  object Qr_Ext_ListaAgenteExtintor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT EAE_CODIGO, EAE_CLASSE, EAE_DESC_INMETRO, EAE_DESCRICAO,'
      '(EAE_DESCRICAO || '#39' | '#39' ||  EAE_CLASSE) AS EAE_COMPLETO'
      'from TB_EXT_AGENTE_EXTINTOR'
      'ORDER BY 5')
    ForcedRefresh = False
    Left = 370
    Top = 342
  end
  object Ds_Ext_ListaAgenteExtintor: TDataSource
    DataSet = Qr_Ext_ListaAgenteExtintor
    Left = 368
    Top = 384
  end
  object Qr_Ext_ListaCapacidadeExtintor: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT DISTINCT'
      '  ETP_CAPACIDADE || '#39' - '#39' || MED_ABREVIATURA DESCRICAO,'
      '  ETP_CAPACIDADE,'
      '  MED_ABREVIATURA'
      'from  TB_EXT_TIPO'
      '   INNER JOIN tb_medida'
      '   ON (tb_medida.med_codigo = tb_ext_tipo.etp_codmed)'
      'ORDER BY ETP_CAPACIDADE')
    ForcedRefresh = False
    Left = 600
    Top = 346
  end
  object Ds_Ext_ListaCapacidadeExtintor: TDataSource
    DataSet = Qr_Ext_ListaCapacidadeExtintor
    Left = 608
    Top = 392
  end
  object Qr_GeneratorBcoDestino: TSTQuery
    CachedUpdates = True
    Connection = IBD_Gestao
    ForcedRefresh = False
    Left = 1047
    Top = 380
  end
  object Sp_Itens_NflBcoDestino: TSTStoredProc
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    StoredProcName = 'SP_ITENS_NFL'
    ForcedRefresh = False
    Left = 1228
    Top = 326
    ParamData = <
      item
        Name = 'ITF_OPER_REG'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODIGO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODPED'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODNFL'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODPRO'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_QTDE'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ITF_VL_CUSTO'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ITF_VL_UNIT'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_COM'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_OPER'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_DESC'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_VL_DESC'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_ESTOQUE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_DESPACHO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_IPI'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_AQ_ICMS'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODEST'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_CODTPR'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'ITF_ALTURA'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_LARGURA'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'ITF_SENTIDO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ITF_IMP_APROX'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object Qr_Acao_EstoqueBcoDestino: TSTQuery
    Connection = IBD_Gestao
    SQL.Strings = (
      'SELECT (LCB_VLCREDIT- LCB_VLDEBITO) AS LCB_SLDANT'
      'FROM TB_LANCABANC')
    ForcedRefresh = False
    Left = 1053
    Top = 503
  end
  object Qr_Insere_EstoqueBcoDestino: TSTQuery
    Connection = IBD_Gestao
    SQL.Strings = (
      'INSERT INTO TB_CTRL_ESTOQUE( '
      '  "CET_VINCULO" '
      ', "CET_CONTROLE" '
      ', "CET_ITEM_CTRL" '
      ', "CET_CODETS" '
      ', "CET_OPERACAO" '
      ', "CET_CODPRO" '
      ', "CET_QTDE" '
      ', "CET_DATA") '
      'values( '
      '  :"CET_VINCULO" '
      ', :"CET_CONTROLE" '
      ', :"CET_ITEM_CTRL" '
      ', :"CET_CODETS" '
      ', :"CET_OPERACAO" '
      ', :"CET_CODPRO" '
      ', :"CET_QTDE" '
      ', :"CET_DATA")')
    ForcedRefresh = False
    Left = 1049
    Top = 439
    ParamData = <
      item
        Name = 'CET_VINCULO'
      end
      item
        Name = 'CET_CONTROLE'
      end
      item
        Name = 'CET_ITEM_CTRL'
      end
      item
        Name = 'CET_CODETS'
      end
      item
        Name = 'CET_OPERACAO'
      end
      item
        Name = 'CET_CODPRO'
      end
      item
        Name = 'CET_QTDE'
      end
      item
        Name = 'CET_DATA'
      end>
  end
  object Qr_Transportadora: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT '
      '    EMP_CODIGO,'
      '    EMP_NOME,'
      '    EMP_FANTASIA,'
      '    EMP_CNPJ,'
      '    EMP_INSC_EST,'
      '    END_CEP,'
      '    END_ENDER,'
      '    END_NUMERO, '
      '    END_BAIRRO,'
      '    CDD_IBGE,'
      '    CDD_DESCRICAO,'
      '    UFE_SIGLA,'
      '    PAI_CODBACEN,'
      '    PAI_DESCRICAO ,'
      '   EMP_EMAIL,'
      '  CDD_IBGE'
      'FROM TB_EMPRESA tb_empresa'
      '  INNER JOIN TB_ENDERECO tb_endereco'
      '  ON (tb_endereco.END_CODEMP = tb_empresa.EMP_CODIGO)'
      '  INNER JOIN TB_CIDADE tb_cidade'
      '  ON (tb_cidade.CDD_CODIGO = tb_endereco.END_CODCDD)'
      '  INNER JOIN TB_UF tb_uf'
      '  ON (tb_uf.UFE_CODIGO = tb_endereco.END_CODUFE)'
      '  INNER JOIN TB_PAIS tb_pais'
      '  ON (tb_pais.PAI_CODBACEN = tb_endereco.END_PAIS)'
      'WHERE (END_PRINCIPAL = '#39'S'#39') AND '
      '  (EMP_CODIGO=:EMP_CODIGO)'
      '')
    ForcedRefresh = False
    Left = 823
    Top = 182
    ParamData = <
      item
        Name = 'EMP_CODIGO'
      end>
  end
  object Ds_Natureza: TDataSource
    DataSet = Qr_Filtra_CFOP
    Left = 929
    Top = 295
  end
  object Qr_Tabelas: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'select  * from TB_TABELA_PRECO'
      'ORDER BY TPR_NOME')
    ForcedRefresh = False
    Left = 661
    Top = 6
  end
  object Ds_Ext_Tecnico_Manu: TDataSource
    DataSet = Qr_Ext_Tecnico_Manu
    Left = 247
    Top = 55
  end
  object Qr_Ext_Tecnico_Manu: TSTQuery
    Connection = IBD_Gestao
    Transaction = IB_Transacao
    SQL.Strings = (
      'SELECT CLB_CODIGO, CLB_NOME'
      'FROM TB_COLABORADOR tb_colaborador'
      '    INNER JOIN TB_CARGO tb_cargo'
      '    ON (tb_cargo.CRG_CODIGO = tb_colaborador.CLB_CODCRG)'
      
        'WHERE (CRG_DESCRICAO LIKE '#39'VENDEDOR%'#39') and (CLB_DEMISSAO IS NULL' +
        ')'
      'ORDER BY CLB_NOME')
    ForcedRefresh = False
    Left = 247
    Top = 6
  end
  object Qr_Crud: TSTQuery
    AutoCalcFields = False
    Connection = IBD_Gestao
    Transaction = IBT_Crud
    SQL.Strings = (
      'select OS.*, MA.mrc_descricao, MD.MOD_DESCRICAO'
      'from TB_OWN_FLEET_OS OS'
      '  INNER JOIN tb_veiculo VEI'
      '  ON (VEI.vei_placa = OS.tb_vehicle_id)'
      '  INNER join tb_marca_veiculo MA'
      '  ON (MA.mrc_codigo = VEI.vei_codmrc)'
      '  INNER join TB_MODELO MD '
      '  ON (MD.MOD_CODIGO = VEI.VEI_CODMOD) ')
    ForcedRefresh = False
    Left = 1033
    Top = 246
  end
  object IBT_Crud: TSTTransaction
    Connection = IBD_Gestao
    Left = 1036
    Top = 297
  end
  object Ds_TPV_Veiculo: TDataSource
    AutoEdit = False
    DataSet = Qr_Tp_Veiculo
    Left = 664
    Top = 277
  end
  object IBT_Estoque: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 193
  end
  object IBT_Financeiro: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 249
  end
  object IBT_Atualiza: TSTTransaction
    Connection = IBD_Gestao
    Left = 44
    Top = 129
  end
  object IBT_Consulta: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 420
  end
  object IBT_Generator: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 361
  end
  object IBT_GeneratorBcoDestino: TSTTransaction
    Connection = IBD_Gestao
    Left = 36
    Top = 305
  end
  object IBT_ConsultaBcoDestino: TSTTransaction
    Connection = IBD_Gestao
    Left = 148
    Top = 313
  end
  object IBT_EstoqueBcoDestino: TSTTransaction
    Connection = IBD_Gestao
    Left = 148
    Top = 417
  end
  object IBT_Faturamento: TSTTransaction
    Connection = IBD_Gestao
    Left = 150
    Top = 187
  end
  object IBT_Listas: TSTTransaction
    Connection = IBD_Gestao
    Left = 148
    Top = 364
  end
  object IBT_Servidor: TSTTransaction
    Connection = IBD_Gestao
    Left = 148
    Top = 129
  end
  object IBT_Report: TSTTransaction
    Connection = IBD_Gestao
    Left = 148
    Top = 257
  end
  object FDConnection1: TFDConnection
    Left = 40
    Top = 536
  end
end
