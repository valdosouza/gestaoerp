unit ControllerComissao;

interface

uses STDatabase,STQuery,Classes, SysUtils,ControllerBase, tblComissao, Md5,
    FireDAC.Stan.Param;

Type
  TControllerComissao = Class(TControllerBase)
  private

  public
    Registro : TComissao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getById:Boolean;
  End;

  implementation
{ ControllerComissao}

constructor TControllerComissao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TComissao.Create;
end;

function TControllerComissao.delete: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      SQL.Clear;
      SQL.Add(concat(
                ' delete from tb_comissao',
                ' where  com_codigo is not null '
              ));

      if (Registro.Codigo > 0) then
        SQL.Add(' AND ( COM_CODIGO =:COM_CODIGO ) ');

      if (Registro.Estabelecimento > 0) then
        SQL.Add(' AND ( COM_CODMHA =:COM_CODMHA ) ');

      if (Registro.Pedido > 0) then
        SQL.Add(' AND ( COM_CODPED =:COM_CODPED ) ');

      if (Registro.Financeiro > 0) then
        SQL.Add(' AND ( COM_CODFIN =:COM_CODFIN ) ');

      if (Registro.Codigo > 0) then
        ParamByName('COM_CODIGO').AsInteger:= Registro.Codigo;

      if (Registro.Estabelecimento > 0) then
        ParamByName('COM_CODMHA').AsInteger:= Registro.Estabelecimento;

      if (Registro.Pedido > 0) then
        ParamByName('COM_CODPED').AsInteger:= Registro.Pedido;

      if (Registro.Financeiro > 0) then
        ParamByName('COM_CODFIN').AsInteger:= Registro.Financeiro;

      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

destructor TControllerComissao.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerComissao.insert: boolean;
begin
  try
    if Registro.Codigo = 0 then
       Registro.Codigo := Generator('GN_COMISSAO');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerComissao.save: boolean;
begin
  try
    if Registro.Codigo = 0 then
       Registro.Codigo := Generator('GN_COMISSAO');
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerComissao.getById: Boolean;
begin
  _getByKey(Registro);
end;

end.
