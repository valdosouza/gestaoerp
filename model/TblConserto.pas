unit TblConserto;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;

Type
  //nome da classe de entidade
  [TableName('tb_conserto')]
  TConserto = Class(TGenericEntity)

  private
    FNOTE: String;
    Fcst_Constatado: String;
    Fcst_dt_entrega: TDate;
    FEXECUTADO: String;
    Fcst_dt_conserto: TDate;
    Fcst_Codigo: Integer;
    Fcst_Relatado: String;
    FSERIE: String;
    Fcst_Codped: Integer;
    Fcst_Modelo: String;
    Fcst_Numero: String;
    Fcst_vl_pecas: Real;
    Fcst_Acessorio: String;
    Fcst_vl_mobra: Real;
    Fcst_codsit: Integer;
    FIMEI: String;
    Fcst_Marca: String;
    Fcst_Aparelho: String;
    Fcst_vl_custo: Real;
    Fcst_Codfor: Integer;
    FDT_FORECAST: TDate;
    FTB_COLABORADOR_ID: Integer;
    FHR_FORECAST: TTime;
    FHR_ENTREGA: TTime;
    FHR_CONSERTO: TTime;

    procedure setFcst_Acessorio(const Value: String);
    procedure setFcst_Aparelho(const Value: String);
    procedure setFcst_Codfor(const Value: Integer);
    procedure setFcst_Codigo(const Value: Integer);
    procedure setFcst_Codped(const Value: Integer);
    procedure setFcst_codsit(const Value: Integer);
    procedure setFcst_Constatado(const Value: String);
    procedure setFcst_dt_conserto(const Value: TDate);
    procedure setFcst_dt_entrega(const Value: TDate);
    procedure setFcst_Marca(const Value: String);
    procedure setFcst_Modelo(const Value: String);
    procedure setFcst_Numero(const Value: String);
    procedure setFcst_Relatado(const Value: String);
    procedure setFcst_vl_custo(const Value: Real);
    procedure setFcst_vl_mobra(const Value: Real);
    procedure setFcst_vl_pecas(const Value: Real);
    procedure setFEXECUTADO(const Value: String);
    procedure setFIMEI(const Value: String);
    procedure setFNOTE(const Value: String);
    procedure setFSERIE(const Value: String);
    procedure setFDT_FORECAST(const Value: TDate);
    procedure setFTB_COLABORADOR_ID(const Value: Integer);
    procedure setFHR_CONSERTO(const Value: TTime);
    procedure setFHR_ENTREGA(const Value: TTime);
    procedure setFHR_FORECAST(const Value: TTime);



  public

    [FieldName('cst_Codigo')]
    [KeyField('cst_Codigo')]
    property Codigo: Integer read Fcst_Codigo write setFcst_Codigo;

    [FieldName('cst_Codped')]
    property Codped: Integer read Fcst_Codped write setFcst_Codped;

    [FieldName('cst_Numero')]
    property Numero: String read Fcst_Numero write setFcst_Numero;

    [FieldName('cst_Aparelho')]
    property Aparelho: String read Fcst_Aparelho write setFcst_Aparelho;

    [FieldName('cst_Marca')]
    property Marca: String read Fcst_Marca write setFcst_Marca;

    [FieldName('cst_Modelo')]
    property Modelo: String read Fcst_Modelo write setFcst_Modelo;

    [FieldName('cst_Acessorio')]
    property Acessorio: String read Fcst_Acessorio write setFcst_Acessorio;

    [FieldName('cst_Relatado')]
    property Relatado: String read Fcst_Relatado write setFcst_Relatado;

    [FieldName('cst_Constatado')]
    property Constatado: String read Fcst_Constatado write setFcst_Constatado;

    [FieldName('cst_Codfor')]
    property Codfor: Integer read Fcst_Codfor write setFcst_Codfor;

    [FieldName('DT_FORECAST')]
    property DataPrevista: TDate read FDT_FORECAST write setFDT_FORECAST;

    [FieldName('cst_dt_conserto')]
    property DataConserto: TDate read Fcst_dt_conserto write setFcst_dt_conserto;

    [FieldName('cst_dt_entrega')]
    property DataEntrega: TDate read Fcst_dt_entrega write setFcst_dt_entrega;

    [FieldName('cst_vl_custo')]
    property VlCusto: Real read Fcst_vl_custo write setFcst_vl_custo;

    [FieldName('cst_vl_pecas')]
    property VlPecas: Real read Fcst_vl_pecas write setFcst_vl_pecas;

    [FieldName('cst_vl_mobra')]
    property VlMobra: Real read Fcst_vl_mobra write setFcst_vl_mobra;

    [FieldName('cst_codsit')]
    property Situacao: Integer read Fcst_codsit write setFcst_codsit;

    [FieldName('SERIE')]
    property Serie: String read FSERIE write setFSERIE;

    [FieldName('IMEI')]
    property IMei: String read FIMEI write setFIMEI;

    [FieldName('NOTE')]
    property Observacao: String read FNOTE write setFNOTE;

    [FieldName('EXECUTADO')]
    property Executado: String read FEXECUTADO write setFEXECUTADO;

    [FieldName('TB_COLABORADOR_ID')]
    property Tecnico: Integer read FTB_COLABORADOR_ID write setFTB_COLABORADOR_ID;

    [FieldName('HR_ENTREGA')]
    property HoraEntrega: TTime read FHR_ENTREGA write setFHR_ENTREGA;

    [FieldName('HR_FORECAST')]
    property HoraPrevista: TTime read FHR_FORECAST write setFHR_FORECAST;

    [FieldName('HR_CONSERTO')]
    property HoraConserto: TTime read FHR_CONSERTO write setFHR_CONSERTO;

  End;

  implementation


{ TConserto }

procedure TConserto.setFcst_Acessorio(const Value: String);
begin
  Fcst_Acessorio := Value;
end;

procedure TConserto.setFcst_Aparelho(const Value: String);
begin
  Fcst_Aparelho := Value;
end;

procedure TConserto.setFcst_Codfor(const Value: Integer);
begin
  Fcst_Codfor := Value;
end;

procedure TConserto.setFcst_Codigo(const Value: Integer);
begin
  Fcst_Codigo := Value;
end;

procedure TConserto.setFcst_Codped(const Value: Integer);
begin
  Fcst_Codped := Value;
end;

procedure TConserto.setFcst_codsit(const Value: Integer);
begin
  Fcst_codsit := Value;
end;

procedure TConserto.setFcst_Constatado(const Value: String);
begin
  Fcst_Constatado := Value;
end;

procedure TConserto.setFcst_dt_conserto(const Value: TDate);
begin
  Fcst_dt_conserto := Value;
end;

procedure TConserto.setFcst_dt_entrega(const Value: TDate);
begin
  Fcst_dt_entrega := Value;
end;

procedure TConserto.setFcst_Marca(const Value: String);
begin
  Fcst_Marca := Value;
end;

procedure TConserto.setFcst_Modelo(const Value: String);
begin
  Fcst_Modelo := Value;
end;

procedure TConserto.setFcst_Numero(const Value: String);
begin
  Fcst_Numero := Value;
end;

procedure TConserto.setFcst_Relatado(const Value: String);
begin
  Fcst_Relatado := Value;
end;

procedure TConserto.setFcst_vl_custo(const Value: Real);
begin
  Fcst_vl_custo := Value;
end;

procedure TConserto.setFcst_vl_mobra(const Value: Real);
begin
  Fcst_vl_mobra := Value;
end;

procedure TConserto.setFcst_vl_pecas(const Value: Real);
begin
  Fcst_vl_pecas := Value;
end;

procedure TConserto.setFDT_FORECAST(const Value: TDate);
begin
  FDT_FORECAST := Value;
end;

procedure TConserto.setFEXECUTADO(const Value: String);
begin
  FEXECUTADO := Value;
end;

procedure TConserto.setFHR_CONSERTO(const Value: TTime);
begin
  FHR_CONSERTO := Value;
end;

procedure TConserto.setFHR_ENTREGA(const Value: TTime);
begin
  FHR_ENTREGA := Value;
end;

procedure TConserto.setFHR_FORECAST(const Value: TTime);
begin
  FHR_FORECAST := Value;
end;

procedure TConserto.setFIMEI(const Value: String);
begin
  FIMEI := Value;
end;

procedure TConserto.setFNOTE(const Value: String);
begin
  FNOTE := Value;
end;

procedure TConserto.setFSERIE(const Value: String);
begin
  FSERIE := Value;
end;


procedure TConserto.setFTB_COLABORADOR_ID(const Value: Integer);
begin
  FTB_COLABORADOR_ID := Value;
end;

end.
