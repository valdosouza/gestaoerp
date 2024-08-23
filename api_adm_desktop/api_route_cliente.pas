unit api_route_cliente;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, tblProjCliente, tblAdmCliente, System.SysUtils;

type
  TApiRouteCliente = class(TBaseApiAdmDesktop)
    private

    public
      ObjCliente : TAdmCliente;
      ObjProjCliente : TProjCliente;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure get(Codigo:Integer);
      procedure getProject(CNPJ:String);
      procedure put;
  end;
implementation

{ TApiRouteCliente }

constructor TApiRouteCliente.Create(AOwner: TComponent);
begin
  inherited;
  ObjCliente := TAdmCliente.create;
  ObjProjCliente := TProjCliente.create;
end;

destructor TApiRouteCliente.Destroy;
begin
  FreeAndNil(ObjCliente);
  FreeAndNil(ObjProjCliente);
  inherited;
end;

procedure TApiRouteCliente.get(Codigo: Integer);
Var
  LcStrJSon : String;
begin
  configComponents('get','cliente','get',IntToStr(Codigo));
  getData('');
  if verificaretorno then
  BEgin
    LcStrJSon := RESTResponse.Content;
    ObjCliente := TJson.JsonToObject<TAdmCliente>(LcStrJSon);
  End
end;

procedure TApiRouteCliente.getProject(CNPJ:String);
Var
  LcStrJSon : String;
begin
  configComponents('get','cliente','getProject',CNPJ);
  getData('');
  if verificaretorno then
  BEgin
    LcStrJSon := RESTResponse.Content;
    ObjProjCliente := TJson.JsonToObject<TProjCliente>(LcStrJSon);
  End;
end;

procedure TApiRouteCliente.put;
Var
  LcStrJSon : String;
begin
  configComponents('put','cliente','put','');
  LcStrJSon := TJson.ObjectToJsonString(ObjCliente);
  sendData(LcStrJSon);
end;

end.
