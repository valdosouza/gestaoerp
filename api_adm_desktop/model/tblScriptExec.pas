unit tblScriptExec;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  TScriptExec = Class(TObject)
  private
    Fscx_codcli: Integer;
    Fscx_codscp: Integer;
    Fscx_resultado: String;
    procedure setFscx_codcli(const Value: Integer);
    procedure setFscx_codscp(const Value: Integer);
    procedure setFscx_resultado(const Value: String);

  public
    property Codigo: Integer read Fscx_codscp write setFscx_codscp;
    property Cliente: Integer read Fscx_codcli write setFscx_codcli;
    property Resultado: String read Fscx_resultado write setFscx_resultado;
    //property DataTime: TDateTime read FSCX_DATATIME write setFSCX_DATATIME;

  End;

implementation
{ TScriptExec }

procedure TScriptExec.setFscx_codcli(const Value: Integer);
begin
  Fscx_codcli := Value;
end;

procedure TScriptExec.setFscx_codscp(const Value: Integer);
begin
  Fscx_codscp := Value;
end;

procedure TScriptExec.setFscx_resultado(const Value: String);
begin
  Fscx_resultado := Value;
end;

end.
