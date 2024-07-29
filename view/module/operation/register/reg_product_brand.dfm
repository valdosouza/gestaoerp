inherited RegProductBrand: TRegProductBrand
  Caption = 'Cadastro de Marca de Produto'
  ClientHeight = 185
  ClientWidth = 615
  ExplicitWidth = 627
  ExplicitHeight = 248
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 121
    Width = 615
    ExplicitTop = 112
    ExplicitWidth = 609
    inherited SB_Inserir: TSpeedButton
      Left = 17
      Width = 87
      ExplicitLeft = 2
      ExplicitTop = 5
      ExplicitWidth = 87
    end
    inherited SB_Alterar: TSpeedButton
      Left = 106
      ExplicitLeft = 106
    end
    inherited SB_Excluir: TSpeedButton
      Left = 210
      ExplicitLeft = 210
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 418
      ExplicitLeft = 418
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 522
      Width = 88
      ExplicitLeft = 508
      ExplicitTop = 5
      ExplicitWidth = 88
    end
    inherited SB_Gravar: TSpeedButton
      Left = 314
      ExplicitLeft = 314
    end
  end
  inherited pnl_fundo: TPanel
    Width = 615
    Height = 121
    ExplicitWidth = 609
    ExplicitHeight = 112
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 615
    Height = 121
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    ExplicitWidth = 609
    ExplicitHeight = 112
    object L_Codigo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
      FocusControl = E_Codigo
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Descricao: TLabel
      Left = 57
      Top = 8
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      FocusControl = E_Descricao
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_Fornecedor: TLabel
      Left = 8
      Top = 48
      Width = 81
      Height = 14
      Caption = 'Nome da F'#225'brica'
      FocusControl = DBLCB_Fornecedor
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Fornecedor: TSpeedButton
      Left = 550
      Top = 61
      Width = 21
      Height = 21
      Caption = '...'
    end
    object Sb_Pesq_Cliente: TSpeedButton
      Left = 573
      Top = 60
      Width = 23
      Height = 22
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
    end
    object E_Codigo: TEdit
      Left = 8
      Top = 24
      Width = 49
      Height = 22
      Color = clScrollBar
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object E_Descricao: TEdit
      Left = 58
      Top = 24
      Width = 537
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DBLCB_Fornecedor: TComboBox
      Left = 8
      Top = 62
      Width = 541
      Height = 21
      TabOrder = 2
    end
  end
end
