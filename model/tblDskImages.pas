unit tblDskImages;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('TB_IMAGES')]
  TDskImages = Class(TGenericEntity)
  private
    FID: Integer;
    FTARGET: String;
    FEXTENSION: String;
    FFILE_NAME: String;
    FTB_INSTITUTION_ID: Integer;
    FTABLE_ID: Integer;
    FKIND: String;
    procedure setFEXTENSION(const Value: String);
    procedure setFFILE_NAME(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFKIND(const Value: String);
    procedure setFTABLE_ID(const Value: Integer);
    procedure setFTARGET(const Value: String);
    procedure setFTB_INSTITUTION_ID(const Value: Integer);


  Public

    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('TB_INSTITUTION_ID')]
    property Estabelecimento: Integer read FTB_INSTITUTION_ID write setFTB_INSTITUTION_ID;

    [FieldName('KIND')]
    property Tipo: String read FKIND write setFKIND;

    [FieldName('TARGET')]
    property Alvo: String read FTARGET write setFTARGET;

    [FieldName('TABLE_ID')]
    property VinculoTabela: Integer read FTABLE_ID write setFTABLE_ID;

    [FieldName('FILE_NAME')]
    property NomeArquivo: String read FFILE_NAME write setFFILE_NAME;

    [FieldName('EXTENSION')]
    property Extensao: String read FEXTENSION write setFEXTENSION;

  End;

implementation



{ TDskImages }

procedure TDskImages.setFEXTENSION(const Value: String);
begin
  FEXTENSION := Value;
end;

procedure TDskImages.setFFILE_NAME(const Value: String);
begin
  FFILE_NAME := Value;
end;

procedure TDskImages.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TDskImages.setFKIND(const Value: String);
begin
  FKIND := Value;
end;

procedure TDskImages.setFTABLE_ID(const Value: Integer);
begin
  FTABLE_ID := Value;
end;

procedure TDskImages.setFTARGET(const Value: String);
begin
  FTARGET := Value;
end;

procedure TDskImages.setFTB_INSTITUTION_ID(const Value: Integer);
begin
  FTB_INSTITUTION_ID := Value;
end;

end.
