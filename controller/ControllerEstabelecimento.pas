unit ControllerEstabelecimento;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,tblempresa,
    ControllerEndereco, Vcl.Graphics, Vcl.Imaging.jpeg,Data.DB;

Type
  TControllerEstabelecimento = Class(TControllerBase)
  private

  public
    Registro : TEmpresa;
    Endereco : TControllerEndereco;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getbyID;
    function getAll:Boolean;
    function salva:boolean;
    function GetTipoEmissao:Integer;
    function GetCNPJByTipoZero:String;
    procedure Imagem(Img:TPicture; Pc_Descricao:String);
    function getDDD:String;
  End;
implementation

{ TControllerEstabelecimento }

constructor TControllerEstabelecimento.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TEmpresa.Create;
  Endereco := TControllerEndereco.create(Self);
end;

destructor TControllerEstabelecimento.Destroy;
begin
  Registro.DisposeOf;
  Endereco.Destroy;
  inherited;
end;

function TControllerEstabelecimento.getAll: Boolean;
begin
  if Registro.Codigo = 0 then
    get( getByField('TB_EMPRESA','EMP_CNPJ',Registro.CpfCNPJ),Registro)
  else
    _getByKey(Registro);
  Endereco.Registro.CodigoEmpresa := Registro.Codigo;
  Endereco.getAll;
end;

procedure TControllerEstabelecimento.getbyID;
begin
  _getByKey(Registro);
end;

function TControllerEstabelecimento.GetCNPJByTipoZero: String;
var
  Lc_Qry : TSTQuery;
begin
  Result := '';
  Lc_Qry := GeraQuery;
   try
    with Lc_Qry do
    Begin
      CachedUpdates := True;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT EMP_CNPJ ',
                'from TB_EMPRESA ',
                'WHERE (EMP_TIPO = 0)'
                ));
      Active := True;
      FetchAll;
      Result := FieldByName('EMP_CNPJ').AsString;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerEstabelecimento.getDDD: String;
begin
  Result := '';
  if Endereco.Registro.Codigo > 0 then
  Begin
    //41999112072
    //4199112072
    //999112072
    //99112072
    if ( Length(Endereco.Registro.Fone)>=10 ) then
    Begin
      Result := Copy(Endereco.Registro.Fone,1,2);
    End;
  End;

end;

function TControllerEstabelecimento.GetTipoEmissao: Integer;
var
  Lc_Qry : TSTQuery;
begin
  Result := 0;
  Lc_Qry := GeraQuery;
   try
    with Lc_Qry do
    Begin
      CachedUpdates := True;
      SQL.Clear;
      SQL.Add(concat(
                'SELECT NFE_EMISSAO ',
                ' from TB_NF_ELETRONICA ',
                'WHERE (NFE_CODEMP=:NFE_CODEMP)'
                ));
      ParamByName('NFE_CODEMP').AsInteger := Self.Registro.Codigo;
      Active := True;
      FetchAll;
      Result := StrToIntDef(FieldByName('NFE_EMISSAO').AsString,1);
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerEstabelecimento.Imagem(Img: TPicture;
  Pc_Descricao: String);
var
  Lc_Qry : TSTQuery;
  St_Image : TStream;
  Lc_jpg : TJPEGImage;
begin
  St_Image := nil;
  Lc_jpg := TJPEGImage.Create;
  Lc_Qry := GeraQuery;
   try
    with Lc_Qry do
    Begin
      CachedUpdates := True;
      SQL.Clear;
      SQL.Add('SELECT IMG_IMAGEM FROM TB_IMG_EMPRESA '+
                   'WHERE (IMG_CODEMP=:IMG_CODEMP) AND (IMG_DESCRICAO =:IMG_DESCRICAO) ');
      ParamByName('IMG_CODEMP').AsInteger := Self.Registro.Codigo;
      ParamByName('IMG_DESCRICAO').AsAnsiString := Pc_Descricao;
      Active := True;
      FetchAll;

      St_Image := CreateBlobStream(FieldByName('IMG_IMAGEM'),bmRead);
      if St_Image.Size > 0 then
      begin
        Lc_jpg.LoadFromStream(St_Image);
        Img.Assign(Lc_jpg);
      end
      else
        Img.Graphic := nil;
    end;
  finally
    FinalizaQuery(Lc_Qry);
    FreeAndNil(St_Image);
    FreeAndNil(Lc_jpg);
  end;

end;

function TControllerEstabelecimento.salva: boolean;
begin
  try
    SaveObj(Registro);
    REsult := True;
  except
    REsult := False;
  end;
end;

end.
