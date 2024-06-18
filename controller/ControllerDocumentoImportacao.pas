unit ControllerDocumentoImportacao;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblDocumentoImportacao ,Un_MSg;

Type
  TControllerDocumentoImportacao = Class(TControllerBase)
  private

  public
    Registro : TDocumentoImportacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
    procedure clear;
  End;

implementation

procedure TControllerDocumentoImportacao.clear;
begin
  clearObj(Registro);
end;

constructor TControllerDocumentoImportacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TDocumentoImportacao.Create;
end;

function TControllerDocumentoImportacao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerDocumentoImportacao.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerDocumentoImportacao.insere: boolean;
begin
  Registro.Codigo := Generator('GN_DEC_IMP');
  SaveObj(Registro);
end;

function TControllerDocumentoImportacao.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_DEC_IMP');
  SaveObj(Registro);
end;

procedure TControllerDocumentoImportacao.getById;
begin
  _getByKey(Registro);
end;



end.
