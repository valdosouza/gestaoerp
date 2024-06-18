unit ControllerAdiclmp;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblAdicImp, Md5,
  STQuery;
Type
  TControllerAdicImp = Class(TControllerBase)

  private

  public
    Registro : TAdicImp;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure Clear;
  End;

  implementation
{ ControllerAdicImp }



procedure TControllerAdicImp.Clear;
begin
ClearObj(Registro);
end;

constructor TControllerAdicImp.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TAdicImp.Create;
end;

function TControllerAdicImp.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerAdicImp.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerAdicImp.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerAdicImp.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerAdicImp.get(Qry:TSTQuery;Obj:TAdicImp);
begin
  with Qry,Obj do
  Begin
    Codigo          := FieldByName('adc_codigo').AsDateTime;
    Coddim          := FieldByName('adc_coddim').asInteger;
    Numero          := FieldByName('adc_numero').asString;
    Sequencia       := FieldByName('adc_sequencia').AsString;
    CodFab          := FieldByName('adc_codfab').AsString;
    VlDesc          := FieldByName('adc_vl_desc').AsFloat;
    PedCpa          := FieldByName('adc_pedcpa').AsString;
    Itcmpa          := FieldByName('adc_itmcpa').AsString;
  End;
end;

function TControllerAdicImp.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerAdicImp.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

