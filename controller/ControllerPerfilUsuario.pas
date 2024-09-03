unit ControllerPerfilUsuario;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblPerfilUsuario, prm_profile, ControllerPermissaoPerfil;

Type
  TListaPerfilUsuario = TObjectList<TPerfilUsuario>;
  TControllerPerfilUsuario = Class(TControllerBase)
  private
    FParametros: TPrmPerfil;
    procedure setFParametros(const Value: TPrmPerfil);

  public
    Registro : TPerfilUsuario;
    Lista : TListaPerfilUsuario;

    permisssaoPerfil : TControllerPermissaoPerfil;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmPerfil read FParametros write setFParametros;
  End;

implementation

function TControllerPerfilUsuario.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerPerfilUsuario.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPerfilUsuario.Create;
  FParametros := TPrmPerfil.Create;
  Lista := TListaPerfilUsuario.Create;
  permisssaoPerfil := TControllerPermissaoPerfil.Create(self);
end;

function TControllerPerfilUsuario.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPerfilUsuario.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  permisssaoPerfil.DisposeOf;
  inherited;
end;

function TControllerPerfilUsuario.insert: boolean;
begin
  try
    if Registro.Codigo  = 0 then
      Registro.Codigo := Generator('GN_PERFIL_USUARIO');
    insertObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerPerfilUsuario.salva: boolean;
begin
  Result := True;
    if Registro.Codigo  = 0 then
      Registro.Codigo := Generator('GN_PERFIL_USUARIO');
  SaveObj(Registro);
end;

function TControllerPerfilUsuario.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


procedure TControllerPerfilUsuario.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TPerfilUsuario;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_PERFIL_USUARIO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND PFL_CODIGO = :PFL_CODIGO';
        ParamByName('PFL_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND PFL_DESCRICAO LIKE :PFL_DESCRICAO';
        ParamByName('PFL_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TPerfilUsuario.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPerfilUsuario.setFParametros(const Value: TPrmPerfil);
begin
  FParametros := Value;
end;

procedure TControllerPerfilUsuario.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerPerfilUsuario.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

