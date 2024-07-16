inherited RegUsers: TRegUsers
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 475
  ClientWidth = 621
  ExplicitWidth = 633
  ExplicitHeight = 538
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 411
    Width = 621
    ExplicitTop = 402
    ExplicitWidth = 615
    inherited SB_Inserir: TSpeedButton
      Left = -6
      ExplicitLeft = -6
    end
    inherited SB_Alterar: TSpeedButton
      Left = 98
      ExplicitLeft = 98
    end
    inherited SB_Excluir: TSpeedButton
      Left = 202
      ExplicitLeft = 202
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 410
      ExplicitLeft = 410
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 514
      ExplicitLeft = 514
    end
    inherited SB_Gravar: TSpeedButton
      Left = 306
      ExplicitLeft = 306
    end
  end
  inherited pnl_fundo: TPanel
    Width = 621
    Height = 411
    ExplicitWidth = 615
    ExplicitHeight = 402
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 617
      Height = 105
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 611
      object Label4: TLabel
        Left = 120
        Top = 50
        Width = 31
        Height = 14
        Caption = 'Senha'
        FocusControl = E_Senha
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 7
        Top = 6
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
      object Label10: TLabel
        Left = 62
        Top = 6
        Width = 27
        Height = 14
        Caption = 'Nome'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 196
        Top = 50
        Width = 78
        Height = 14
        Caption = 'Nivel de Acesso'
        FocusControl = E_Senha
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object sb_reseta: TSpeedButton
        Left = 361
        Top = 69
        Width = 91
        Height = 22
        Caption = 'Resetar Senha'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
      end
      object sb_permissao: TSpeedButton
        Left = 502
        Top = 49
        Width = 88
        Height = 47
        Caption = 'Permiss'#245'es - F8'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          5000555555555555577755555555555550B0555555555555F7F7555555555550
          00B05555555555577757555555555550B3B05555555555F7F557555555555000
          3B0555555555577755755555555500B3B0555555555577555755555555550B3B
          055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
          555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
          55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
          555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
          55555575FFFF7755555555570000755555555557777775555555}
        Layout = blGlyphTop
        NumGlyphs = 2
        ParentFont = False
      end
      object Label1: TLabel
        Left = 359
        Top = 49
        Width = 83
        Height = 14
        Caption = 'Resetar p/ 12345'
        FocusControl = E_Senha
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_Nome: TEdit
        Left = 60
        Top = 20
        Width = 530
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
      object E_Login: TEdit
        Left = 9
        Top = 66
        Width = 109
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_Senha: TEdit
        Left = 121
        Top = 66
        Width = 77
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 3
      end
      object E_Codigo: TEdit
        Left = 9
        Top = 20
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
      object CB_Nivel: TComboBox
        Left = 196
        Top = 66
        Width = 159
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'Usu'#225'rio'
        Items.Strings = (
          'Usu'#225'rio'
          'Administrador')
      end
      object DBChBx_Ativo: TCheckBox
        Left = 9
        Top = 50
        Width = 97
        Height = 12
        Caption = 'Usu'#225'rio Ativo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
    end
    object pnl_auth_card: TPanel
      Left = 2
      Top = 107
      Width = 617
      Height = 47
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitWidth = 611
      object Label15: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 2
        Width = 607
        Height = 14
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Informe o n'#250'mero do cart'#227'o para ser utilizado na autoriza'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 294
      end
      object E_Auth_card: TEdit
        AlignWithMargins = True
        Left = 5
        Top = 19
        Width = 607
        Height = 22
        Align = alTop
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 0
        ExplicitWidth = 601
      end
    end
    object RegUsers: TGroupBox
      Left = 2
      Top = 154
      Width = 617
      Height = 255
      Align = alClient
      Caption = 'Configura'#231#245'es para Envio de e-mail'
      TabOrder = 2
      ExplicitWidth = 611
      ExplicitHeight = 246
      object Label5: TLabel
        Left = 7
        Top = 19
        Width = 3
        Height = 14
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 3
        Top = 128
        Width = 28
        Height = 14
        Caption = 'e-mail'
        FocusControl = E_lgn_email
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 5
        Top = 165
        Width = 31
        Height = 14
        Caption = 'Senha'
        FocusControl = E_pwd_email
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 5
        Top = 92
        Width = 201
        Height = 14
        Caption = 'Usu'#225'rio (Quando Requerido pelo Servidor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 5
        Top = 55
        Width = 189
        Height = 14
        Caption = 'Nome que aparecer'#225' no t'#237'tulo do emails'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 306
        Top = 17
        Width = 25
        Height = 14
        Caption = 'Porta'
        FocusControl = E_pwd_email
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 5
        Top = 17
        Width = 126
        Height = 14
        Caption = 'Servidor de sa'#237'da (SMTP);'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 367
        Top = 19
        Width = 130
        Height = 14
        Caption = 'Configura'#231#245'es do Servidor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 309
        Top = 77
        Width = 53
        Height = 14
        Caption = 'Assinatura'
        FocusControl = E_pwd_email
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object SpeedButton1: TSpeedButton
        Left = 212
        Top = 179
        Width = 91
        Height = 24
        Caption = 'Testar e-mail'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
      end
      object E_Srv_Smtp: TEdit
        Left = 3
        Top = 31
        Width = 300
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object E_lgn_email: TEdit
        Left = 3
        Top = 142
        Width = 300
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object E_pwd_email: TEdit
        Left = 3
        Top = 178
        Width = 119
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 7
      end
      object E_Usr_Mail: TEdit
        Left = 3
        Top = 106
        Width = 300
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object E_Lbl_Name: TEdit
        Left = 3
        Top = 69
        Width = 300
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object E_porta_email: TEdit
        Left = 304
        Top = 31
        Width = 57
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Cbx_Req_Autenticacao: TCheckBox
        Left = 367
        Top = 39
        Width = 168
        Height = 14
        Caption = 'Requer Autentica'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object Cbx_Req_Con_ssl: TCheckBox
        Left = 367
        Top = 59
        Width = 223
        Height = 14
        Caption = 'Requer uma conex'#227'o de seguran'#231'a (SSL)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object DBMemo1: TMemo
        Left = 309
        Top = 97
        Width = 279
        Height = 133
        TabOrder = 8
      end
      object chbx_notifica_login: TCheckBox
        Left = 2
        Top = 236
        Width = 613
        Height = 17
        Align = alBottom
        Caption = 'Quero receber notifica'#231#227'o de tentativas ou login efetuado'
        TabOrder = 9
        ExplicitTop = 227
        ExplicitWidth = 607
      end
    end
  end
  inherited Menu: TMainMenu
    Left = 80
  end
end
