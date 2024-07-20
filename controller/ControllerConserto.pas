unit ControllerConserto;

interface

uses STDatabase,System.Classes, System.SysUtils,ControllerBase,
      tblConserto, Md5, STQuery, ControllerElectEquip,ControllerAnnotation,
      ControllerNotaFiscal;
Type
  TControllerConserto = Class(TControllerBase)
  private

  public
    Registro : TConserto;
    Equipamento : TControllerElectEquip;
    Anotacao : TControllerAnnotation;
    NotaFiscal : TControllerNotaFiscal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getByPedido:Boolean;
    function getAllByKey:boolean;
  End;

  implementation
{ ControllerConserto }

constructor TControllerConserto.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TConserto.Create;
  Equipamento := TControllerElectEquip.Create(self);
  Anotacao := TControllerAnnotation.Create(self);
  NotaFiscal := TControllerNotaFiscal.Create(self);
end;

function TControllerConserto.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerConserto.Destroy;
begin
  NotaFiscal.DisposeOf;
  Anotacao.DisposeOf;
  Equipamento.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerConserto.insert: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CONSERTO');
    if Registro.Numero = '' then
      Registro.Numero := Registro.Codigo.ToString();
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerConserto.save: boolean;
begin
  try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CONSERTO');
    if Registro.Numero = '' then
      Registro.Numero := Registro.Codigo.ToString();
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerConserto.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerConserto.getByKey: Boolean;
begin
  Try
    Self._getByKey(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerConserto.getByPedido: Boolean;
var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select * ',
                'from tb_conserto ',
                'where CST_CODPED =:CST_CODPED '
      ));
      ParambyNAme('CST_CODPED').AsInteger := Registro.Codped;
      Active := True;
      FetchAll;
      exist := (RecordCount > 0);
      if (exist) then
        get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.

