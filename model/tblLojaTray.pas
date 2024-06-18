unit tblLojaTray;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_LOJA_TRAY')]
  TLojaTray = Class(TGenericEntity)

  private
    FId: Integer;
    FTABELA: String;
    FWEB_ID: Integer;
    procedure setFId(const Value: Integer);
    procedure setFTABELA(const Value: String);
    procedure setFWEB_ID(const Value: Integer);

  public
    [KeyField('TABELA')]
    [FieldName('TABELA')]
    property Tabela: String read FTABELA write setFTABELA;

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FId write setFId;

    [FieldName('WEB_ID')]
    property WebID: Integer read FWEB_ID write setFWEB_ID;


  End;


implementation

{ TLojaTray }

procedure TLojaTray.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TLojaTray.setFTABELA(const Value: String);
begin
  FTABELA := Value;
end;

procedure TLojaTray.setFWEB_ID(const Value: Integer);
begin
  FWEB_ID := Value;
end;

end.
