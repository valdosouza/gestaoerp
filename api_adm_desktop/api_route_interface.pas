unit api_route_interface;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, System.SysUtils, tblInterface, System.Contnrs,Generics.Collections;

type
  TListaInterface = TObjectList<TInterface>;

  TApiRouteInterface = class(TBaseApiAdmDesktop)
    private

    public
      ObjInterface : TInterface;
      Lista : TListaInterface;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure getList(cliente,projeto:Integer);
      procedure put;
      procedure post;
      procedure delete;
  end;
implementation

{ TApiRouteInterface }

constructor TApiRouteInterface.Create(AOwner: TComponent);
begin
  inherited;
  ObjInterface := TInterface.create;
  Lista := TListaInterface.create;
end;

procedure TApiRouteInterface.delete;
Var
  LcStrJSon : String;
begin
  configComponents('delete','interface','delete','');
  LcStrJSon := TJson.ObjectToJsonString(ObjInterface);
  sendData(LcStrJSon);
end;

destructor TApiRouteInterface.Destroy;
begin
  ObjInterface.disposeOf;
  Lista.disposeOf;
  inherited;
end;

procedure TApiRouteInterface.getList(cliente,projeto:Integer);
Var
  LcStrJSon : String;
  Lc_item :TInterface;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  configComponents('get','interface','getlist',concat(IntToStr(cliente),'/',IntToStr(projeto)));
  getData('');
  if verificaretorno then
  BEgin
    LcStrJSon := RESTResponse.Content;
    try
      try
        //LArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LcStrJSon),0) as TJSONArray;
        LArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LcStrJSon),0) as TJSONArray;
        for LValue in LArray do
        begin
          LJsonObject := TJSONObject.ParseJSONValue(LValue.ToJSON) as TJSONObject;
          try
            Lc_item := TJSON.JsonToObject<TInterface>(LJsonObject);
            Lista.Add(Lc_item);
          finally
            LJsonObject.Free;
          end;
        end;
      except
        raise;
      end;
    finally
      LArray.Free;
    end;
  End;
end;

procedure TApiRouteInterface.post;
Var
  LcStrJSon : String;
begin
  configComponents('post','interface','post','');
  LcStrJSon := TJson.ObjectToJsonString(ObjInterface);
  sendData(LcStrJSon);
end;

procedure TApiRouteInterface.put;
Var
  LcStrJSon : String;
begin
  configComponents('put','interface','put','');
  LcStrJSon := TJson.ObjectToJsonString(ObjInterface);
  sendData(LcStrJSon);
end;

end.
