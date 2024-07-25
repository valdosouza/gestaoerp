unit tblBanco;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //Aqui a empresa é Tipada com EMP_TIPO = 4
  [TableName('TB_EMPRESA')]
  TBanco = Class(TGenericEntity)

  private
    FOBSERV: String;
    FEMAIL: String;
    FCODIGO: Integer;
    FFANTASIA: String;
    FATIVA: String;
    FNOME: String;
    FCNPJ: String;
    FNUMBCO: String;
    FSTATUS: String;
    FSITE: String;
    FDT_FUNDA: TDate;
    FDT_CADASTRO: TDate;
    FINSC_EST: String;
    FNumeroNome: String;
    procedure setFATIVA(const Value: String);
    procedure setFCNPJ(const Value: String);
    procedure setFCODIGO(const Value: Integer);
    procedure setFDT_CADASTRO(const Value: TDate);
    procedure setFDT_FUNDA(const Value: TDate);
    procedure setFEMAIL(const Value: String);
    procedure setFFANTASIA(const Value: String);
    procedure setFINSC_EST(const Value: String);
    procedure setFNOME(const Value: String);
    procedure setFNUMBCO(const Value: String);
    procedure setFOBSERV(const Value: String);
    procedure setFSITE(const Value: String);
    procedure setFSTATUS(const Value: String);
    procedure setfNumeroNome(const Value: String);


   public
    [KeyField('EMP_CODIGO')]
    [FieldName('EMP_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;

    [FieldName('EMP_NOME')]
    property NomeRazaoSocial: String read FNOME write setFNOME;

    [FieldName('EMP_FANTASIA')]
    property ApelidoFantasia: String read FFANTASIA write setFFANTASIA;

    [FieldName('EMP_CNPJ')]
    property CpfCNPJ: String read FCNPJ write setFCNPJ;

    [FieldName('EMP_INSC_EST')]
    property InscricaoEstadual: String read FINSC_EST write setFINSC_EST;

    [FieldName('EMP_OBSERV')]
    property Observacao: String read FOBSERV write setFOBSERV;

    [FieldName('EMP_DT_CADASTRO')]
    property DataCadastro: TDate read FDT_CADASTRO write setFDT_CADASTRO;

    [FieldName('EMP_EMAIL')]
    property Email: String read FEMAIL write setFEMAIL;

    [FieldName('EMP_SITE')]
    property WebSite: String read FSITE write setFSITE;

    [FieldName('EMP_DT_FUNDA')]
    property DataFundacao: TDate read FDT_FUNDA write setFDT_FUNDA;

    [FieldName('EMP_NUMBCO')]
    property Numero: String read FNUMBCO write setFNUMBCO;

    [FieldName('EMP_ATIVA')]
    property Ativa: String read FATIVA write setFATIVA;

    [FieldName('EMP_STATUS')]
    property Status: String read FSTATUS write setFSTATUS;

    property NumeroNome : String read FNumeroNome write setfNumeroNome;

  End;
implementation

{ TBanco }

procedure TBanco.setFATIVA(const Value: String);
begin
  FATIVA := Value;
end;

procedure TBanco.setFCNPJ(const Value: String);
begin
  FCNPJ := Value;
end;

procedure TBanco.setFCODIGO(const Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TBanco.setFDT_CADASTRO(const Value: TDate);
begin
  FDT_CADASTRO := Value;
end;

procedure TBanco.setFDT_FUNDA(const Value: TDate);
begin
  FDT_FUNDA := Value;
end;

procedure TBanco.setFEMAIL(const Value: String);
begin
  FEMAIL := Value;
end;

procedure TBanco.setFFANTASIA(const Value: String);
begin
  FFANTASIA := Value;
end;

procedure TBanco.setFINSC_EST(const Value: String);
begin
  FINSC_EST := Value;
end;

procedure TBanco.setFNOME(const Value: String);
begin
  FNOME := Value;
end;

procedure TBanco.setFNUMBCO(const Value: String);
begin
  FNUMBCO := Value;
end;

procedure TBanco.setfNumeroNome(const Value: String);
begin
  FNumeroNome := Value;
end;

procedure TBanco.setFOBSERV(const Value: String);
begin
  FOBSERV := Value;
end;

procedure TBanco.setFSITE(const Value: String);
begin
  FSITE := Value;
end;

procedure TBanco.setFSTATUS(const Value: String);
begin
  FSTATUS := Value;
end;

end.
