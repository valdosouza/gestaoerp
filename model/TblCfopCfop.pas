unit TblCfopCfop;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_cfop_cfop')]
  TCfopCfop = Class(TGenericEntity)

  private
    Fnat_codorig: Integer;
    Fnat_coddest: Integer;
    procedure setFnat_coddest(const Value: Integer);
    procedure setFnat_codorig(const Value: Integer);

  public

    [FieldName('nat_codorig')]
    [KeyField('nat_codorig')]
    property Codorig: Integer read Fnat_codorig write setFnat_codorig;

    [FieldName('nat_coddest')]
    property Coddest: Integer read Fnat_coddest write setFnat_coddest;

  End;

  implementation

{ TCfopCfop }

procedure TCfopCfop.setFnat_coddest(const Value: Integer);
begin
  Fnat_coddest := Value;
end;

procedure TCfopCfop.setFnat_codorig(const Value: Integer);
begin
  Fnat_codorig := Value;
end;

end.
