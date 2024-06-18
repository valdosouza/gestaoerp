unit tblInternet;


interface

Uses TEntity,CAtribEntity, Data.DB;

Type
  //nome da classe de entidade
  [TableName('TB_INTERNET')]
  TInternet = Class(TGenericEntity)
  private
    FINT_FTP_PWS: String;
    FINT_FTP_DIR_IMG: String;
    FINT_DIR_IMAGES: String;
    FINT_VITRINE: String;
    FINT_PXY_USER: String;
    FINT_PXY_PORTA: String;
    FINT_ID_GOOGLE_ANALYTIC: String;
    FINT_TITLE: String;
    FINT_CODIGO: Integer;
    FINT_PXY_PATH: String;
    FINT_WEBSERVICE: String;
    FINT_FTP_DIR_BKP: String;
    FINT_FTP_USER: String;
    FINT_DEALER: String;
    FINT_WWW: String;
    FINT_EMAIL_FINANCEIRO: String;
    FINT_CODTPR: String;
    FINT_FTP_PATH: String;
    FINT_CODMHA: Integer;
    FINT_CODETS: Integer;
    FINT_PXY_PWS: String;
    FINT_CODWSR: Integer;
    procedure setFINT_CODETS(const Value: Integer);
    procedure setFINT_CODIGO(const Value: Integer);
    procedure setFINT_CODMHA(const Value: Integer);
    procedure setFINT_CODTPR(const Value: String);
    procedure setFINT_CODWSR(const Value: Integer);
    procedure setFINT_DEALER(const Value: String);
    procedure setFINT_DIR_IMAGES(const Value: String);
    procedure setFINT_EMAIL_FINANCEIRO(const Value: String);
    procedure setFINT_FTP_DIR_BKP(const Value: String);
    procedure setFINT_FTP_DIR_IMG(const Value: String);
    procedure setFINT_FTP_PATH(const Value: String);
    procedure setFINT_FTP_PWS(const Value: String);
    procedure setFINT_FTP_USER(const Value: String);
    procedure setFINT_ID_GOOGLE_ANALYTIC(const Value: String);
    procedure setFINT_PXY_PATH(const Value: String);
    procedure setFINT_PXY_PORTA(const Value: String);
    procedure setFINT_PXY_PWS(const Value: String);
    procedure setFINT_PXY_USER(const Value: String);
    procedure setFINT_TITLE(const Value: String);
    procedure setFINT_VITRINE(const Value: String);
    procedure setFINT_WEBSERVICE(const Value: String);
    procedure setFINT_WWW(const Value: String);

  public

    [KeyField('ID')]
    [FieldName('INT_CODIGO')]
    property Codigo: Integer read FINT_CODIGO write setFINT_CODIGO;

    [FieldName('INT_CODMHA')]
    property Estabelecimento: Integer read FINT_CODMHA write setFINT_CODMHA;

    [FieldName('INT_WWW')]
    property www: String read FINT_WWW write setFINT_WWW;

    [FieldName('INT_FTP_PATH')]
    property Ftp_Path: String read FINT_FTP_PATH write setFINT_FTP_PATH;

    [FieldName('INT_FTP_USER')]
    property Ftp_User: String read FINT_FTP_USER write setFINT_FTP_USER;

    [FieldName('INT_FTP_PWS')]
    property ftp_pws: String read FINT_FTP_PWS write setFINT_FTP_PWS;

    [FieldName('INT_FTP_DIR_IMG')]
    property Ftp_dir_img: String read FINT_FTP_DIR_IMG write setFINT_FTP_DIR_IMG;

    [FieldName('INT_FTP_DIR_BKP')]
    property ftp_dir_bkp: String read FINT_FTP_DIR_BKP write setFINT_FTP_DIR_BKP;

    [FieldName('INT_PXY_PATH')]
    property proxy_path: String read FINT_PXY_PATH write setFINT_PXY_PATH;

    [FieldName('INT_PXY_PORTA')]
    property proxy_porta: String read FINT_PXY_PORTA write setFINT_PXY_PORTA;

    [FieldName('INT_PXY_USER')]
    property proxy_user: String read FINT_PXY_USER write setFINT_PXY_USER;

    [FieldName('INT_PXY_PWS')]
    property proxy_pws: String read FINT_PXY_PWS write setFINT_PXY_PWS;

    [FieldName('INT_CODTPR')]
    property TabelaPreco: String read FINT_CODTPR write setFINT_CODTPR;

    [FieldName('INT_CODWSR')]
    property CodigoWebServer: Integer read FINT_CODWSR write setFINT_CODWSR;

    [FieldName('INT_WEBSERVICE')]
    property Url_Webservice: String read FINT_WEBSERVICE write setFINT_WEBSERVICE;

    [FieldName('INT_VITRINE')]
    property Vitrine: String read FINT_VITRINE write setFINT_VITRINE;

    [FieldName('INT_DEALER')]
    property Revendedor: String read FINT_DEALER write setFINT_DEALER;

    [FieldName('INT_TITLE')]
    property TituloSite: String read FINT_TITLE write setFINT_TITLE;

    [FieldName('INT_CODETS')]
    property CodigoEstoque: Integer read FINT_CODETS write setFINT_CODETS;

    [FieldName('INT_DIR_IMAGES')]
    property DiretorioImagem: String read FINT_DIR_IMAGES write setFINT_DIR_IMAGES;

    [FieldName('INT_ID_GOOGLE_ANALYTIC')]
    property GoogleAnalytic: String read FINT_ID_GOOGLE_ANALYTIC write setFINT_ID_GOOGLE_ANALYTIC;

    [FieldName('INT_EMAIL_FINANCEIRO')]
    property emailFinanceiro: String read FINT_EMAIL_FINANCEIRO write setFINT_EMAIL_FINANCEIRO;

  End;


implementation

{ TInternet }

procedure TInternet.setFINT_CODETS(const Value: Integer);
begin
  FINT_CODETS := Value;
end;

procedure TInternet.setFINT_CODIGO(const Value: Integer);
begin
  FINT_CODIGO := Value;
end;

procedure TInternet.setFINT_CODMHA(const Value: Integer);
begin
  FINT_CODMHA := Value;
end;

procedure TInternet.setFINT_CODTPR(const Value: String);
begin
  FINT_CODTPR := Value;
end;

procedure TInternet.setFINT_CODWSR(const Value: Integer);
begin
  FINT_CODWSR := Value;
end;

procedure TInternet.setFINT_DEALER(const Value: String);
begin
  FINT_DEALER := Value;
end;

procedure TInternet.setFINT_DIR_IMAGES(const Value: String);
begin
  FINT_DIR_IMAGES := Value;
end;

procedure TInternet.setFINT_EMAIL_FINANCEIRO(const Value: String);
begin
  FINT_EMAIL_FINANCEIRO := Value;
end;

procedure TInternet.setFINT_FTP_DIR_BKP(const Value: String);
begin
  FINT_FTP_DIR_BKP := Value;
end;

procedure TInternet.setFINT_FTP_DIR_IMG(const Value: String);
begin
  FINT_FTP_DIR_IMG := Value;
end;

procedure TInternet.setFINT_FTP_PATH(const Value: String);
begin
  FINT_FTP_PATH := Value;
end;

procedure TInternet.setFINT_FTP_PWS(const Value: String);
begin
  FINT_FTP_PWS := Value;
end;

procedure TInternet.setFINT_FTP_USER(const Value: String);
begin
  FINT_FTP_USER := Value;
end;

procedure TInternet.setFINT_ID_GOOGLE_ANALYTIC(const Value: String);
begin
  FINT_ID_GOOGLE_ANALYTIC := Value;
end;

procedure TInternet.setFINT_PXY_PATH(const Value: String);
begin
  FINT_PXY_PATH := Value;
end;

procedure TInternet.setFINT_PXY_PORTA(const Value: String);
begin
  FINT_PXY_PORTA := Value;
end;

procedure TInternet.setFINT_PXY_PWS(const Value: String);
begin
  FINT_PXY_PWS := Value;
end;

procedure TInternet.setFINT_PXY_USER(const Value: String);
begin
  FINT_PXY_USER := Value;
end;

procedure TInternet.setFINT_TITLE(const Value: String);
begin
  FINT_TITLE := Value;
end;

procedure TInternet.setFINT_VITRINE(const Value: String);
begin
  FINT_VITRINE := Value;
end;

procedure TInternet.setFINT_WEBSERVICE(const Value: String);
begin
  FINT_WEBSERVICE := Value;
end;

procedure TInternet.setFINT_WWW(const Value: String);
begin
  FINT_WWW := Value;
end;

end.
