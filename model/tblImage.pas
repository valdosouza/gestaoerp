unit tblImage;


interface

Uses TEntity,CAtribEntity, Data.DB;

Type
  //nome da classe de entidade
  [TableName('TB_IMAGES')]
  TTableImage = Class(TGenericEntity)
  private
    Fcontent: String;
    Flink: String;
    Fid: Integer;
    Ftarget: String;
    Fextension: String;
    Ftb_institution_id: Integer;
    Ftable_id: String;
    Fkind: String;
    Ffile_name: String;
    Fpath_server: String;
    procedure setFcontent(const Value: String);
    procedure setFextension(const Value: String);
    procedure setFfile_name(const Value: String);
    procedure setFid(const Value: Integer);
    procedure setFkind(const Value: String);
    procedure setFlink(const Value: String);
    procedure setFtable_id(const Value: String);
    procedure setFtarget(const Value: String);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFpath_server(const Value: String);
  public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo : Integer read Fid write setFid;

    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [FieldName('KIND')]
    property Tipo : String read Fkind write setFkind;

    [FieldName('TARGET')]
    property Alvo: String read Ftarget write setFtarget;

    [FieldName('TABLE_ID')]
    property IdTabela: String read Ftable_id write setFtable_id;

    [FieldName('FILE_NAME')]
    property NomeArquivo: String read Ffile_name write setFfile_name;

    [FieldName('EXTENSION')]
    property Extensao: String read Fextension write setFextension;

    [FieldName('CONTENT')]
    property Conteudo: String read Fcontent write setFcontent;

    [FieldName('LINK')]
    property link: String read Flink write setFlink;

    property CaminhoServer: String read Fpath_server write setFpath_server;
  End;

implementation

{ TTableImage }

procedure TTableImage.setFcontent(const Value: String);
begin
  Fcontent := Value;
end;

procedure TTableImage.setFextension(const Value: String);
begin
  Fextension := Value;
end;

procedure TTableImage.setFfile_name(const Value: String);
begin
  Ffile_name := Value;
end;

procedure TTableImage.setFid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TTableImage.setFkind(const Value: String);
begin
  Fkind := Value;
end;

procedure TTableImage.setFlink(const Value: String);
begin
  Flink := Value;
end;

procedure TTableImage.setFpath_server(const Value: String);
begin
  Fpath_server := Value;
end;

procedure TTableImage.setFtable_id(const Value: String);
begin
  Ftable_id := Value;
end;

procedure TTableImage.setFtarget(const Value: String);
begin
  Ftarget := Value;
end;

procedure TTableImage.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

end.
