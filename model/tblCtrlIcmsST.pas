unit tblCtrlIcmsST;

interface

Uses GenericEntity,CAtribEntity, Classes, SysUtils;

Type
  //nome da classe de entidade
  [TableName('TB_CTRL_ICMS_ST')]
  TCtrlIcmsST = Class(TGenericEntity)

  private
    FPST: Real;
    FTB_PRODUTO_ID: integer;
    FVBCSTRET: Real;
    FID: integer;
    FVICMSSTRET: real;
    FTB_INSTITUTION_ID: integer;
    FITF_DESTINO_ID: Integer;
    FVICMSSUBSTITUTO: real;
    FITF_ORIGEM_ID: Integer;
    procedure setFID(const Value: integer);
    procedure setFITF_DESTINO_ID(const Value: Integer);
    procedure setFITF_ORIGEM_ID(const Value: Integer);
    procedure setFPST(const Value: Real);
    procedure setFTB_INSTITUTION_ID(const Value: integer);
    procedure setFTB_PRODUTO_ID(const Value: integer);
    procedure setFVBCSTRET(const Value: Real);
    procedure setFVICMSSTRET(const Value: real);
    procedure setFVICMSSUBSTITUTO(const Value: real);

  public
    [KeyField('TB_INSTITUTION_ID')]
    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: integer  read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: integer  read FID write setFID;


    [FieldName('ITF_ORIGEM_ID')]
    property Origem: Integer  read FITF_ORIGEM_ID write setFITF_ORIGEM_ID;

    [FieldName('TB_PRODUTO_ID')]
    property Produto: integer read FTB_PRODUTO_ID write setFTB_PRODUTO_ID;

    [FieldName('VBCSTRET')]
    property ValorBaseSTRetido: Real  read FVBCSTRET write setFVBCSTRET;

    [FieldName('PST')]
    property AliqST: Real read FPST write setFPST;

    [FieldName('VICMSSUBSTITUTO')]
    property ValorICMSSubstituto: real read FVICMSSUBSTITUTO write setFVICMSSUBSTITUTO;

    [FieldName('VICMSSTRET')]
    property ValorICMSSTRetido: real read FVICMSSTRET  write setFVICMSSTRET;

    [FieldName('ITF_DESTINO_ID')]
    property Destino: Integer  read FITF_DESTINO_ID write setFITF_DESTINO_ID;

  End;


implementation

{ TCtrlIcmsST }

procedure TCtrlIcmsST.setFID(const Value: integer);
begin
  FID := Value;
end;

procedure TCtrlIcmsST.setFITF_DESTINO_ID(const Value: Integer);
begin
  FITF_DESTINO_ID := Value;
end;

procedure TCtrlIcmsST.setFITF_ORIGEM_ID(const Value: Integer);
begin
  FITF_ORIGEM_ID := Value;
end;

procedure TCtrlIcmsST.setFPST(const Value: Real);
begin
  FPST := Value;
end;

procedure TCtrlIcmsST.setFTB_INSTITUTION_ID(const Value: integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

procedure TCtrlIcmsST.setFTB_PRODUTO_ID(const Value: integer);
begin
  FTB_PRODUTO_ID := Value;
end;

procedure TCtrlIcmsST.setFVBCSTRET(const Value: Real);
begin
  FVBCSTRET := Value;
end;

procedure TCtrlIcmsST.setFVICMSSTRET(const Value: real);
begin
  FVICMSSTRET := Value;
end;

procedure TCtrlIcmsST.setFVICMSSUBSTITUTO(const Value: real);
begin
  FVICMSSUBSTITUTO := Value;
end;

end.
