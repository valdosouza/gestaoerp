object Fm_ListaContaBancaria: TFm_ListaContaBancaria
  Left = 0
  Top = 0
  Width = 554
  Height = 44
  TabOrder = 0
  object L_ContaBancaria: TLabel
    Left = 0
    Top = 0
    Width = 554
    Height = 14
    Align = alTop
    Caption = 'Informe a Conta-Corrente '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 125
  end
  object Sb_ContaBancaria: TSpeedButton
    AlignWithMargins = True
    Left = 527
    Top = 14
    Width = 24
    Height = 29
    Margins.Top = 0
    Margins.Bottom = 1
    Align = alRight
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    OnClick = Sb_ContaBancariaClick
    ExplicitLeft = 524
    ExplicitHeight = 22
  end
  object DBLCB_ContaBancaria: TDBLookupComboBox
    AlignWithMargins = True
    Left = 3
    Top = 17
    Width = 518
    Height = 23
    Align = alClient
    KeyField = 'CTB_CODIGO'
    ListField = 'CTB_COMPLETO'
    ListSource = Ds_ContaBancaria
    TabOrder = 0
    OnKeyDown = DBLCB_ContaBancariaKeyDown
  end
  object Qr_ContaBancaria: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'SELECT CTB_CODIGO, EMP_FANTASIA, CTB_AGENCIA, CTB_CONTA,'
      
        ' (EMP_FANTASIA || '#39' - '#39' || CTB_AGENCIA || '#39' - '#39' || CTB_CONTA) CT' +
        'B_COMPLETO, EMP_CODIGO, EMP_NUMBCO'
      'FROM TB_CONTABANCARIA tb_contabancaria '
      '   INNER JOIN TB_EMPRESA tb_banco '
      '   ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO ) '
      'WHERE (CTB_CODIGO IS NOT NULL)  '
      'and CTB_CODMHA =:CTB_CODMHA')
    ForcedRefresh = True
    Left = 328
    Top = 44
    ParamData = <
      item
        Name = 'CTB_CODMHA'
      end>
  end
  object Ds_ContaBancaria: TDataSource
    DataSet = Qr_ContaBancaria
    Left = 436
    Top = 45
  end
end
