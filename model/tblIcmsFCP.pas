unit tblIcmsFCP;

interface

Uses TEntity,CAtribEntity, Data.DB;

Type
  //nome da classe de entidade
  [TableName('TB_ICMS_FCP')]
  TIcmsFCP = Class(TGenericEntity)
  private
    FPFCP: Real;
    FVFCP: Real;
    FTB_NOTA_FISCAL_ID: Integer;
    FTB_ITENS_NFL_ID: Integer;
    FPST: Real;
    FPFCPST: Real;
    FVBCFCPST: Real;
    FVBCFCPSTRET: Real;
    FPFCPSTRET: Real;
    FVFCPST: Real;
    FVFCPSTRET: Real;
    FVBCFCP: Real;
    procedure setFPFCP(const Value: Real);
    procedure setFPFCPST(const Value: Real);
    procedure setFPFCPSTRET(const Value: Real);
    procedure setFPST(const Value: Real);
    procedure setFTB_ITENS_NFL_ID(const Value: Integer);
    procedure setFTB_NOTA_FISCAL_ID(const Value: Integer);
    procedure setFVBCFCP(const Value: Real);
    procedure setFVBCFCPST(const Value: Real);
    procedure setFVBCFCPSTRET(const Value: Real);
    procedure setFVFCP(const Value: Real);
    procedure setFVFCPST(const Value: Real);
    procedure setFVFCPSTRET(const Value: Real);

  public
    [KeyField('TB_ITENS_NFL_ID')]
    [FieldName('TB_ITENS_NFL_ID')]
    property Codigo: Integer read FTB_ITENS_NFL_ID write setFTB_ITENS_NFL_ID;

    [FieldName('TB_NOTA_FISCAL_ID')]
    property NotaFiscal: Integer read FTB_NOTA_FISCAL_ID write setFTB_NOTA_FISCAL_ID;

    [FieldName('VBCFCP')]
    property BaseCalculo: Real read FVBCFCP write setFVBCFCP;

    [FieldName('PFCP')]
    property Percentual: Real read FPFCP write setFPFCP;

    [FieldName('VFCP')]
    property Valor: Real read FVFCP write setFVFCP;

    [FieldName('VBCFCPST')]
    property BaseCalculoST: Real read FVBCFCPST write setFVBCFCPST;

    [FieldName('PFCPST')]
    property PercentualST: Real read FPFCPST write setFPFCPST;

    [FieldName('VFCPST')]
    property ValorST: Real read FVFCPST write setFVFCPST;

    [FieldName('PST')]
    property AliqSupConsumidor: Real read FPST write setFPST;

    [FieldName('VBCFCPSTRET')]
    property BaseCalculoSTRET: Real read FVBCFCPSTRET write setFVBCFCPSTRET;

    [FieldName('PFCPSTRET')]
    property PercentualSTRET: Real read FPFCPSTRET write setFPFCPSTRET;

    [FieldName('VFCPSTRET')]
    property ValorSTRET: Real read FVFCPSTRET write setFVFCPSTRET;

  End;

implementation

{ TIcmsFCP }

procedure TIcmsFCP.setFPFCP(const Value: Real);
begin
  FPFCP := Value;
end;

procedure TIcmsFCP.setFPFCPST(const Value: Real);
begin
  FPFCPST := Value;
end;

procedure TIcmsFCP.setFPFCPSTRET(const Value: Real);
begin
  FPFCPSTRET := Value;
end;

procedure TIcmsFCP.setFPST(const Value: Real);
begin
  FPST := Value;
end;

procedure TIcmsFCP.setFTB_ITENS_NFL_ID(const Value: Integer);
begin
  FTB_ITENS_NFL_ID := Value;
end;

procedure TIcmsFCP.setFTB_NOTA_FISCAL_ID(const Value: Integer);
begin
  FTB_NOTA_FISCAL_ID := Value;
end;

procedure TIcmsFCP.setFVBCFCP(const Value: Real);
begin
  FVBCFCP := Value;
end;

procedure TIcmsFCP.setFVBCFCPST(const Value: Real);
begin
  FVBCFCPST := Value;
end;

procedure TIcmsFCP.setFVBCFCPSTRET(const Value: Real);
begin
  FVBCFCPSTRET := Value;
end;

procedure TIcmsFCP.setFVFCP(const Value: Real);
begin
  FVFCP := Value;
end;

procedure TIcmsFCP.setFVFCPST(const Value: Real);
begin
  FVFCPST := Value;
end;

procedure TIcmsFCP.setFVFCPSTRET(const Value: Real);
begin
  FVFCPSTRET := Value;
end;

end.
