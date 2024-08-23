unit api_route_projeto;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, System.SysUtils;

type
  TApiRouteProjeto = class(TBaseApiAdmDesktop)
    private

    public
      ObjProjeto : TProjeto;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure get(Codigo:Integer);
  end;
implementation

{ TApiRouteProjeto }

constructor TApiRouteProjeto.Create(AOwner: TComponent);
begin
  inherited;
  ObjProjeto := TProjeto.create;
end;

destructor TApiRouteProjeto.Destroy;
begin
  FreeAndNil(ObjProjeto);
  inherited;
end;

procedure TApiRouteProjeto.get(Codigo: Integer);
Var
  LcStrJSon : String;
begin
  configComponents('get','projeto','get',IntToStr(Codigo));
  getData('');
  if verificaretorno then
  BEgin
    LcStrJSon := RESTResponse.Content;
    ObjProjeto := TJson.JsonToObject<TProjeto>(LcStrJSon);
  End;
end;

end.
