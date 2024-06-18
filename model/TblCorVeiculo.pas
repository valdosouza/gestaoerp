unit TblCorVeiculo;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_cor_veiculo')]
  TCorVeiculo = Class(TGenericEntity)

  private
    Fcor_codigo: Integer;
    Fcor_renavam: String;
    Fcor_descricao: String;
    procedure setFcor_codigo(const Value: Integer);
    procedure setFcor_descricao(const Value: String);
    procedure setFcor_renavam(const Value: String);


  public

    [FieldName('cor_codigo')]
    [KeyField('cor_codigo')]
    property Codigo: Integer read Fcor_codigo write setFcor_codigo;

    [FieldName('cor_renavam')]
    property Renavam: String read Fcor_renavam write setFcor_renavam;

    [FieldName('cor_descricao')]
    property Descricao: String read Fcor_descricao write setFcor_descricao;


  End;

  implementation


{ TContato }

procedure TContato.setFcor_codigo(const Value: Integer);
begin
  Fcor_codigo := Value;
end;

procedure TContato.setFcor_descricao(const Value: String);
begin
  Fcor_descricao := Value;
end;

procedure TContato.setFcor_renavam(const Value: String);
begin
  Fcor_renavam := Value;
end;

end.
