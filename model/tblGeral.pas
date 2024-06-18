unit tblGeral;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_GERAL')]
  TGeral = Class(TGenericEntity)
  private
    FCAMPO      : String;
    FCONTEUDO   : String;
    FCODMHA     : Integer;

    procedure setFCAMPO( Value :String);
    procedure setFCONTEUDO( Value :String);
    procedure setFCODMHA( Value :Integer);
  public
    [KeyField('GRL_CAMPO')]
    [FieldName('GRL_CAMPO')]
    property Campo: String read FCAMPO write setFCAMPO;

    [FieldName('GRL_CONTEUDO')]
    property Conteudo: String read FCONTEUDO write setFCONTEUDO;

    [KeyField('GRL_CODMHA')]
    [FieldName('GRL_CODMHA')]
    property CodigoEstabelecimento: Integer read FCODMHA write setFCODMHA;
  End;

implementation

{ TGeral }

procedure TGeral.setFCAMPO(Value: String);
begin
  FCAMPO := Value;
end;

procedure TGeral.setFCODMHA(Value: Integer);
begin
  fCODMHA := Value;
end;

procedure TGeral.setFCONTEUDO(Value: String);
begin
  FCONTEUDO := Value;
end;

end.
