unit tblItensIfc;

interface

Uses GenericEntity,GenericDao,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_IFC')]
  TItensIfc = Class(TObject)
  private
    Fiif_codopf: Integer;
    Fiif_codigo: Integer;
    Fiif_codifc: Integer;
    procedure setFiif_codifc(const Value: Integer);
    procedure setFiif_codigo(const Value: Integer);
    procedure setFiif_codopf(const Value: Integer);

  public
    [KeyField('IIF_CODIGO')]
    [FieldName('IIF_CODIGO')]
    property Codigo: Integer read Fiif_codigo write setFiif_codigo;

    [FieldName('IIF_CODIFC')]
    property CodigoInterface: Integer read Fiif_codifc write setFiif_codifc;

    [FieldName('IIF_CODOPF')]
    property Operacao: Integer read Fiif_codopf write setFiif_codopf;
  End;


implementation

{ TItensIfc }

procedure TItensIfc.setFiif_codifc(const Value: Integer);
begin
  Fiif_codifc := Value;
end;

procedure TItensIfc.setFiif_codigo(const Value: Integer);
begin
  Fiif_codigo := Value;
end;

procedure TItensIfc.setFiif_codopf(const Value: Integer);
begin
  Fiif_codopf := Value;
end;

end.
