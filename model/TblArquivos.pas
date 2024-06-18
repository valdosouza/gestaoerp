unit TblArquivos;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('tb_arquivos')]
  TArquivos = Class(TGenericEntity)
  private
    FArq_Codigo: Integer;
    FArq_Tipo: Integer;
    FArq_Formato: String;
    FArq_CodVcl: Integer;
    FArq_Conteudo: String;
    FArq_Chv_Nfe : String;
    procedure setFarq_chv_nfe(const Value: String);
    procedure setFarq_codigo(const Value: Integer);
    procedure setFarq_codvcl(const Value: Integer);
    procedure setFarq_conteudo(const Value: String);
    procedure setFarq_formato(const Value: String);
    procedure setFarq_tipo(const Value: Integer);

  public
    [FieldName('arq_codigo')]
    [KeyField('arq_codigo')]
    property Codigo: Integer read Farq_codigo write setFarq_codigo;

    [KeyField('arq_tipo')]
    [FieldName('arq_tipo')]
    property Tipo: Integer read Farq_tipo write setFarq_tipo;

    [FieldName('arq_formato')]
    property Formato: String read Farq_formato write setFarq_formato;

    [FieldName('arq_codvcl')]
    property CodVcl: Integer read Farq_codvcl write setFarq_codvcl;

    [FieldName('arq_conteudo')]
    property Conteudo: String read Farq_conteudo write setFarq_conteudo;

    [FieldName('arq_chv_nfe')]
    property ChvNfe: String read Farq_chv_nfe write setFarq_chv_nfe;

  End;
implementation


{ TArquivos }

procedure TArquivos.setFarq_chv_nfe(const Value: String);
begin
  Farq_chv_nfe := Value;
end;

procedure TArquivos.setFarq_codigo(const Value: Integer);
begin
  Farq_codigo := Value;
end;

procedure TArquivos.setFarq_codvcl(const Value: Integer);
begin
  Farq_codvcl := Value;
end;

procedure TArquivos.setFarq_conteudo(const Value: String);
begin
  Farq_conteudo := Value;
end;

procedure TArquivos.setFarq_formato(const Value: String);
begin
  Farq_formato := Value;
end;

procedure TArquivos.setFarq_tipo(const Value: Integer);
begin
  Farq_tipo := Value;
end;

end.
