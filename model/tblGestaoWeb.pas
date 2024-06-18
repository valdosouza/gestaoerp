unit tblGestaoWeb;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_GESTAO_WEB')]
  TGestaoWeb = Class(TGenericEntity)

  private
    FWEB_ID: Integer;
    FId: Integer;
    FTABELA: String;
    procedure setFId(const Value: Integer);
    procedure setFTABELA(const Value: String);
    procedure setFWEB_ID(const Value: Integer);

  public

    [KeyField('TABELA')]
    [FieldName('TABELA')]
    property Tabela: String read FTABELA write setFTABELA;

    [KeyField('id')]
    [FieldName('id')]
    property Codigo: Integer read FId write setFId;

    [FieldName('WEB_ID')]
    property WebID: Integer read FWEB_ID write setFWEB_ID;


  End;


implementation


{ TGestaoWeb }

procedure TGestaoWeb.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TGestaoWeb.setFTABELA(const Value: String);
begin
  FTABELA := Value;
end;

procedure TGestaoWeb.setFWEB_ID(const Value: Integer);
begin
  FWEB_ID := Value;
end;

end.
