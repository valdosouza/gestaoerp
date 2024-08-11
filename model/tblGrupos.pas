unit tblGrupos;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_GRUPOS')]
  TGrupos = Class(TGenericEntity)
  private
    FGRP_AGRUPAR: String;
    FGRP_VL_DESCONTO: REal;
    FGRP_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FGRP_PROG_TAM: String;
    FGRP_INTERFACE: String;
    FGRP_TAMANHOS: String;
    FGRP_COMPOSICAO: String;
    FGRP_SEQUENCIA: Integer;
    FGRP_SHOW_MENU: String;
    FGRP_ATIVO: String;
    FIFOOD: String;
    FIFOOD_CD: String;
    FSubGrupo: String;
    FGruposVazios: boolean;

    procedure setFGRP_CODIGO( Value : INTEGER);
    procedure setFGRP_DESCRICAO( Value : String);
    procedure setFGRP_VL_DESCONTO( Value : Real);
    procedure setFGRP_COMPOSICAO( Value : String);
    procedure setFGRP_INTERFACE( Value : String);
    procedure setFGRP_TAMANHOS( Value : String);
    procedure setFGRP_PROG_TAM( Value : String);
    procedure setFGRP_AGRUPAR( Value : String);
    procedure setFGRP_SEQUENCIA(const Value: Integer);
    procedure setFGRP_SHOW_MENU(const Value: String);
    procedure setFGRP_ATIVO(const Value: String);
    procedure setFIFOOD(const Value: String);
    procedure setFIFOOD_CD(const Value: String);
    procedure setSubGrupo(const Value: String);
    procedure setGruposVazios(const Value: boolean);


  public

    [KeyField('GRP_CODIGO')]
    [FieldName('GRP_CODIGO')]
    property Codigo: Integer read FGRP_CODIGO write setFGRP_CODIGO;

    [FieldName('GRP_DESCRICAO')]
    property Descricao: String read FGRP_DESCRICAO write setFGRP_DESCRICAO;

    [FieldName('GRP_VL_DESCONTO')]
    property ValorDesconto: Real read FGRP_VL_DESCONTO write setFGRP_VL_DESCONTO;

    [FieldName('GRP_COMPOSICAO')]
    property Composicao: String read FGRP_COMPOSICAO write setFGRP_COMPOSICAO;

    [FieldName('GRP_INTERFACE')]
    property ControleInterface: String read FGRP_INTERFACE write setFGRP_INTERFACE;

    [FieldName('GRP_TAMANHOS')]
    property Tamanhos: String read FGRP_TAMANHOS write setFGRP_TAMANHOS;

    [FieldName('GRP_PROG_TAM')]
    property PropagaTamanho: String read FGRP_PROG_TAM write setFGRP_PROG_TAM;

    [FieldName('GRP_AGRUPAR')]
    property Agrupar: String read FGRP_AGRUPAR write setFGRP_AGRUPAR;

    [FieldName('GRP_SEQUENCIA')]
    property Sequencia: Integer read FGRP_SEQUENCIA write setFGRP_SEQUENCIA;

    [FieldName('GRP_SHOW_MENU')]
    property ShowMenu: String read FGRP_SHOW_MENU write setFGRP_SHOW_MENU;


    [FieldName('GRP_ATIVO')]
    property Ativo: String read FGRP_ATIVO write setFGRP_ATIVO;

    [FieldName('IFOOD')]
    property IfoodAtivo: String read FIFOOD write setFIFOOD;

    [FieldName('IFOOD_CD')]
    property IfoodCodigo: String read FIFOOD_CD write setFIFOOD_CD;

    property SubGrupo: String read FSubGrupo write setSubGrupo;
    property GruposVazios: boolean read FGruposVazios write setGruposVazios;

  End;

implementation

{ TGrupos }

procedure TGrupos.setFGRP_AGRUPAR(Value: String);
begin
  FGRP_AGRUPAR := Value;
end;

procedure TGrupos.setFGRP_ATIVO(const Value: String);
begin
  FGRP_ATIVO := Value;
end;

procedure TGrupos.setFGRP_CODIGO(Value: INTEGER);
begin
  FGRP_CODIGO := Value;
end;

procedure TGrupos.setFGRP_COMPOSICAO(Value: String);
begin
  FGRP_COMPOSICAO := Value;
end;

procedure TGrupos.setFGRP_DESCRICAO(Value: String);
begin
  FGRP_DESCRICAO := Value;
end;

procedure TGrupos.setFGRP_INTERFACE(Value: String);
begin
  FGRP_INTERFACE := Value;
end;

procedure TGrupos.setFGRP_PROG_TAM(Value: String);
begin
  FGRP_PROG_TAM := Value;
end;

procedure TGrupos.setFGRP_SEQUENCIA(const Value: Integer);
begin
  FGRP_SEQUENCIA := Value;
end;

procedure TGrupos.setFGRP_SHOW_MENU(const Value: String);
begin
  FGRP_SHOW_MENU := Value;
end;

procedure TGrupos.setFGRP_TAMANHOS(Value: String);
begin
  FGRP_TAMANHOS := Value;
end;

procedure TGrupos.setFGRP_VL_DESCONTO(Value: Real);
begin
  FGRP_VL_DESCONTO := Value;
end;

procedure TGrupos.setFIFOOD(const Value: String);
begin
  FIFOOD := Value;
end;

procedure TGrupos.setFIFOOD_CD(const Value: String);
begin
  FIFOOD_CD := Value;
end;

procedure TGrupos.setGruposVazios(const Value: boolean);
begin
  FGruposVazios := Value;
end;

procedure TGrupos.setSubGrupo(const Value: String);
begin
  FSubGrupo := Value;
end;

end.
