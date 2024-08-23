unit tblInterface;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_INTERFACE')]
  TInterface = Class(TGenericDAO)
  private
    Fifc_codmnu: Integer;
    Fifc_codprj: Integer;
    Fifc_descricao: String;
    Fifc_codigo: Integer;
    Fifc_sistema: String;
    Fifc_menu: String;
    Fifc_fr_name: String;
    procedure setFifc_codigo(const Value: Integer);
    procedure setFifc_codmnu(const Value: Integer);
    procedure setFifc_codprj(const Value: Integer);
    procedure setFifc_descricao(const Value: String);
    procedure setFifc_fr_name(const Value: String);
    procedure setFifc_menu(const Value: String);
    procedure setFifc_sistema(const Value: String);

  public
    [KeyField('IFC_CODIGO')]
    [FieldName('IFC_CODIGO')]
    property Codigo: Integer read Fifc_codigo write setFifc_codigo;

    [FieldName('IFC_CODPRJ')]
    property projeto: Integer read Fifc_codprj write setFifc_codprj;

    [FieldName('IFC_DESCRICAO')]
    property Descricao: String read Fifc_descricao write setFifc_descricao;

    [FieldName('IFC_FR_NAME')]
    property Formulario: String read Fifc_fr_name write setFifc_fr_name;

    [FieldName('IFC_CODMNU')]
    property CodigoMenu: Integer read Fifc_codmnu write setFifc_codmnu;

    [FieldName('IFC_SISTEMA')]
    property Sistema: String read Fifc_sistema write setFifc_sistema;

    [FieldName('IFC_MENU')]
    property Menu: String read Fifc_menu write setFifc_menu;

  End;

implementation


{ TInterface }

procedure TInterface.setFifc_codigo(const Value: Integer);
begin
  Fifc_codigo := Value;
end;

procedure TInterface.setFifc_codmnu(const Value: Integer);
begin
  Fifc_codmnu := Value;
end;

procedure TInterface.setFifc_codprj(const Value: Integer);
begin
  Fifc_codprj := Value;
end;

procedure TInterface.setFifc_descricao(const Value: String);
begin
  Fifc_descricao := Value;
end;

procedure TInterface.setFifc_fr_name(const Value: String);
begin
  Fifc_fr_name := Value;
end;

procedure TInterface.setFifc_menu(const Value: String);
begin
  Fifc_menu := Value;
end;

procedure TInterface.setFifc_sistema(const Value: String);
begin
  Fifc_sistema := Value;
end;

end.
