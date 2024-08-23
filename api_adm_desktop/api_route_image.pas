unit api_route_image;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, System.SysUtils, tblImage, System.Contnrs,Generics.Collections,
  REST.Types;

type

  TApiRouteImage = class(TBaseApiAdmDesktop)
    private

    protected

    public
      ObjImage : TTableImage;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure post();
  end;
implementation

{ TApiRouteImage }

constructor TApiRouteImage.Create(AOwner: TComponent);
begin
  inherited;
  ObjImage := TTableImage.create;
end;

destructor TApiRouteImage.Destroy;
begin
  ObjImage.disposeOf;
  inherited;
end;

procedure TApiRouteImage.post;
Var
  LcStrJSon : WideString;
begin
  configComponents('post','image','post','');
  LcStrJSon := TJson.ObjectToJsonString(ObjImage);
  sendData(LcStrJSon);
end;


end.
