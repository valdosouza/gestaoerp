unit tblAdmCliente;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  TAdmCliente = Class(TObject)
  private
    Fcli_vl_cred: Real;
    Fcli_atualizar: String;
    Fcli_codfpg: Integer;
    Fcli_codtrp: Integer;
    Fcli_ativo: String;
    Fcli_lojista: String;
    Fcli_dt_ult_mov: TDate;
    Fcli_codetd: Integer;
    Fcli_st_cred: String;
    Fcli_consumidor: String;
    Fcli_ml_drt: String;
    Fcli_micro_emp: String;
    procedure setFcli_ativo(const Value: String);
    procedure setFcli_atualizar(const Value: String);
    procedure setFcli_codetd(const Value: Integer);
    procedure setFcli_codfpg(const Value: Integer);
    procedure setFcli_codtrp(const Value: Integer);
    procedure setFcli_consumidor(const Value: String);
    procedure setFcli_dt_ult_mov(const Value: TDate);
    procedure setFcli_lojista(const Value: String);
    procedure setFcli_micro_emp(const Value: String);
    procedure setFcli_ml_drt(const Value: String);
    procedure setFcli_st_cred(const Value: String);
    procedure setFcli_vl_cred(const Value: Real);


  public
    property Cliente: Integer read Fcli_codetd  write setFcli_codetd;
    property Consumidor: String read Fcli_consumidor  write setFcli_consumidor;
    property MicroEmpresa: String read Fcli_micro_emp  write setFcli_micro_emp;
    property SituacaoCredito: String read Fcli_st_cred  write setFcli_st_cred;
    property ValorCredito: Real read Fcli_vl_cred  write setFcli_vl_cred;
    property MalaDireta: String read Fcli_ml_drt  write setFcli_ml_drt;
    property Transportadora: Integer read Fcli_codtrp  write setFcli_codtrp;
    property UltimoMovimento: TDate read Fcli_dt_ult_mov  write setFcli_dt_ult_mov;
    property FormaPagto: Integer read Fcli_codfpg  write setFcli_codfpg;
    property Ativo: String read Fcli_ativo  write setFcli_ativo;
    property Atualizar: String read Fcli_atualizar  write setFcli_atualizar;
    property Lojista: String read Fcli_lojista  write setFcli_lojista;

  End;
implementation

{ TAdmCliente }

procedure TAdmCliente.setFcli_ativo(const Value: String);
begin
  Fcli_ativo := Value;
end;

procedure TAdmCliente.setFcli_atualizar(const Value: String);
begin
  Fcli_atualizar := Value;
end;

procedure TAdmCliente.setFcli_codetd(const Value: Integer);
begin
  Fcli_codetd := Value;
end;

procedure TAdmCliente.setFcli_codfpg(const Value: Integer);
begin
  Fcli_codfpg := Value;
end;

procedure TAdmCliente.setFcli_codtrp(const Value: Integer);
begin
  Fcli_codtrp := Value;
end;

procedure TAdmCliente.setFcli_consumidor(const Value: String);
begin
  Fcli_consumidor := Value;
end;

procedure TAdmCliente.setFcli_dt_ult_mov(const Value: TDate);
begin
  Fcli_dt_ult_mov := Value;
end;

procedure TAdmCliente.setFcli_lojista(const Value: String);
begin
  Fcli_lojista := Value;
end;

procedure TAdmCliente.setFcli_micro_emp(const Value: String);
begin
  Fcli_micro_emp := Value;
end;

procedure TAdmCliente.setFcli_ml_drt(const Value: String);
begin
  Fcli_ml_drt := Value;
end;

procedure TAdmCliente.setFcli_st_cred(const Value: String);
begin
  Fcli_st_cred := Value;
end;

procedure TAdmCliente.setFcli_vl_cred(const Value: Real);
begin
  Fcli_vl_cred := Value;
end;

end.
