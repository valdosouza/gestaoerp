object Fm_CardapioMTP: TFm_CardapioMTP
  Left = 0
  Top = 0
  Width = 623
  Height = 386
  TabOrder = 0
  inline Fm_CardapioMT: TFm_CardapioMT
    Left = 0
    Top = 0
    Width = 623
    Height = 386
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 623
    ExplicitHeight = 386
    inherited Pg_Geral: TPageControl
      Width = 623
      Height = 386
      ExplicitWidth = 623
      ExplicitHeight = 386
      inherited tbs_SAbor: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 30
        ExplicitWidth = 617
        ExplicitHeight = 359
        inherited Fm_Sabor: TFm_CardapioPanel
          inherited Panel4: TPanel
            ExplicitTop = 301
            ExplicitWidth = 615
            inherited Sb_Insere: TSpeedButton
              OnClick = Fm_SaborSb_InsereClick
            end
            inherited Sb_Altera: TSpeedButton
              OnClick = Fm_SaborSb_AlteraClick
            end
            inherited Sb_Excluir: TSpeedButton
              Left = 212
              Top = 6
              OnClick = Fm_SaborSb_ExcluirClick
              ExplicitLeft = 212
              ExplicitTop = 6
            end
            inherited Sb_Botao1: TSpeedButton
              Caption = 'Recheio'
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
              Visible = True
              OnClick = Fm_SaborSb_Botao1Click
            end
            inherited Sb_Botao2: TSpeedButton
              Caption = 'Opcionais'
              Glyph.Data = {
                F6060000424DF606000000000000360000002800000018000000180000000100
                180000000000C0060000D60D0000D60D00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFDFDFDFBFBFBF9F9F9F8F8F8F8F8
                F8F9F9F9FBFBFBFCFCFCFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFCFCFCF8F8F8F4F4F4EEEEEE
                EAEAEAE8E8E8E7E7E7E9E9E9ECECECF2F2F2F7F7F7FBFBFBFEFEFEFEFEFEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFBFBFBF3F3F3EA
                EAEAE2E2E2DDDDDDDFDFDFDFDFDFDFDFDFDFDFDFDDDDDDE0E0E0E7E7E7F1F1F1
                F9F9F9FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF8F8
                F8EFEFEFE1E1E1DDDDDDE0E0E0D9D9DCC7C7DCBCBCE2BCBCE3C2C2DED1D1DADF
                DFDFDDDDDDDFDFDFEAEAEAF5F5F5FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FDFDFDF8F8F8ECECECE1E1E1DFDFDFDBDBDDAAABDB8384DB6060DB4C4CE84C4C
                EC5B5BE57979DDA1A1E3CFCFD8DEDEDEDFDFDFE8E8E8F5F5F5FDFDFDFEFEFEFF
                FFFFFFFFFFFEFEFEFBFBFBEFEFEFE1E1E1E0E0E0D5D6DD8788D14E50E04647E7
                4949EA4B4BEE4E4DF24F4FF4504FF45454F07070E4C6C6DFDFDFDFDFDFDFEAEA
                EAF9F9F9FEFEFEFFFFFFFFFFFFFDFDFDF5F5F5E3E3E3E0E0E0D9D9DE696ACD44
                46E04345E44748E94A4BED6262ED6362F25352FA5452FA5150F64E4EF24D4CED
                C5C5DEDEDEDEDFDFDFF0F0F0FBFBFBFFFFFFFEFEFEFAFAFAEDEDEDDFDFDFE5E5
                E58D8ED25B5DE14C4EE14345E44748E94A4BEDB9B9EEB5B4F15453FA5553FB51
                50F64E4EF24B4BEE6D6DDFD0D0D8DDDDDDE7E7E7F7F7F7FDFDFDFEFEFEF7F7F7
                E6E6E6E4E4E4C4C4D76163D57274E54A4DE04344E34647E8494AEBCDCDF6CDCD
                F75150F65251F74F4FF44D4DF04A4AED4D4EE69E9FDFE0E0E0DFDFDFF3F3F3FC
                FCFCFDFDFDF2F2F2E0E0E0E7E7E78E90DB696BDE7678E55254E04143E04445E5
                4747E86B6BEE6E6EEF4C4DF04D4CF04C4CEF4A4AEC4748E94546E57576D5D3D3
                DADEDEDEECECECFBFBFBFBFBFBF0F0F0DFDFDFE2E2E48284D1696CDD797BE359
                5CE03F41DD4243E14445E4BEBEEBDBDBF06B6CE84949EB4849EA4647E84446E5
                4244E15556D6C3C4DCDFDFDFE9E9E9F9F9F9FBFBFBEEEEEEE1E1E1DBDBE27B7D
                CC6C6FDC787BE15C5EDE3D3FDA3F41DE4142E15E5FE2ECECEDC7C7E55E5EE445
                46E54344E34143E13F41DE3F42D9BABBDFE0E0E0E8E8E8F8F8F8FBFBFBEEEEEE
                E1E1E1E0E0E57E81CC696DD9777ADE7679E1494DD94B4DD85A5CDC4245DC6769
                DFE1E1E8C2C2DB3F41DF3E40DD3D3FDB3B3ED84548D1BEBFDDE1E1E1E9E9E9F9
                F9F9FCFCFCF1F1F1DFDFDFEBEBEC898CD56367D57578DC7679DE6165DB999AD7
                CDCEE4585BD9575AD7C9C9DCE6E6E63B3ED93A3DD7393CD6383BD45D60CBCBCC
                DBDFDFDFEBEBEBFAFAFAFDFDFDF4F4F4E2E2E2F1F1F19FA1D96569D07276D974
                77DB7679DD9C9EDEEAEAEAC7C8E5C2C2E0E0E0E3C0C1D7383BD4373AD23639D1
                3539CF8284D3DFDFE1DEDEDEEFEFEFFBFBFBFEFEFEF9F9F9EAEAEAE9E9E9E7E7
                EA6165C76B6FD57175D77377D9797DDAABADDEC4C5E0C2C3DCA5A7D64B4FCE33
                37CE3236CC3135CB484CC9B9BBD5E2E2E2E4E4E4F5F5F5FDFDFDFEFEFEFCFCFC
                F2F2F2E3E3E3F1F1F1BFC1E04B51C76C70D47075D67175D77276D8686CD26064
                CD3337C92F34C82E34C82D33C72D32C68F91CEE4E4E4DFDFDFEDEDEDF9F9F9FE
                FEFEFFFFFFFEFEFEF9F9F9E8E8E8EAEAEAF8F8F8A4A6DD4C51C4676CD16E73D4
                6F73D57074D66D71D56166D25F63D24C52CD3338C47376C2DFDFE2E2E2E2E3E3
                E3F5F5F5FDFDFDFFFFFFFFFFFFFFFFFFFDFDFDF5F5F5E6E6E6EEEEEEFBFBFBCD
                CFE3676CC76266C75A60CA5B61CC5B61CD5B60CC5E62CA5054C09C9FD1E4E4E5
                E3E3E3E2E2E2F0F0F0FCFCFCFEFEFEFFFFFFFFFFFFFFFFFFFEFEFEFBFBFBF3F3
                F3E7E7E7ECECECF6F6F6F5F5F6B2B4D98D90D7888CD18286CD898DD49B9ED3D5
                D5DDE9E9E9E3E3E3E3E3E3EFEFEFFAFAFAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFEFEFEFCFCFCF5F5F5EAEAEAE5E5E5E8E8E8F7F7F7F6F6F6F1F1F1EDED
                EDEFEFEFEEEEEEE4E4E4E0E0E0E6E6E6F2F2F2F9F9F9FDFDFDFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFDFDFDF9F9F9F2F2F2EBEBEBE5E5E5
                E0E0E0DFDFDFDFDFDFDFDFDFE3E3E3EAEAEAF0F0F0F7F7F7FCFCFCFEFEFEFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFC
                FCFCF9F9F9F6F6F6F3F3F3F1F1F1F1F1F1F2F2F2F5F5F5F9F9F9FBFBFBFDFDFD
                FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFE
                FEFEFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              Visible = True
              OnClick = Fm_SaborSb_Botao2Click
            end
          end
          inherited Pnl_Lista: TPanel
            ExplicitWidth = 615
            ExplicitHeight = 301
            inherited StrGrd_Lista: TStringGrid
              Width = 611
              Height = 297
              ExplicitWidth = 611
              ExplicitHeight = 297
            end
          end
          inherited popMenuTamanho: TPopupMenu
            Left = 544
          end
        end
        inherited Pnl_GrupoSubgrupo: TPanel
          Left = 90
          Top = 64
          ExplicitLeft = 90
          ExplicitTop = 64
        end
      end
      inherited tbs_Tamanho: TTabSheet
        OnShow = Fm_CardapioMTtbs_TamanhoShow
        ExplicitWidth = 615
        ExplicitHeight = 352
        inherited Fm_Tamanho: TFm_CardapioPanel
          Width = 615
          Height = 352
          ExplicitWidth = 615
          ExplicitHeight = 352
          inherited Panel4: TPanel
            Top = 301
            Width = 615
            ExplicitTop = 301
            ExplicitWidth = 615
            inherited Sb_Insere: TSpeedButton
              OnClick = Fm_TamahoSb_InsereClick
            end
            inherited Sb_Altera: TSpeedButton
              OnClick = Fm_TamahoSb_AlteraClick
            end
            inherited Sb_Excluir: TSpeedButton
              Left = 206
              OnClick = Fm_TamanhoSb_ExcluirClick
              ExplicitLeft = 206
            end
            inherited Sb_Botao1: TSpeedButton
              OnClick = Fm_TamanhoSb_Botao1Click
            end
            inherited Sb_Botao2: TSpeedButton
              OnClick = Fm_TamanhoSb_Botao2Click
            end
          end
          inherited Pnl_Lista: TPanel
            Width = 615
            Height = 301
            ExplicitWidth = 615
            ExplicitHeight = 301
            inherited StrGrd_Lista: TStringGrid
              Width = 611
              Height = 297
              OnSelectCell = Fm_TamanhoStrGrd_ListaSelectCell
              ExplicitWidth = 611
              ExplicitHeight = 297
            end
          end
          inherited popMenuTamanho: TPopupMenu
            object DesativarTamanho1: TMenuItem
              Caption = 'Desativar Tamanho'
              OnClick = DesativarTamanho1Click
            end
          end
        end
      end
    end
  end
end