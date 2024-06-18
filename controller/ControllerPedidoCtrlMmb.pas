unit ControllerPedidoCtrlMmb;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPedidoCtrlMmb ,Un_MSg;

Type
  TControllerPedidoCtrlMmb = Class(TControllerBase)
  private

  protected

  public
    Registro : TPedidoCtrlMmb;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function Insere:boolean;
    function Atualiza:boolean;
    Function delete:boolean;
    procedure getbyKey;
  End;

implementation

uses Un_funcoes,Un_sistema, Un_Regra_Negocio;

constructor TControllerPedidoCtrlMmb.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPedidoCtrlMmb.Create;
end;


destructor TControllerPedidoCtrlMmb.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerPedidoCtrlMmb.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPedidoCtrlMmb.Insere:boolean;
begin
  Try
    Result := True;
    InsertObj(Registro);
  Except
    Result := False
  End;
end;


function TControllerPedidoCtrlMmb.Atualiza:boolean;
begin
  Try
    Result := True;
    UpdateObj(Registro);
  Except
    Result := False
  End;
end;

function TControllerPedidoCtrlMmb.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPedidoCtrlMmb.getByKey;
begin
//  _getByKey(Registro)
end;

end.
