unit tblBotao;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('tb_botao')]
  TBotao = Class(TGenericEntity)

  private
    Fbtn_codigo: Integer;
    Fbtn_descricao: String;
    Fbtn_altura: Integer;
    Fbtn_largura: Integer;
    Fbtn_label: String;
    Fbtn_path: String;
    Fbtn_imagem: String;
    Fbtn_mrg_sup: Integer;
    Fbtn_sequencia: Integer;
    procedure setFbtn_altura(const Value: Integer);
    procedure setFbtn_codigo(const Value: Integer);
    procedure setFbtn_descricao(const Value: String);
    procedure setFbtn_imagem(const Value: String);
    procedure setFbtn_label(const Value: String);
    procedure setFbtn_largura(const Value: Integer);
    procedure setFbtn_mrg_sup(const Value: Integer);
    procedure setFbtn_path(const Value: String);
    procedure setFbtn_sequencia(const Value: Integer);


   public
    [FieldName('btn_codigo')]
    [KeyField('btn_codigo')]
    property Codigo: Integer read Fbtn_codigo write setFbtn_codigo;

    [FieldName('btn_descricao')]
    property Descricao: String read Fbtn_descricao write setFbtn_descricao;

    [FieldName('btn_altura')]
    property Altura: Integer read Fbtn_altura write setFbtn_altura;

    [FieldName('btn_largura')]
    property Largura: Integer read Fbtn_largura write setFbtn_largura;

    [FieldName('btn_label')]
    property BtnLabel: String read Fbtn_label write setFbtn_label;

    [FieldName('btn_path')]
    property Path: String read Fbtn_path write setFbtn_path;

    [FieldName('btn_imagem')]
    property Imagem: String read Fbtn_imagem write setFbtn_imagem;

    [FieldName('btn_mrg_sup')]
    property MrgSup: Integer read Fbtn_mrg_sup write setFbtn_mrg_sup;

    [FieldName('btn_sequencia')]
    property Sequencia: Integer read Fbtn_sequencia write setFbtn_sequencia;
  End;

  implementation

{ TBotao }

procedure TBotao.setFbtn_altura(const Value: Integer);
begin
  Fbtn_altura := Value;
end;

procedure TBotao.setFbtn_codigo(const Value: Integer);
begin
  Fbtn_codigo := Value;
end;

procedure TBotao.setFbtn_descricao(const Value: String);
begin
  Fbtn_descricao := Value;
end;

procedure TBotao.setFbtn_imagem(const Value: String);
begin
  Fbtn_imagem := Value;
end;

procedure TBotao.setFbtn_label(const Value: String);
begin
  Fbtn_label := Value;
end;

procedure TBotao.setFbtn_largura(const Value: Integer);
begin
  Fbtn_largura := Value;
end;

procedure TBotao.setFbtn_mrg_sup(const Value: Integer);
begin
  Fbtn_mrg_sup := Value;
end;

procedure TBotao.setFbtn_path(const Value: String);
begin
  Fbtn_path := Value;
end;

procedure TBotao.setFbtn_sequencia(const Value: Integer);
begin
  Fbtn_sequencia := Value;
end;

end.
