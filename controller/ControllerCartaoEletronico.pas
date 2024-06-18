unit ControllerCartaoEletronico;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      ControllerFormaPagamento,
      tblCartaoEletronico, Md5, STQuery;
Type
  TControllerCartaoEletronico = Class(TControllerBase)

  private

  public
    Registro : TCartaoEletronico;
    FormaPagto : TControllerFormaPagamento;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getbyFormaPagto:Boolean;
    function getAllByKey:boolean;
    procedure clear;
  End;

  implementation
{ ControllerCartaoEletronico}

procedure TControllerCartaoEletronico.clear;
begin
  clearObj(Registro)
end;

constructor TControllerCartaoEletronico.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCartaoEletronico.Create;
  FormaPagto := TControllerFormaPagamento.Create(Self);
end;

function TControllerCartaoEletronico.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCartaoEletronico.Destroy;
begin
  FormaPagto.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerCartaoEletronico.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCartaoEletronico.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerCartaoEletronico.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerCartaoEletronico.getbyFormaPagto: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
              'SELECT * ',
              'FROM TB_CARTAOELETRONICO ',
              'WHERE CTE_CODFPT =:CTE_CODFPT '
      ));
      ParamByName('CTE_CODFPT').AsInteger := Registro.FormaPagamento;
      Active := true;
      First;
      exist := ( RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;

end;

function TControllerCartaoEletronico.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

