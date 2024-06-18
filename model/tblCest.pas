unit tblCest;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_cest')]
  TCest = Class(TGenericEntity)

  private
    Fcest: String;
    Fncm: String;
    Fdescricao: String;
    procedure setFcest(const Value: String);
    procedure setFdescricao(const Value: String);
    procedure setFncm(const Value: String);

  public

    [FieldName('cest')]
    [KeyField('cest')]
    property Cest: String read Fcest write setFcest;

    [FieldName('ncm')]
    property Ncm: String read Fncm write setFncm;

    [FieldName('descricao')]
    property Descricao: String read Fdescricao write setFdescricao;


  End;

  implementation

{ TCest }

procedure TCest.setFcest(const Value: String);
begin
  Fcest := Value;
end;

procedure TCest.setFdescricao(const Value: String);
begin
  Fdescricao := Value;
end;

procedure TCest.setFncm(const Value: String);
begin
  Fncm := Value;
end;

end.
