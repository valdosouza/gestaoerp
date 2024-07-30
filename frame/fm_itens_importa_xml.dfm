object FmItensImportaXml: TFmItensImportaXml
  Left = 0
  Top = 0
  Width = 1606
  Height = 48
  TabOrder = 0
  DesignSize = (
    1606
    48)
  object E_Nr_ITem: TLabeledEdit
    Left = 1
    Top = 23
    Width = 38
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'N'#176' Item'
    TabOrder = 0
  end
  object E_Descricao_Produto: TLabeledEdit
    Left = 45
    Top = 23
    Width = 305
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 141
    EditLabel.Height = 13
    EditLabel.Caption = 'Descri'#231#227'o do Produto/Servi'#231'o'
    TabOrder = 1
  end
  object E_Unidade: TLabeledEdit
    Left = 353
    Top = 23
    Width = 50
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'Unidade'
    TabOrder = 2
  end
  object E_Quantidade: TLabeledEdit
    Left = 406
    Top = 23
    Width = 62
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Quantidade'
    TabOrder = 3
  end
  object E_ValorUnitario: TLabeledEdit
    Left = 470
    Top = 23
    Width = 74
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 64
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor Unit'#225'rio'
    TabOrder = 4
  end
  object E_ValorTotal: TLabeledEdit
    Left = 547
    Top = 23
    Width = 88
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor Total'
    TabOrder = 5
  end
  object E_Valor_Desconto: TLabeledEdit
    Left = 638
    Top = 23
    Width = 77
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = 'Valor Desconto'
    TabOrder = 6
  end
  object E_Cod_Item_Nota: TLabeledEdit
    Left = 718
    Top = 23
    Width = 74
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'd. Nota'
    TabOrder = 7
  end
  object E_Cod_Item_Interno: TLabeledEdit
    Left = 794
    Top = 23
    Width = 74
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'd Interno'
    TabOrder = 8
  end
  object E_Cod_Barras: TLabeledEdit
    Left = 870
    Top = 23
    Width = 104
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 67
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'digo Barras'
    TabOrder = 9
  end
  object E_Descricao_Vinculado: TLabeledEdit
    Left = 976
    Top = 23
    Width = 194
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 138
    EditLabel.Height = 13
    EditLabel.Caption = 'Vinculado ao Produto interno'
    TabOrder = 10
  end
  inline Fm_ListaEstoques: TFm_ListaEstoques
    Left = 1173
    Top = 8
    Width = 260
    Height = 36
    Anchors = [akLeft, akBottom]
    TabOrder = 11
    ExplicitLeft = 1173
    ExplicitTop = 8
    ExplicitWidth = 260
    inherited Label1: TLabel
      Width = 255
    end
    inherited Sb_Cadastro: TSpeedButton
      Left = 237
      ExplicitLeft = 234
      ExplicitHeight = 13
    end
    inherited Dblcb_Estoque: TDBLookupComboBox
      Left = 2
      Width = 225
      ExplicitLeft = 2
      ExplicitWidth = 225
    end
    inherited ChBx_Estoques: TCheckBox
      Left = 154
      Visible = False
      OnClick = nil
      ExplicitLeft = 154
    end
  end
  object e_NCM: TLabeledEdit
    Left = 1439
    Top = 23
    Width = 74
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'NCM'
    TabOrder = 12
  end
  object E_Origem: TLabeledEdit
    Left = 1519
    Top = 23
    Width = 43
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Origem'
    TabOrder = 13
  end
  object E_ST: TLabeledEdit
    Left = 1568
    Top = 23
    Width = 26
    Height = 21
    Anchors = [akLeft, akBottom]
    AutoSize = False
    EditLabel.Width = 20
    EditLabel.Height = 13
    EditLabel.Caption = 'S.T.'
    TabOrder = 14
  end
end
