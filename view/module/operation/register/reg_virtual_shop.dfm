inherited RegVirtualShop: TRegVirtualShop
  Caption = 'Loja Virtual'
  ClientHeight = 487
  ClientWidth = 602
  ExplicitWidth = 608
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 487
    Width = 602
    Height = 0
    ExplicitTop = 487
    ExplicitWidth = 602
    ExplicitHeight = 0
    inherited SB_Inserir: TSpeedButton
      Left = 79
      Height = -2
      ExplicitLeft = 47
      ExplicitTop = 45
      ExplicitHeight = -2
    end
    inherited SB_Alterar: TSpeedButton
      Left = 183
      Height = -2
      ExplicitLeft = 127
      ExplicitTop = 21
      ExplicitHeight = -2
    end
    inherited SB_Excluir: TSpeedButton
      Left = -25
      Height = -2
      Enabled = False
      ExplicitLeft = -51
      ExplicitHeight = -2
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 391
      Height = -2
      ExplicitLeft = 397
      ExplicitHeight = -2
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 495
      Height = -2
      ExplicitLeft = 501
      ExplicitHeight = -2
    end
    inherited SB_Gravar: TSpeedButton
      Left = 287
      Height = -2
      ExplicitLeft = 293
      ExplicitHeight = -2
    end
  end
  inherited pnl_fundo: TPanel
    Width = 602
    Height = 487
    ExplicitWidth = 602
    ExplicitHeight = 487
    object Pnl_Edicao: TPanel
      Left = 2
      Top = 2
      Width = 598
      Height = 483
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      object Label54: TLabel
        Left = 5
        Top = 4
        Width = 121
        Height = 13
        Caption = 'WebServices dispon'#237'veis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label55: TLabel
        Left = 4
        Top = 41
        Width = 141
        Height = 13
        Caption = 'Caminho do WebService  - url'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label40: TLabel
        Left = 5
        Top = 155
        Width = 125
        Height = 13
        Caption = 'Nome da Tabela de Pre'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label37: TLabel
        Left = 5
        Top = 116
        Width = 100
        Height = 13
        Caption = 'Diret'#243'rio de Imagens '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 203
        Width = 175
        Height = 13
        Caption = 'ID - Identificador do Google Analytics'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 5
        Top = 79
        Width = 64
        Height = 13
        Caption = 'T'#237'tulo do Site'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 162
        Top = 4
        Width = 93
        Height = 13
        Caption = 'Site na WEb (www)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 4
        Top = 251
        Width = 349
        Height = 13
        Caption = 
          'e-mail para controlar o pagamento eletronico - BCash (www.bchas.' +
          'com.br)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Cb_TipoWebservice: TComboBox
        Left = 4
        Top = 18
        Width = 156
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        Items.Strings = (
          'VirtueMart'
          'Solu'#231#227'o Setes'
          'Gest'#227'o 2013'
          'TrayCommerce')
      end
      object E_Path_WebService: TEdit
        Left = 5
        Top = 54
        Width = 580
        Height = 22
        CharCase = ecLowerCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object E_Dir_Images: TEdit
        Left = 5
        Top = 131
        Width = 580
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object Chbx_Internet: TCheckBox
        Left = 4
        Top = 299
        Width = 481
        Height = 17
        Caption = 'Ativar Conex'#227'o com a Internet - Com'#233'cio Eletr'#244'nico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object chbx_Vitrine: TCheckBox
        Left = 4
        Top = 315
        Width = 481
        Height = 17
        Caption = 
          'Ativar apenas como uma vitrine para os produtos, mas sem efetuar' +
          ' venda pelo site'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object chbx_Dealer: TCheckBox
        Left = 4
        Top = 331
        Width = 481
        Height = 17
        Caption = 
          'Permiti a visualiza'#231#227'o de pre'#231'os e/ou compra apenas para revende' +
          'dores'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object E_Id_Google_analytics: TEdit
        Left = 5
        Top = 223
        Width = 580
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object E_Titulo_Site: TEdit
        Left = 5
        Top = 94
        Width = 580
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object gbProxy: TGroupBox
        Left = 2
        Top = 355
        Width = 594
        Height = 58
        Align = alBottom
        Caption = 'Proxy'
        TabOrder = 9
        object Label10: TLabel
          Left = 8
          Top = 12
          Width = 22
          Height = 13
          Caption = 'Host'
        end
        object Label11: TLabel
          Left = 279
          Top = 12
          Width = 26
          Height = 13
          Caption = 'Porta'
        end
        object Label14: TLabel
          Left = 331
          Top = 12
          Width = 36
          Height = 13
          Caption = 'Usu'#225'rio'
        end
        object Label19: TLabel
          Left = 472
          Top = 12
          Width = 30
          Height = 13
          Caption = 'Senha'
        end
        object E_Proxy_Path: TEdit
          Left = 6
          Top = 28
          Width = 266
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object E_Proxy_Porta: TEdit
          Left = 276
          Top = 28
          Width = 36
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object E_Proxy_User: TEdit
          Left = 315
          Top = 28
          Width = 121
          Height = 22
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object E_Proxy_Pws: TEdit
          Left = 439
          Top = 28
          Width = 142
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
      end
      object E_Site: TEdit
        Left = 163
        Top = 17
        Width = 422
        Height = 22
        CharCase = ecLowerCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object e_mail: TEdit
        Left = 2
        Top = 271
        Width = 580
        Height = 22
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object Panel1: TPanel
        Left = 2
        Top = 413
        Width = 594
        Height = 68
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 10
        DesignSize = (
          594
          68)
        object SpeedButton1: TSpeedButton
          Left = 289
          Top = 8
          Width = 93
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Gravar - F5'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_gravarClick
          ExplicitLeft = 307
        end
        object SpeedButton2: TSpeedButton
          Left = 388
          Top = 6
          Width = 93
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar - F6'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_CancelarClick
          ExplicitLeft = 400
        end
        object SpeedButton3: TSpeedButton
          Left = 475
          Top = 8
          Width = 93
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Sair- Esc'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = Sb_Sair_0Click
          ExplicitLeft = 493
        end
        object SpeedButton4: TSpeedButton
          Left = 204
          Top = 6
          Width = 90
          Height = 54
          Anchors = [akRight, akBottom]
          Caption = 'Alterar - F3'
          Flat = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Layout = blGlyphTop
          ParentFont = False
          OnClick = SB_alterarClick
          ExplicitLeft = 216
        end
      end
      object ComboBox1: TComboBox
        Left = 4
        Top = 175
        Width = 581
        Height = 21
        TabOrder = 12
      end
    end
  end
end
