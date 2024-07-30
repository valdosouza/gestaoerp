object Fm_ListaEmpresas: TFm_ListaEmpresas
  Left = 0
  Top = 0
  Width = 623
  Height = 45
  TabOrder = 0
  object SB_Empresas: TSpeedButton
    AlignWithMargins = True
    Left = 572
    Top = 20
    Width = 23
    Height = 22
    Margins.Right = 1
    Align = alRight
    Caption = '...'
    OnClick = SB_EmpresasClick
    ExplicitLeft = 422
    ExplicitTop = 16
  end
  object Sb_Pesq_Empresa: TSpeedButton
    AlignWithMargins = True
    Left = 597
    Top = 20
    Width = 23
    Height = 22
    Margins.Left = 1
    Align = alRight
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
    OnClick = Sb_Pesq_EmpresaClick
    ExplicitLeft = 447
    ExplicitTop = 16
  end
  object DBLCB_Empresa: TDBLookupComboBox
    AlignWithMargins = True
    Left = 72
    Top = 20
    Width = 494
    Height = 22
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    KeyField = 'EMP_CODIGO'
    ListField = 'EMP_NOME'
    ListSource = DM_ListaConsultas.Ds_ListaEmpresa
    ParentFont = False
    TabOrder = 0
    OnClick = DBLCB_EmpresaClick
    OnExit = DBLCB_EmpresaExit
    OnKeyDown = DBLCB_EmpresaKeyDown
  end
  object E_Cd_Empresa: TMaskEdit
    AlignWithMargins = True
    Left = 3
    Top = 20
    Width = 63
    Height = 22
    Align = alLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = ''
    OnExit = E_Cd_EmpresaExit
    OnKeyPress = E_Cd_EmpresaKeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 4
      Top = 3
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object ChBx_Nome: TCheckBox
      Left = 71
      Top = 1
      Width = 121
      Height = 17
      Caption = 'Nome/Raz'#227'o Social'
      Checked = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = ChBx_NomeClick
    end
    object ChBx_Fantasia: TCheckBox
      Left = 199
      Top = 1
      Width = 121
      Height = 17
      Caption = 'Apelido/Fantasia'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ChBx_FantasiaClick
    end
  end
end
