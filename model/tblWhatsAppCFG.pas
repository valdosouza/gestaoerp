unit tblWhatsAppCFG;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_WHATSAPP_CFG')]
  TWhatsAppCFG = Class(TGenericEntity)

  private
    FDESCRIPTION: String;
    FId: Integer;
    FURL_SEND: String;
    FTOKEN: String;
    FTOKEN_AUTH: String;
    FTB_INSTITUTION_ID: Integer;
    procedure setFDESCRIPTION(const Value: String);
    procedure setFId(const Value: Integer);
    procedure setFTOKEN(const Value: String);
    procedure setFTOKEN_AUTH(const Value: String);
    procedure setFURL_SEND(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);

  public

    [FieldName('ID')]
    [KeyField('ID')]
    property Codigo: Integer read FId write setFId;

    [FieldName('TB_INSTITUTION_ID')]
    [KeyField('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('DESCRIPTION')]
    property Descricao: String read FDESCRIPTION write setFDESCRIPTION;

    [FieldName('URL_SEND')]
    property urlSend: String read FURL_SEND write setFURL_SEND;

    [FieldName('TOKEN')]
    property Token: String read FTOKEN write setFTOKEN;

    [FieldName('TOKEN_AUTH')]
    property TokenAuth: String read FTOKEN_AUTH write setFTOKEN_AUTH;


  End;

implementation


{ TWhatsAppCFG }

procedure TWhatsAppCFG.setFDESCRIPTION(const Value: String);
begin
  FDESCRIPTION := Value;
end;

procedure TWhatsAppCFG.setFId(const Value: Integer);
begin
  FId := Value;
end;

procedure TWhatsAppCFG.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TWhatsAppCFG.setFTOKEN(const Value: String);
begin
  FTOKEN := Value;
end;

procedure TWhatsAppCFG.setFTOKEN_AUTH(const Value: String);
begin
  FTOKEN_AUTH := Value;
end;

procedure TWhatsAppCFG.setFURL_SEND(const Value: String);
begin
  FURL_SEND := Value;
end;

end.
