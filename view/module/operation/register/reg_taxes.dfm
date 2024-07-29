inherited RegTaxes: TRegTaxes
  Caption = 'Impostos para a Lucratividade'
  ClientHeight = 236
  ClientWidth = 323
  ExplicitWidth = 335
  ExplicitHeight = 299
  TextHeight = 13
  inherited pnl_botao: TPanel
    Top = 172
    Width = 323
    ExplicitTop = 163
    ExplicitWidth = 317
    inherited SB_Inserir: TSpeedButton
      Left = -304
      ExplicitLeft = -304
    end
    inherited SB_Alterar: TSpeedButton
      Left = -200
      ExplicitLeft = -200
    end
    inherited SB_Excluir: TSpeedButton
      Left = -96
      ExplicitLeft = -96
    end
    inherited SB_Cancelar: TSpeedButton
      Left = 112
      ExplicitLeft = 112
    end
    inherited SB_Sair_0: TSpeedButton
      Left = 216
      ExplicitLeft = 216
    end
    inherited SB_Gravar: TSpeedButton
      Left = 8
      ExplicitLeft = 8
    end
  end
  inherited pnl_fundo: TPanel
    Width = 323
    Height = 172
    ExplicitWidth = 317
    ExplicitHeight = 163
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 319
      Height = 168
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      ExplicitWidth = 313
      ExplicitHeight = 159
      object L_Aq_Pis: TLabel
        Left = 8
        Top = 42
        Width = 70
        Height = 13
        Caption = 'Al'#237'quota do Pis'
        FocusControl = E_Aq_Pis
      end
      object L_Aq_Cofins: TLabel
        Left = 8
        Top = 82
        Width = 87
        Height = 13
        Caption = 'Aliquota do Cofins'
        FocusControl = E_Aq_Cofins
      end
      object L_Aq_CSLL: TLabel
        Left = 151
        Top = 4
        Width = 132
        Height = 13
        Caption = 'Al'#237'quota Contribui'#231#227'o Social'
        FocusControl = E_Aq_CSLL
      end
      object L_Aq_Irpj: TLabel
        Left = 151
        Top = 42
        Width = 79
        Height = 13
        Caption = 'Al'#237'quota do IRPJ'
        FocusControl = E_Aq_Irpj
      end
      object L_Aq_Icms: TLabel
        Left = 7
        Top = 4
        Width = 67
        Height = 13
        Caption = 'Aliquota ICMS'
        FocusControl = E_Aq_Icms
      end
      object E_Aq_Pis: TEdit_Setes
        Left = 8
        Top = 58
        Width = 140
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
        Text = ''
      end
      object E_Aq_Cofins: TEdit_Setes
        Left = 8
        Top = 98
        Width = 140
        Height = 21
        Alignment = taRightJustify
        TabOrder = 2
        Text = ''
      end
      object E_Aq_CSLL: TEdit_Setes
        Left = 151
        Top = 19
        Width = 140
        Height = 21
        Alignment = taRightJustify
        TabOrder = 3
        Text = ''
      end
      object E_Aq_Irpj: TEdit_Setes
        Left = 151
        Top = 58
        Width = 140
        Height = 21
        Alignment = taRightJustify
        TabOrder = 4
        Text = ''
      end
      object E_Aq_Icms: TEdit_Setes
        Left = 7
        Top = 19
        Width = 140
        Height = 21
        Alignment = taRightJustify
        TabOrder = 0
        Text = ''
      end
      object Panel1: TPanel
        Left = 2
        Top = 125
        Width = 315
        Height = 41
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 5
        ExplicitTop = 116
        ExplicitWidth = 309
        DesignSize = (
          315
          41)
        object Btn_Ok: TButton
          Left = 133
          Top = 7
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'OK'
          TabOrder = 0
          ExplicitLeft = 127
        end
        object Btn_Cancelar: TButton
          Left = 212
          Top = 7
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Cancelar'
          TabOrder = 1
          ExplicitLeft = 206
        end
        object Btn_Aplicar: TButton
          Left = 53
          Top = 7
          Width = 79
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Aplicar'
          Enabled = False
          TabOrder = 2
          ExplicitLeft = 47
        end
      end
    end
  end
end
