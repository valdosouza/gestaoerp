unit tblRetaguarda;

interface

Uses TEntity,CAtribEntity;

Type
  //nome da classe de entidade
  [TableName('TB_RETAGUARDA')]
  TRetaguarda = Class(TGenericEntity)
  private
    FPATH_BD: String;
    FATIVO: String;
    FID: Integer;
    FTERMINAL: Integer;
    procedure setFATIVO(const Value: String);
    procedure setFID(const Value: Integer);
    procedure setFPATH_BD(const Value: String);
    procedure setFTERMINAL(const Value: Integer);

  public
    [KeyField('ID')]
    [FieldName('ID')]
    property Codigo: Integer read FID write setFID;

    [FieldName('ATIVO')]
    property Ativo: String read FATIVO write setFATIVO;

    [FieldName('PATH_BD')]
    property CaminhoBancoDados: String read FPATH_BD write setFPATH_BD;

    [FieldName('TERMINAL')]
    property Termina: Integer read FTERMINAL write setFTERMINAL;

  End;

implementation

{ TRetaguarda }

procedure TRetaguarda.setFATIVO(const Value: String);
begin
  FATIVO := Value;
end;

procedure TRetaguarda.setFID(const Value: Integer);
begin
  FID := Value;
end;

procedure TRetaguarda.setFPATH_BD(const Value: String);
begin
  FPATH_BD := Value;
end;

procedure TRetaguarda.setFTERMINAL(const Value: Integer);
begin
  FTERMINAL := Value;
end;

end.
