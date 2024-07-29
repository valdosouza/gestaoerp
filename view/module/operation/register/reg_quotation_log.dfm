inherited RegQuotationLog: TRegQuotationLog
  Caption = 'Log de Or'#231'amento '
  ClientHeight = 572
  ClientWidth = 742
  ExplicitWidth = 754
  ExplicitHeight = 635
  TextHeight = 13
  object Label12: TLabel [0]
    Left = 0
    Top = 241
    Width = 742
    Height = 20
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Detalhes do Or'#231'amento'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    ExplicitTop = 252
  end
  object GroupBox1: TGroupBox [1]
    Left = 0
    Top = 0
    Width = 742
    Height = 77
    Align = alTop
    Caption = ' Digite sua op'#231#227'o de busca '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 736
    object L_Orcamento: TLabel
      Left = 175
      Top = 16
      Width = 37
      Height = 14
      Caption = 'N'#250'mero'
      FocusControl = E_Orcamento
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object L_BuscaFantasia: TLabel
      Left = 247
      Top = 16
      Width = 27
      Height = 14
      Caption = 'Nome'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object RG_Situacao: TRadioGroup
      Left = 532
      Top = 10
      Width = 205
      Height = 43
      Caption = 'Situa'#231#227'o do Documento'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Excluidos'
        'Ativos'
        'Todos')
      TabOrder = 5
    end
    object E_Orcamento: TMaskEdit
      Left = 170
      Top = 31
      Width = 71
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = ''
    end
    object E_Data_Ini: TDateTimePicker
      Left = 4
      Top = 31
      Width = 81
      Height = 22
      Date = 39580.000000000000000000
      Time = 0.356281493062852000
      Checked = False
      TabOrder = 1
    end
    object E_Data_Fim: TDateTimePicker
      Left = 86
      Top = 31
      Width = 81
      Height = 22
      Date = 39580.000000000000000000
      Time = 0.356281493062852000
      Checked = False
      TabOrder = 2
    end
    object ChBx_Periodo: TCheckBox
      Left = 7
      Top = 16
      Width = 128
      Height = 12
      Caption = 'Data Inicial    Data Final'
      TabOrder = 0
    end
    object ChBx_Bloqueados: TCheckBox
      Left = 537
      Top = 59
      Width = 128
      Height = 12
      Caption = 'Somente Bloqueados'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object E_BuscaFantasia: TMaskEdit
      Left = 244
      Top = 31
      Width = 285
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = ''
    end
  end
  object DBG_Pesquisa: TDBGrid [2]
    Left = 0
    Top = 77
    Width = 742
    Height = 164
    Align = alTop
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CTC_NUMERO'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FPT_DESCRICAO'
        Title.Caption = 'Tipo Cobran'#231'a'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 123
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTC_DATA'
        Title.Caption = 'Data'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTC_FANTASIA'
        Title.Caption = 'Cliente'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 428
        Visible = True
      end>
  end
  object DBG_Itens: TDBGrid [3]
    Left = 0
    Top = 261
    Width = 742
    Height = 247
    TabStop = False
    Align = alClient
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgAlwaysShowSelection, dgTitleClick]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PRO_CODIGOFAB'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ICT_DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 304
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ICT_QTDE'
        Title.Caption = 'Quantidade'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ICT_VL_UNIT'
        Title.Caption = 'Valor Unit'#225'rio'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 77
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ICT_VL_SUBTOTAL'
        Title.Caption = 'SubTotal'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clNavy
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 123
        Visible = True
      end>
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 508
    Width = 742
    Height = 64
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    ExplicitTop = 499
    ExplicitWidth = 736
    object SB_Buscar: TSpeedButton
      AlignWithMargins = True
      Left = 537
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Buscar - F7'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE7E7E7ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF0F0F09F9F9F9696969D9D9DF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFB0AEB0CECDCE9D9C9DA5A5A5ADADADF9F9F9FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFBBB4B8F9F5F8B5B4B59C9B9C999999C3C3C3FEFEFEFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFEDEBECBDB1B5FAF5F8A09FA0A9A9A98F8F8FD9D9D9FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDEDADCC4B8BBF3EFF2939292AEAEAE919191EAEAEAFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFCAC5C8D2C8CAE3E0E28D8C8CA7A7A7A8A8A8F9F9F9FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFDFDFDBEB7B9DFD6D9C6C3C4989798939393C8C8C8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF9F9F9B8AFB2E5DDDFB0AEAFA0A0A08C8B8BE2E2
        E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3B8ADB1E3DCDFA19FA09C9C9C9A9A
        9AF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEDEEB9AFB2DBD4D69B9A9A8C8C
        8CBBBBBBFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFBFBFBFBFBFBFDFDFDFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEAEBC1B7B8CDC8C99796
        96828282D3D3D3F5F5F5E8E8E8C4C4C4A9A9A99E9E9FA5A5A5BBBBBBD5D5D5EC
        ECECFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEBECC5BBBDBFBB
        BB8E8E8E83838389898A80808398989BADACACB5B5B3ACACAC94949773747587
        8787C8C8C8F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E1E2D2D0
        D0C3C3C48D8D90BCBBBCF0EFECF9F8F6FCFCF9FEFDFBFDFCFAFBF9F8F0F0EEB5
        B6B6717173A9A9A9ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9696
        99B7B6B9E4E3E0FBF9F6FDFAF7FEFBF8FFFCF9FFFDFBFFFCFAFEFBF9FDF8F7FD
        F8F7ECEBE8868688969696EEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDCDCEA1A0
        A2EDEBE7FCF8F4FBF6F1FCF7F1FDF9F4FEFAF5FEFAF6FEFAF5FDF9F5FCF9F5FC
        F5F3FCF1F3F6F2F0898A8CA6A6A6FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7929295EAE7
        E1FBF6F0FAF3EBFBF4EDFDF7F1FDF7F1FDF8F2FDF8F2FDF8F2FDF8F3FCF8F2FB
        F8F3FBF3F1FCEEF0EFEDEB757577D4D4D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFB1C7C5C1F9F2
        EBFAF1E7FAF1E8FCF5EDFDF6EEFDF6EEFDF6EFFDF6EFFDF6EFFDF7F0FCF6F0FC
        F6F0FBF7F1FBF0EEFCEEEFC6C7C58E8E8FFDFDFDFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE98979AE3DED6FBF1
        E7F9EFE3FBF1E6FCF5ECFDF4ECFDF5ECFDF5EBFDF5ECFDF5ECFDF5EDFDF5EDFC
        F5EEFCF5EEFBF5EFFCE9EBF2EBEA7B7C7DEBEBEBFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E7E8A1A0A0EDE5DAFBEF
        E1FAEDDFFCF2E8FCF4EAFDF4E9FDF3E9FDF3E9FDF4E9FDF4EAFDF4EBFDF4EBFD
        F5ECFCF4ECFBF5EDFCEDEAFAECEC999A9AD2D2D2FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCDCDCDAAA6A4F0E5D8FAEC
        DCFAECDDFCF3E8FDF2E7FEF2E7FEF3E7FEF2E7FEF2E7FEF3E8FEF3E9FDF4E9FD
        F4EAFCF4EAFBF4ECFCEFEAFCEAEAB6B6B5BCBCBCFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1C1C1A7A39FF0E2D3FAEA
        D8FAECDDFDF2E8FDF2E6FEF1E5FEF1E5FEF2E4FEF1E5FEF1E5FEF2E6FEF2E7FD
        F2E8FCF3E9FCF4EAFCF0E9FDE8E7C1BFBFB8B8B9FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFE09D9995E9D9C8FBE8
        D4FBE9D5FCEDDCFEEFE0FEF0E2FEF1E3FEF1E4FEF1E4FEF1E5FEF1E6FEF2E6FE
        F2E7FDF2E7FCF2E7FCEEE4FCE6E1BDBBBAC4C5C5FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F69D9B97D5C5B4FDE8
        D1FAE7D1FCE7D0FCE5CDFDE6CDFEE6CEFEE7D0FEE7D1FEE8D3FEE9D5FDEAD6FD
        EBD8FCECDAFBEDDEFCEADEFBE6E0A9A9A9E5E5E5FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEBAB9B9B0A292F7E0
        C9FDEBD8FDF0E4FDEEDDFDECDAFEEAD7FEEAD5FEEAD6FEEAD7FEECD9FEEDDCFE
        EFE0FDF1E3FCF2E7FEEAE2F2E5DE99999BFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E590877BDDC8
        B0FEEAD4FDF0E3FDEFE0FEEFDFFEEFDFFEEFDFFEEFE0FEEFE0FEEFE1FDF0E2FD
        F0E3FDF1E4FDF0E3FEE7DCD5CFCAB5B6B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCBAB7B5A894
        80ECD5BEFFF2E3FDEEDEFDEDDDFEEDDDFEEEDCFEEEDDFEEEDEFEEEDFFDEFE0FD
        EFE1FDF1E3FFEBDDEEDBD0A0A0A0F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E09990
        88B29B84ECDBCBFFF0E0FFEFDEFFEEDCFEEDDCFEEDDCFEEDDDFDEEDEFEF0E0FF
        F1E3FFECDBEAD4C5B1ADADD2D2D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEB
        ECA79C93A99685D7C7BAF4E3D2FFEDDBFFEFDDFFEFDEFFEFDFFFF0E0FFEEDCF5
        DECBD4C1B2AEAAA8C4C4C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFD9D9D9A9A4A1A6988CB1A091C9B6A4DAC7B5E3CFBCE1CEBBD8C4B1C8B4A3B5
        AAA0A5A4A4D5D5D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFF0F0F0BDBDBDB0ADA9ADA59CAA9F94A99D93ACA298ABA59FA9A8A8BE
        BEBFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFE5E5E6D4D4D4CECECED7D7D7EAEAEBFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphTop
      ParentFont = False
      ExplicitTop = 4
    end
    object SB_Sair: TSpeedButton
      AlignWithMargins = True
      Left = 639
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Sair - ESC'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C30E0000C30E00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000020300000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000002E4800528000466C003B5C00324F00273D001E2F001520000D1400
        060A000102000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000131D0019280018260018
        26001826004F7B0267A60466A60367A40266A100649D006299005E9300598B00
        5382004C7600446A00395A00324D002032000102000000000000000000000000
        0000000000000000000000000000000000000019270060970061990060980060
        98006098005E930B66AD1C76CB1C7AC91A78C61876C31473BE1270B90E6EB60C
        6CB1096AAE0769AA0468A60267A500649E001725000000000000000000000000
        00000000000000000000000000000000000000314D00649E0D4571103F681040
        69103E670452820E6DB42382D22487D32588D32485D32284D32284D22182D220
        80D11F7FD01D7CCD1B7ACB1772C60767AC002233000000000000000000000000
        000000000000000000000000000000000000002F4A01619A123C6414375D1438
        5E14365C0550801173B9288AD7298FD7278DD6288ED6288DD5268CD5258BD425
        8AD42489D32387D22287D21F7FD10B6CB1002337000000000000000000000000
        000000000000000000000000000000000000002E49016199113C6513385F1339
        6013385E0352831576BD2B8FD92A92D8268DD62C93D92B93D9288FD7258CD529
        90D82890D7268DD5258CD52488D50E71B800273C000000000000000000000000
        000000000000000000000000000000000000004065015F96123C6313385F1339
        6013395F035486197AC12E92DC2C93D9288FD72F96DB2E95DB2B91D8278DD62C
        93D92B93D9278ED6268DD6288CD71175BB002A43000000000000000000000000
        000000000000000000000000000000000000004771045A901339601339601339
        601339600256891C7DC53195DD2D94DB2A91D83299DD3197DC2C93D92990D72F
        96DB2E95DB2990D8288FD72B8FDA1276BD002F4A000000000000000000000000
        00000000000000000000000000000000000000456D04598F13385F1339601339
        5F12396002588C1F81C93599DF2F97DD2D95DC359DE0349ADE2E95DB2A91D832
        99DD3197DC2C93D92A90D72E92DC167AC3003351000000000000000000000000
        000000000000000000000000000000000405004F7E05578E1439601339601338
        5F113B62025A8F2485CD399EE33196D72C8BC9379ADA379FE33198DD2C93D935
        9CDF349ADE2F96DB2B92D93196DE1A7DC7003757000000000000000000000000
        00000000000000000000000000000000070C005A8B044767122C53133A621338
        5F113C63035C922A8CD43594D41B639F134F86205C86348FC8349CE12E95DA38
        9FE1379EE03299DD2D94DA359AE01C80C8003A5C000000000000000000000000
        00000000000000000000000000000000050E005B79056F14052C210F28501439
        61103D65045F952C8DD31B68AF1267B31570BE0E519122608A3499DA3097DD3C
        A2E33AA1E2359CDF2D94DA389DE21F84CC003F63000000000000000000000000
        00000000000000000000000000000000020300403D30A63D319E3A0033160D22
        47103C6606649C2781C81265B01C84D01D87D3136EBC1A55883493CE329ADF3F
        A5E53DA3E4389FE12F96DB3AA0E32489D100436A000000000000000000000000
        000000000000000000002100055407157E1B2A993257C46977DC8E42AE4D0343
        100529480867A22681C92270B659A6DE5BA8DF3180C3195D96389AD7349BDF42
        A8E73FA6E53CA2E33097DB3EA4E6278CD3004670000000000000000000000000
        000000000E000461061EA92939C54B4DCE625CD17165D27C70D38683DE9B5CC0
        650C61330663A03193DC387CBAB8D2E8C6DDF15286B92A82BD3DA4E5349BDF45
        ABE943A9E73FA6E53098DC41A7E72B8FD5004A75000000000000000000000000
        000B0006740922BD3235C4493FC4524AC75F57CB6C63CF796FD3857AD69194E7
        A85AB68F03649F3EA1E63F9FDF4388C34F8EC53B92CF49B0EC3EA5E5369DDF48
        AEEB45ACE942AAE83298DD44A9E93095DA014F7E000102000000000000000200
        02620418B92827BF3A33C24741C8554ECC615BD06D66D17C6FD38582DD9A71D0
        7A197A4F0968A840A3E74DB4EF2F99DE40AAE94CB4F04CB3EE3FA6E5379EE04B
        B1ED48AFEB47ADEA349ADE46ABEB3499DF025484000305000000000000002800
        0BA3151EC03227BF3826B63422A52C1C922B1E8E374BB95C7ADD9258C2640F64
        220340600F6FAE44A7EA4BB2EF2F99DF45AFEE49B3F049B3F03BA6E7319DE346
        B2F043AFEF41AEEE2A97DF40ACEE379CE0035788000508000000000000015A02
        12BA2214B022097A0D004400001E00003143005C7834A64246B54E0755281030
        580943741274B045AAEE53B5ED45A0D960B8E866BBE96ABDE864B3E062AFDB79
        C2E57BC1E27CC0E273B4D575BBE13CA0E4045B8F00060B000000000000036907
        0AA413004100000500000000000000002E5200678A0C7F170A4C351233611537
        5F0746731277B654B0ECDEDDCEFEF6D8FFF6DDFCF2DDFFF3DDFFF3DEFDEFDFFD
        EEE0FDEDE1FFF1E2FCEDE3FFE9D15CACE0025F9800080D000000000000016402
        00480000000000000000000000000000446C025F910E40541335621339611437
        5D064876127BBC79C1E6DDCCD9736CF1655EEF7A75F1ADA9F5CDC9F7706CF257
        52F1726DF3E3E1FC706CF5FFF5E76CB4E002619C000B12000000000000005800
        001200000000000000000000000000004670045A911437631339601339601437
        5D044978177EC086CBE8AFA6E13F3BF3B1AEFAC3C1FB4E47F14942F1BBB9FA75
        70F4A09DF7E8E8FD5B57F4FFF8EC73B9E20365A2000E17000000000000001400
        00030000000000000000000000000000466F04598E13385F1339601339601437
        5E034B7A1A83C68CCEEAB7ADE3403BF28783F5EFEFFE847FF5352EEEFFFFFF81
        7CF5B2B0F8F2F3FE5C58F6FEF6EA7CBEE3076CAB00101B000000000000000000
        00000000000000000000000000000000476F05588D14385E1339601339601338
        5E024E7E1D88CB92D1E9B8ADE33E38F29592F7E9E9FD645FF33028EEDAD8FC77
        71F4938FF6B4B1FB5750D3C0B3A46AB2DF0D73B100121E000000000000000000
        00000000000000000000000000000000476F05588D14385E1339601339601339
        5F005182228CCF9BD6E9B8ADE52D26F16A65F3807CF56D69F4AEACF96B67F460
        5BF3706BF5726DF3DCC3C9BAD1D54DB6F61375B1001725000000000000000000
        00000000000000000000000000000000477008538614375D13396013395F1339
        600053862691D49CD0E7E9DEE7AFADF9BDBAF8D2CFF9F0EDFBFFFFFBF2EEF8FD
        F8F7FFFEF6FFFFF0EDE0D166C0F14FB8F7187BB9001B2C000000000000000000
        0000000000000000000000000000000047700A4F8015355A14375D14375C1338
        5E0055892995D99DCAE2FFF3D5FFFFEAFFFFE6FFFAE2FFF5E0FFF0DDFFEFDBFB
        EBD9F2E8D9E7E3D691C5E24DBAF950B4F6197DBF001F32000000000000000000
        000000000000000000000000000000004974055D950A4F80095081094F810950
        81005A902F95D96CBDEECDD6D2C5D7DBB3D3E0A5CFE493CAE784C5EA75C0ED64
        B9ED58B3ED4BACEA41A5E73D9FDF3193D70E74B600253B000000000000000000
        0000000000000000000000000000000033510049740047700047700047700049
        73005C923091D744AAF13FA8EC38A2E52F98DD2791D6218ACE1982C5157DBF0F
        75B60A70B0066BA903659F00619A00588C00588B001825000000000000000000
        0000000000000000000000000000000000000000000000000000000000000004
        06005D92086EAC0B6EAB0569A502649E006099005A90005486004E7C00426A00
        3F65002E4A002C46001C2C001725000B11000609000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000005
        0800426800476F003656002F4A00223600192700121C00070B00030500000000
        0000000000000000000000000000000000000000000000000000}
      Layout = blGlyphTop
      ParentFont = False
      ExplicitLeft = 636
      ExplicitTop = 5
      ExplicitHeight = 54
    end
    object SB_Retonar: TSpeedButton
      AlignWithMargins = True
      Left = 435
      Top = 3
      Width = 100
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Retornar - F5'
      Enabled = False
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphTop
      Margin = 15
      NumGlyphs = 2
      ParentFont = False
      ExplicitLeft = 436
      ExplicitTop = 5
      ExplicitHeight = 54
    end
    object Sb_Desbloqueia: TSpeedButton
      AlignWithMargins = True
      Left = 320
      Top = 3
      Width = 113
      Height = 58
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'Desbloquear Or'#231'amento'
      Enabled = False
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
      Margin = 15
      NumGlyphs = 2
      ParentFont = False
      ExplicitTop = 4
    end
  end
end
