object BaseFrameList: TBaseFrameList
  Left = 0
  Top = 0
  Width = 494
  Height = 36
  TabOrder = 0
  object L_Carteira: TLabel
    Left = 0
    Top = 0
    Width = 494
    Height = 14
    Align = alTop
    Caption = 'Carteira de Cobran'#231'a'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 103
  end
  object pnl_linha_1: TPanel
    Left = 0
    Top = 14
    Width = 494
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Sb_Carteira: TSpeedButton
      Left = 470
      Top = 0
      Width = 24
      Height = 21
      Align = alRight
      Caption = '...'
      ExplicitLeft = 441
      ExplicitTop = 11
      ExplicitHeight = 22
    end
    object Dblcb_Lista: TDBLookupComboBox
      Left = 0
      Top = 0
      Width = 470
      Height = 21
      Align = alClient
      TabOrder = 0
    end
  end
  object Qr_Lista: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = IBT_Lista
    SQL.Strings = (
      'SELECT *'
      'FROM TB_CARTEIRA_COBRANCA'
      'WHERE CTR_CODBCO=:CTR_CODBCO')
    ForcedRefresh = True
    Left = 17
    Top = 51
    ParamData = <
      item
        Name = 'CTR_CODBCO'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object Ds_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 73
    Top = 49
  end
  object IBT_Lista: TSTTransaction
    Params.Strings = (
      'concurrency'
      'nowait')
    DefaultDatabase = DM.IBD_Gestao
    Left = 132
    Top = 52
  end
end
