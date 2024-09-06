object Fm_ListaPet: TFm_ListaPet
  Left = 0
  Top = 0
  Width = 431
  Height = 39
  TabOrder = 0
  object Label19: TLabel
    Left = 0
    Top = 0
    Width = 431
    Height = 14
    Align = alTop
    Caption = 'Nome do Pet'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 60
  end
  object Sb_Cadastro: TSpeedButton
    AlignWithMargins = True
    Left = 380
    Top = 14
    Width = 23
    Height = 22
    Margins.Left = 1
    Margins.Top = 0
    Margins.Right = 1
    Align = alRight
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    NumGlyphs = 2
    ParentFont = False
    OnClick = Sb_CadastroClick
    ExplicitLeft = 661
    ExplicitHeight = 223
  end
  object Sb_Pesquisa: TSpeedButton
    AlignWithMargins = True
    Left = 405
    Top = 14
    Width = 23
    Height = 22
    Margins.Left = 1
    Margins.Top = 0
    Align = alRight
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      E6010000424DE60100000000000036000000280000000C0000000C0000000100
      180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF285A9F626F8DFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2963AC7EE3FA18
      79DEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF296CBA7FE3FA
      177FE4C9D5E9FFFFFFFFFFFFFFFFFFF7F6F7E6E5E6FFFFFFFFFFFF447DC57EE3
      FA177FE4C9D8ECFFFFFFFFFFFFEFEEEF66574AFBDCACFFEECDC0C8A6483C489C
      A1B62372CBC9DBF1FFFFFFFFFFFFFFFFFF8D734FF5BC91FFD8B6FFEED2FFF9E0
      FFFEF0463C49FFFFFFFFFFFFFFFFFFFFFFFF8F8792E1A87DDDA479FFD7B5FFED
      D4FFF7E1FFFDEDCCD6C0FFFFFFFFFFFFFFFFFFFFFFFF7C6A78DAA176DAA176FD
      C498FFEFE0FFEED6FFF4DAFFF2CFD6D5D8FFFFFFFFFFFFFFFFFF827788D0976C
      FFE1CBFFF9F5FFCBA3FFE4CBFFE7CDFFECC2F1F1F2FFFFFFFFFFFFFFFFFFDFDC
      E0BF8656FCC398FFE5D2FBC297ECB388FFC99E8C8171FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF9C929FBF8857D69D72DBA277EAB186AB976FE9E8EBFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFE4E0E49D91A0A1939DA69FABFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF}
    ParentFont = False
    OnClick = Sb_PesquisaClick
    ExplicitLeft = 701
    ExplicitTop = 17
    ExplicitHeight = 223
  end
  object Dblcb_Lista: TDBLookupComboBox
    Left = 0
    Top = 14
    Width = 377
    Height = 21
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'ID'
    ListField = 'NAME'
    ListSource = DS_Lista
    ParentFont = False
    TabOrder = 0
    OnKeyDown = Dblcb_ListaKeyDown
  end
  object Qr_Lista: TSTQuery
    Connection = DM.IBD_Gestao
    Transaction = IBT_Lista
    SQL.Strings = (
      'Select *'
      'from tb_pet')
    ForcedRefresh = True
    Left = 41
    Top = 36
  end
  object DS_Lista: TDataSource
    DataSet = Qr_Lista
    Left = 129
    Top = 32
  end
  object IBT_Lista: TSTTransaction
    Left = 12
    Top = 37
  end
end
