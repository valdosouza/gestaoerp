unit tblVehicleBrand;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_MARCA_VEICULO')]
  TVehicleBrand = Class(TGenericEntity)
  private
    FMRC_CODIGO: Integer;
    FMRC_CODFAB: Integer;
    FMRC_DESCRICAO: String;
    FModeloDescricao: string;
    FMarcasVazio: boolean;
    procedure setFMRC_CODFAB(const Value: Integer);
    procedure setFMRC_CODIGO(const Value: Integer);
    procedure setFMRC_DESCRICAO(const Value: String);
    procedure setFModeloDescricao(const Value: string);
    procedure setFMarcasVazio(const Value: boolean);
  public

    [KeyField('MRC_CODIGO')]
    [FieldName('MRC_CODIGO')]
    property Codigo: Integer read FMRC_CODIGO write setFMRC_CODIGO;

    [FieldName('MRC_DESCRICAO')]
    property Descricao: String read FMRC_DESCRICAO write setFMRC_DESCRICAO;

    [FieldName('MRC_CODFAB')]
    property Fabricante: Integer read FMRC_CODFAB write setFMRC_CODFAB;

    property ModeloDescricao: string read FModeloDescricao write setFModeloDescricao;
    property MarcasVazio: boolean read FMarcasVazio write setFMarcasVazio;

  End;

implementation

{ TVehicleBrand }

procedure TVehicleBrand.setFMarcasVazio(const Value: boolean);
begin
  FMarcasVazio := Value;
end;

procedure TVehicleBrand.setFModeloDescricao(const Value: string);
begin
  FModeloDescricao := Value;
end;

procedure TVehicleBrand.setFMRC_CODFAB(const Value: Integer);
begin
  FMRC_CODFAB := Value;
end;

procedure TVehicleBrand.setFMRC_CODIGO(const Value: Integer);
begin
  FMRC_CODIGO := Value;
end;

procedure TVehicleBrand.setFMRC_DESCRICAO(const Value: String);
begin
  FMRC_DESCRICAO := Value;
end;

end.
