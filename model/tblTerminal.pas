unit tblTerminal;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_TERMINAL')]
  TTerminal = Class(TGenericEntity)
  private
    FDESCRIPTION: String;
    FID: Integer;
    FPATH_DATABASE: String;
    FPATH_SERVER: String;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFPATH_DATABASE(const Value: String);
    procedure setFPATH_SERVER(const Value: String);

  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('DESCRIPTION')]
    property Descricao: String read FDESCRIPTION write setFDESCRIPTION;

    [FieldName('PATH_SERVER')]
    property Server: String read FPATH_SERVER write setFPATH_SERVER;

    [FieldName('PATH_DATABASE')]
    property Database: String read FPATH_DATABASE write setFPATH_DATABASE;

  End;

implementation

{ TTerminal }

procedure TTerminal.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TTerminal.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TTerminal.setFPATH_DATABASE(const Value: String);
begin
  FPATH_DATABASE := Value;
end;

procedure TTerminal.setFPATH_SERVER(const Value: String);
begin
  FPATH_SERVER := Value;
end;

end.
