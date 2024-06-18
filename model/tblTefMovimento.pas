Unit  tblTefMovimento ;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_TEF_MOVIMENTO')]
  TTefMovimento = Class(TGenericEntity)
  private
    FRede: String;
    Fdatahora: TDateTime;
    Fcampo11: String;
    Finstituicao: integer;
    Fstatus: String;
    Fvalor_total: Real;
    Ftb_pedido_id: Integer;
    Fdoc_vinc: String;
    Ftb_institution_id: Integer;
    Fnsu: String;
    Ftb_user_id: Integer;
    Fcrt_id: Integer;
    Fparcela: Integer;
    procedure setFcampo11(const Value: String);
    procedure setFcrt_id(const Value: Integer);
    procedure setFdatahora(const Value: TDateTime);
    procedure setFdoc_vinc(const Value: String);
    procedure setFinstituicao(const Value: integer);
    procedure setFnsu(const Value: String);
    procedure setFparcela(const Value: Integer);
    procedure setFRede(const Value: String);
    procedure setFstatus(const Value: String);
    procedure setFtb_institution_id(const Value: Integer);
    procedure setFtb_pedido_id(const Value: Integer);
    procedure setFtb_user_id(const Value: Integer);
    procedure setFvalor_total(const Value: Real);


  public

    [KeyField('tb_pedido_id')]
    [FieldName('tb_pedido_id')]
    property CodigoPedido: Integer read Ftb_pedido_id write setFtb_pedido_id;

    [KeyField('tb_institution_id')]
    [FieldName('tb_institution_id')]
    property Estabelecimento: Integer read Ftb_institution_id write setFtb_institution_id;

    [KeyField('parcela')]
    [FieldName('parcela')]
    property Parcela: Integer read Fparcela write setFparcela;

    [FieldName('crt_id')]
    property CRT: Integer read Fcrt_id write setFcrt_id;

    [FieldName('doc_vinc')]
    property DocumentoVinculado: String read Fdoc_vinc write setFdoc_vinc;

    [FieldName('valor_total')]
    property ValorTotal: Real read Fvalor_total write setFvalor_total;

    [FieldName('rede')]
    property Rede: String read FRede write setFRede;

    [FieldName('nsu')]
    property NSU: String read Fnsu write setFnsu;

    [FieldName('datahora')]
    property DataHora: TDateTime read Fdatahora write setFdatahora;

    [FieldName('instituicao')]
    property Instituicao: integer read Finstituicao write setFinstituicao;

    [FieldName('campo11')]
    property Campo11: String read Fcampo11 write setFcampo11;

    [FieldName('status')]
    property status: String read Fstatus write setFstatus;

    [FieldName('tb_user_id')]
    property Usuario: Integer read Ftb_user_id write setFtb_user_id;

  End;

implementation

{ TTefMovimento }

procedure TTefMovimento.setFcampo11(const Value: String);
begin
  Fcampo11 := Value;
end;

procedure TTefMovimento.setFcrt_id(const Value: Integer);
begin
  Fcrt_id := Value;
end;

procedure TTefMovimento.setFdatahora(const Value: TDateTime);
begin
  Fdatahora := Value;
end;

procedure TTefMovimento.setFdoc_vinc(const Value: String);
begin
  Fdoc_vinc := Value;
end;

procedure TTefMovimento.setFinstituicao(const Value: integer);
begin
  Finstituicao := Value;
end;

procedure TTefMovimento.setFnsu(const Value: String);
begin
  Fnsu := Value;
end;

procedure TTefMovimento.setFparcela(const Value: Integer);
begin
  Fparcela := Value;
end;

procedure TTefMovimento.setFRede(const Value: String);
begin
  FRede := Value;
end;

procedure TTefMovimento.setFstatus(const Value: String);
begin
  Fstatus := Value;
end;

procedure TTefMovimento.setFtb_institution_id(const Value: Integer);
begin
  Ftb_institution_id := Value;
end;

procedure TTefMovimento.setFtb_pedido_id(const Value: Integer);
begin
  Ftb_pedido_id := Value;
end;

procedure TTefMovimento.setFtb_user_id(const Value: Integer);
begin
  Ftb_user_id := Value;
end;

procedure TTefMovimento.setFvalor_total(const Value: Real);
begin
  Fvalor_total := Value;
end;

end.
