unit tblItensAvulso;

interface

Uses TEntity,CAtribEntity, Variants, SysUtils;

Type
  //nome da classe de entidade
  //nome da classe de entidade
  [TableName('TB_ITENS_AVL')]
  TItensAvulso = Class(TGenericEntity)
  private
    FIAV_DESCRICAO: String;
    FPED_CODIGO: Integer;
    FIAV_UNIDADE: String;
    procedure setFIAV_UNIDADE(const Value: String);
    procedure setFIIAV_DESCRICAO(const Value: String);
    procedure setFPED_CODIGO(const Value: Integer);


  public
    [KeyField('IAV_CODITF')]
    [FieldName('IAV_CODITF')]
    property Codigo: Integer read FPED_CODIGO write setFPED_CODIGO;

    [FieldName('IAV_UNIDADE')]
    property Unidade: String read FIAV_UNIDADE write setFIAV_UNIDADE;

    [FieldName('IAV_DESCRICAO')]
    property Descricao: String read FIAV_DESCRICAO write setFIIAV_DESCRICAO;

  End;

implementation

{ TItensAvulso }

procedure TItensAvulso.setFIAV_UNIDADE(const Value: String);
begin
  FIAV_UNIDADE := Value;
end;

procedure TItensAvulso.setFIIAV_DESCRICAO(const Value: String);
begin
  FIAV_DESCRICAO := Value;
end;

procedure TItensAvulso.setFPED_CODIGO(const Value: Integer);
begin
  FPED_CODIGO := Value;
end;

end.
