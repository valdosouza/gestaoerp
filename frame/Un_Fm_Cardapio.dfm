object Fm_Cardapio: TFm_Cardapio
  Left = 0
  Top = 0
  Width = 574
  Height = 391
  TabOrder = 0
  object Pg_Geral: TPageControl
    Left = 0
    Top = 0
    Width = 574
    Height = 391
    ActivePage = TabSheet2
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'SABORES'
    end
    object TabSheet2: TTabSheet
      Caption = 'TAMANHOS'
      ImageIndex = 1
    end
  end
  object Qr_Tamanho: TSTQuery
    ForcedRefresh = False
    Left = 108
    Top = 78
  end
end
