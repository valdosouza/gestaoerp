unit tblImgProduto;

interface

Uses GenericEntity,CAtribEntity, System.Classes, System.SysUtils;
Type
  //nome da classe de entidade
  [TableName('TB_IMG_PRODUTO')]
  TImgProduto = Class(TGenericEntity)
  private

  Public

    [KeyField('IMG_CODIGO')]
    [FieldName('IMG_CODIGO')]
    property Codigo: Integer read FIMG_CODIGO write setFIMG_CODIGO;


    [FieldName('IMG_CODPRO')]
    property Produto: Integer read FIMG_CODPRO write setFIMG_CODPRO;



    IMG_IMAGEM  BLOB SUB_TYPE 0 SEGMENT SIZE 80,
    IMG_TIPO    CHAR(1),
    IMG_RESIZE  CHAR(1)

  End;

implementation

end.
