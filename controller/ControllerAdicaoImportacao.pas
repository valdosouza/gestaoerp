unit ControllerAdicaoImportacao;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblAdicaoImportacao ,Un_MSg;

Type
  TControllerAdicaoImportacao = Class(TControllerBase)
  private
  public
    Registro : TAdicaoImportacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    Function delete:boolean;
    procedure getbyDIM;
    procedure clear;
  End;

implementation

procedure TControllerAdicaoImportacao.clear;
begin
  clearObj(Registro);
end;

constructor TControllerAdicaoImportacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAdicaoImportacao.Create;
end;

function TControllerAdicaoImportacao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerAdicaoImportacao.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerAdicaoImportacao.insere: boolean;
begin
  Registro.Codigo := Generator('GN_ADIC_IMP');
  SaveObj(Registro);
end;

function TControllerAdicaoImportacao.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_ADIC_IMP');
  SaveObj(Registro);
end;

procedure TControllerAdicaoImportacao.getbyDIM;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_ADIC_IMP '+
              'WHERE (ADC_CODDIM =:ADC_CODDIM)');
      ParamByName('ADC_CODDIM').asInteger := Registro.CodigoImportacao;
      Active := True;
      FetchAll;
      if ( RecordCount > 0 ) then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerAdicaoImportacao.getById;
begin
  _getByKey(Registro);
end;


end.
