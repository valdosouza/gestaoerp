program Gestao;

uses
  Vcl.Forms,
  main in 'main.pas' {FrMain},
  un_dm in 'un_dm.pas' {DM: TDataModule},
  Un_Base in 'view\inheritable\Un_Base.pas' {Fr_Base},
  base_search in 'view\inheritable\base_search.pas' {BaseSearch},
  base_registry in 'view\inheritable\base_registry.pas' {BaseRegistry},
  UN_TabelasEmListas in 'UN_TabelasEmListas.pas' {DM_ListaConsultas: TDataModule},
  env in 'env.pas',
  prm_receipt in 'parameter\prm_receipt.pas',
  prm_historico_bancario in 'parameter\prm_historico_bancario.pas',
  prm_electronic_card in 'parameter\prm_electronic_card.pas',
  tblBanco in 'model\tblBanco.pas' {,
  reg_banking_account in 'view\module\banking\register\reg_banking_account.pas' {RegBankingAccount},
  reg_banking_account in 'view\module\banking\register\reg_banking_account.pas' {RegBankingAccount},
  reg_banking_history in 'view\module\banking\register\reg_banking_history.pas' {RegBankingHistory},
  reg_billing_portfolio in 'view\module\banking\register\reg_billing_portfolio.pas' {RegBillingPortfolio},
  reg_electronic_card in 'view\module\banking\register\reg_electronic_card.pas' {RegElectronicCard},
  reg_electronic_slip in 'view\module\banking\register\reg_electronic_slip.pas' {RegElectronicSlip},
  sea_banking_account in 'view\module\banking\register\sea_banking_account.pas' {SeaBankingAccount},
  sea_banking_history in 'view\module\banking\register\sea_banking_history.pas' {SeaBankingHistory},
  sea_electronic_card in 'view\module\banking\register\sea_electronic_card.pas' {SeaEletronicCard},
  sea_electronic_slip in 'view\module\banking\register\sea_electronic_slip.pas' {SeaElectronicSlip},
  reg_collaborator in 'view\module\human_resource\register\reg_collaborator.pas' {RegCollaborator},
  reg_job_position in 'view\module\human_resource\register\reg_job_position.pas' {RegJobPosition},
  sea_collaborator in 'view\module\human_resource\register\sea_collaborator.pas' {SeaCollaborator},
  sea_job_position in 'view\module\human_resource\register\sea_job_position.pas' {SeaJobPosition},
  reg_commitment in 'view\module\operation\admin\reg_commitment.pas' {RegCommitment},
  reg_config_tag in 'view\module\operation\admin\reg_config_tag.pas' {RegConfigTag},
  reg_printers in 'view\module\operation\admin\reg_printers.pas' {RegPrinters},
  reg_users in 'view\module\operation\admin\reg_users.pas' {RegUsers},
  reg_virtual_shop in 'view\module\operation\admin\reg_virtual_shop.pas' {RegVirtualShop},
  sea_printers in 'view\module\operation\admin\sea_printers.pas' {SeaPrinters},
  sea_users in 'view\module\operation\admin\sea_users.pas' {SeaUsers},
  reg_banner_site in 'view\module\operation\register\reg_banner_site.pas' {RegBannerSite},
  reg_category in 'view\module\operation\register\reg_category.pas' {RegCategory},
  reg_city in 'view\module\operation\register\reg_city.pas' {RegCity},
  reg_ext_motive in 'view\module\operation\register\reg_ext_motive.pas' {RegExtMotive},
  reg_group_menu in 'view\module\operation\register\reg_group_menu.pas' {RegGroupMenu},
  reg_package in 'view\module\operation\register\reg_package.pas' {RegPackage},
  reg_subgroup_menu in 'view\module\operation\register\reg_subgroup_menu.pas' {RegSubgroupMenu},
  reg_uf in 'view\module\operation\register\reg_uf.pas' {RegUf},
  sea_banner_site in 'view\module\operation\register\sea_banner_site.pas' {SeaBannerSite},
  sea_category in 'view\module\operation\register\sea_category.pas' {SeaCategory},
  sea_city in 'view\module\operation\register\sea_city.pas' {SeaCity},
  sea_config_tag in 'view\module\operation\register\sea_config_tag.pas' {SeaConfigTag},
  sea_ext_motive in 'view\module\operation\register\sea_ext_motive.pas' {SeaExtMotive},
  sea_group_menu in 'view\module\operation\register\sea_group_menu.pas' {SeaGroupMenu},
  sea_package in 'view\module\operation\register\sea_package.pas' {SeaPackage},
  sea_uf in 'view\module\operation\register\sea_uf.pas' {SeaUf},
  reg_receipt in 'view\module\operation\task\reg_receipt.pas' {RegReceipt},
  sea_receipt in 'view\module\operation\task\sea_receipt.pas' {SeaReceipt},
  Un_envia_email in 'view\module\operation\task\Un_envia_email.pas' {Fr_envia_email},
  Un_Fm_CardapioPanel in 'frame\Un_Fm_CardapioPanel.pas' {Fm_CardapioPanel: TFrame},
  Un_Especie_Doc in 'view\module\banking\register\Un_Especie_Doc.pas' {Fr_Especie_Doc};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDM_ListaConsultas, DM_ListaConsultas);
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(TFr_Especie_Doc, Fr_Especie_Doc);
  Application.Run;
end.
