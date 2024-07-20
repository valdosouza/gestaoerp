unit ControllerPayBackExpired;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPayBackExpired ,Un_MSg,Generics.Collections,prmbase, prm_pay_back;

Type
  TControllerPayBackExpired = Class(TControllerBase)
  private
    FCodigoCliente: Integer;
    procedure setFCodigoCliente(const Value: Integer);

  public
    Registro : TPayBackExpired;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insert:boolean;
    function getLast:TDate;
    procedure Clear;
    property CodigoCliente : Integer read FCodigoCliente write setFCodigoCliente;
  End;

implementation

{ TControllerPayBackExpired }

procedure TControllerPayBackExpired.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerPayBackExpired.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPayBackExpired.Create;
end;

destructor TControllerPayBackExpired.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerPayBackExpired.getLast: TDate;
var
  Lc_Qry : TSTQuery;
begin
  Result := Date;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
          'Select MAX(DT_RECORD) DATA ',
          'FROM tb_pay_back_expired ',
          'WHERE TB_CUSTOMER_ID =:TB_CUSTOMER_ID '
      ));
      ParamByName('TB_CUSTOMER_ID').AsInteger :=  Registro.CodigoCliente;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('DATA').AsDateTime
      else
        Result := StrToDate('01/01/2000');
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerPayBackExpired.insert: boolean;
begin
  try
    insertObj(Registro);
    Result := True;
  Except
    Result := False;
  end;
end;

procedure TControllerPayBackExpired.setFCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
end;

end.
