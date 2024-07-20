unit ControllerBanco;

interface

uses
  ControllerEmpresa, System.Classes, STQuery, System.SysUtils;

type
  TControllerBanco = Class(TcontrollerEmpresa)
    private

    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getNumber(Codigo: Integer):Integer;
  End;

implementation

{ TControllerBanco }

constructor TControllerBanco.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TControllerBanco.Destroy;
begin

  inherited;
end;

function TControllerBanco.getNumber(Codigo: Integer):Integer;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      sql.Add(concat(
        'select emp_codigo, EMP_NUMBCO ',
        'from tb_empresa ',
        'where EMP_CODIGO =:EMP_CODIGO '
      ));
      ParamByName('EMP_CODIGO').AsInteger := Codigo;
      Active := True;
      FetchAll;
      Result := StrToIntDEf(FieldByName('EMP_NUMBCO').AsString,1);
    End;
  finally
    Lc_Qry.DisposeOf;
  end;
end;

end.
