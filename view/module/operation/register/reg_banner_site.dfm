inherited RegBannerSite: TRegBannerSite
  Caption = 'Cadastro de Bannar para Site'
  ClientHeight = 423
  ClientWidth = 809
  ExplicitHeight = 486
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 359
    Width = 809
    ExplicitTop = 350
    ExplicitWidth = 803
    inherited SB_Inserir: TSpeedButton
      Left = 182
      ExplicitLeft = 176
    end
    inherited SB_Alterar: TSpeedButton
      Left = 286
      ExplicitLeft = 280
    end
    inherited SB_Excluir: TSpeedButton
      Left = 390
      ExplicitLeft = 384
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 598
      ExplicitLeft = 592
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 702
      ExplicitLeft = 696
    end
    inherited SB_Gravar: TSpeedButton
      Left = 494
      ExplicitLeft = 488
    end
  end
  inherited pnl_fundo: TPanel
    Width = 809
    Height = 359
    ExplicitWidth = 803
    ExplicitHeight = 350
    object img_amostra: TImage
      Left = 2
      Top = 113
      Width = 805
      Height = 200
      Align = alClient
      Center = True
      ExplicitTop = 114
      ExplicitWidth = 799
      ExplicitHeight = 223
    end
    object Image1: TImage
      Left = 2
      Top = 113
      Width = 805
      Height = 200
      Align = alClient
      Center = True
      ExplicitLeft = 4
      ExplicitTop = 115
      ExplicitWidth = 799
      ExplicitHeight = 223
    end
    object Image2: TImage
      Left = 2
      Top = 113
      Width = 805
      Height = 200
      Align = alClient
      Center = True
      ExplicitLeft = 4
      ExplicitTop = 115
      ExplicitWidth = 799
      ExplicitHeight = 223
    end
    object pnl_fundos: TPanel
      Left = 2
      Top = 2
      Width = 805
      Height = 111
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 799
      object Sb_Carr_Imagem: TSpeedButton
        Left = 663
        Top = 29
        Width = 108
        Height = 27
        Caption = 'Carregar Imagem'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Layout = blGlyphTop
        NumGlyphs = 4
        ParentFont = False
      end
      object Lb_Caminho: TLabel
        Left = 5
        Top = 9
        Width = 196
        Height = 14
        Caption = 'Indique o Caminho da imagem do Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Lb_link: TLabel
        Left = 237
        Top = 56
        Width = 119
        Height = 14
        Caption = 'link do Banner (opcional)'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object E_PathIMG: TEdit
        Left = 7
        Top = 29
        Width = 650
        Height = 21
        TabOrder = 0
      end
      object Rg_ImageTarget: TRadioGroup
        Left = 6
        Top = 56
        Width = 225
        Height = 43
        Caption = 'Tipo da Imagem'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Normal'
          'Capa'
          'Banner')
        ParentFont = False
        TabOrder = 2
      end
      object E_link: TEdit
        Left = 237
        Top = 76
        Width = 537
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 313
      Width = 805
      Height = 44
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      ExplicitTop = 304
      ExplicitWidth = 799
      object Sb_First: TSpeedButton
        Left = 9
        Top = 4
        Width = 38
        Height = 35
        Flat = True
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000C30E0000C30E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4
          F4DFDFDFCFD4D3C8D2CFCDD4D2DDDEDEF2F2F2FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0B4C2BB70A78F3F96
          70239463159159118D5617976326A17341A98470B79DAFCBC2ECEBECFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4A1B5AB3A9069098E520A9F5C0B9F
          5C0C9C5B0C9B5A10A06215A86D16AC7119B3781EBC8225BA8540B28B9BC5B8F0
          EEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFD3D4D34E917006904F089D580A97570C96590E99
          5C0F9A5D119F6317A76E1AAB731EAE7721B17B23B37F24B58126C08930C99556
          B899CAD9D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB8C1BC228755059B540894540B94570D985A0F9A5D109E
          6112A26618AA701DAF7722B47D28B8832CBB882FBC8B32BD8C33BE8E30BD8D32
          CB983EC297AECDC5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB6BEBA178750049A520992530C95570D975A0F9A5D119E6212A3
          6717A96F1DB07824B6802BBB8732C08D38C2933DC69741C89A44C89C44C89C40
          C5993ACB9B46CEA4ADCFC5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFCDCCCC2285540299500892520B94570D96590E995C119F6214A3680973
          3C056E3709773F0C7E4510854913894C178E5049C59959D4AD59D3AB58D2AB56
          D0AA50CDA545D0A34ECDA7C3D8D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EEEEEE4B916D00984E0691510A93560C95570E985A109C6012A46718A86E076E
          3602692F067439097D3F0D8544108C4615914B5DCDA673DDBD71DCBB6FDBBB6C
          DAB967D7B55DD2AD51DAAF67CAADE8E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          97ACA1018A4702924F0893540B93560C95580E995C11A06314A86D1AAC730979
          3F05773B0B8345118D4D1799531CA25C23A76671D7B68AE4CB88E3C987E3C982
          E2C77CDFC373DBBC64D5B25EE4BC9CD2C3FFFFFFFFFFFFFFFFFFFFFFFFE4E4E4
          358C600098500491520A93550B93560D96590F9C5F13A36716AC711EB1780C80
          46088042108E4E179C5820A86527B2732EB67D82DEC39BEAD69AE8D39AE8D396
          E8D28FE6CF87E3CA7BDEC166DCB965D0B3DFE5E3FFFFFFFFFFFFFFFFFFA6B4AC
          0187460093500692540B92540B93550D9759109E6114A66A18AF7422B57E0F87
          4C0C88481599571FA86529B57931BF8838C4918EE4CCA8EEDCA7ECDAA7ECDAA5
          ECD99EEBD797E8D38CE4CD79DDC170EAC7ABD7CBFFFFFFFFFFFFFBFBFB62977B
          0098500092510792540A91530B93540D985A11A06315A86C1AB17727B782128C
          500F90501AA26026B27432BF893ACA9841CE9F98E8D3B0F0E1B0EFDFB1EFDFAF
          EEDEA9EEDCA2ECD999E8D58AE4CC76E8C984D3BEF6F6F6FFFFFFE5E5E531895D
          0099530193530792530A90520A92540D995B11A16416A96E1BB3792AB9851390
          541295541FA8672CB97E38C69440D0A346D3AA9EEBD7B7F1E4B6F1E2B7F1E2B6
          F0E1B1F0E0A9EEDEA2EBD995E7D37FE4CA72D5BDDFE6E4FFFFFFCECDCD15854C
          009754019354079152098F500A92540D995B11A16416A96E1CB37A2BBA861592
          5614985722AC6D30BD843CCA9944D2A74AD5ADA2ECD9BAF3E5BAF1E4BBF1E4BA
          F2E4B5F1E3AEF0E0A7EEDD9BE9D786E5CE7CE7CBCBDDD9FFFFFFBBC0BD088347
          009754009353069051098E4E0992530D9A5C12A26516AA6F1CB57C2CBC881593
          5714995824AD6E32BD853DCA9944D1A54AD3ABA5ECDABFF4E8BFF3E6C1F3E7C0
          F3E7BAF2E5B0F1E2A9EEDE9FEBD98BE6D082F0D5BFDCD4FFFFFFB2BAB6038144
          009655009353058F4F088E4E08894B0B8D500F975B139F6418A97026B27C1391
          5414985723AC6D31BC833CC69442CEA048D1A797E7D2AEEFDFAFEFDFB2EFE0AD
          EFDFA6EDDDAFF1E2A9EEDF9FEBDA8CE7D281F3D8B6DAD2FFFFFFB6BCB8068247
          009654009352038E4D078E4D078045015820015B2102662B046D33077A3D0A87
          4814975621A9682EB87E38C18E3FCA9944CEA14CD3AA4FD6B053D8B350D9B445
          D7AE86E5CDB1F1E3A6EEDD9BEAD889E7D17FF3D8BBDCD4FFFFFFC6C6C60E844B
          009653009252028D4C068A4808905008824701581F005A1F02642A0370340881
          431193531DA46229B27533BC853AC4903FCA9940CC9E42CFA33ED2A639D1A581
          E4C9B3F1E4A8EEDEA0ECDA96E9D682E6D079EDD4C6DDD8FFFFFFDDDCDC268857
          009852009251008D4B048947058A480994540B894E025C25015D23036A31067A
          3D0D8C4C169D5A22AB6A2CB67A33BC8537C18D3BC69338C99637C89780E0C5AF
          F1E1A5EDDC9FECDA98E9D78CE7D377E6CD6EE1C8D6E2DFFFFFFFF4F4F44D916E
          009851009150008E4C018845048845068B4B0A97570D8E53035F29015E270570
          380A824511945219A35E22AE6D29B5782EBA802CBB822FBD8678DCBDA4EDDC9C
          EAD799EAD695E8D48DE7D27FE4CE6BEACE6FD8C2EDEBEBFFFFFFFFFFFF8BA798
          018F4A00914F008F4D008945038642058846078D4D0B995A0E925804632D0261
          2B07763D0D884B1498551AA45E20AC6920AE6D27B1746DD6B494E9D48EE6CF8F
          E6D08CE6CF86E5CE7DE3CC6EE0C75EF0D292D9CAFFFFFFFFFFFFFFFFFFD1D0D0
          1C865100954F008F4D008A47008541038542058947088E4E0D9A5C11965D0667
          3303632F097A410F8A4C149754159C541EA3615FD0AB80E4CA7DE1C67FE1C77F
          E1C87CE1C875E0C76ADFC455DFC04EE6C8C9E0DCFFFFFFFFFFFFFFFFFFFCFCFC
          6F9C8401944C008E4C008C4A00874300843F038542058948088F4F0D9B5D139C
          63096B390464310A7C430B84441492514CC89F69DEBF68DABA6CDCBD6DDCBE6C
          DDC067DDBF60DCBE52DBBC3AEBC75DD5C3FDFCFCFFFFFFFFFFFFFFFFFFFFFFFF
          D5D4D425885600964D008C4A00894600853F01833D038541058948088E4F0D9C
          6015A16A0A6E3E025F2D0C7C4538BE934FD6B151D3AE56D5B259D7B558D8B757
          D8B851D8B847D8B732DCB719DDBCBDDEDBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFA0B1A804844400924B008B4800874300833E00833D028541048947078F
          4F0E9F6315A26C0B774821AB7B33C99D37C99F3ECDA541D0A943D1AC43D3AE3D
          D4AF33D4AF20D4AD0AEAC277D1C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFBFBFB7CA08E018C4700904900894600864200833E00823D01843F0388
          450691520C9F6413AC7418B4801EB98926C0932AC59A2BCA9F2BCCA328CEA51F
          CFA60ED0A500E6BA52CCBAFBF7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF6F6F6789F8B01884500924900884400864100833E00833D0083
          3E018845039454069E620AA76E0EB07A11B78512BD8D11C2930DC59707C79900
          CE9E02E1B451C8B4F2EFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFBFBFB96AEA213844C00954B008B4400854000843F0084
          3F00843F008B48009656009E6101A76D01AF7700B58000BA8600BF8D00D29E06
          CDA276C7B8F8F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCACECC519574058344009349008E440087
          4000843F008540008F4C00995900A06300A96D00B47A00C48A04C49239BA9EB9
          D5D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9BCC6C1649F842389590485
          44018C4701914800934B019E5901A66703A66D17A87C52B79DADCEC7F7F5F5FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7E6E6BECA
          C599BAAC81B29C79B1997FB59E93BFB0B7CEC7E3E3E3FEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      object Sb_Next: TSpeedButton
        Left = 48
        Top = 4
        Width = 38
        Height = 35
        Flat = True
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000C30E0000C30E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4
          F4DDDCDCC6C6C6B6BCB8B2BAB6BBC0BDCECDCDE5E5E5FBFBFBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCD1D0D08BA7984D91
          6E2688570E844B06824703814508834815854D31895D62977BA6B4ACE4E4E4FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D4D46F9C841C8651018F4A0098
          51009852009653009654009655009754009754009953009850018746358C6097
          ACA1EEEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBFBFBA0B1A825885601944C00954F00914F0091
          5000925100925200935200935300935301935401935300925100935000985001
          8A474B916DCDCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF6F6F67CA08E04854500964D008E4C008F4D008F4D008E
          4C008D4B028D4C038E4D058F4F06905107915207925307925406925404915202
          924F00984E228554B6BEBAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFBFBFB789F8B018C4700924B008C4A008C4A008A470089450188
          45048947068A48078E4D088E4E098E4E098F500A90520A91530B92540A935508
          9354069151029950178750B8C1BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF96AEA2018845009049008B480089460087430085410386420488
          45058A4808905007804508894B0992530A92540A92540B93540B93550B93560B
          93560A9356089252049A52228755D3D4D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFCACECC13844C00924900894600874300853F00843F038542058846068B
          4B0994540882470158200B8D500D9A5C0D995B0D995B0D985A0D97590D96590C
          95580C95570B9457099253059B544E9170F4F4F4FFFFFFFFFFFFFFFFFFFFFFFF
          F9F9F951957400954B00884400864200833E01833D038542058947078D4D0A97
          570B894E01581F015B210F975B12A26511A16411A16411A063109E610F9C5F0E
          995C0E985A0D96590C955708945406904FA1B5ABFFFFFFFFFFFFFFFFFFFFFFFF
          BCC6C1058445008B4400864100833E00833D038541058948088E4E0B995A0D8E
          53025C25005A1F02662B139F6416AA6F16A96E16A96E15A86C14A66A13A36711
          A063109C600E995C0D975A0B9457089D583A9069F0F0F0FFFFFFFFFFFFFFFFFF
          649F8400934900854000833E00823D028541058948088F4F0D9A5C0E9258035F
          29015D2302642A046D3318A9701CB57C1CB37A1BB3791AB17718AF7416AC7114
          A86D12A467119F620F9A5D0D985A0A9757098E52B4C2BBFFFFFFFFFFFFE7E6E6
          238A59008E4400843F00833D01843F048947088E4F0D9B5D11965D04632D015E
          27036A31037034077A3D26B27C2CBC882BBA862AB98527B78222B57E1EB1781A
          AC7318A86E14A368119E620F9A5D0C96590A9F5C70A78FFFFFFFFFFFFFBECAC5
          04854500874000843F00833E038845078F4F0D9C60139C6306673302612B0570
          38067A3D0881430A8748139154159357159256139054128C500F874C0C804609
          793F076E3609733C12A367109E610E995C0B9F5C3F9770F4F4F4FFFFFF99BAAC
          018C4700843F00843F0188450691520E9F6315A16A096B3903632F07763D0A82
          450D8C4C1193531497561498571499581498571295540F90500C884808804205
          773B02692F056E3717A96F12A2660F9A5D0C9C5B239463DFDFDFFFFFFF81B29C
          019148008540008B480394540C9F6415A26C0A6E3E046431097A410D884B1194
          52169D5A1DA46221A96823AC6D24AD6E22AC6D1FA8671AA260159957108E4E0B
          834506743909773F1DB07818AA70119F630C9B5A15915ACFD4D3FFFFFF79B199
          00934B008F4C009656069E6213AC740B7748025F2D0A7C430F8A4C14985519A3
          5E22AB6A29B2752EB87E31BC8332BD8530BD842CB97E26B2741FA865179C5811
          8D4D097D3F0C7E4524B6801DAF7717A76E10A062118E57C8D2CFFFFFFF7FB59E
          019E59009959009E610AA76E18B48021AB7B0C7C450B84441497541AA45E22AE
          6D2CB67A33BC8538C18E3CC6943DCA993CCA9938C69432BF8929B57920A86517
          99530D85441085492BBB8722B47D1AAB7315A86D179763CDD4D2FFFFFF93BFB0
          01A66700A06301A76D0EB07A1EB98933C99D38BE93149251159C5420AC6929B5
          7833BC853AC4903FCA9942CEA044D1A544D2A740D0A33ACA9831BF8827B2731C
          A25C108C4613894C32C08D28B8831EAE7716AC7127A274DDDEDEFFFFFFB7CEC7
          03A66D00A96D01AF7711B78526C09337C99F4FD6B14CC89F1EA36120AE6D2EBA
          8037C18D3FCA9944CEA148D1A74AD3AB4AD5AD46D3AA41CE9F38C4912EB67D23
          A76615914B178E5038C2932CBB8821B17B19B37842A984F2F2F2FFFFFFE3E3E3
          17A87C00B47A00B58012BD8D2AC59A3ECDA551D3AE69DEBF5FD0AB27B1742CBB
          823BC69340CC9E4CD3AA97E7D2A5ECDAA2ECD99EEBD798E8D38EE4CC82DEC371
          D7B65DCDA649C5993DC6972FBC8B23B37F1EBC8270B79DFFFFFFFFFFFFFEFEFE
          52B79D00C48A00BA8611C2932BCA9F41D0A956D5B268DABA80E4CA6DD6B42FBD
          8638C99642CFA34FD6B0AEEFDFBFF4E8BAF3E5B7F1E4B0F0E1A8EEDC9BEAD68A
          E4CB73DDBD59D4AD41C89A32BD8C24B58125BA85AFCBC2FFFFFFFFFFFFFFFFFF
          ADCEC704C49200BF8D0DC5972BCCA343D1AC59D7B56CDCBD7DE1C694E9D478DC
          BD37C8973ED2A653D8B3AFEFDFBFF3E6BAF1E4B6F1E2B0EFDFA7ECDA9AE8D388
          E3C971DCBB59D3AB44C89C33BE8E26C08941B28CECEBECFFFFFFFFFFFFFFFFFF
          F7F5F539BB9E00D29E07C79928CEA543D3AE58D8B76DDCBE7FE1C78EE6CFA4ED
          DC80E0C539D1A550D9B4B2EFE0C1F3E7BBF1E4B7F1E2B1EFDFA7ECDA9AE8D387
          E3C96FDBBB58D2AB44C89C30BD8D30C9959BC5B8FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFB9D5D006CDA200CE9E1FCFA63DD4AF57D8B86CDDC07FE1C88FE6D09CEA
          D7AFF1E181E4C945D7AEADEFDFC0F3E7BAF2E4B6F0E1AFEEDEA5ECD996E8D282
          E2C76CDAB956D0AA40C59932CB9856B899F0EEEFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF76C7B802E1B40ED0A533D4AF51D8B867DDBF7CE1C88CE6CF99EA
          D6A5EDDCB3F1E486E5CDA6EDDDBAF2E5B5F1E3B1F0E0A9EEDC9EEBD78FE6CF7C
          DFC367D7B550CDA53ACB9B3FC298CAD9D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF8F5F551C8B400E6BA20D4AD47D8B760DCBE75E0C786E5CE95E8
          D49FECDAA8EEDEB1F1E3AFF1E2B0F1E2AEF0E0A9EEDEA2ECD997E8D387E3CA73
          DBBC5DD2AD45D0A346CEA4AECDC5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF2EFEF52CCBA0AEAC232DCB752DBBC6ADFC47DE3CC8DE7
          D298E9D7A0ECDAA6EEDDA9EEDFA9EEDEA7EEDDA2EBD999E8D58CE4CD7BDEC164
          D5B251DAAF4ECDA7ADCFC5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFBF7F777D1C619DDBC3AEBC755DFC06EE0C77FE4
          CE8CE7D396E9D69BEAD89FEBDA9FEBD99BE9D795E7D38AE4CC79DDC166DCB95E
          E4BC67CBADC3D8D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBDDEDB5ED6C34EE6C85EF0D26BEA
          CE77E6CD82E6D089E7D18CE7D28BE6D086E5CE7FE4CA76E8C970EAC766D0B39C
          D2C3E8E8E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFCC9E0DC92D9CA6FD8
          C26EE1C879EDD47FF3D881F3D882F0D57CE7CB73D6BD85D3BEABD7CBDFE5E3FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEB
          EBD6E2DFC6DDD8BBDCD4B6DAD2BFDCD4CBDDD9DFE6E4F6F6F6FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      object Sb_Prior: TSpeedButton
        Left = 87
        Top = 4
        Width = 38
        Height = 35
        Flat = True
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000C30E0000C30E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F6DFE6
          E4CBDDD9BFDCD4B6DAD2BBDCD4C6DDD8D6E2DFEDEBEBFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFE5E3ABD7CB84D3BE72D5
          BD7CE7CB82F0D581F3D87FF3D879EDD46EE1C86FD8C292D9CAC9E0DCFDFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8E89CD2C365D0B370EAC776E8C97FE4
          CA86E5CE8BE6D08CE7D289E7D182E6D077E6CD6BEACE5EF0D24EE6C85DD5C3BD
          DEDBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFC3D8D267CAAD5EE4BC66DCB979DDC18AE4CC95E7
          D39BE9D79FEBD99FEBDA9BEAD896E9D68CE7D37FE4CE6EE0C755DFC03AEBC719
          DDBC77D1C6FBF7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFADCFC54ECDA751DAAF64D5B27BDEC18CE4CD99E8D5A2EB
          D9A7EEDDA9EEDEA9EEDFA6EEDDA0ECDA98E9D78DE7D27DE3CC6ADFC452DBBC32
          DCB70AEAC252CCBAF2EFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFAECDC546CEA445D0A35DD2AD73DBBC87E3CA97E8D3A2ECD9A9EE
          DEAEF0E0B0F1E2AFF1E2B1F1E3A8EEDE9FECDA95E8D486E5CE75E0C760DCBE47
          D8B720D4AD00E6BA51C8B4F8F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFCAD9D43EC2973ACB9B50CDA567D7B57CDFC38FE6CF9EEBD7A9EEDCB1F0
          E0B5F1E3BAF2E5A6EDDD86E5CDB3F1E4A5EDDC99EAD68CE6CF7CE1C867DDBF51
          D8B833D4AF0ED0A502E1B476C7B8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          F0EEEF56B89932CB9840C59956D0AA6CDAB982E2C796E8D2A5ECD9AFEEDEB6F0
          E1BAF2E4C0F3E7ADEFDF45D7AE81E4C9AFF1E19CEAD78FE6D07FE1C86CDDC057
          D8B83DD4AF1FCFA600CE9E06CDA2B9D5D0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          9BC5B830C99530BD8D44C89C58D2AB6FDBBB87E3C99AE8D3A7ECDAB1EFDFB7F1
          E2BBF1E4C1F3E7B2EFE050D9B439D1A580E0C5A4EDDC8EE6CF7FE1C76DDCBE58
          D8B743D3AE28CEA507C79900D29E39BA9EF7F5F5FFFFFFFFFFFFFFFFFFECEBEC
          40B28B26C08933BE8E44C89C59D3AB71DCBB88E3C99AE8D3A7ECDAB0EFDFB6F1
          E2BAF1E4BFF3E6AFEFDF53D8B33ED2A637C89778DCBD94E9D47DE1C66CDCBD59
          D7B543D1AC2BCCA30DC59700BF8D04C492ADCEC7FFFFFFFFFFFFFFFFFFAFCBC2
          25BA8524B58132BD8C41C89A59D4AD73DDBD8AE4CB9BEAD6A8EEDCB0F0E1B7F1
          E4BAF3E5BFF4E8AEEFDF4FD6B042CFA338C9962FBD866DD6B480E4CA68DABA56
          D5B241D0A92BCA9F11C29300BA8600C48A52B79DFEFEFEFFFFFFFFFFFF70B79D
          1EBC8223B37F2FBC8B3DC69749C5995DCDA671D7B682DEC38EE4CC98E8D39EEB
          D7A2ECD9A5ECDA97E7D24CD3AA40CC9E3BC6932CBB8227B1745FD0AB69DEBF51
          D3AE3ECDA52AC59A12BD8D00B58000B47A17A87CE3E3E3FFFFFFF2F2F241A984
          19B37821B17B2CBB8838C293178E5015914B23A7662EB67D38C49141CE9F46D3
          AA4AD5AD4AD3AB48D1A744CEA13FCA9937C18D2EBA8020AE6D1EA3614CC89F4F
          D6B137C99F26C09311B78501AF7700A96D03A66DB7CEC7FFFFFFDDDEDE26A173
          16AC711EAE7728B88332C08D13894C108C461CA25C27B27331BF883ACA9840D0
          A344D2A744D1A542CEA03FCA993AC49033BC8529B57820AC69159C5414925138
          BE9333C99D1EB9890EB07A01A76D00A06301A66793BFB0FFFFFFCDD4D2179763
          15A86D1AAB7322B47D2BBB871085490D854417995320A86529B57932BF8938C6
          943CCA993DCA993CC69438C18E33BC852CB67A22AE6D1AA45E1497540B84440C
          7C4521AB7B18B4800AA76E009E61009959019E597FB59EFFFFFFC8D2CF118D56
          10A06217A76E1DAF7724B6800C7E45097D3F118D4D179C581FA86526B2742CB9
          7E30BD8432BD8531BC832EB87E29B27522AB6A19A35E1498550F8A4C0A7C4302
          5F2D0B774813AC74069E62009656008F4C00934B79B199FFFFFFCFD4D3159159
          0C9B5A119F6318AA701DB07809773F0674390B8345108E4E1599571AA2601FA8
          6722AC6D24AD6E23AC6D21A9681DA462169D5A1194520D884B097A410464310A
          6E3E15A26C0C9F64039454008B4800854001914881B29CFFFFFFDFDFDF239463
          0C9C5B0F9A5D12A26617A96F056E3702692F05773B0880420C88480F90501295
          541498571499581498571497561193530D8C4C0A824507763D03632F096B3915
          A16A0E9F6306915201884500843F00843F018C4799BAACFFFFFFF4F4F43F9670
          0B9F5C0E995C109E6112A36709733C076E3609793F0C80460F874C128C501390
          541592561593571391540A8748088143067A3D05703802612B066733139C630D
          9C60078F4F03884500833E00843F008740048544BECAC5FFFFFFFFFFFF70A78F
          0A9F5C0C96590F9A5D119E6214A36818A86E1AAC731EB17822B57E27B7822AB9
          852BBA862CBC8826B27C077A3D037034036A31015E2704632D11965D0D9B5D08
          8E4F04894701843F00833D00843F008E44238959E7E6E6FFFFFFFFFFFFB4C2BB
          098E520A97570D985A0F9A5D119F6212A46714A86D16AC7118AF741AB1771BB3
          791CB37A1CB57C18A970046D3302642A015D23035F290E92580D9A5C088F4F05
          894802854100823D00833E008540009349649F84FFFFFFFFFFFFFFFFFFF0F0F0
          3A9069089D580B94570D975A0E995C109C6011A06313A36714A66A15A86C16A9
          6E16A96E16AA6F139F6402662B005A1F025C250D8E530B995A088E4E05894803
          854100833D00833E008641008B44058344BCC6C1FFFFFFFFFFFFFFFFFFFFFFFF
          A1B5AB06904F0894540C95570D96590E985A0E995C0F9C5F109E6111A06311A1
          6411A16412A2650F975B015B2101581F0B894E0A9757078D4D05894703854201
          833D00833E00864200884400954B519574F9F9F9FFFFFFFFFFFFFFFFFFFFFFFF
          F4F4F44E9170059B540992530B94570C95570C95580D96590D97590D985A0D99
          5B0D995B0D9A5C0B8D50015820088247099454068B4B05884603854200843F00
          853F00874300894600924913844CCACECCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFD3D4D3228755049A520892520A93560B93560B93560B93550B93540A92
          540A925409925308894B078045089050058A4804884503864200854100874300
          8946008B4800904901884596AEA2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFB8C1BC1787500299500691510893540A93550B92540A91530A90
          52098F50098E4E088E4E078E4D068A48048947018845008945008A47008C4A00
          8C4A00924B018C47789F8BFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFB6BEBA22855400984E02924F0491520692540792540792
          53079152069051058F4F038E4D028D4C008D4B008E4C008F4D008F4D008E4C00
          964D0484447CA08EF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFCDCCCC4B916D018A470098500093500092510193
          5301935400935300935300935200925200925100915000914F00954F01944C25
          8856A0B1A8FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEE97ACA1358C600187460098500099
          53009754009754009655009654009653009852009851018F4A1C86516F9C84D5
          D4D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4E4E4A6B4AC62977B3189
          5D15854C0883470381440682470E844B2688574D916E8BA798D1D0D0FCFCFCFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE5E5
          E5CECDCDBBC0BDB2BAB6B6BCB8C6C6C6DDDCDCF4F4F4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
      object Sb_Last: TSpeedButton
        Left = 126
        Top = 4
        Width = 38
        Height = 35
        Flat = True
        Glyph.Data = {
          360C0000424D360C000000000000360000002800000020000000200000000100
          180000000000000C0000C30E0000C30E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEE3E3
          E3B7CEC793BFB07FB59E79B19981B29C99BAACBECAC5E7E6E6FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F5F5ADCEC752B79D17A8
          7C03A66D01A667019E5900934B019148018C47048544238959649F84BCC6C1F9
          F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB9D5D039BA9E04C49200C48A00B4
          7A00A96D00A063009959008F4C00854000843F008740008E4400934905834451
          9574CACECCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF8F5F576C7B806CDA200D29E00BF8D00BA8600B5
          8001AF7701A76D009E61009656008B4800843F00843F00843F008540008B4400
          954B13844C96AEA2FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF2EFEF51C8B402E1B400CE9E07C7990DC59711C29312BD
          8D11B7850EB07A0AA76E069E6203945401884500833E00833D00833E00864100
          8844009249018845789F8BF6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFBF7F752CCBA00E6BA0ED0A51FCFA628CEA52BCCA32BCA9F2AC5
          9A26C0931EB98918B48013AC740C9F6406915203884501843F00823D00833E00
          8642008946009049018C477CA08EFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF77D1C60AEAC220D4AD33D4AF3DD4AF43D3AE43D1AC41D0A93ECD
          A537C99F33C99D21AB7B0B774815A26C0E9F63078F4F04894702854100833D00
          833E008743008B4800924B048444A0B1A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFBDDEDB19DDBC32DCB747D8B751D8B857D8B858D8B759D7B556D5B251D3
          AE4FD6B138BE930C7C45025F2D0A6E3E15A16A0D9C60088E4F05894803854101
          833D00853F008946008C4A00964D258856D5D4D4FFFFFFFFFFFFFFFFFFFFFFFF
          FDFCFC5DD5C33AEBC752DBBC60DCBE67DDBF6CDDC06DDCBE6CDCBD68DABA69DE
          BF4CC89F1492510B84440A7C43046431096B39139C630D9B5D088F4F05894803
          854200843F008743008C4A008E4C01944C6F9C84FCFCFCFFFFFFFFFFFFFFFFFF
          C9E0DC4EE6C855DFC06ADFC475E0C77CE1C87FE1C87FE1C77DE1C680E4CA5FD0
          AB1EA361159C541497540F8A4C097A4103632F06673311965D0D9A5C088E4E05
          8947038542008541008A47008F4D00954F1C8651D1D0D0FFFFFFFFFFFFFFFFFF
          92D9CA5EF0D26EE0C77DE3CC86E5CE8CE6CF8FE6D08EE6CF94E9D46DD6B427B1
          7420AE6D20AC691AA45E1498550D884B07763D02612B04632D0E92580B995A07
          8D4D058846038642008945008F4D00914F018F4A8BA798FFFFFFFFFFFFEDEBEB
          6FD8C26BEACE7FE4CE8DE7D295E8D499EAD69CEAD7A4EDDC78DCBD2FBD862CBB
          822EBA8029B57822AE6D19A35E1194520A8245057038015E27035F290D8E530A
          9757068B4B048845018845008E4C0091500098514D916EF4F4F4FFFFFFD6E2DF
          6EE1C877E6CD8CE7D398E9D79FECDAA5EDDCAFF1E180E0C537C89738C9963BC6
          9337C18D33BC852CB67A22AB6A169D5A0D8C4C067A3D036A31015D23025C250B
          894E099454058A48048947008D4B009251009852268857DDDCDCFFFFFFC6DDD8
          79EDD482E6D096E9D6A0ECDAA8EEDEB3F1E481E4C939D1A53ED2A642CFA340CC
          9E3FCA993AC49033BC8529B2751DA46211935308814303703402642A005A1F01
          581F088247089050068A48028D4C0092520096530E844BC6C6C6FFFFFFBBDCD4
          7FF3D889E7D19BEAD8A6EEDDB1F1E386E5CD45D7AE50D9B453D8B34FD6B04CD3
          AA44CEA13FCA9938C18E2EB87E21A9681497560A8748077A3D046D3302662B01
          5B21015820078045078E4D038E4D009352009654068247B6BCB8FFFFFFB6DAD2
          81F3D88CE7D29FEBDAA9EEDFAFF1E2A6EDDDADEFDFB2EFE0AFEFDFAEEFDF97E7
          D248D1A742CEA03CC69431BC8323AC6D14985713915426B27C18A970139F640F
          975B0B8D5008894B088E4E058F4F009353009655038144B2BAB6FFFFFFBFDCD4
          82F0D58BE6D09FEBD9A9EEDEB0F1E2BAF2E5C0F3E7C1F3E7BFF3E6BFF4E8A5EC
          DA4AD3AB44D1A53DCA9932BD8524AD6E1499581593572CBC881CB57C16AA6F12
          A2650D9A5C099253098E4E069051009353009754088347BBC0BDFFFFFFCBDDD9
          7CE7CB86E5CE9BE9D7A7EEDDAEF0E0B5F1E3BAF2E4BBF1E4BAF1E4BAF3E5A2EC
          D94AD5AD44D2A73CCA9930BD8422AC6D1498571592562BBA861CB37A16A96E11
          A1640D995B0A9254098F5007915201935400975415854CCECDCDFFFFFFDFE6E4
          72D5BD7FE4CA95E7D3A2EBD9A9EEDEB1F0E0B6F0E1B7F1E2B6F1E2B7F1E49EEB
          D746D3AA40D0A338C6942CB97E1FA8671295541390542AB9851BB37916A96E11
          A1640D995B0A92540A905207925301935300995331895DE5E5E5FFFFFFF6F6F6
          84D3BE76E8C98AE4CC99E8D5A2ECD9A9EEDCAFEEDEB1EFDFB0EFDFB0F0E198E8
          D341CE9F3ACA9832BF8926B2741AA2600F9050128C5027B7821AB17715A86C11
          A0630D985A0B93540A915307925400925100985062977BFBFBFBFFFFFFFFFFFF
          ABD7CB70EAC779DDC18CE4CD97E8D39EEBD7A5ECD9A7ECDAA7ECDAA8EEDC8EE4
          CC38C49131BF8829B5791FA8651599570C88480F874C22B57E18AF7414A66A10
          9E610D97590B93550B9254069254009350018746A6B4ACFFFFFFFFFFFFFFFFFF
          DFE5E365D0B366DCB97BDEC187E3CA8FE6CF96E8D29AE8D39AE8D39BEAD682DE
          C32EB67D27B27320A865179C58108E4E0880420C80461EB17816AC7113A3670F
          9C5F0D96590B93560A9355049152009850358C60E4E4E4FFFFFFFFFFFFFFFFFF
          FFFFFF9CD2C35EE4BC64D5B273DBBC7CDFC382E2C787E3C988E3C98AE4CB71D7
          B623A7661CA25C179953118D4D0B834505773B09793F1AAC7314A86D11A0630E
          995C0C95580B935608935402924F018A4797ACA1FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFE8E8E867CAAD51DAAF5DD2AD67D7B56CDAB96FDBBB71DCBB73DDBD5DCD
          A615914B108C460D8544097D3F06743902692F076E3618A86E12A467109C600E
          985A0C95570A935606915100984E4B916DEEEEEEFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC3D8D24ECDA745D0A350CDA556D0AA58D2AB59D3AB59D4AD49C5
          99178E5013894C1085490C7E4509773F056E3709733C14A368119F620E995C0D
          96590B9457089252029950228554CDCCCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFADCFC546CEA43ACB9B40C59944C89C44C89C41C89A3DC6
          9738C29332C08D2BBB8724B6801DB07817A96F12A367119E620F9A5D0D975A0C
          9557099253049A52178750B6BEBAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFAECDC53EC29732CB9830BD8D33BE8E32BD8C2FBC
          8B2CBB8828B88322B47D1DAF7718AA7012A266109E610F9A5D0D985A0B945708
          9454059B54228755B8C1BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCAD9D456B89930C99526C08924B58123B3
          7F21B17B1EAE771AAB7317A76E119F630F9A5D0E995C0C96590A9757089D5806
          904F4E9170D3D4D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0EEEF9BC5B840B28B25BA851EBC
          8219B37816AC7115A86D10A0620C9B5A0C9C5B0B9F5C0A9F5C098E523A9069A1
          B5ABF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECEBECAFCBC270B7
          9D41A98426A173179763118D561591592394633F967070A78FB4C2BBF0F0F0FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFF2F2F2DDDEDECDD4D2C8D2CFCFD4D3DFDFDFF4F4F4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      end
    end
  end
end
