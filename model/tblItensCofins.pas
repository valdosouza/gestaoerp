unit tblItensCofins;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_ITENS_CFS')]
  TItensCofins = Class(TGenericEntity)
  private
    FCofins_CODITF: Integer;
    FCofins_VL_NR: Real;
    FCofins_CODIGO: Integer;
    FCofins_CODNFL: Integer;
    FCofins_AQ_NR: Real;
    FCofins_QT_VDA: Real;
    FCofins_VL_AQ: Real;
    FCofins_VL_BC: Real;
    FCofins_CODTBP: Integer;
    procedure setFCofins_AQ_NR(const Value: Real);
    procedure setFCofins_CODIGO(const Value: Integer);
    procedure setFCofins_CODITF(const Value: Integer);
    procedure setFCofins_CODNFL(const Value: Integer);
    procedure setFCofins_CODTBP(const Value: Integer);
    procedure setFCofins_QT_VDA(const Value: Real);
    procedure setFCofins_VL_AQ(const Value: Real);
    procedure setFCofins_VL_BC(const Value: Real);
    procedure setFCofins_VL_NR(const Value: Real);



  public

    [KeyField('CFS_CODIGO')]
    [FieldName('CFS_CODIGO')]
    property Codigo: Integer read FCofins_CODIGO write setFCofins_CODIGO;


    [FieldName('CFS_CODNFL')]
    property Nota : Integer read FCofins_CODNFL write setFCofins_CODNFL;

    [FieldName('CFS_CODITF')]
    property ItemNota:Integer read FCofins_CODITF write setFCofins_CODITF;

    [FieldName('CFS_CODTBC')]
    property CST : Integer read FCofins_CODTBP write setFCofins_CODTBP;

    [FieldName('CFS_VL_BC')]
    property ValorBase : Real read FCofins_VL_BC write setFCofins_VL_BC;

    [FieldName('CFS_AQ_NR')]
    property Aliquota : Real read FCofins_AQ_NR write setFCofins_AQ_NR;

    [FieldName('CFS_VL_NR')]
    property Valor : Real read FCofins_VL_NR write setFCofins_VL_NR;

    [FieldName('CFS_QT_UNID')]
    property QtdeVenda : Real read FCofins_QT_VDA write setFCofins_QT_VDA;

    [FieldName('CFS_VL_AQ')]
    property ValorAliquota : Real read FCofins_VL_AQ write setFCofins_VL_AQ;

  End;

implementation

{ TItensCofins }

procedure TItensCofins.setFCofins_AQ_NR(const Value: Real);
begin
  FCofins_AQ_NR := Value;
end;

procedure TItensCofins.setFCofins_CODIGO(const Value: Integer);
begin
  FCofins_CODIGO := Value;
end;

procedure TItensCofins.setFCofins_CODITF(const Value: Integer);
begin
  FCofins_CODITF := Value;
end;

procedure TItensCofins.setFCofins_CODNFL(const Value: Integer);
begin
  FCofins_CODNFL := Value;
end;

procedure TItensCofins.setFCofins_CODTBP(const Value: Integer);
begin
  FCofins_CODTBP := Value;
end;

procedure TItensCofins.setFCofins_QT_VDA(const Value: Real);
begin
  FCofins_QT_VDA := Value;
end;

procedure TItensCofins.setFCofins_VL_AQ(const Value: Real);
begin
  FCofins_VL_AQ := Value;
end;

procedure TItensCofins.setFCofins_VL_BC(const Value: Real);
begin
  FCofins_VL_BC := Value;
end;

procedure TItensCofins.setFCofins_VL_NR(const Value: Real);
begin
  FCofins_VL_NR := Value;
end;

end.
