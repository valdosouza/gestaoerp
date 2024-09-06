object Fm_CardapioMT: TFm_CardapioMT
  Left = 0
  Top = 0
  Width = 625
  Height = 393
  TabOrder = 0
  object Pg_Geral: TPageControl
    Left = 0
    Top = 0
    Width = 625
    Height = 393
    ActivePage = tbs_Tamanho
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object tbs_SAbor: TTabSheet
      Caption = 'SABORES'
      OnShow = tbs_SAborShow
      object Pnl_GrupoSubgrupo: TPanel
        Left = 106
        Top = 72
        Width = 401
        Height = 134
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        Visible = False
        DesignSize = (
          401
          134)
        object Label1: TLabel
          Left = 2
          Top = 2
          Width = 397
          Height = 16
          Align = alTop
          Caption = 'Alterar o Subgrupo'
          Color = clNavy
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 109
        end
        object Sb_Confirma: TButton
          Left = 210
          Top = 97
          Width = 92
          Height = 29
          Anchors = [akRight, akBottom]
          Caption = 'Confirma'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = Sb_ConfirmaClick
        end
        object Sb_Cancela: TButton
          Left = 302
          Top = 97
          Width = 92
          Height = 29
          Anchors = [akRight, akBottom]
          Caption = 'Cancela'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = Sb_CancelaClick
        end
      end
    end
    object tbs_Tamanho: TTabSheet
      Caption = 'TAMANHOS'
      ImageIndex = 1
    end
  end
  object Qr_Tamanho: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      
        'SELECT distinct MED_CODIGO, MED_SEQUENCIA, MED_DESCRICAO, 0.000 ' +
        'PRO_VL_NORMAL, 0.000 PRO_VL_PROMOCAO'
      'FROM tb_medida')
    ForcedRefresh = True
    Left = 108
    Top = 46
  end
  object Qr_UpdateSubgrupo: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IB_Transacao
    SQL.Strings = (
      'Update tb_produto p set'
      'p.pro_codsbg =:new_Subgrupo'
      'where p.pro_descricao =:pro_descricao'
      'and p.PRO_CODGRP =:grp_codigo'
      'and p.PRO_CODSBG =:old_Subgrupo')
    ForcedRefresh = True
    Left = 172
    Top = 46
    ParamData = <
      item
        Name = 'new_Subgrupo'
      end
      item
        Name = 'pro_descricao'
      end
      item
        Name = 'grp_codigo'
      end
      item
        Name = 'old_Subgrupo'
      end>
  end
end
