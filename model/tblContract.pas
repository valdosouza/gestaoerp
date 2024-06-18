unit tblContract;

interface

Uses TEntity,CAtribEntity, STQuery;

Type
  //nome da classe de entidade
  [TableName('TB_CONTRACT')]
  TContract = Class(TGenericEntity)
  private
    FTITTLE: String;
    FCONTENTS: String;
    FID: Integer;
    FTB_INSTITUTION_ID: Integer;
    FKIND: String;
    FSQLCMD: String;
    procedure setFCONTENTS(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFKIND(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);
    procedure setFTITTLE(const Value: String);
    procedure setFSQLCMD(const Value: String);

  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('KIND')]
    property Tipo: String read FKIND write setFKIND;

    [FieldName('TITTLE')]
    property Titulo:String  read FTITTLE write setFTITTLE;

    [FieldName('CONTENTS')]
    property Conteudo: String  read FCONTENTS write setFCONTENTS;

    [FieldName('SQLCMD')]
    property SqlComando: String  read FSQLCMD write setFSQLCMD;


  End;


implementation

{ TContract }

procedure TContract.setFCONTENTS(const Value: String);
begin
  FCONTENTS := Value;
end;

procedure TContract.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TContract.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TContract.setFSQLCMD(const Value: String);
begin
  FSQLCMD := Value;
end;

procedure TContract.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TContract.setFTITTLE(const Value: String);
begin
  FTITTLE := Value;
end;

end.
