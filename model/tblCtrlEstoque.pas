unit tblCtrlEstoque;

interface

Uses TEntity,CAtribEntity, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_CTRL_ESTOQUE')]
  TCtrlEstoque = Class(TGenericEntity)
  private
    FUPDATE_AT: TDateTime;
    FCET_CODPRO: Integer;
    FCET_OPERACAO: String;
    FCET_CODIGO: Integer;
    FCET_CODETS: Integer;
    FCET_VINCULO: String;
    FCET_ITEM_CTRL: Integer;
    FCET_QTDE: Real;
    FCET_CONTROLE: Integer;
    FCET_DATA: TDate;
    FCET_TIPO: String;
    FCET_TERMINAL: Integer;
    procedure setFCET_CODETS(const Value: Integer);
    procedure setFCET_CODIGO(const Value: Integer);
    procedure setFCET_CODPRO(const Value: Integer);
    procedure setFCET_CONTROLE(const Value: Integer);
    procedure setFCET_DATA(const Value: TDate);
    procedure setFCET_ITEM_CTRL(const Value: Integer);
    procedure setFCET_OPERACAO(const Value: String);
    procedure setFCET_QTDE(const Value: Real);
    procedure setFCET_VINCULO(const Value: String);
    procedure setFUPDATE_AT(const Value: TDateTime);
    procedure setFCET_TIPO(const Value: String);
    procedure setFCET_TERMINAL(const Value: Integer);

  public
    [KeyField('CET_CODIGO')]
    [FieldName('CET_CODIGO')]
    property Codigo: Integer read FCET_CODIGO write setFCET_CODIGO;

    [KeyField('CET_TERMINAL')]
    [FieldName('CET_TERMINAL')]
    property Terminal: Integer read FCET_TERMINAL write setFCET_TERMINAL;

//    [KeyField('CET_VINCULO')]
    [FieldName('CET_VINCULO')]
    property Vinculo: String read FCET_VINCULO write setFCET_VINCULO;


//    [KeyField('CET_CONTROLE')]
    [FieldName('CET_CONTROLE')]
    property Ordem: Integer read FCET_CONTROLE write setFCET_CONTROLE;

//    [KeyField('CET_ITEM_CTRL')]
    [FieldName('CET_ITEM_CTRL')]
    property Item: Integer read FCET_ITEM_CTRL write setFCET_ITEM_CTRL;

//    [KeyField('CET_CODETS')]
    [FieldName('CET_CODETS')]
    property Estoque: Integer read FCET_CODETS write setFCET_CODETS;


    [FieldName('CET_OPERACAO')]
    property operacao: String read FCET_OPERACAO write setFCET_OPERACAO;

    [FieldName('CET_CODPRO')]
    property Produto: Integer read FCET_CODPRO write setFCET_CODPRO;

    [FieldName('CET_QTDE')]
    property Quantidade: Real read FCET_QTDE write setFCET_QTDE;

    [FieldName('CET_DATA')]
    property Data: TDate read FCET_DATA write setFCET_DATA;

    [FieldName('UPDATE_AT')]
    property UpdateAt: TDateTime read FUPDATE_AT write setFUPDATE_AT;

    [FieldName('CET_TIPO')]
    property Tipo: String read FCET_TIPO write setFCET_TIPO;


  End;


implementation


{ TCtrlEstoque }

procedure TCtrlEstoque.setFCET_CODETS(const Value: Integer);
begin
  FCET_CODETS := Value;
end;

procedure TCtrlEstoque.setFCET_CODIGO(const Value: Integer);
begin
  FCET_CODIGO := Value;
end;

procedure TCtrlEstoque.setFCET_CODPRO(const Value: Integer);
begin
  FCET_CODPRO := Value;
end;

procedure TCtrlEstoque.setFCET_CONTROLE(const Value: Integer);
begin
  FCET_CONTROLE := Value;
end;

procedure TCtrlEstoque.setFCET_DATA(const Value: TDate);
begin
  FCET_DATA := Value;
end;

procedure TCtrlEstoque.setFCET_ITEM_CTRL(const Value: Integer);
begin
  FCET_ITEM_CTRL := Value;
end;

procedure TCtrlEstoque.setFCET_OPERACAO(const Value: String);
begin
  FCET_OPERACAO := Value;
end;

procedure TCtrlEstoque.setFCET_QTDE(const Value: Real);
begin
  FCET_QTDE := Value;
end;

procedure TCtrlEstoque.setFCET_TERMINAL(const Value: Integer);
begin
  FCET_TERMINAL := Value;
end;

procedure TCtrlEstoque.setFCET_TIPO(const Value: String);
begin
  if Value <> '' then
    FCET_TIPO := UPPERCASE(Trim(Value))
  else
    FCET_TIPO := 'FALTA REGISTRAR'
end;

procedure TCtrlEstoque.setFCET_VINCULO(const Value: String);
begin
  FCET_VINCULO := Value;
end;

procedure TCtrlEstoque.setFUPDATE_AT(const Value: TDateTime);
begin
  FUPDATE_AT := Value;
end;

end.
