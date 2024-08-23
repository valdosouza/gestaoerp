unit tblProjCliente;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  TProjCliente = Class(TObject)
  private
    FPJC_CODPRJ: Integer;
    FPJC_CODCLI: Integer;
    procedure setFPJC_CODCLI(const Value: Integer);
    procedure setFPJC_CODPRJ(const Value: Integer);

  public
    property Projeto: Integer read FPJC_CODPRJ  write setFPJC_CODPRJ ;
    property Cliente: Integer read FPJC_CODCLI write setFPJC_CODCLI;
  End;

implementation

{ TProjCliente }

procedure TProjCliente.setFPJC_CODCLI(const Value: Integer);
begin
  FPJC_CODCLI := Value;
end;

procedure TProjCliente.setFPJC_CODPRJ(const Value: Integer);
begin
  FPJC_CODPRJ := Value;
end;

end.
