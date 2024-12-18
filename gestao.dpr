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
  reg_city in 'view\module\operation\register\reg_city.pas' {RegCity},
  reg_ext_motive in 'view\module\operation\register\reg_ext_motive.pas' {RegExtMotive},
  reg_group_menu in 'view\module\operation\register\reg_group_menu.pas' {RegGroupMenu},
  reg_package in 'view\module\operation\register\reg_package.pas' {RegPackage},
  reg_subgroup_menu in 'view\module\operation\register\reg_subgroup_menu.pas' {RegSubgroupMenu},
  reg_uf in 'view\module\operation\register\reg_uf.pas' {RegUf},
  sea_banner_site in 'view\module\operation\register\sea_banner_site.pas' {SeaBannerSite},
  sea_city in 'view\module\operation\register\sea_city.pas' {SeaCity},
  sea_config_tag in 'view\module\operation\register\sea_config_tag.pas' {SeaConfigTag},
  sea_ext_motive in 'view\module\operation\register\sea_ext_motive.pas' {SeaExtMotive},
  sea_group_menu in 'view\module\operation\register\sea_group_menu.pas' {SeaGroupMenu},
  sea_package in 'view\module\operation\register\sea_package.pas' {SeaPackage},
  sea_uf in 'view\module\operation\register\sea_uf.pas' {SeaUf},
  reg_receipt in 'view\module\operation\task\reg_receipt.pas' {RegReceipt},
  sea_receipt in 'view\module\operation\task\sea_receipt.pas' {SeaReceipt},
  Un_envia_email in 'view\module\operation\task\Un_envia_email.pas' {Fr_envia_email},
  Un_Especie_Doc in 'view\module\banking\register\Un_Especie_Doc.pas' {Fr_Especie_Doc},
  un_fm_billing_portfolio in 'frame\un_fm_billing_portfolio.pas' {FmBillingPortfolio: TFrame},
  Un_Fm_ListaEspecieDoc in 'frame\Un_Fm_ListaEspecieDoc.pas' {Fm_ListaEspecieDoc: TFrame},
  Un_Fm_ListaContaBancaria in 'frame\Un_Fm_ListaContaBancaria.pas' {Fm_ListaContaBancaria: TFrame},
  base_frame_list in 'view\inheritable\base_frame_list.pas' {BaseFrameList: TFrame},
  reg_banking_account in 'view\module\banking\register\reg_banking_account.pas' {RegBankingAccount},
  reg_banking_history in 'view\module\banking\register\reg_banking_history.pas' {RegBankingHistory},
  reg_billing_portfolio in 'view\module\banking\register\reg_billing_portfolio.pas' {RegBillingPortfolio},
  reg_electronic_slip in 'view\module\banking\register\reg_electronic_slip.pas' {RegElectronicSlip},
  sea_banking_account in 'view\module\banking\register\sea_banking_account.pas' {SeaBankingAccount},
  sea_banking_history in 'view\module\banking\register\sea_banking_history.pas' {SeaBankingHistory},
  sea_electronic_card in 'view\module\banking\register\sea_electronic_card.pas' {SeaEletronicCard},
  sea_electronic_slip in 'view\module\banking\register\sea_electronic_slip.pas' {SeaElectronicSlip},
  reg_measure in 'view\module\operation\register\reg_measure.pas' {RegMeasure},
  prm_itens_ifc in 'parameter\prm_itens_ifc.pas',
  Un_PesqEndereco in 'view\module\operation\admin\Un_PesqEndereco.pas' {Fr_PesqEndereco},
  Un_Fm_ListaMultiEmpresa in 'frame\Un_Fm_ListaMultiEmpresa.pas' {Fm_ListaMultiEmpresa: TFrame},
  reg_quotation_log in 'view\module\operation\register\reg_quotation_log.pas' {RegQuotationLog},
  ControllerItensCotacao in 'controller\ControllerItensCotacao.pas',
  reg_profile in 'view\module\operation\register\reg_profile.pas' {RegProfile},
  rg_privilege in 'view\module\operation\register\rg_privilege.pas' {RgPrivilege},
  reg_interface in 'view\module\operation\register\reg_interface.pas' {RegInterface},
  reg_oper_interface in 'view\module\operation\register\reg_oper_interface.pas' {RegOperInterface},
  sea_oper_interface in 'view\module\operation\register\sea_oper_interface.pas' {SeaOperInterface},
  tblTaxModeDetBcIcms in 'model\tblTaxModeDetBcIcms.pas',
  tblTaxModeDetBcIcmsSt in 'model\tblTaxModeDetBcIcmsSt.pas',
  tblTaxRelievesIcms in 'model\tblTaxRelievesIcms.pas',
  reg_technical_assistance in 'view\module\operation\task\reg_technical_assistance.pas' {RegTechnicalAssistance},
  sea_technical_assistance in 'view\module\operation\task\sea_technical_assistance.pas' {SeaTechnicalAssistance},
  cfg_technical_assistance in 'view\module\operation\task\cfg_technical_assistance.pas' {CfgTechnicalAssistance},
  sea_customer_origin in 'view\module\operation\register\sea_customer_origin.pas' {SeaCustomerOrigin},
  reg_customer_origin in 'view\module\operation\register\reg_customer_origin.pas' {RegCustomerOrigin},
  reg_button_image in 'view\module\operation\register\reg_button_image.pas' {RegButtonImage},
  sea_tax_icms_sn in 'view\module\operation\register\sea_tax_icms_sn.pas' {SeaTaxIcmsSn},
  reg_tax_icms_sn in 'view\module\operation\register\reg_tax_icms_sn.pas' {RegTaxIcmsSn},
  sea_tax_icms_nr in 'view\module\operation\register\sea_tax_icms_nr.pas' {SeaTaxIcmsNr},
  reg_tax_icms_nr in 'view\module\operation\register\reg_tax_icms_nr.pas' {RegTaxIcmsNr},
  reg_stocks in 'view\module\operation\register\reg_stocks.pas' {RegStocks},
  sea_stocks in 'view\module\operation\register\sea_stocks.pas' {SeaStocks},
  reg_category in 'view\module\operation\register\reg_category.pas' {RegCategory},
  reg_coating in 'view\module\operation\register\reg_coating.pas' {RegCoating},
  sea_coating in 'view\module\operation\register\sea_coating.pas' {SeaCoating},
  sea_button_image in 'view\module\operation\register\sea_button_image.pas' {SeaButtonImage},
  reg_electronic_card in 'view\module\banking\register\reg_electronic_card.pas' {RegElectronicCard},
  sea_category in 'view\module\operation\register\sea_category.pas' {SeaCategory},
  sea_kind_profitability in 'view\module\operation\register\sea_kind_profitability.pas' {Seakindprofitability},
  reg_subgroup in 'view\module\operation\register\reg_subgroup.pas' {RegSubgroup},
  sea_service in 'view\module\operation\register\sea_service.pas' {SeaService};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TDM_ListaConsultas, DM_ListaConsultas);
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(TSeaButtonImage, SeaButtonImage);
  Application.CreateForm(TRegElectronicCard, RegElectronicCard);
  Application.CreateForm(TSeaCategory, SeaCategory);
  Application.CreateForm(TSeakindprofitability, Seakindprofitability);
  Application.CreateForm(TRegSubgroup, RegSubgroup);
  Application.CreateForm(TSeaService, SeaService);
  Application.Run;
end.
