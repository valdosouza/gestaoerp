object Fm_PizzariaMTP: TFm_PizzariaMTP
  Left = 0
  Top = 0
  Width = 644
  Height = 486
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 349
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object Lista: TListBox
      Left = 2
      Top = 2
      Width = 640
      Height = 345
      Align = alClient
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnDblClick = ListaDblClick
      OnKeyPress = ListaKeyPress
    end
  end
  object Pnl_Composicao: TPanel
    Left = 0
    Top = 349
    Width = 644
    Height = 137
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 4
      Top = 3
      Width = 139
      Height = 16
      Caption = 'Tamanhos Dispon'#237'veis'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 404
      Top = 42
      Width = 70
      Height = 16
      Caption = 'Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 515
      Top = 42
      Width = 77
      Height = 16
      Caption = 'Valor Unit'#225'io'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Sb_Limpa: TSpeedButton
      Left = 483
      Top = 94
      Width = 70
      Height = 38
      Caption = 'Limpa'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
        FEFDFDFDFDFDFDFCFCFCFCFCFCFDFDFDFDFDFDFEFEFEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCF6F6F6F2F2F2EFEFEFEDEDEDEBEB
        EBEAEAEAEAEAEAEAEAEAEBEBEBECECECEEEEEEEFEFEFF1F1F1F3F3F3F6F6F6F8
        F8F8FAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFF7F7F7F0F0F0EAEAEAE5E5E5E0E0E0DDDDDDD7DADB74BC
        CB1DA3BF0D9AB829A1BC169CBA3FBFD42EA7C2E4E5E5E8E8E8EBEBEBEDEDEDF0
        F0F0F3F3F3F6F6F6F9F9F9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFEFEFEF5F5F5EDEDEDE4E4E4DCDCDCD5D5D584C1CB0DA9C452CBDF86E7
        F369DDED4DD4E631BDD5159AB82CD1E67FE4F030A5BDE2E2E2E5E5E5E9E9E9EC
        ECECEFEFEFF2F2F2F5F5F5F9F9F9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFDFDFDF4F4F4EBEBEBE2E2E291CDD518B5CD8AEAF60DABC659D0E327CE
        E421D1E712CAE161D6E70D99B74BD3E62BD2E61EA5BFE1E1E1E5E5E5E8E8E8EB
        EBEBEEEEEEF2F2F2F5F5F5F8F8F8FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFBFBFBF3F3F31DBDD473DDED6DDFF058E6F686EAF60DABC552CF
        E328D5E91ACEE40EC5DE51CEE15FD3E50BCBE263D8E7C2D8DDE8E8E8EBEBEBEE
        EEEEF1F1F1F4F4F4F7F7F7FBFBFBFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF88E0EA39CEDF6DDFF14FD8EC5FE7F75BE5F55CD7E76ED8
        E82ED5EA23D2E814C9E13BCDE15CD2E40BCBE280E4F059B5C8F0F0F0F3F3F3F5
        F5F5F8F8F8FAFAFAFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF11C2D775E6F40EBFD586E8F555D9EE4DD8EC5BE7F76DE7F53AC5
        D935C9E02BD6EA1DCFE50FC5DE57D0E30BCBE25FDDEC0E97B6FBFBFBFDFDFDFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFDFF7FA29CBDFA0F4FE8FEFFA0EBFD48CE7F451D9ED61E8F856E5F581EA
        F66AD6E832D8EC26D3E817C9E112C4DC0BCBE238D5E70D97B6FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFF3FCFD21C9DC9AF4FE9DF3FC34CDE16DDFF150D9ED5EE8F752E3
        F47EE4F22CCCE32DD7EB1ECEE311C5DE0BCBE225D1E51BA2BFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE8F9FB35D1E38EF2FD9FF4FE8CECF854D9ED64E9F859E6
        F653E3F36DD7E835D9ED29D5E919C9E011CDE31BCEE421AAC5FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFB9EDF36AE3F27BF0FD99F3FE97EEF853DAEE61E9
        F854E4F53FD7EC36D6EB30D8EB21CFE518CFE524D0E514A3BFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF59D6E394F1FB72EFFD96F3FE7EE9F765E9
        F85CE7F750E3F428C3DD38DAED2BD6EA1FD2E73ED7E90DA1BEFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1AC6D9A0F4FE72EFFD72EFFD68E9
        F863EAF957E5F643DAED3FDDEF33D9EC27D4E965DFEE52BDD1FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12C2D69EF4FE72EFFD72EF
        FD6BECFB5FE8F853E4F438D3E83ADBEE26B3C34F7A92D9D5DDFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF17C4D89FF4FE6BEA
        FA71EEFC66EBFA38CBE341C1D04E718C67385FA178A567395DFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFF12C2D694F1
        FB89EEFA4D8AA3673B607A4F76A981AE9E73A067375E337D9DFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6C49
        6D957190C7AFC9C2A6C5885E8566365E4CAEC61DBED96CE1EF2EB7CEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9777
        91764D7167375E5B89A663EAF93ACFE54CE1F36BE5F35CDAE912AEC8FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFD5F4F891EFF95FDEF085EFFC78E1F060DBEA0EB6CE1D6E8EFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFC8F1F637D0E230CCDF0FC2D719ACD0117FC1117DC11D7DBA82A1B5FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFD4E1E9338AC21982C4157FC21881C31C6797EBF0F4FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF1D6B993090CD258AC92187C82F8ECA12547EFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF19649458A7D93594D03192CF2D8FCD3E95CE5C
        8AA8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFC1D6E461AAD8469FD7429CD63E9AD4409AD324
        71A1F8FAFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11649868B3E252A7DD4EA4DB4AA2D960
        ADDD1C6490FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6EA0BF88C3EA63B1E41B6A9B1A679958
        A9DF3280B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0B5F938AC6ED136597FFFFFF20
        73A780BFE991B6CDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9E6EE3481B26DAED62873A138
        89BC8DC8EE5791B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFE0EA0F62977BB8DF94
        CBEF3784B4E7EFF4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8E6EEA6
        C4D7FEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      OnClick = Sb_LimpaClick
    end
    object Sb_Recheio: TSpeedButton
      Left = 400
      Top = 94
      Width = 83
      Height = 38
      Caption = 'Recheio'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCE2E2E2D6D6
        D6D8D8D8E6E6E6F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E0A2A4BA64699C3F48962A379D202D
        9E22309F2F3DA33D4AA5525CA1797FADAFB2C6E4E4E4FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFEBEBEB787CA52631951523A61828B91829BC1829BD1829
        BB1829BB1929BB182ABD1A2CC31B2EC4192BB52E3DA6636AA3B0B2BDF6F6F6FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDCDCDC3D45891727B61728BD1626B51626B01525AE1523AB1422
        A81422A51422A31422A31523A51523A71726AF192BBE1B2EC61627A8434B91B0
        B1B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF4F4F43F44801626B71728B91524B01423AE1523AD1423AD1524AC1524
        AB1423A91422A81423A71522A61422A51321A31421A21524A41727B11A2CC315
        249C666B91E1E1E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA1A2AE101D971423B11320A9121FA81321AD1423B11627B61728B51729
        B3172CB31629B01525AE1525AA1523A51422A31320A113209E13209D1423A118
        29B7182AB82A3583B0B0B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF4A4D811320AE121FA8121EA81422B2172ABC182FBF182EBF182EBC1934
        BD1936BB1935B9172DB31527AE1525A71424A31322A213209F12209E13209C13
        219D1525A7192BBE162389A4A5ACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        EEEEEE2B32831321B01321B21424B9192FC3192FC7192DC4192CBF1934C01B3B
        C11C3EC21C3DC11A35BC182CB61728B11526A91424A51422A313209F13209D13
        209C13219C1423A0192BBD26307EE8E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        CBCBCC151E8B1322B61625BD1A2FC81C34CE192BCA1A2EC81A33C71D3DCA2046
        CC2149CC2045CA1C39C4192DBD192BBA182AB71628B01523A81422A313219D12
        1F9B13209C14219C1423A11728AB85889BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        BFBFC1121E991727C41728C61B2FCF1C32D11D36D22042D62348D7254FD92653
        D72453D62248D01E3CCA1A31C41A31C21A2DBF182ABB1727B31524AA1422A313
        1F9C131F9A13219D13219D1625AC343C80F2F2F2FFFFFFFFFFFFFFFFFFFFFFFF
        D9D9D9222F9B1D31D61827C91B32D2203FDB2144DC2550DF2753E22A5BE42961
        E1285FDE2655D9234BD51F3ECE1C39C91C35C51A2EC0182ABC1728B51526AC14
        23A3121F9B121F9A13219E1423A4131F88C3C4C5FFFFFFFFFFFFFFFFFFFFFFFF
        F8F8F838428E243DEB1A2FD81838DF2248E7284FE92C5AED2E5DED3477EE3D8D
        EF387DE9295FE1224EDC2348D7203DD11F3CCD1D39C81B31C2182ABB1728B415
        25AA1422A1121F98131F9D1321A113219A8D8FA3FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7F819A1C31D34262F8789DF75383F93B5AF43A5FFB386EFB3B90F974BD
        FBABD7FF5DAFF84B95EE2E6DE42550DA213FD5203FD1203DCD1C33C5182ABB17
        27B01625A81322A0121F9B1420A01422A660648BFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE9E9E92C3486627AF9CCE6FF6895FE2540EB2643E33161F53478FB3879
        F64880E7479DF25AB6FA50A2F23577E6244DDB2240D62140D4213ED11D36C718
        2BB81627AE1524A713209D121E9B1422A64E538AFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFC6C6C72E3890435AE74D78FF2D53EE2449DE1E3FB21F43921E44
        B42B637B25529F2662D83878E33F83ED3375E9264CDD2140D82140D6213ED21D
        33C51728B41625AD1422A1121F9B131FA13B4181F9F9F9FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFE1E1E15658881E36BD3868F6234CE6152DB5234B4F3A86
        504BA5653C7D592A595F2452C52D66EA3F91F9408FF5274CE22141DA2141D820
        3BCF1B32C0192CB81525A912209F1320A2434A89FDFDFDFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFE7E7E719226A3D59E75575EF1933D7142B763789
        462361362B673735715A2755BD2D69E93E8CF85DB3FE3974F52344E22447DE23
        43D9203DCC1D38C31728B21320A21320A64E5289FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF82849B2738C3556CF1192DD40A1289132D
        511E51241A4C293C8F50234C5E2B68D83B8AF88CC5FD63A3FD2D5CEF2548E324
        44DF2240D61C34C61728B51321A71321A6585C82FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F64148862539E02339E11836E51632
        7E204E43296B3F1F46371D4099326FF13A86F7A1DBFF87C9FF3C7CF6264AE625
        45E4213BDD1B2ECB1828BC1423AF111E998F90A1FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D5D520298A2F44E63367F02155
        C71127BE2356481D3C6B254DD03574F5387CF985C6FE6AB5FF3669F52542E923
        3DE52139E11F36D31A2DC41523B4172085D0D0D1FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5B5BA333C908296E982A3
        FF2D54FF203F97254EBF2E66F52D6AF52D62F9437EFD4278FF2A4CFB2442EF21
        3CE72341E31F3BD41A33C71626BC373D82F6F6F6FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDEA0A0AE797A
        982A377F314EE4325FFF5B8AF7A0C1FC6D9CFB5586FE4D81FE4A7AFF446CFB41
        62F22D4FE61D38D21A32CD1524AF8B8DA2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFDCDCDC6C769C2038B5345CF574AFFF81B7FF87AFFF86ADFF7798FB5979F544
        62EF2240E41D35DC192BC4575D92F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFB5B7BC505A9B1932AF1D3FDA264FF92851FD203FF01B37E417
        2FCF1628B4333FA88589ADF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFD2D2D29C9EB76E73A6676DA87076A98388B0A0
        A2BEC1C1CAECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      Transparent = False
      OnClick = Sb_RecheioClick
    end
    object Sb_Confirma: TSpeedButton
      Left = 553
      Top = 94
      Width = 87
      Height = 38
      Caption = 'Confirma'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7EEEEEEE4E4E4DDDDDDD6D6
        D6D2D2D2CECECECCCCCCCCCCCCCECECED2D2D2D6D6D6DDDDDDE4E4E4EEEEEEF7
        F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7EEEEEED3D2D2ADABA97B78
        865D59764240693733633733634240695D59767B7886ADABA9D3D2D2EEEEEEF7
        F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFBFBCCCAC8726D7C4543973132
        B02F31BE2D2ECA2D30D12D30D12D2FCA2F31BE3132B0454497726D7CCCCAC8FC
        FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFCFCFCDBDAD86D6B8739398F2C2FD12D30D32D30
        D42F32D42F32D42F33D53033D52F32D52F32D42E31D42D30D42D30D239398F6D
        6A86DBDAD8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFC9C7C55E5C7E2F30BE2D2FD12D30D42F32D52F32
        D53134D63134D63235D73235D73135D73134D63033D62F32D52E31D52E31D230
        31BE5E5C7FC9C7C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFDFDFDCAC8C6413F782D2FC42D30D32F32D43033D53235D63337
        D73538D83639D8363AD9363AD93639D83639D83437D73336D73134D63033D52E
        31D42E30C5413F78CAC8C6FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDBDAD8615D7F2D2FC42D2FD42F32D53134D63236D73438D83639
        D9373BDA383CDA393DDB393DDB393CDA383CDA373AD93639D93437D73235D730
        33D52E31D52E30C4615D7FDBDAD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFAF9F96A67842E30BE2C2FD32E31D53134D53336D7363AD8383CDA3A3E
        DA3C40DC3D41DC3E42DD3E42DD3D41DC3D41DC3B3FDB393DDA373BD93538D833
        36D63033D52E31D43031BF6A6784FAF9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFC3C1BE3737912B2ED12E31D43033D63336D73538D9383CDA3A3EDC3D41
        DC3F43DE4044DE4045DF4145DF4044DE4044DE3E42DD3C40DC3A3EDB373ADA35
        38D83235D73033D52D2FD2393792C3C1BEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        EDEDEB6F6B7B2B2ED12C2FD42F32D53235D63539D8383BDA3C40DB3E42DD4145
        DE4347DF4C4BC95E5FB35E5FB34D4BCA4448E04246DF4044DE3E42DC3A3EDB37
        3BD93437D73134D62E31D52D30D2716C7CEDEDEBFFFFFFFFFFFFFFFFFFFFFFFF
        CDCCCA4341982C2FD32E31D43134D63437D8373BD93A3DDB3E42DD4044DF4347
        E04549E13F3C9B282641282641413D9C464BE24449E14246E04044DE3C40DC39
        3DDA3639D93336D72F32D52D30D4454599CDCCCAFFFFFFFFFFFFFFFFFFFFFFFF
        9A97A43031AF2C2FD32E31D53235D63438D8393CDA3B3FDC4044DD4247DF464B
        E1484DE344409C2A28422A284246419D4A4FE3484DE24449E14246DF3E42DD3B
        3FDB373AD93437D73033D62E31D43132AF9B99A5FFFFFFFFFFFFFFFFFFFFFFFF
        74708D2E30BE2D30D32F32D53336D73639D93A3EDB3D41DD4246DF4449E1484D
        E24A4FE447439E2C2A422C2A4248449E4C51E54A4FE3464BE24448E04044DE3D
        41DC383CDA3639D83134D62F32D42F31BF74718DFFFFFFFFFFFFFFFFFFFFFFFF
        5450782C2DCB2D30D32F32D53337D7363AD93B3EDB3E42DD4646D45752B7615F
        B66663B85550852D2C412D2C415853866866B86562B75A57B94949D54044DE3D
        41DC393CDA3639D83135D72F32D52D2FCB545179FFFFFFFFFFFFFFFFFFFFFFFF
        4743712B2ECE2E31D43033D63437D7373AD93B3FDB3E42DD4040BA302B512A29
        422C2B432B2A4027283D28293D2C2B412E2C432B2A42322D524343BB4145DF3E
        42DD393DDB363AD93235D73033D52D30CF474571FFFFFFFFFFFFFFFFFFFFFFFF
        4E4A753235D13538D6373AD83B3FDA3E42DC4346DD464ADF4546BD302A572724
        472927482B2A462D2D452E2D452C2A462B2848292647312C584948BF484CE045
        49DE4144DD3E41DB393DDA363AD83437D24E4A75FFFFFFFFFFFFFFFFFFFFFFFF
        5E5A7F3C3FD03E42D94144DA4548DC484CDE4C50DF4F53E15255D94D4EBB4E4F
        B65151B84E4A8C3B39523B39534F4A8C5253B95051B74F50BB5458DA5256E24F
        53E04A4EDF484BDD4346DC4044DA3E41D15F5A7FFFFFFFFFFFFFFFFFFFFFFFFF
        807A954547C94649DB484BDD4C4FDE4E53E05357E1565AE35B5FE45D61E66064
        E86266E95D59AC41405C42405C5F5AAD6368E96266E95F63E75D61E5595DE456
        5AE25155E14E52DF4A4DDE484BDC4748C9807C95FFFFFFFFFFFFFFFFFFFFFFFF
        A29FAD4647BA4548DB474ADC4A4DDE4D51E05255E05458E2595DE35B5FE55F62
        E66064E85A56AA3F3E5B3F3E5B5B56AB6166E86064E75D61E65B5FE4575BE354
        58E15053E04C51DF484BDD4649DC4848BBA3A0ADFFFFFFFFFFFFFFFFFFFFFFFF
        D2CFCC5755A24347DA4649DC494CDD4B4FDF4F54E05256E2565AE3585CE45B5F
        E55D61E65451AA3635593735595552AA5E62E75C60E55A5EE5585CE35458E352
        56E14D52E04B4EDE484BDD4649DB5756A2D2CFCCFFFFFFFFFFFFFFFFFFFFFFFF
        EEEDEC7C77814346D94447DB474ADC494CDE4D52DF5054E05458E1565AE3595D
        E35B5FE45759D04A4DB64B4DB65759D15C60E55A5EE3585CE3565AE25256E150
        54E04B50DF494CDD4649DC4548DA7C7781EEEDECFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFC7C4C04B4A9E4246D94649DC484BDD4A4EDE4C50E05054E05256E25458
        E2565AE3575BE3585CE4585CE4585CE3575BE35559E35457E25255E14E52E04C
        50DF4A4DDE484BDC4547DA4C4A9FC7C4C0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF9F9F976728B4446C94447DB4649DC484CDD4A4EDE4D52DF4F54E05255
        E05357E15458E25559E25559E25558E25458E25356E15155E04E53E04C50DF4A
        4EDD484BDD4649DB4747C976728BF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFDEDDDA706B8A4445CE4447DB4649DC484BDD494CDE4B4FDF4D51
        E04E53E05053E05054E15154E15054E05053E04E52E04D51E04B4EDE494CDE47
        4ADD4648DC4547CF706C8ADEDDDAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFDFDFDCECBC85550824445CF4447DB4649DC474ADC494CDD4A4D
        DE4C4FDE4C50DF4D51DF4D51DF4C51DF4C4FDF4B4EDE4A4DDE484BDD474ADC45
        48DB4546CF555083CECBC8FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFCECBC86F6B8B4446C84246D94447DB4649DC474A
        DC484BDD484BDD494CDE494CDE484BDD484BDD474ADD474ADC4548DC4447D946
        47C86F6B8BCECBC8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFDFCFCDEDBD97B758E4E4C9C4346D94347DA4548
        DB4649DB4649DB474ADC474ADC4649DB4649DB4548DB4448DB4447DA4F4C9C7A
        758EDEDBD9FDFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFBFBCFCCC97E77845755A14646
        BB4547C84345D24346D84346D84345D24547C84647BB5855A27E7784CFCCC9FC
        FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEEEDD3D0CDA29E
        AC807D96656083554F77554F77656083807D96A29EACD3D0CDEFEEEDFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      Transparent = False
    end
    object Str_Composicao: TStringGrid
      Left = 4
      Top = 46
      Width = 394
      Height = 89
      DefaultColWidth = 390
      DefaultRowHeight = 20
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goTabs]
      ScrollBars = ssNone
      TabOrder = 0
      OnKeyDown = Str_ComposicaoKeyDown
    end
    object E_Qtde: TEdit
      Left = 404
      Top = 59
      Width = 90
      Height = 24
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 494
      Top = 59
      Width = 16
      Height = 24
      Associate = E_Qtde
      TabOrder = 2
    end
    object E_VL_Unitario: TEdit
      Left = 515
      Top = 59
      Width = 120
      Height = 24
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '0'
    end
  end
end
