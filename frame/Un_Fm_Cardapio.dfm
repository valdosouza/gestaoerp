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
      inline Fm_Sabor: TFm_CardapioPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 357
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 566
        ExplicitHeight = 357
        inherited Panel4: TPanel
          Top = 306
          Width = 566
          ExplicitTop = 306
          ExplicitWidth = 566
        end
        inherited Pnl_Lista: TPanel
          Width = 566
          Height = 306
          ExplicitWidth = 566
          ExplicitHeight = 306
          inherited StrGrd_Lista: TStringGrid
            Width = 562
            Height = 302
            ExplicitWidth = 562
            ExplicitHeight = 302
          end
        end
        inherited popMenuTamanho: TPopupMenu
          Left = 424
          Top = 160
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TAMANHOS'
      ImageIndex = 1
      inline Fm_CardapioPanel1: TFm_CardapioPanel
        Left = 0
        Top = 0
        Width = 566
        Height = 357
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 566
        ExplicitHeight = 357
        inherited Panel4: TPanel
          Top = 306
          Width = 566
          ExplicitTop = 306
          ExplicitWidth = 566
        end
        inherited Pnl_Lista: TPanel
          Width = 566
          Height = 306
          ExplicitWidth = 566
          ExplicitHeight = 306
          inherited StrGrd_Lista: TStringGrid
            Width = 562
            Height = 302
            ExplicitWidth = 562
            ExplicitHeight = 302
          end
        end
      end
    end
  end
  object Qr_Tamanho: TSTQuery
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 108
    Top = 78
  end
end
