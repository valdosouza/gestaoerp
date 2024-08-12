unit TblCfgEtiqueta;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_cfg_etiqueta')]
  TCfgEtiqueta = Class(TGenericEntity)

  private
    Fcge_codigo: Integer;
    Fcge_descricao: String;
    Fcge_pg_altura: Real;
    Fcge_pg_largura: Real;
    Fcge_superior: Real;
    Fcge_inferior: Real;
    Fcge_direita: Real;
    Fcge_esquerda: Real;
    Fcge_et_altura: Real;
    Fcge_et_largura: Real;
    Fcge_dis_coluna: Real;
    Fcge_typefonte: String;
    Fcge_sizefonte: Integer;
    Fcge_pagesize: String;
    Fcge_nr_coluna: Real;
    Fcge_eti_superior: Real;
    procedure setFcge_codigo(const Value: Integer);
    procedure setFcge_descricao(const Value: String);
    procedure setFcge_direita(const Value: Real);
    procedure setFcge_dis_coluna(const Value: Real);
    procedure setFcge_esquerda(const Value: Real);
    procedure setFcge_et_altura(const Value: Real);
    procedure setFcge_et_largura(const Value: Real);
    procedure setFcge_eti_superior(const Value: Real);
    procedure setFcge_inferior(const Value: Real);
    procedure setFcge_nr_coluna(const Value: Real);
    procedure setFcge_pagesize(const Value: String);
    procedure setFcge_pg_altura(const Value: Real);
    procedure setFcge_pg_largura(const Value: Real);
    procedure setFcge_sizefonte(const Value: Integer);
    procedure setFcge_superior(const Value: Real);
    procedure setFcge_typefonte(const Value: string);
  public

    [FieldName('cge_codigo')]
    [KeyField('cge_codigo')]
    property Codigo: Integer read Fcge_codigo write setFcge_codigo;

    [FieldName('cge_descricao')]
    property Descricao: String read Fcge_descricao write setFcge_descricao;

    [FieldName('cge_pg_altura')]
    property PgAltura: Real read Fcge_pg_altura write setFcge_pg_altura;

    [FieldName('cge_pg_largura')]
    property PgLargura: Real read Fcge_pg_largura write setFcge_pg_largura;

    [FieldName('cge_superior')]
    property Superior: Real read Fcge_superior write setFcge_superior;

    [FieldName('cge_inferior')]
    property Inferior: Real read Fcge_inferior write setFcge_inferior;

    [FieldName('cge_direita')]
    property Direita: Real read Fcge_direita write setFcge_direita;

    [FieldName('cge_esquera')]
    property Esquerda: Real read Fcge_esquerda write setFcge_esquerda;

    [FieldName('cge_et_altura')]
    property EtAltura: Real read Fcge_et_altura write setFcge_et_altura;

    [FieldName('cge_et_largura')]
    property EtLargura: Real read Fcge_et_largura write setFcge_et_largura;

    [FieldName('cge_dis_coluna')]
    property DisColuna: Real read Fcge_dis_coluna write setFcge_dis_coluna;

    [FieldName('cge_typefonte')]
    property TypeFonte: string read Fcge_typefonte write setFcge_typefonte;

    [FieldName('cge_sizefonte')]
    property SizeFonte: Integer read Fcge_sizefonte write setFcge_sizefonte;

    [FieldName('cge_pagesize')]
    property PageSize: String read Fcge_pagesize write setFcge_pagesize;

    [FieldName('cge_nr_coluna')]
    property NrColuna: Real read Fcge_nr_coluna write setFcge_nr_coluna;

    [FieldName('cge_eti_superior')]
    property EtiSuperior: Real read Fcge_eti_superior write setFcge_eti_superior;

  End;

  implementation
{ TCfgEtiqueta }

procedure TCfgEtiqueta.setFcge_codigo(const Value: Integer);
begin
  Fcge_codigo := Value;
end;

procedure TCfgEtiqueta.setFcge_descricao(const Value: String);
begin
  Fcge_descricao := Value;
end;

procedure TCfgEtiqueta.setFcge_direita(const Value: Real);
begin
  Fcge_direita := Value;
end;

procedure TCfgEtiqueta.setFcge_dis_coluna(const Value: Real);
begin
  Fcge_dis_coluna := Value;
end;

procedure TCfgEtiqueta.setFcge_esquerda(const Value: Real);
begin
  Fcge_esquerda := Value;
end;

procedure TCfgEtiqueta.setFcge_eti_superior(const Value: Real);
begin
  Fcge_eti_superior := Value;
end;

procedure TCfgEtiqueta.setFcge_et_altura(const Value: Real);
begin
  Fcge_et_altura := Value;
end;

procedure TCfgEtiqueta.setFcge_et_largura(const Value: Real);
begin
  Fcge_et_largura := Value;
end;

procedure TCfgEtiqueta.setFcge_inferior(const Value: Real);
begin
  Fcge_inferior := Value;
end;

procedure TCfgEtiqueta.setFcge_nr_coluna(const Value: Real);
begin
  Fcge_nr_coluna := Value;
end;

procedure TCfgEtiqueta.setFcge_pagesize(const Value: String);
begin
  Fcge_pagesize := Value;
end;

procedure TCfgEtiqueta.setFcge_pg_altura(const Value: Real);
begin
  Fcge_pg_altura := Value;
end;

procedure TCfgEtiqueta.setFcge_pg_largura(const Value: Real);
begin
  Fcge_pg_largura := Value;
end;

procedure TCfgEtiqueta.setFcge_sizefonte(const Value: Integer);
begin
  Fcge_sizefonte := Value;
end;

procedure TCfgEtiqueta.setFcge_superior(const Value: Real);
begin
  Fcge_superior := Value;
end;

procedure TCfgEtiqueta.setFcge_typefonte(const Value: string);
begin
  Fcge_typefonte := Value;
end;

end.
