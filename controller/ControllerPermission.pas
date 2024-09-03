unit ControllerPermission;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblPermissao, prm_Permission, ControllerItensIfc,
     ControllerPermissaoPerfil,ControllerPerfilUsuario;

Type
  TListaPermissao = TObjectList<TPermissao>;
  TControllerPermission = Class(TControllerBase)
  private
    FParametros: TPrmPermission;
    procedure setFParametros(const Value: TPrmPermission);

  public
    Registro : TPermissao;
    Lista : TListaPermissao;
    ItensInterface : TControllerItensIFc;
    Profile : TControllerPermissaoPerfil;
    UserProfile : TControllerPerfilUsuario;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    procedure replace;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    procedure LoadByInterface;
    function getPrivilege:boolean;
    procedure deletebyUser;
    property Parametros : TPrmPermission read FParametros write setFParametros;
  End;

implementation

function TControllerPermission.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerPermission.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPermissao.Create;
  FParametros := TPrmPermission.Create;
  Lista := TListaPermissao.Create;
  ItensInterface := TControllerItensIFc.Create(self);
  Profile := TControllerPermissaoPerfil.Create(self);
  UserProfile := TControllerPerfilUsuario.Create(self);
end;

function TControllerPermission.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPermission.deletebyUser;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'delete from TB_PERMISSAO ',
                'where PER_CODUSU = :PER_CODUSU  '
      ));
      ParamByName('PER_CODUSU').AsInteger := Registro.Usuario;
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerPermission.Destroy;
begin
  FreeAndNil( UserProfile);
  FreeAndNil(Profile);
  FreeAndNil(ItensInterface);
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerPermission.insert: boolean;
begin
  try
    insertObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerPermission.getPrivilege: boolean;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' SELECT P.* ',
                '   FROM TB_PERMISSAO p ',
                'WHERE PER_CODMHA=:PER_CODMHA ',
                '  AND PER_CODUSU=:PER_CODUSU ',
                '  AND PER_CODIIF=:PER_CODIIF '
      ));
      ParamByName('PER_CODMHA').AsInteger := Parametros.Estabelecimento;
      ParamByName('PER_CODUSU').AsInteger := Parametros.FieldName.Usuario;
      ParamByName('PER_CODIIF').AsInteger := Parametros.FieldName.Privilegio;
      Active := True;
      FetchAll;
      Result := (recordCount >0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPermission.LoadByInterface;
var
  Lc_Qry: TSTQuery;
  Lc_item : TPermissao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
              'SELECT IIF.IIF_CODIGO, OPF.OPF_CODIGO, OPF.OPF_DESCRICAO ',
              'FROM TB_ITENS_IFC IIF ',
              '   INNER JOIN TB_OPER_INTERFACE OPF ',
              '   ON (OPF.OPF_CODIGO = IIF.IIF_CODOPF) ',
             'WHERE IIF_CODIFC=:IIF_CODIFC ',
              'ORDER BY OPF_CODIGO  '
      ));
      ParamByName('IIF_CODIFC').AsInteger := Parametros.FieldName.Privilegio;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not Eof do
      Begin
        Lc_item := TPermissao.Create;
        get(Lc_Qry, Lc_item);
        Lista.add(Lc_item);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPermission.replace;
begin
  replaceObj(Registro);
end;

function TControllerPermission.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerPermission.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TPermissao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' SELECT P.*, u.USU_NOME, o.OPF_DESCRICAO ',
                '   FROM TB_PERMISSAO p ',
                '   JOIN TB_USUARIO u ',
                '   ON (u.USU_CODIGO = p.PER_CODUSU) ',
                '   JOIN TB_ITENS_IFC i ',
                '   ON (i.IIF_CODIGO = p.PER_CODIIF) ',
                '   JOIN TB_OPER_INTERFACE o ',
                '   ON (o.OPF_CODIGO = i.IIF_CODOPF) ',
                'WHERE ( PER_CODMHA=:PER_CODMHA ) '
      ));
      ParamByName('PER_CODMHA').AsInteger := Parametros.Estabelecimento;

      if Parametros.FieldName.Usuario > 0 then
      Begin
        SQL.Add('  AND (PER_CODUSU =:PER_CODUSU) ');
        ParamByName('PER_CODUSU').AsInteger := Parametros.FieldName.Usuario;
      End;

      if Parametros.FieldName.Privilegio > 0 then
      Begin
        SQL.Add('  AND (PER_CODIIF =:PER_CODIIF ) ');
        ParamByName('PER_CODIIF').AsInteger := Parametros.FieldName.Privilegio;
      End;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TPermissao.Create;
        get(Lc_Qry, LITem);
        LITem.DescricaoOperacao := FieldByname('OPF_DESCRICAO').AsString;
        LITem.DescricaoOperacao := FieldByname('OPF_DESCRICAO').AsString;
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPermission.setFParametros(const Value: TPrmPermission);
begin
  FParametros := Value;
end;

procedure TControllerPermission.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerPermission.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

