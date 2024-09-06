object fm_ListaTributacao: Tfm_ListaTributacao
  Left = 0
  Top = 0
  Width = 606
  Height = 42
  TabOrder = 0
  object Label1: TLabel
    AlignWithMargins = True
    Left = 5
    Top = 0
    Width = 601
    Height = 14
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Regra de Tributa'#231#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 98
  end
  object Dblcb_Lista: TDBLookupComboBox
    AlignWithMargins = True
    Left = 3
    Top = 17
    Width = 600
    Height = 23
    Align = alTop
    KeyField = 'TRB_CODIGO'
    ListField = 'CFOP_COMPLETE'
    ListSource = Ds_Lista
    TabOrder = 0
    OnKeyDown = Dblcb_ListaKeyDown
  end
  object Qr_Lista: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = DM.IBT_Listas
    SQL.Strings = (
      
        'Select tb.trb_codigo, (nt.nat_cfop || '#39' - '#39' || nt.nat_descricao)' +
        ' CFOP_COMPLETE, nt.nat_cfop'
      'from tb_tributacao tb'
      '  inner join tb_natureza nt'
      '  on (nt.nat_codigo = tb.trb_codnat)'
      'where tb.trb_codigo is not null')
    ForcedRefresh = True
    Left = 87
    Top = 24
    object Qr_ListaTRB_CODIGO: TIntegerField
      FieldName = 'TRB_CODIGO'
      Origin = '"TB_TRIBUTACAO"."TRB_CODIGO"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object Ds_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 144
    Top = 24
  end
end
