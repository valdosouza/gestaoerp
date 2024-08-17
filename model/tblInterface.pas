unit tblInterface;

interface

Uses TEntity, CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_INTERFACE')]
  TInterface = Class(TGenericEntity)
  private
    FIFC_CODMNU: integer;
    FIFC_DEIFC_FR_NAME: String;
    FIFC_CODPRJ: integer;
    FIFC_DESCRICAO: String;
    FIPIFC_CODIGO: Integer;
    FIFC_SISTEMA: String;
    FIFC_MENU: String;
    procedure setFIFC_CODIGO(const Value: Integer);
    procedure setFIFC_CODMNU(const Value: integer);
    procedure setFIFC_CODPRJ(const Value: integer);
    procedure setFIFC_DESCRICAO(const Value: String);
    procedure setFIFC_FR_NAME(const Value: String);
    procedure setFIFC_MENU(const Value: String);
    procedure setFIFC_SISTEMA(const Value: String);
  public
    [KeyField('IFC_CODIGO')]
    [FieldName('IFC_CODIGO')]
    property Codigo: Integer read FIPIFC_CODIGO write setFIFC_CODIGO;
    [FieldName('IFC_DESCRICAO')]
    property Descricao: String read FIFC_DESCRICAO write setFIFC_DESCRICAO;
    [FieldName('IFC_FR_NAME')]
    property FrName: String read FIFC_DEIFC_FR_NAME write setFIFC_FR_NAME;
    [FieldName('IFC_CODMNU')]
    property CodMnu: integer read FIFC_CODMNU write setFIFC_CODMNU;
    [FieldName('IFC_SISTEMA')]
    property Sistema: String read FIFC_SISTEMA write setFIFC_SISTEMA;
    [FieldName('IFC_MENU')]
    property Menu: String read FIFC_MENU write setFIFC_MENU;
    [FieldName('IFC_CODPRJ')]
    property CodPrj: integer read FIFC_CODPRJ write setFIFC_CODPRJ;
  end;

implementation

{ TInterface}

procedure TInterface.setFIFC_CODIGO(const Value: Integer);
begin
  FIPIFC_CODIGO := Value;
end;

procedure TInterface.setFIFC_CODMNU(const Value: integer);
begin
  FIFC_CODMNU := Value;
end;

procedure TInterface.setFIFC_CODPRJ(const Value: integer);
begin
  FIFC_CODPRJ := Value;
end;

procedure TInterface.setFIFC_DESCRICAO(const Value: String);
begin
  FIFC_DESCRICAO := Value;
end;

procedure TInterface.setFIFC_FR_NAME(const Value: String);
begin
  FIFC_DEIFC_FR_NAME := Value;
end;

procedure TInterface.setFIFC_MENU(const Value: String);
begin
  FIFC_MENU := Value;
end;

procedure TInterface.setFIFC_SISTEMA(const Value: String);
begin
  FIFC_SISTEMA := Value;
end;

end.
