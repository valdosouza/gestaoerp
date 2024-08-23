unit tblProjeto;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  TProjeto = Class(TObject)

  private
    FPRJ_PATH_LOCAL: TDate;
    FPRJ_PATH_FTP: TDate;
    FPRJ_CODETD: Integer;
    FPRJ_ATUALIZACAO: String;
    FPRJ_HR_FINAL: Ttime;
    FPRJ_HR_INICIAL: TTime;
    FPRJ_DESCRICAO: String;
    FPRJ_CODIGO: Integer;
    FPRJ_NUMERO: String;
    FPRJ_CODSIT: Integer;
    FPRJ_DETALHE: String;
    FPRJ_CODETB: Integer;
    FPRJ_DT_FINAL: TDate;
    FPRJ_DT_INICIAL: TDate;
    FPRJ_DATA: TDate;
    procedure setFPRJ_ATUALIZACAO(const Value: String);
    procedure setFPRJ_CODETB(const Value: Integer);
    procedure setFPRJ_CODETD(const Value: Integer);
    procedure setFPRJ_CODIGO(const Value: Integer);
    procedure setFPRJ_CODSIT(const Value: Integer);
    procedure setFPRJ_DATA(const Value: TDate);
    procedure setFPRJ_DESCRICAO(const Value: String);
    procedure setFPRJ_DETALHE(const Value: String);
    procedure setFPRJ_DT_FINAL(const Value: TDate);
    procedure setFPRJ_DT_INICIAL(const Value: TDate);
    procedure setFPRJ_HR_FINAL(const Value: Ttime);
    procedure setFPRJ_HR_INICIAL(const Value: TTime);
    procedure setFPRJ_NUMERO(const Value: String);
    procedure setFPRJ_PATH_FTP(const Value: TDate);
    procedure setFPRJ_PATH_LOCAL(const Value: TDate);

  public
    property Codigo: Integer read FPRJ_CODIGO write setFPRJ_CODIGO;
    property Estabelecimento: Integer read FPRJ_CODETB write setFPRJ_CODETB;
    property Numero: String read FPRJ_NUMERO write setFPRJ_NUMERO;
    property Data: TDate read FPRJ_DATA write setFPRJ_DATA;
    property Entidade: Integer read FPRJ_CODETD write setFPRJ_CODETD;
    property Situacao: Integer read FPRJ_CODSIT write setFPRJ_CODSIT;
    property Descricao: String read FPRJ_DESCRICAO write setFPRJ_DESCRICAO;
    property Detalhe: String read FPRJ_DETALHE write setFPRJ_DETALHE;
    property DataInicial: TDate read FPRJ_DT_INICIAL write setFPRJ_DT_INICIAL;
    property DataFinal: TDate read FPRJ_DT_FINAL write setFPRJ_DT_FINAL;
    property HoraInicial: TTime read FPRJ_HR_INICIAL write setFPRJ_HR_INICIAL;
    property HoraFinal: Ttime read FPRJ_HR_FINAL write setFPRJ_HR_FINAL;
    property PathLocal: TDate read FPRJ_PATH_LOCAL write setFPRJ_PATH_LOCAL;
    property PathFtp: TDate read FPRJ_PATH_FTP write setFPRJ_PATH_FTP;
    property Atualizacao: String read FPRJ_ATUALIZACAO write setFPRJ_ATUALIZACAO;

  End;

implementation

{ TProjeto }

procedure TProjeto.setFPRJ_ATUALIZACAO(const Value: String);
begin
  FPRJ_ATUALIZACAO := Value;
end;

procedure TProjeto.setFPRJ_CODETB(const Value: Integer);
begin
  FPRJ_CODETB := Value;
end;

procedure TProjeto.setFPRJ_CODETD(const Value: Integer);
begin
  FPRJ_CODETD := Value;
end;

procedure TProjeto.setFPRJ_CODIGO(const Value: Integer);
begin
  FPRJ_CODIGO := Value;
end;

procedure TProjeto.setFPRJ_CODSIT(const Value: Integer);
begin
  FPRJ_CODSIT := Value;
end;

procedure TProjeto.setFPRJ_DATA(const Value: TDate);
begin
  FPRJ_DATA := Value;
end;

procedure TProjeto.setFPRJ_DESCRICAO(const Value: String);
begin
  FPRJ_DESCRICAO := Value;
end;

procedure TProjeto.setFPRJ_DETALHE(const Value: String);
begin
  FPRJ_DETALHE := Value;
end;

procedure TProjeto.setFPRJ_DT_FINAL(const Value: TDate);
begin
  FPRJ_DT_FINAL := Value;
end;

procedure TProjeto.setFPRJ_DT_INICIAL(const Value: TDate);
begin
  FPRJ_DT_INICIAL := Value;
end;

procedure TProjeto.setFPRJ_HR_FINAL(const Value: Ttime);
begin
  FPRJ_HR_FINAL := Value;
end;

procedure TProjeto.setFPRJ_HR_INICIAL(const Value: TTime);
begin
  FPRJ_HR_INICIAL := Value;
end;

procedure TProjeto.setFPRJ_NUMERO(const Value: String);
begin
  FPRJ_NUMERO := Value;
end;

procedure TProjeto.setFPRJ_PATH_FTP(const Value: TDate);
begin
  FPRJ_PATH_FTP := Value;
end;

procedure TProjeto.setFPRJ_PATH_LOCAL(const Value: TDate);
begin
  FPRJ_PATH_LOCAL := Value;
end;

end.
