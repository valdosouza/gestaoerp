object Fm_CardapioMTS: TFm_CardapioMTS
  Left = 0
  Top = 0
  Width = 626
  Height = 394
  TabOrder = 0
  inline Fm_CardapioMT: TFm_CardapioMT
    Left = 0
    Top = 0
    Width = 626
    Height = 394
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 626
    ExplicitHeight = 394
    inherited Pg_Geral: TPageControl
      Width = 626
      Height = 394
      ActivePage = Fm_CardapioMT.tbs_SAbor
      OnChange = Fm_CardapioMTPg_GeralChange
      ExplicitWidth = 626
      ExplicitHeight = 394
      inherited tbs_SAbor: TTabSheet
        ExplicitWidth = 618
        ExplicitHeight = 360
        inherited Pnl_GrupoSubgrupo: TPanel
          StyleElements = [seFont, seClient, seBorder]
          inherited Label1: TLabel
            Width = 109
            StyleElements = [seFont, seClient, seBorder]
          end
        end
      end
    end
  end
end
