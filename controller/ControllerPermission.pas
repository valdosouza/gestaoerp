unit ControllerPermission;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblPermissao, prm_Permission;

Type
  TListaPermissao = TObjectList<TPermissao>;
  TControllerPermission = Class(TControllerBase)
  private
    FParametros: TPrmPermission;
    procedure setFParametros(const Value: TPrmPermission);

  public
    Registro : TPermissao;
    Lista : TListaPermissao;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
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

destructor TControllerPermission.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerPermission.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
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
      SQL.Text := ' SELECT * FROM TB_PERMISSAO where 1=1 ';

      {' SELECT PER.PER_CODMHA, PER.PER_CODUSU, PER.PER_CODIIF, USU_NOME, OPF.OPF_DESCRICAO ' +
      '   FROM TB_PERMISSAO PER ' +
      '   JOIN TB_USUARIO USU ON USU.USU_CODIGO = PER.PER_CODUSU ' +
      '   JOIN TB_ITENS_IFC IIF ON IIF.IIF_CODIGO = PER.PER_CODIIF ' +
      '   JOIN TB_OPER_INTERFACE OPF ON OPF.OPF_CODIGO = IIF.IIF_CODOPF ';}

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TPermissao.Create;
        get(Lc_Qry, LITem);
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

