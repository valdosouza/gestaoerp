inherited Fm_ListaMultiEmpresa: TFm_ListaMultiEmpresa
  Width = 555
  Height = 47
  ExplicitWidth = 555
  ExplicitHeight = 47
  inherited L_Carteira: TLabel
    AlignWithMargins = True
    Left = 20
    Top = 3
    Width = 532
    Margins.Left = 20
    Caption = 'Selecionar todas as Empresas'
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 20
    ExplicitTop = 3
    ExplicitWidth = 147
  end
  inherited pnl_linha_1: TPanel
    Top = 20
    Width = 555
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 20
    ExplicitWidth = 555
    inherited Sb_Carteira: TSpeedButton
      Left = 531
      Visible = False
      ExplicitLeft = 531
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      Width = 531
      KeyField = 'EMP_CODIGO'
      ListField = 'EMP_FANTASIA'
      ListSource = Ds_Lista
      ExplicitWidth = 531
    end
  end
  object chbx_Empresas: TCheckBox [2]
    Left = 3
    Top = 3
    Width = 22
    Height = 14
    TabOrder = 1
    OnClick = chbx_EmpresasClick
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT'
      'EMP_CODIGO,'
      'EMP_NOME,'
      'EMP_FANTASIA,'
      'EMP_CODVDOR,'
      'EMP_DT_FUNDA,'
      'EMP_MULTIPLICADOR,'
      'EMP_CONSUMIDOR'
      'FROM TB_EMPRESA'
      'WHERE (EMP_ATIVA = '#39'S'#39') and (EMP_TIPO = '#39'0'#39')')
    Left = 41
  end
  inherited Ds_Lista: TDataSource
    Left = 89
  end
  inherited IBT_Lista: TSTTransaction
    Connection = DM.IBD_Gestao
    Left = 140
  end
end
