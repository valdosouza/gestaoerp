object Fm_ListaUnidades: TFm_ListaUnidades
  Left = 0
  Top = 0
  Width = 243
  Height = 38
  TabOrder = 0
  object Label19: TLabel
    Left = 3
    Top = 0
    Width = 39
    Height = 14
    Caption = 'Unidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Sb_Medida: TSpeedButton
    Left = 215
    Top = 14
    Width = 23
    Height = 22
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_MedidaClick
  end
  object DBLCB_Medida: TDBLookupComboBox
    Left = 3
    Top = 14
    Width = 206
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyField = 'MED_CODIGO'
    ListField = 'MED_ABREVIATURA'
    ListSource = DM_ListaConsultas.Ds_ListaMedida
    ParentFont = False
    TabOrder = 0
  end
end
