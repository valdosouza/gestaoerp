unit tblScript;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  TScript = Class(TObject)
  private
    FSCP_CODPRJ: Integer;
    FSCP_CODCLI: Integer;
    FSCP_CODIGO: Integer;
    FSCP_COMANDO: String;
    FSCP_DATATIME: TDateTime;
    procedure setFSCP_CODCLI(const Value: Integer);
    procedure setFSCP_CODIGO(const Value: Integer);
    procedure setFSCP_CODPRJ(const Value: Integer);
    procedure setFSCP_COMANDO(const Value: String);
    procedure setFSCP_DATATIME(const Value: TDateTime);

  public
    property Codigo: Integer read FSCP_CODIGO write setFSCP_CODIGO;
    property projeto: Integer read FSCP_CODPRJ write setFSCP_CODPRJ;
    property Cliente: Integer read FSCP_CODCLI write setFSCP_CODCLI;
    property DataTime: TDateTime read FSCP_DATATIME write setFSCP_DATATIME;
    property Comando: String read FSCP_COMANDO write setFSCP_COMANDO;
  End;

implementation


{ TScript }

procedure TScript.setFSCP_CODCLI(const Value: Integer);
begin
  FSCP_CODCLI := Value;
end;

procedure TScript.setFSCP_CODIGO(const Value: Integer);
begin
  FSCP_CODIGO := Value;
end;

procedure TScript.setFSCP_CODPRJ(const Value: Integer);
begin
  FSCP_CODPRJ := Value;
end;

procedure TScript.setFSCP_COMANDO(const Value: String);
begin
  FSCP_COMANDO := Value;
end;

procedure TScript.setFSCP_DATATIME(const Value: TDateTime);
begin
  FSCP_DATATIME := Value;
end;

end.
