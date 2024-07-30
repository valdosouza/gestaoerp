unit reg_electronic_slip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,
  base_registry, ControllerBoletoEletronico;


type
  TRegElectronicSlip = class(TBaseRegistry)
    Pnl_fundos: TPanel;
    L_Carteira: TLabel;
    Sb_Carteira: TSpeedButton;
    L_Cedente_Convenio: TLabel;
    L_Varia_Carteira: TLabel;
    L_Modelo_Boleto: TLabel;
    L_Local_Pagamneto: TLabel;
    L_Inst_Pagamento_1: TLabel;
    L_Inst_Pagamento_2: TLabel;
    L_IntrucaoAdicional: TLabel;
    L_Remessa_Retorno: TLabel;
    Sb_Path_remessa: TSpeedButton;
    L_Tx_Multa: TLabel;
    L_Tx_Juros: TLabel;
    L_Protesto: TLabel;
    L_Vl_Tarifa: TLabel;
    L_Dias_Protesto: TLabel;
    L_Tx_Desconto: TLabel;
    L_Vl_Mora_Min: TLabel;
    L_LayoutRemessa: TLabel;
    L_CodTransmissao: TLabel;
    L_Posto_Benef: TLabel;
    L_Negativacao: TLabel;
    L_Dias_Negativacao: TLabel;
    cb_Carteira: TComboBox;
    E_Cedente_Convenio: TEdit;
    E_Varia_Carteira: TEdit;
    Cb_Modelo_Boleto: TComboBox;
    E_Local_Pagamento: TEdit;
    E_Inst_Pagamento_1: TEdit;
    E_Inst_Pagamento_2: TEdit;
    E_Path_Remessa_Retorno: TEdit;
    E_Tx_Multa: TEdit;
    E_Tx_Juros: TEdit;
    Cb_Protesto: TComboBox;
    DBMemo1: TMemo;
    E_Tx_Mora: TEdit;
    E_VL_Tarifa: TEdit;
    E_Dias_Protesto: TEdit;
    RG_Aceite: TRadioGroup;
    E_Tx_Desconto: TEdit;
    E_VL_MORA_MIN: TEdit;
    Cb_LayoutRemessa: TComboBox;
    E_CodTransmissao: TEdit;
    E_POSTO_BENEF: TEdit;
    Cb_Negativacao: TComboBox;
    E_Dias_Negativacao: TEdit;
    L_Tx_Mora: TLabel;
  protected
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
  public
    boletoEletronico : TControllerBoletoEletronico;
  end;

var
  RegElectronicSlip: TRegElectronicSlip;

implementation

{$R *.dfm}

uses UN_MSG;

{ TRegElectronicSlip }

procedure TRegElectronicSlip.Change;
begin
  inherited;
  cb_Carteira.SetFocus;
end;

procedure TRegElectronicSlip.CriarVariaveis;
begin
  inherited;
  boletoEletronico := TControllerboletoEletronico.create(self);
end;

procedure TRegElectronicSlip.Delete;
begin
  boletoEletronico.delete;
  inherited;
end;

procedure TRegElectronicSlip.FinalizaVariaveis;
begin
  inherited;
  FreeAndNil(boletoEletronico);
end;

procedure TRegElectronicSlip.IniciaVariaveis;
begin
  if Self.CodigoRegistro > 0 then
  Begin
    boletoEletronico.Registro.Codigo := Self.CodigoRegistro;
    boletoEletronico.getbyId;
  End;
  inherited;
end;

procedure TRegElectronicSlip.Insert;
begin
  inherited;
  cb_Carteira.SetFocus;
end;

procedure TRegElectronicSlip.Save;
begin
  with boletoEletronico do
  Begin

 //   Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text




    {Registro.Descricao := E_Descricao.Text;
    Registro.Caminho := E_Caminho.Text;
    Registro.Salto := StrToIntDef(E_Salto.Text, 0);
    Registro.Vias := StrToIntDef(E_Vias.Text, 0);
    Registro.Colunas := StrToIntDef(E_Colunas.Text, 0);
    Registro.Modelo := IfThen(Ch_Tipo.Checked, SIM, NAO); }
    salva;
  End;
  CodigoRegistro := boletoEletronico.Registro.Codigo;
  inherited;
end;

procedure TRegElectronicSlip.ShowData;
begin
  with boletoEletronico do
  Begin
    {E_Descricao.Text  := Registro.Descricao;
    E_Caminho.Text := Registro.Caminho;
    E_Salto.Text := IntToStr(Registro.Salto);
    E_Vias.Text := IntToStr(Registro.Vias);
    E_Colunas.Text := IntToStr(Registro.Colunas);

    if Registro.Modelo = SIM then
      Ch_Tipo.Checked := True
    else
      Ch_Tipo.Checked := False;     }
  End;
  inherited;
end;

procedure TRegElectronicSlip.ShowNoData;
begin
  cb_Carteira.ItemIndex := -1;
end;

function TRegElectronicSlip.ValidateDelete: boolean;
begin
  Result := True;
  if (TMsg.Excluir = mrBotao1) then
  Begin
    Result := False;
    exit;
  End;



  {if (MensagemPadrao('Mensagem de Confirmação',
                     'Excluir a carteira de cobraça de seus arquivos.'+EOLN+EOLN+
                     'Confirmar a exclusão ?',
                    ['Sim','Não'],[bEscape,bNormal],mpConfirmacao,clRed) = mrBotao1) then
  begin
    try
      Tb_BoletoEletronico.Delete;
      if Tb_BoletoEletronico.Transaction.InTransaction then Tb_BoletoEletronico.Transaction.CommitRetaining;
      PC_Buscar;
      Pg_Interface.ActivePage := tbs_Pesquisa;
    except
      MensagemPadrao('Mensagem de erro','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Um erro impossibilitou a exclusão dos dados.'+EOLN+
                     'Entre em contato com o suporte técnico.'+EOLN,
                    ['OK'],[bEscape],mpErro);
    end;
  end;}

end;

function TRegElectronicSlip.ValidateSave: boolean;
begin
  Result := True;
  (*
  if (trim(Fm_ListaContaBancaria.DBLCB_ContaBancaria.Text) = EmptyStr) then
  begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo Conta Corrente não informado.'+EOLN+
                   'Preenchimento obrigatório.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result := False;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Exit;


    {TMsg.ValidaPreenchimentoCampo(Fm_ListaContaBancaria.Label16.Caption);
    Result := False;
    Fm_ListaContaBancaria.DBLCB_ContaBancaria.SetFocus;
    Exit;}
  end;

  if (Trim(cb_Carteira.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(L_Carteira.Caption);
    Result := False;
    cb_Carteira.SetFocus;
    Exit;
  end;

  if (trim( Fm_ListaEspecieDoc.Dblcb_Especie_Doc.Text ) = EmptyStr) then
  begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Campo Espécie de Documento não informado.'+EOLN+
                   'Preenchimento obrigatório.'+EOLN,
                    ['OK'],[bEscape],mpAlerta);
    Result := False;
    Fm_ListaEspecieDoc.Dblcb_Especie_Doc.SetFocus;
    Exit;

    {TMsg.ValidaPreenchimentoCampo(Fm_ListaEspecieDoc.Label1.Caption);
    Result := False;
    Fm_ListaEspecieDoc.Dblcb_Especie_Doc.SetFocus;
    Exit;}
  end;

  if (Trim(Cb_Modelo_Boleto.Text) = EmptyStr) then
  begin
    TMsg.ValidaPreenchimentoCampo(l_Modelo_Boleto.Caption);
    Result := False;
    Cb_Modelo_Boleto.SetFocus;
    Exit;
  end;

  if ((Copy(Cb_Protesto.text,1,1) = '1') or (Copy(Cb_Protesto.text,1,1) = '2')) and
    (Trim(E_Dias_Protesto.Text) = EmptyStr)   then
  begin
    Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                   'Para campo protesto igual a 1 ou 2 torna obrigatório '+EOLN+
                   'o preenchimento do campo Nr dias'+EOLN,
                   ['OK'],[bEscape],mpAlerta);
    Result := False;
    E_Dias_Protesto.SetFocus;
    Exit;
  end;

  if (Fm_ListaContaBancaria.Qr_ContaBancaria.FieldByName('EMP_NUMBCO').AsString = '748') then
  begin
    if (Trim(E_POSTO_BENEF.Text) = EmptyStr) then
    begin
      Mensagem('Mensagem ','A T E N Ç Ã O!.'+EOLN+EOLN+
                     'Para Banco Sicred, favor informar campo Posto Beneficiário.'+EOLN+
                     'Preenchimento obrigatório.'+EOLN,
                      ['OK'],[bEscape],mpAlerta);
      Result := False;
      E_POSTO_BENEF.SetFocus;
      Exit;
    end;
  end;   *)
end;

end.
