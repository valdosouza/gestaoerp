object Fm_CardapioMTS: TFm_CardapioMTS
  Left = 0
  Top = 0
  Width = 626
  Height = 394
  TabOrder = 0
  inline Fm_CardapioMT: TFm_CardapioMT
    Left = 0
    Top = 0
    Width = 626
    Height = 394
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 626
    ExplicitHeight = 394
    inherited Pg_Geral: TPageControl
      Width = 626
      Height = 394
      ActivePage = Fm_CardapioMT.tbs_SAbor
      OnChange = Fm_CardapioMTPg_GeralChange
      ExplicitWidth = 626
      ExplicitHeight = 394
      inherited tbs_SAbor: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 30
        ExplicitWidth = 618
        ExplicitHeight = 360
        inherited Fm_Sabor: TFm_CardapioPanel
          Width = 618
          Height = 360
          ExplicitWidth = 618
          ExplicitHeight = 360
          inherited Panel4: TPanel
            Top = 309
            Width = 618
            ExplicitTop = 309
            ExplicitWidth = 618
            inherited Sb_Insere: TSpeedButton
              Left = 5
              Top = 8
              OnClick = Fm_SaborSb_InsereClick
              ExplicitLeft = 5
              ExplicitTop = 8
            end
            inherited Sb_Altera: TSpeedButton
              Left = 99
              Top = 6
              OnClick = Fm_SaborSb_AlteraClick
              ExplicitLeft = 99
              ExplicitTop = 6
            end
            inherited Sb_Excluir: TSpeedButton
              Left = 205
              Top = 8
              OnClick = Fm_SaborSb_ExcluirClick
              ExplicitLeft = 205
              ExplicitTop = 8
            end
            inherited Sb_Botao1: TSpeedButton
              Left = 300
              Caption = 'Bot'#227'o'
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
              Visible = True
              OnClick = Fm_SaborSb_Botao1Click
              ExplicitLeft = 300
            end
            inherited Sb_Botao2: TSpeedButton
              Left = 406
              Top = 6
              ExplicitLeft = 406
              ExplicitTop = 6
            end
            inherited Sb_Botao3: TSpeedButton
              Top = 8
              ExplicitTop = 8
            end
          end
          inherited Pnl_Lista: TPanel
            Width = 618
            Height = 309
            ExplicitWidth = 618
            ExplicitHeight = 309
            inherited StrGrd_Lista: TStringGrid
              Width = 614
              Height = 305
              ParentBiDiMode = False
              ExplicitWidth = 614
              ExplicitHeight = 305
            end
          end
        end
      end
      inherited tbs_Tamanho: TTabSheet
        inherited Fm_Tamanho: TFm_CardapioPanel
          inherited Panel4: TPanel
            ExplicitTop = 309
            ExplicitWidth = 618
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
            ExplicitWidth = 618
            ExplicitHeight = 309
            inherited StrGrd_Lista: TStringGrid
              Width = 614
              Height = 305
              OnSelectCell = Fm_TamanhoStrGrd_ListaSelectCell
              ExplicitWidth = 614
              ExplicitHeight = 305
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
