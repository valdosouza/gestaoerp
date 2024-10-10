unit tblContato;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_contato')]
  TContato = Class(TGenericEntity)

  private
    FCto_Codigo: Integer;
    FCto_Cadastro: TDateTime;
    FCto_Codemp: Integer;
    FCto_Sexo: String;
    FCto_Nome: String;
    FCto_Cargo: Integer;
    FCto_Ender: String;
    FCto_Complem: String;
    FCto_Bairro: String;
    FCto_Cep: String;
    FCto_Cidade: String;
    FCto_Estado: String;
    FCto_Pais: String;
    FCto_Fone: String;
    FCto_Ramal: String;
    FCto_Celular: String;
    FCto_Email: String;
    FCto_Principal: String;
    FCto_Msn: String;
    FCto_Observ: String;
    FCto_Aniver: TDateTime;
    FCRG_DESCRICAO: string;
    procedure setFCto_Aniver(const Value: TDateTime);
    procedure setFCto_Cadastro(const Value: TDateTime);
    procedure setFCto_Cargo(const Value: Integer);
    procedure setFCto_Celular(const Value: String);
    procedure setFCto_Cep(const Value: String);
    procedure setFCto_Cidade(const Value: String);
    procedure setFCto_Codigo(const Value: Integer);
    procedure setFCto_Complem(const Value: String);
    procedure setFCto_Email(const Value: String);
    procedure setFCto_Ender(const Value: String);
    procedure setFCto_Estado(const Value: String);
    procedure setFCto_Fone(const Value: String);
    procedure setFCto_Msn(const Value: String);
    procedure setFCto_Nome(const Value: String);
    procedure setFCto_Observ(const Value: String);
    procedure setFCto_Pais(const Value: String);
    procedure setFCto_Principal(const Value: String);
    procedure setFCto_Ramal(const Value: String);
    procedure setFCto_Sexo(const Value: String);
    procedure setFFCto_Codemp(const Value: Integer);
    procedure setFCto_Bairro(const Value: String);
    procedure setFCRG_DESCRICAO(const Value: string);

  public

    [FieldName('Cto_Codigo')]
    [KeyField('Cto_Codigo')]
    property Codigo: Integer read FCto_Codigo write setFCto_Codigo;

    [FieldName('Cto_Cadastro')]
    property Cadastro: TDateTime read FCto_cadastro write setFCto_Cadastro;

    [FieldName('Cto_Codemp')]
    property Codemp: Integer read FCto_Codemp write setFFCto_Codemp;

    [FieldName('Cto_Sexo')]
    property Sexo: String read FCto_Sexo write setFCto_Sexo;

    [FieldName('Cto_Nome')]
    property Nome: String read FCto_Nome write setFCto_Nome;

    [FieldName('Cto_Cargo')]
    property Cargo: Integer read FCto_Cargo write setFCto_Cargo;

    [FieldName('Cto_Ender')]
    property Ender: String read FCto_Ender write setFCto_Ender;

    [FieldName('Cto_Complem')]
    property Complem: String read FCto_Complem write setFCto_Complem;

    [FieldName('Cto_Bairro')]
    property Bairro: String read FCto_Bairro write setFCto_Bairro;

    [FieldName('Cto_Cep')]
    property Cep: String read FCto_Cep write setFCto_Cep;

    [FieldName('Cto_Cidade')]
    property Cidade: String read FCto_Cidade write setFCto_Cidade;

    [FieldName('Cto_Estado')]
    property Estado: String read FCto_Estado write setFCto_Estado;

    [FieldName('Cto_Pais')]
    property Pais: String read FCto_Pais write setFCto_Pais;

    [FieldName('Cto_Fone')]
    property Fone: String read FCto_Fone write setFCto_Fone;

    [FieldName('Cto_Ramal')]
    property Ramal: String read FCto_Ramal write setFCto_Ramal;

    [FieldName('Cto_Celular')]
    property Celular: String read FCto_Celular write setFCto_Celular;

    [FieldName('Cto_Email')]
    property Email: String read FCto_Email write setFCto_Email;

    [FieldName('Cto_Principal')]
    property Principal: String read FCto_Principal write setFCto_Principal;

    [FieldName('Cto_Msn')]
    property Msn: String read FCto_Msn write setFCto_Msn;

    [FieldName('Cto_Observ')]
    property Observ: String read FCto_Observ write setFCto_Observ;

    [FieldName('Cto_Aniver')]
    property Aniver: TDateTime read FCto_Aniver write setFCto_Aniver;

    property CRG_DESCRICAO: string read FCRG_DESCRICAO write setFCRG_DESCRICAO;
  End;

  implementation



{ TContato }

procedure TContato.setFCRG_DESCRICAO(const Value: string);
begin
  FCRG_DESCRICAO := Value;
end;

procedure TContato.setFCto_Aniver(const Value: TDateTime);
begin
  FCto_Aniver := Value;
end;

procedure TContato.setFCto_Bairro(const Value: String);
begin
  FCto_Bairro := Value;
end;

procedure TContato.setFCto_Cadastro(const Value: TDateTime);
begin
  FCto_cadastro := Value;
end;

procedure TContato.setFCto_Cargo(const Value: Integer);
begin
  FCto_Cargo := Value;
end;

procedure TContato.setFCto_Celular(const Value: String);
begin
  FCto_Celular := Value;
end;

procedure TContato.setFCto_Cep(const Value: String);
begin
  FCto_Cep := Value;
end;

procedure TContato.setFCto_Cidade(const Value: String);
begin
  FCto_Cidade := Value;
end;

procedure TContato.setFCto_Codigo(const Value: Integer);
begin
  FCto_Codigo := Value;
end;

procedure TContato.setFCto_Complem(const Value: String);
begin
  FCto_Complem := Value;
end;

procedure TContato.setFCto_Email(const Value: String);
begin
  FCto_Email := Value;
end;

procedure TContato.setFCto_Ender(const Value: String);
begin
  FCto_Ender := Value;
end;

procedure TContato.setFCto_Estado(const Value: String);
begin
  FCto_Estado := Value;
end;

procedure TContato.setFCto_Fone(const Value: String);
begin
  FCto_Fone := Value;
end;

procedure TContato.setFCto_Msn(const Value: String);
begin
  FCto_Msn := Value;
end;

procedure TContato.setFCto_Nome(const Value: String);
begin
  FCto_Nome := Value;
end;

procedure TContato.setFCto_Observ(const Value: String);
begin
  FCto_Observ := Value;
end;

procedure TContato.setFCto_Pais(const Value: String);
begin
  FCto_Pais := Value;
end;

procedure TContato.setFCto_Principal(const Value: String);
begin
  FCto_Principal := Value;
end;

procedure TContato.setFCto_Ramal(const Value: String);
begin
  FCto_Ramal := Value;
end;

procedure TContato.setFCto_Sexo(const Value: String);
begin
  FCto_Sexo := Value;
end;

procedure TContato.setFFCto_Codemp(const Value: Integer);
begin
  FCto_Codemp := Value;
end;

end.
