unit ControllerPermissaoPerfil;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblPermissaoPerfil, prm_permissao_perfil;

Type
  TListaPermissaoPerfil = TObjectList<TPermissaoPerfil>;
  TControllerPermissaoPerfil = Class(TControllerBase)
  private
    FParametros: TPrmPermissaoPerfil;
    procedure setFParametros(const Value: TPrmPermissaoPerfil);

  public
    Registro : TPermissaoPerfil;
    Lista : TListaPermissaoPerfil;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    procedure replace;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure getbyId;

    function Clear:Boolean;
    function getPrivilege:boolean;
    procedure search;
    property Parametros : TPrmPermissaoPerfil read FParametros write setFParametros;
  End;

implementation

function TControllerPermissaoPerfil.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerPermissaoPerfil.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPermissaoPerfil.Create;
  FParametros := TPrmPermissaoPerfil.Create;
  Lista := TListaPermissaoPerfil.Create;
end;

function TControllerPermissaoPerfil.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPermissaoPerfil.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerPermissaoPerfil.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerPermissaoPerfil.replace;
begin
  replaceObj(Registro);
end;

function TControllerPermissaoPerfil.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerPermissaoPerfil.search;
var
  Lc_Qry : TSTQuery;
  LITem : TPermissaoPerfil;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                'select pf.* ',
                'from TB_PERFIL_USUARIO pu ',
                '  INNER JOIN TB_PERMISSAO_PERFIL pf ',
                '  ON (pu.PFL_CODIGO = pf.PPF_CODPFL) ',
                'WHERE  (pu.PFL_CODIGO =:PFL_CODIGO)  '

      ));
      ParamByName('PFL_CODIGO').AsInteger := Parametros.FieldName.Perfil;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TPermissaoPerfil.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerPermissaoPerfil.setFParametros(const Value: TPrmPermissaoPerfil);
begin
  FParametros := Value;
end;

procedure TControllerPermissaoPerfil.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerPermissaoPerfil.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

function TControllerPermissaoPerfil.getPrivilege: boolean;
var
  Lc_Qry: TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add('SELECT * FROM TB_PERMISSAO_PERFIL '+
              'WHERE PPF_CODPFL=:PPF_CODPFL '+
              '  AND PPF_CODIIF=:PPF_CODIIF ');

      ParamByName('PPF_CODPFL').AsInteger := Parametros.FieldName.Perfil;
      ParamByName('PPF_CODIIF').AsInteger := Parametros.FieldName.Privilegio;
      Active := True;
      FetchAll;
      Result := (RecordCount > 0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.

