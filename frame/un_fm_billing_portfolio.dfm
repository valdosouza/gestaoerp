inherited FmBillingPortfolio: TFmBillingPortfolio
  Height = 35
  ParentFont = False
  ExplicitHeight = 35
  inherited pnl_linha_1: TPanel
    inherited Sb_Carteira: TSpeedButton
      OnClick = Sb_CarteiraClick
    end
    inherited Dblcb_Lista: TDBLookupComboBox
      KeyField = 'CTR_CODIGO'
      ListField = 'CTR_DESCRICAO'
      ListSource = Ds_Lista
    end
  end
  inherited Qr_Lista: TSTQuery
    SQL.Strings = (
      'SELECT * '
      'FROM TB_CARTEIRA_COBRANCA '
      'WHERE CTR_CODBCO=:CTR_CODBCO ')
  end
end
