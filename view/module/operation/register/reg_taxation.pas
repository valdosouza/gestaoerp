unit reg_taxation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Menus,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Classes, Vcl.Buttons,
  Vcl.ExtCtrls,  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, System.StrUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, STQuery,
  base_registry, ControllerTributacao, un_dm, Un_Fm_ListaEstados;

type
  TRegTaxation = class(TBaseRegistry)
    pl_fundo: TPanel;
    L_Aq_ICMS: TLabel;
    L_Red_Base: TLabel;
    L_Observacao: TLabel;
    Sb_Observacao: TSpeedButton;
    L_Red_Aliq: TLabel;
    L_Natureza: TLabel;
    SB_Natureza: TSpeedButton;
    L_Origem: TLabel;
    E_Aq_ICMS: TEdit;
    E_Red_Base: TEdit;
    E_Red_Aliq: TEdit;
    Pnl_Outros: TGroupBox;
    L_Transacao_Produto: TLabel;
    L_CodigoNCM: TLabel;
    Sb_Classificacao: TSpeedButton;
    chbx_sit_trb: TCheckBox;
    chbx_Consumidor: TCheckBox;
    chbx_micro: TCheckBox;
    chbx_diferido: TCheckBox;
    chbx_destaque: TCheckBox;
    CHBX_ST_ICMS: TCheckBox;
    Cb_Transacao_Produto: TComboBox;
    E_CodigoNCM: TEdit;
    Chbx_Sentido: TCheckBox;
    Pg_Outros: TPageControl;
    tbs_ipi: TTabSheet;
    Panel2: TPanel;
    L_Aq_IPI: TLabel;
    L_Situacao_tributaria_IPI: TLabel;
    Sb_Sit_Trib_IPI: TSpeedButton;
    E_Aq_IPI: TEdit;
    tbs_pis: TTabSheet;
    Panel3: TPanel;
    L_Aq_PIS: TLabel;
    L_Situacao_tributaria_PIS: TLabel;
    Sb_Sit_Trib_PIS: TSpeedButton;
    E_Aq_Pis: TEdit;
    tbs_cofins: TTabSheet;
    Panel4: TPanel;
    L_Aq_Cofins: TLabel;
    L_Situacao_tributaria_CFS: TLabel;
    Sb_Sit_Trib_CFS: TSpeedButton;
    E_Aq_Cofins: TEdit;
    tbs_outros: TTabSheet;
    Panel5: TPanel;
    L_Aq_IRPJ: TLabel;
    L_Aq_CSLL: TLabel;
    L_Aq_Siscomex: TLabel;
    L_Aq_Tec: TLabel;
    L_Aq_ISS: TLabel;
    L_AQ_AFRMM: TLabel;
    E_Aq_IRPJ: TEdit;
    E_Aq_CSLL: TEdit;
    E_Aq_Siscomex: TEdit;
    E_Aq_Tec: TEdit;
    E_Aq_ISS: TEdit;
    E_AQ_AFRMM: TEdit;
    Cb_Origem: TComboBox;
    Chbx_Red_Base_ST: TCheckBox;
    Sb_Sit_Trib_ICMS: TSpeedButton;
    Sb_Sit_Trib_CSOSN: TSpeedButton;
    Sb_Modal_ICMS_St: TSpeedButton;
    Dblcb_Modal_ICMS_ST: TDBLookupComboBox;
    Dblcb_Situacao_tributaria: TDBLookupComboBox;
    L_Situacao_tributaria: TLabel;
    L_Simples_Nacional: TLabel;
    Dblcb_Simples_Nacional: TDBLookupComboBox;
    L_Modal_ICMS: TLabel;
    Dblcb_Modal_ICMS: TDBLookupComboBox;
    L_Modal_ICMS_ST: TLabel;
    Sb_Modal_ICMS: TSpeedButton;
    Sb_Desoneracao: TSpeedButton;
    Dblcb_Desoneracao: TDBLookupComboBox;
    L_Desoneracao: TLabel;
    Dblcb_Situacao_tributaria_IPI: TDBLookupComboBox;
    Dblcb_Situacao_tributaria_PIS: TDBLookupComboBox;
    Dblcb_Situacao_tributaria_CFS: TDBLookupComboBox;
    qr_Desoneracao: TSTQuery;
    Ds_Desoneracao: TDataSource;
    Fm_ListaEstados: TFm_ListaEstados;
    DBLCB_Natureza: TDBLookupComboBox;
    DBLCB_Observacao: TDBLookupComboBox;
    procedure Sb_Sit_Trib_ICMSClick(Sender: TObject);
    procedure Sb_Sit_Trib_CSOSNClick(Sender: TObject);
    procedure Sb_Modal_ICMSClick(Sender: TObject);
    procedure Sb_Modal_ICMS_StClick(Sender: TObject);
    procedure Sb_DesoneracaoClick(Sender: TObject);
    procedure SB_NaturezaClick(Sender: TObject);
    procedure Fm_ListaEstadosDBLCB_UFExit(Sender: TObject);
    procedure Sb_ObservacaoClick(Sender: TObject);
  protected
    procedure ClearAllFields; Override;
    procedure CriarVariaveis; Override;
    procedure FinalizaVariaveis; Override;
    procedure IniciaVariaveis; Override;
    procedure ShowData; Override;
    procedure ShowNoData; Override;
    procedure Insert; Override;
    procedure Change; Override;
    function ValidateDelete():boolean; Override;
    procedure Delete; Override;
    function ValidateSave():boolean; Override;
    procedure Save; Override;
  private
    taxation : TControllerTributacao;

    qr_Situacao_tributaria: TFDQuery;
    ds_Situacao_tributaria: TDataSource;
    qr_Simples_Nacional: TFDQuery;
    ds_Simples_Nacional: TDataSource;
    qr_ICMS: TFDQuery;
    ds_ICMS: TDataSource;
    qr_ICMS_ST: TFDQuery;
    ds_ICMS_ST: TDataSource;
    qr_IPI: TFDQuery;
    ds_IPI: TDataSource;
    qr_PIS: TFDQuery;
    ds_PIS: TDataSource;
    qr_CFS: TFDQuery;
    ds_CFS: TDataSource;

    qr_obs: TFDQuery;
    ds_obs: TDataSource;

    qr_Natureza: TFDQuery;
    ds_Natureza: TDataSource;

    It_Cd_CRT : Integer;

    procedure carregar_Situacao_tributaria;
    procedure carregar_Simples_Nacional;
    procedure carregar_ICMS;
    procedure carregar_ICMS_ST;
    procedure carregar_IPI;
    procedure carregar_PIS;
    procedure carregar_CFS;
    procedure carregar_Obs;
    procedure carregar_Natureza;
    function Fc_VerificaRegraExistente: Boolean;
  end;

var
  RegTaxation: TRegTaxation;

implementation

uses UN_MSG, env, un_sistema, un_regra_negocio, sea_tax_icms_sn, sea_tax_icms_nr,
     sea_cfop, sea_note, sea_tax_mode_det_bc_icms, sea_tax_mode_det_bc_icms_st,
     sea_tax_relieves_icms;

{$R *.dfm}

procedure TRegTaxation.CriarVariaveis;
begin
  inherited;
  taxation := TControllerTributacao.create(self);

  qr_Situacao_tributaria := TFDQuery.Create(nil);
  ds_Situacao_tributaria := TDataSource.Create(nil);
  qr_Simples_Nacional := TFDQuery.Create(nil);
  ds_Simples_Nacional := TDataSource.Create(nil);
  qr_ICMS := TFDQuery.Create(nil);
  ds_ICMS := TDataSource.Create(nil);
  qr_ICMS_ST := TFDQuery.Create(nil);
  ds_ICMS_ST := TDataSource.Create(nil);
  qr_IPI := TFDQuery.Create(nil);
  ds_IPI := TDataSource.Create(nil);
  qr_PIS := TFDQuery.Create(nil);
  ds_PIS := TDataSource.Create(nil);
  qr_CFS := TFDQuery.Create(nil);
  ds_CFS := TDataSource.Create(nil);

  qr_obs := TFDQuery.Create(nil);
  ds_obs := TDataSource.Create(nil);
  qr_Natureza := TFDQuery.Create(nil);
  ds_Natureza := TDataSource.Create(nil);
end;

procedure TRegTaxation.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(taxation);

  qr_Situacao_tributaria.Free;
  ds_Situacao_tributaria.Free;
  qr_Simples_Nacional.Free;
  ds_Simples_Nacional.Free;;
  qr_ICMS.Free;
  ds_ICMS.Free;
  qr_ICMS_ST.Free;
  ds_ICMS_ST.Free;
  qr_IPI.Free;
  ds_IPI.Free;
  qr_PIS.Free;
  ds_PIS.Free;
  qr_CFS.Free;
  ds_CFS.Free;

  qr_obs.Free;
  ds_obs.Free;

  qr_Natureza.Free;
  ds_Natureza.Free;
end;

procedure TRegTaxation.IniciaVariaveis;
begin
  carregar_Situacao_tributaria;
  carregar_Simples_Nacional;
  carregar_ICMS;
  carregar_ICMS_ST;
  qr_Desoneracao.Open;
  carregar_IPI;
  carregar_PIS;
  carregar_CFS;
  carregar_Obs;
  carregar_Natureza;

  Pc_AtivaEstabelecimento;
  It_Cd_CRT := StrToIntDef(DM.Qr_Estabelecimento.FieldByname('EMP_CRT').AsString,3);

  Fm_ListaEstados.Pc_Listar;

  if Self.CodigoRegistro > 0 then
  Begin
    taxation.Registro.Codigo := Self.CodigoRegistro;
    taxation.getbyId;
  End;
  inherited;
end;

procedure TRegTaxation.Change;
begin
  inherited;
  Cb_Origem.SetFocus;
end;

procedure TRegTaxation.ClearAllFields;
begin
  inherited;
  taxation.clear;
end;

procedure TRegTaxation.Delete;
begin
  taxation.delete;
  inherited;
end;

procedure TRegTaxation.Insert;
begin
  inherited;
  Cb_Origem.SetFocus;
end;

procedure TRegTaxation.Save;
begin
  with taxation do
  Begin
    Registro.Estabelecimento := Gb_CodMha;

    Registro.Origem := IntToStr(Cb_Origem.ItemIndex);
    Registro.TribICMS_NR := Dblcb_Situacao_tributaria.KeyValue;
    Registro.TribICMS_SN := Dblcb_Simples_Nacional.KeyValue;
    Registro.DeterBC_ICMS_NR := Dblcb_Modal_ICMS.KeyValue;
    Registro.DeterBC_ICMS_ST := Dblcb_Modal_ICMS_ST.KeyValue;
    Registro.Desoneracao := Dblcb_Desoneracao.KeyValue;

    Registro.AliqICMS := StrToFloatDef(E_Aq_ICMS.Text, 0);
    Registro.RedAliqICMS := StrToFloatDef(E_Red_Aliq.Text, 0);
    Registro.RedBCICMS := StrToFloatDef(E_Red_Base.Text, 0);

    Registro.PropRedBCST := IfThen(Chbx_Red_Base_ST.Checked, SIGLA_S, SIGLA_N);

    Registro.TribIPI := Dblcb_Situacao_tributaria_IPI.KeyValue;
    Registro.AliqIPI := StrToFloatDef(E_Aq_IPI.Text, 0);

    Registro.TribPIS := Dblcb_Situacao_tributaria_PIS.KeyValue;
    Registro.AliqIPI := StrToFloatDef(E_Aq_PIS.Text, 0);

    Registro.TribCofins := Dblcb_Situacao_tributaria_CFS.KeyValue;
    Registro.AliqCofins := StrToFloatDef(E_Aq_COFINS.Text, 0);

    Registro.AliqIRPJ := StrToFloatDef(E_Aq_IRPJ.Text, 0);
    Registro.AliqCSLL := StrToFloatDef(E_Aq_CSLL.Text, 0);
    Registro.AliqSisComex := StrToFloatDef(E_Aq_Siscomex.Text, 0);
    Registro.AliqII := StrToFloatDef(E_Aq_Tec.Text, 0);
    Registro.AliqISS := StrToFloatDef(E_Aq_ISS.Text, 0);
    Registro.AliqAFRMM := StrToFloatDef(E_AQ_AFRMM.Text, 0);

    Registro.TemST := IfThen(chbx_sit_trb.Checked, SIGLA_S, SIGLA_N);
    Registro.Consumidor := IfThen(chbx_Consumidor.Checked, SIGLA_S, SIGLA_N);
    Registro.MicroEmpresa := IfThen(chbx_micro.Checked, SIGLA_S, SIGLA_N);
    Registro.Diferido := IfThen(chbx_diferido.Checked, SIGLA_S, SIGLA_N);
    Registro.Destacar := IfThen(chbx_destaque.Checked, SIGLA_S, SIGLA_N);
    Registro.SubstitutoTributario := IfThen(CHBX_ST_ICMS.Checked, SIGLA_S, SIGLA_N);
    Registro.Sentido := IfThen(Chbx_Sentido.Checked, SIGLA_S, SIGLA_N);

    Registro.Produto := Cb_Transacao_Produto.ItemIndex;

    Registro.Estado := Fm_ListaEstados.DBLCB_UF.KeyValue;
    Registro.NCM := E_CodigoNCM.Text;

    Registro.Observacao := DBLCB_Observacao.KeyValue;
    Registro.CFOP := DBLCB_Natureza.KeyValue;

    salva;
  End;
  CodigoRegistro := taxation.Registro.Codigo;
  inherited;
end;

procedure TRegTaxation.ShowData;
begin
  with taxation do
  begin
    Cb_Origem.ItemIndex := StrToInt(Registro.Origem);
    Dblcb_Situacao_tributaria.KeyValue := Registro.TribICMS_NR;
    Dblcb_Simples_Nacional.KeyValue := Registro.TribICMS_SN;
    Dblcb_Modal_ICMS.KeyValue := Registro.DeterBC_ICMS_NR;
    Dblcb_Modal_ICMS_ST.KeyValue := Registro.DeterBC_ICMS_ST;
    Dblcb_Desoneracao.KeyValue := Registro.Desoneracao;

    E_Aq_ICMS.Text := FloatToStr(Registro.AliqICMS);
    E_Red_Aliq.Text := FloatToStr(Registro.RedAliqICMS);
    E_Red_Base.Text := FloatToStr(Registro.RedBCICMS);

    if Registro.PropRedBCST = SIGLA_S then
      Chbx_Red_Base_ST.Checked := True
    else
      Chbx_Red_Base_ST.Checked := False;

    Dblcb_Situacao_tributaria_IPI.KeyValue := Registro.TribIPI;
    E_Aq_IPI.Text := FloatToStr(Registro.AliqIPI);

    Dblcb_Situacao_tributaria_PIS.KeyValue := Registro.TribPIS;
    E_Aq_PIS.Text := FloatToStr(Registro.AliqPIS);

    Dblcb_Situacao_tributaria_CFS.KeyValue := Registro.TribCofins;
    E_Aq_COFINS.Text := FloatToStr(Registro.AliqCofins);

    E_Aq_IRPJ.Text := FloatToStr(Registro.AliqIRPJ);
    E_Aq_CSLL.Text := FloatToStr(Registro.AliqCSLL);
    E_Aq_Siscomex.Text := FloatToStr(Registro.AliqSisComex);
    E_Aq_Tec.Text := FloatToStr(Registro.AliqII);
    E_Aq_ISS.Text := FloatToStr(Registro.AliqISS);
    E_AQ_AFRMM.Text := FloatToStr(Registro.AliqAFRMM);

    if Registro.TemST = SIGLA_S then
      chbx_sit_trb.Checked := True
    else
      chbx_sit_trb.Checked := False;

    if Registro.Consumidor = SIGLA_S then
      chbx_Consumidor.Checked := True
    else
      chbx_Consumidor.Checked := False;

    if Registro.MicroEmpresa = SIGLA_S then
      chbx_micro.Checked := True
    else
      chbx_micro.Checked := False;

    if Registro.Diferido = SIGLA_S then
      chbx_diferido.Checked := True
    else
      chbx_diferido.Checked := False;

    if Registro.Destacar = SIGLA_S then
      chbx_destaque.Checked := True
    else
      chbx_destaque.Checked := False;

    if Registro.SubstitutoTributario = SIGLA_S then
      CHBX_ST_ICMS.Checked := True
    else
      CHBX_ST_ICMS.Checked := False;

    if Registro.Sentido = SIGLA_S then
      Chbx_Sentido.Checked := True
    else
      Chbx_Sentido.Checked := False;

    Cb_Transacao_Produto.ItemIndex := Registro.Produto;

    Fm_ListaEstados.DBLCB_UF.KeyValue := Registro.Estado;
    E_CodigoNCM.Text := Registro.NCM;

    DBLCB_Observacao.KeyValue := Registro.Observacao;
    DBLCB_Natureza.KeyValue := Registro.CFOP;
  end;
  inherited;
end;

procedure TRegTaxation.ShowNoData;
begin
//
end;

procedure TRegTaxation.Sb_DesoneracaoClick(Sender: TObject);
Var
  Form : TSeaTaxRelievesIcms;
begin
  Form := TSeaTaxRelievesIcms.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Modal_ICMSClick(Sender: TObject);
Var
  Form : TSeaTaxModeDetBcIcms;
begin
  Form := TSeaTaxModeDetBcIcms.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Modal_ICMS_StClick(Sender: TObject);
Var
  Form : TSeaTaxModeDetBcIcmsSt;
begin
  Form := TSeaTaxModeDetBcIcmsSt.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.SB_NaturezaClick(Sender: TObject);
Var
  Form : TSeaCFOP;
begin
  Form := TSeaCFOP.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_ObservacaoClick(Sender: TObject);
Var
  Form : TSeaNote;
begin
  Form := TSeaNote.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Sit_Trib_CSOSNClick(Sender: TObject);
Var
  Form : TSeaTaxIcmsSn;
begin
  Form := TSeaTaxIcmsSn.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

procedure TRegTaxation.Sb_Sit_Trib_ICMSClick(Sender: TObject);
Var
  Form : TSeaTaxIcmsNr;
begin
  Form := TSeaTaxIcmsNr.Create(self);
  Try
    Form.ShowModal;
  Finally
    FreeAndNil(Form);
  End;
end;

function TRegTaxation.ValidateDelete: boolean;
begin
  Result := True;
  inherited;
end;

procedure TRegTaxation.Fm_ListaEstadosDBLCB_UFExit(Sender: TObject);
begin
  inherited;
  if not Chbx_Sentido.Checked then
  Begin
    if (Fm_ListaEstados.DBLCB_UF.Text = '') then
      Pc_Filtra_CFOP('S','N')
    else
    if (Fm_ListaEstados.DBLCB_UF.KeyValue = Fc_Estado(Gb_CodMha,'S')) then
      Pc_Filtra_CFOP('S','E')
    else
    if (Fm_ListaEstados.DBLCB_UF.Text = 'EX') then
      Pc_Filtra_CFOP('S','X')
    else
      Pc_Filtra_CFOP('S','N');
  end
  else
  Begin
    if (Fm_ListaEstados.DBLCB_UF.Text = '') then
      Pc_Filtra_CFOP('E','N')
    else
    if (Fm_ListaEstados.DBLCB_UF.KeyValue = Fc_Estado(Gb_CodMha,'S')) then
      Pc_Filtra_CFOP('E','E')
    else
    if (Fm_ListaEstados.DBLCB_UF.Text = 'EX') then
      Pc_Filtra_CFOP('E','X')
    else
      Pc_Filtra_CFOP('E','N');
  end
end;

function TRegTaxation.ValidateSave: boolean;
begin
  Result := True;

  Fm_ListaEstadosDBLCB_UFExit(Self);

  if (It_Cd_CRT  = 3) or (It_Cd_CRT  = 2) then
  begin
    if Trim(Dblcb_Situacao_tributaria.Text) = EmptyStr then
    begin
      TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria.Caption);
      Result := False;
      Dblcb_Situacao_tributaria.SetFocus;
      Exit;
    end;
  end
  else
  begin
    if TRIM(Dblcb_Simples_Nacional.Text) = EmptyStr then
    begin
      TMsgSetes.ValidaPreenchimentoCampo(L_Simples_Nacional.Caption);
      Result := False;
      Dblcb_Simples_Nacional.SetFocus;
      Exit;
    end;
  end;

  if TRIM(Dblcb_Modal_ICMS.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Modal_ICMS.Caption);
    Dblcb_Modal_ICMS.SetFocus;
    Result := False;
    Exit;
  end;

  if chbx_sit_trb.Checked then
  Begin
    if TRIM(Dblcb_Modal_ICMS_ST.Text) = EmptyStr then
    begin
      TMsgSetes.ValidaPreenchimentoCampo(L_Modal_ICMS_ST.Caption);
      Dblcb_Modal_ICMS_ST.SetFocus;
      Result := False;
      Exit;
    end;
  end;

  if TRIM(DBLCB_Natureza.Text) = EmptyStr then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Natureza.Caption);
    DBLCB_Natureza.SetFocus;
    Result := False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_IPI.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_IPI.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria_IPI.Caption);
    Dblcb_Situacao_tributaria_IPI.SetFocus;
    Result := False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_Cofins.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_CFS.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria_CFS.Caption);
    Dblcb_Situacao_tributaria_CFS.SetFocus;
    Result := False;
    Exit;
  end;

  if (StrToFloatDef(E_Aq_Pis.Text,0) > 0 ) and (trim(Dblcb_Situacao_tributaria_PIS.Text) = EmptyStr) then
  begin
    TMsgSetes.ValidaPreenchimentoCampo(L_Situacao_tributaria_PIS.Caption);
    Dblcb_Situacao_tributaria_PIS.SetFocus;
    Result := False;
    Exit;
  end;

  if Fc_VerificaRegraExistente then
  begin
    MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                   'Já existe uma regra com os dados informados.'+EOLN+
                   'Verifique e tente novamente com dados diferente.'+EOLN,
                    [' OK'],[bEscape],mpAlerta);
    Result := False;
    Exit;
  end;

  if Cb_Transacao_Produto.ItemIndex = 6 then
  Begin
    if StrToFloatDef(E_Aq_ISS.Text,0) = 0 then
    Begin
      MensagemPadrao(' Mensagem ', 'A T E N Ç Ã O!.' + EOLN+EOLN+
                     'Para o Tipo de Transação Prestação de Serviço informa a alíquota I.S.S..'+EOLN+
                     'Verifique e tente novamente.'+EOLN,
                      [' OK'],[bEscape],mpAlerta);
      Result := False;
      Pg_Outros.ActivePageIndex := 3;
      IF E_Aq_ISS.CanFocus then
        E_Aq_ISS.SetFocus;
      Exit;
    end;
  end;
end;

function TRegTaxation.Fc_VerificaRegraExistente:Boolean;
var
  Lc_Qry: TFDQuery;
begin
  Lc_Qry := TFDQuery.Create(nil);
  Lc_Qry.Connection := DM.IBD_Gestao;

  Try
    with Lc_Qry do
    Begin
      SQL.Add('select TRB_CODIGO ' +
              'from tb_tributacao '+
              'where (TRB_CODIGO <>:TRB_CODIGO) AND '+
              'TRB_CODPRO =:TRB_CODPRO AND '+
              'TRB_ORIGEM =:TRB_ORIGEM AND '+
              'TRB_CODTBI_ICMS_NR =:TRB_CODTBI_ICMS_NR AND '+
              'TRB_CODTBI_ICMS_SN =:TRB_CODTBI_ICMS_SN AND '+
              'TRB_CODMDB_ICMS_NR =:TRB_CODMDB_ICMS_NR AND '+
              'TRB_CODMDB_ICMS_ST =:TRB_CODMDB_ICMS_ST AND '+
              'TRB_CODDSI_ICMS =:TRB_CODDSI_ICMS AND '+
              'TRB_AQ_ICMS =:TRB_AQ_ICMS AND '+
              'TRB_RD_AQ_ICMS =:TRB_RD_AQ_ICMS AND '+
              'TRB_RD_BS_ICMS =:TRB_RD_BS_ICMS AND '+
              'TRB_CODTBI_IPI =:TRB_CODTBI_IPI AND '+
              'TRB_AQ_IPI =:TRB_AQ_IPI AND '+
              'TRB_CODTBI_PIS =:TRB_CODTBI_PIS AND '+
              'TRB_AQ_PIS =:TRB_AQ_PIS AND '+
              'TRB_CODTBI_CFS =:TRB_CODTBI_CFS AND '+
              'TRB_AQ_COFINS =:TRB_AQ_COFINS AND '+
              'TRB_AQ_IRPJ =:TRB_AQ_IRPJ AND '+
              'TRB_AQ_CSLL =:TRB_AQ_CSLL AND '+
              'TRB_AQ_SISCOMEX =:TRB_AQ_SISCOMEX AND '+
              'TRB_AQ_II =:TRB_AQ_II AND '+
              'TRB_ST_ICMS =:TRB_ST_ICMS AND '+
              'TRB_CONSUMIDOR =:TRB_CONSUMIDOR AND '+
              'TRB_MICRO =:TRB_MICRO AND '+
              'TRB_DIFERIDO =:TRB_DIFERIDO AND '+
              'TRB_DESTAQUE =:TRB_DESTAQUE AND '+
              'TRB_CODOBS =:TRB_CODOBS AND '+
              'TRB_CODNAT =:TRB_CODNAT AND '+
              'TRB_ESTADO =:TRB_ESTADO AND '+
              'TRB_CODMHA =:TRB_CODMHA AND '+
              'TRB_SUB_TRI =:TRB_SUB_TRI AND '+
              'TRB_CODIGONCM =:TRB_CODIGONCM AND '+
              'TRB_PRODUTO =:TRB_PRODUTO and '+
              'TRB_CODEMP =:TRB_CODEMP ');
      //Passagem de Parametros
      ParamByName('TRB_CODIGO').AsInteger := taxation.Registro.Codigo;

      ParamByName('TRB_CODPRO').AsInteger := taxation.Registro.Produto;
      //ParamByName('TRB_CODEMP').AsInteger := taxation.Registro.Empresa; //nao utilizado

      ParamByName('TRB_ORIGEM').AsInteger := Cb_Origem.ItemIndex;
      if trim(Dblcb_Situacao_tributaria.Text) <> EmptyStr then
        ParamByName('TRB_CODTBI_ICMS_NR').AsInteger := Dblcb_Situacao_tributaria.KeyValue
      else
        ParamByName('TRB_CODTBI_ICMS_NR').AsInteger := 0;

      if trim(Dblcb_Simples_Nacional.Text) <> EmptyStr then
        ParamByName('TRB_CODTBI_ICMS_SN').AsInteger := Dblcb_Simples_Nacional.KeyValue
      else
        ParamByName('TRB_CODTBI_ICMS_SN').AsInteger := 0;

      if trim(Dblcb_Modal_ICMS.Text) <> EmptyStr then
        ParamByName('TRB_CODMDB_ICMS_NR').AsInteger := Dblcb_Modal_ICMS.KeyValue
      else
        ParamByName('TRB_CODMDB_ICMS_NR').AsInteger := 0;

      if trim(Dblcb_Modal_ICMS_ST.Text) <> EmptyStr then
        ParamByName('TRB_CODMDB_ICMS_ST').AsInteger := Dblcb_Modal_ICMS_ST.KeyValue
      else
        ParamByName('TRB_CODMDB_ICMS_ST').AsInteger := 0;

      if trim(Dblcb_Desoneracao.Text) <> EmptyStr then
        ParamByName('TRB_CODDSI_ICMS').AsInteger := Dblcb_Desoneracao.KeyValue
      else
        ParamByName('TRB_CODDSI_ICMS').AsInteger := 0;

      ParamByName('TRB_AQ_ICMS').AsFloat := StrToFloatDef(E_Aq_ICMS.Text,0);
      ParamByName('TRB_RD_AQ_ICMS').AsFloat := StrToFloatDef(E_Red_Aliq.Text,0);
      ParamByName('TRB_RD_BS_ICMS').AsFloat := StrToFloatDef(E_Red_Base.Text,0);

      if trim(Dblcb_Situacao_tributaria_IPI.Text) <> EmptyStr then
        ParamByName('TRB_CODTBI_IPI').AsInteger := Dblcb_Situacao_tributaria_IPI.KeyValue
      else
        ParamByName('TRB_CODTBI_IPI').AsInteger := 0;
      ParamByName('TRB_AQ_IPI').AsFloat := StrToFloatDef(E_Aq_IPI.Text,0);

      if trim(Dblcb_Situacao_tributaria_PIS.Text) <> EmptyStr then
        ParamByName('TRB_CODTBI_PIS').AsInteger := Dblcb_Situacao_tributaria_PIS.KeyValue
      else
        ParamByName('TRB_CODTBI_PIS').AsInteger := 0;
      ParamByName('TRB_AQ_PIS').AsFloat := StrToFloatDef(E_Aq_Pis.Text,0);

      if trim(Dblcb_Situacao_tributaria_CFS.Text) <> EmptyStr then
        ParamByName('TRB_CODTBI_CFS').AsInteger := Dblcb_Situacao_tributaria_CFS.KeyValue
      else
        ParamByName('TRB_CODTBI_CFS').AsInteger := 0;

      ParamByName('TRB_AQ_COFINS').AsFloat := StrToFloatDef(E_Aq_Cofins.Text,0);
      ParamByName('TRB_AQ_IRPJ').AsFloat := StrToFloatDef(E_Aq_IRPJ.Text,0);
      ParamByName('TRB_AQ_CSLL').AsFloat := StrToFloatDef(E_Aq_CSLL.Text,0);
      ParamByName('TRB_AQ_SISCOMEX').AsFloat := StrToFloatDef(E_Aq_Siscomex.Text,0);
      ParamByName('TRB_AQ_II').AsFloat := StrToFloatDef(E_Aq_Tec.Text,0);
      if chbx_sit_trb.Checked then
        ParamByName('TRB_ST_ICMS').AsString := SIGLA_S
      else
        ParamByName('TRB_ST_ICMS').AsString := SIGLA_N;
      if chbx_Consumidor.Checked then
        ParamByName('TRB_CONSUMIDOR').AsString := SIGLA_S
      else
        ParamByName('TRB_CONSUMIDOR').AsString := SIGLA_N;
      IF chbx_micro.Checked then
        ParamByName('TRB_MICRO').AsString := SIGLA_S
      else
        ParamByName('TRB_MICRO').AsString := SIGLA_N;
      if chbx_diferido.Checked then
        ParamByName('TRB_DIFERIDO').AsString := SIGLA_S
      else
        ParamByName('TRB_DIFERIDO').AsString := SIGLA_N;
      IF chbx_destaque.Checked then
        ParamByName('TRB_DESTAQUE').AsString := SIGLA_S
      else
        ParamByName('TRB_DESTAQUE').AsString := SIGLA_N;
      if CHBX_ST_ICMS.Checked then
        ParamByName('TRB_SUB_TRI').AsString := SIGLA_S
      else
        ParamByName('TRB_SUB_TRI').AsString := SIGLA_N;

      ParamByName('TRB_PRODUTO').AsInteger := Cb_Transacao_Produto.ItemIndex;

      IF Trim(DBLCB_Observacao.Text) <> EmptyStr then
        ParamByName('TRB_CODOBS').AsInteger := DBLCB_Observacao.KeyValue
      else
        ParamByName('TRB_CODOBS').AsInteger := 0;

      IF Trim(DBLCB_Natureza.Text) <> EmptyStr then
        ParamByName('TRB_CODNAT').AsInteger := DBLCB_Natureza.KeyValue
      else
        ParamByName('TRB_CODNAT').AsInteger := 0;
      if Trim(Fm_ListaEstados.DBLCB_UF.Text) <> EmptyStr then
        ParamByName('TRB_ESTADO').AsInteger := Fm_ListaEstados.DBLCB_UF.KeyValue
      else
        ParamByName('TRB_ESTADO').Value := null;

      ParamByName('TRB_CODIGONCM').AsString := E_CodigoNCM.Text;
      ParamByName('TRB_CODMHA').AsInteger := Gb_CodMha;

      Active := True;
      FetchAll;
      Result := (RecordCount>0);
    end;
  Finally
    Lc_Qry.Free;
  End;
end;

procedure TRegTaxation.carregar_Situacao_tributaria;
begin
  ds_Situacao_tributaria.DataSet := qr_Situacao_tributaria;
  Dblcb_Situacao_tributaria.ListSource := ds_Situacao_tributaria;

  qr_Situacao_tributaria.Close;
  qr_Situacao_tributaria.Connection := DM.IBD_Gestao;
  qr_Situacao_tributaria.SQL.Text :=
    'select TBI_CODIGO, TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO from TB_TRIB_ICMS_NR';
  qr_Situacao_tributaria.Open;
end;

procedure TRegTaxation.carregar_Simples_Nacional;
begin
  ds_Simples_Nacional.DataSet := qr_Simples_Nacional;
  Dblcb_Simples_Nacional.ListSource := ds_Simples_Nacional;

  qr_Simples_Nacional.Close;
  qr_Simples_Nacional.Connection := DM.IBD_Gestao;
  qr_Simples_Nacional.SQL.Text :=
    'SELECT TBI_CODIGO, TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO from TB_TRIB_ICMS_SN';
  qr_Simples_Nacional.Open;
end;

procedure TRegTaxation.carregar_ICMS;
begin
  ds_ICMS.DataSet := qr_ICMS;
  Dblcb_Modal_ICMS.ListSource := ds_ICMS;

  qr_ICMS.Close;
  qr_ICMS.Connection := DM.IBD_Gestao;
  qr_ICMS.SQL.Text :=
    'SELECT MDB_CODIGO , MDB_GRUPO || '' - '' ||  MDB_DESCRICAO DESCRICAO FROM TB_MOD_DET_BC_ICMS';
  qr_ICMS.Open;
end;

procedure TRegTaxation.carregar_ICMS_ST;
begin
  ds_ICMS_ST.DataSet := qr_ICMS_ST;
  Dblcb_Modal_ICMS_ST.ListSource := ds_ICMS_ST;

  qr_ICMS_ST.Close;
  qr_ICMS_ST.Connection := DM.IBD_Gestao;
  qr_ICMS_ST.SQL.Text :=
    'SELECT MDB_CODIGO , MDB_GRUPO || '' - '' || MDB_DESCRICAO DESCRICAO FROM TB_MOD_DET_BC_ICMS_ST';
  qr_ICMS_ST.Open;
end;

procedure TRegTaxation.carregar_IPI;
begin
  ds_IPI.DataSet := qr_IPI;
  Dblcb_Situacao_tributaria_IPI.ListSource := ds_IPI;

  qr_IPI.Close;
  qr_IPI.Connection := DM.IBD_Gestao;
  qr_IPI.SQL.Text :=
    'SELECT TBI_CODIGO, TBI_GRUPO || '' - '' || TBI_DESCRICAO DESCRICAO FROM TB_TRIB_IPI';
  qr_IPI.Open;
end;

procedure TRegTaxation.carregar_PIS;
begin
  ds_PIS.DataSet := QR_PIS;
  Dblcb_Situacao_tributaria_PIS.ListSource := ds_PIS;

  QR_PIS.Close;
  QR_PIS.Connection := DM.IBD_Gestao;
  QR_PIS.SQL.Text :=
    'SELECT TBP_CODIGO, TBP_GRUPO || '' - '' || TBP_DESCRICAO DESCRICAO FROM TB_TRIB_PIS';
  QR_PIS.Open;
end;

procedure TRegTaxation.carregar_CFS;
begin
  ds_CFS.DataSet := qr_CFS;
  Dblcb_Situacao_tributaria_CFS.ListSource := ds_CFS;

  qr_CFS.Close;
  qr_CFS.Connection := DM.IBD_Gestao;
  qr_CFS.SQL.Text :=
    'SELECT TBC_CODIGO, TBC_GRUPO || '' - '' || TBC_DESCRICAO DESCRICAO FROM TB_TRIB_CFS';
  qr_CFS.Open;
end;

procedure TRegTaxation.carregar_Obs;
begin
  ds_OBS.DataSet := qr_OBS;
  DBLCB_Observacao.ListSource := ds_OBS;

  qr_OBS.Close;
  qr_OBS.Connection := DM.IBD_Gestao;
  qr_OBS.SQL.Text :=
    'SELECT OBS_CODIGO, OBS_DESCRICAO FROM TB_OBSERVACAO WHERE OBS_CODMHA =:OBS_CODMHA ORDER BY OBS_DESCRICAO';
  qr_OBS.ParamByName('OBS_CODMHA').AsInteger := Gb_CodMha;
  qr_OBS.Open;
end;

procedure TRegTaxation.carregar_Natureza;
begin
  ds_Natureza.DataSet := qr_Natureza;
  DBLCB_Natureza.ListSource := ds_Natureza;

  qr_Natureza.Close;
  qr_Natureza.Connection := DM.IBD_Gestao;
  qr_Natureza.SQL.Text :=
    'SELECT NAT_CODIGO, NAT_CFOP || '' - '' || NAT_DESCRICAO CFOP FROM TB_NATUREZA WHERE NAT_ATIVO = ''S'' ';
  qr_Natureza.Open;
end;

end.
