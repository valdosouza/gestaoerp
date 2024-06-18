unit tblArquivo;

interface

Uses TEntity,CAtribEntity, Data.DB;

Type
  //nome da classe de entidade
  [TableName('TB_ARQUIVOS')]
  TArquivo = Class(TGenericEntity)
  private
    FTIPO: Integer;
    FCODIGO: Integer;
    FFORMATO: String;
    FCHV_NFE: String;
    FCODVCL: Integer;
    FCONTEUDO: String;
    procedure setFCHV_NFE(const Value: String);
    procedure setFCODIGO(const Value: Integer);
    procedure setFCODVCL(const Value: Integer);
    procedure setFFORMATO(const Value: String);
    procedure setFTIPO(const Value: Integer);
    procedure setFCONTEUDO(const Value: String);



  public
    [KeyField('ARQ_CODIGO')]
    [FieldName('ARQ_CODIGO')]
    property Codigo: Integer read FCODIGO write setFCODIGO;

    [FieldName('ARQ_TIPO')]
    property TipoDoArquivo: Integer read FTIPO write setFTIPO;

    [FieldName('ARQ_FORMATO')]
    property Formato: String read FFORMATO write setFFORMATO;

    [FieldName('ARQ_CODVCL')]
    property CodigoVinculo: Integer read FCODVCL write setFCODVCL;

    [FieldName('ARQ_CONTEUDO')]
    property Conteudo: String read FCONTEUDO write setFCONTEUDO;

    [FieldName('ARQ_CHV_NFE')]
    property ChaveNFe: String read FCHV_NFE write setFCHV_NFE;

  End;

implementation

{ TArquivo }

procedure TArquivo.setFCHV_NFE(const Value: String);
begin
  FCHV_NFE := Value;
end;

procedure TArquivo.setFCODIGO(const Value: Integer);
begin
  FCODIGO := Value;
end;

procedure TArquivo.setFCODVCL(const Value: Integer);
begin
  FCODVCL := Value;
end;

procedure TArquivo.setFCONTEUDO(const Value: String);
begin
  FCONTEUDO := Value;
end;

procedure TArquivo.setFFORMATO(const Value: String);
begin
  FFORMATO := Value;
end;

procedure TArquivo.setFTIPO(const Value: Integer);
begin
  FTIPO := Value;
end;

end.
