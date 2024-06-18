unit tblRetaguardaWeb;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RETAGUARDA_WEB')]
  TRetaguardaWeb = Class(TGenericEntity)
  private
    FPATH_DB: String;
    FSERVER_DB: String;
    FATIVO: String;
    FID: Integer;
    FUSER_PHRASE: String;
    FPORTA_DB: String;
    FTERMINAL: Integer;
    FUSER_NAME: String;
    procedure setFATIVO(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFPATH_DB(const Value: String);
    procedure setFPORTA_DB(const Value: String);
    procedure setFSERVER_DB(const Value: String);
    procedure setFTERMINAL(const Value: Integer);
    procedure setFUSER_NAME(const Value: String);
    procedure setFUSER_PHRASE(const Value: String);



  public
   [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('ATIVO')]
    property Ativo: String read FATIVO write setFATIVO;

    [FieldName('SERVER_DB')]
    property CaminhoServidor: String read FSERVER_DB write setFSERVER_DB;

    [FieldName('PORTA_DB')]
    property PortaBanco: String read FPORTA_DB write setFPORTA_DB;

    [FieldName('PATH_DB')]
    property CaminhoBancoDados: String read FPATH_DB write setFPATH_DB;

    [FieldName('USER_NAME')]
    property UserName: String read FUSER_NAME write setFUSER_NAME;

    [FieldName('USER_PHRASE')]
    property UserFrase: String read FUSER_PHRASE write setFUSER_PHRASE;

    [FieldName('TERMINAL')]
    property Terminal: Integer read FTERMINAL write setFTERMINAL;

  End;

implementation


{ TRetaguardaWeb }

procedure TRetaguardaWeb.setFATIVO(const Value: String);
begin
  FATIVO := Value;
end;

procedure TRetaguardaWeb.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TRetaguardaWeb.setFPATH_DB(const Value: String);
begin
  FPATH_DB := Value;
end;

procedure TRetaguardaWeb.setFPORTA_DB(const Value: String);
begin
  FPORTA_DB := Value;
end;

procedure TRetaguardaWeb.setFSERVER_DB(const Value: String);
begin
  FSERVER_DB := Value;
end;

procedure TRetaguardaWeb.setFTERMINAL(const Value: Integer);
begin
  FTERMINAL := Value;
end;

procedure TRetaguardaWeb.setFUSER_NAME(const Value: String);
begin
  FUSER_NAME := Value;
end;

procedure TRetaguardaWeb.setFUSER_PHRASE(const Value: String);
begin
  FUSER_PHRASE := Value;
end;

end.
