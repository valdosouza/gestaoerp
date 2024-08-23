unit api_route_itens_ifc;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, System.SysUtils, tblItensIfc, System.Contnrs,Generics.Collections;

type
  TListaItensIfc = TObjectList<TItensIfc>;

  TApiRouteItensIfc = class(TBaseApiAdmDesktop)
    private

    public
      ObjOperInterface : TItensIfc;
      Lista : TListaItensIfc;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure getList(Projeto:Integer);
      procedure put;
      procedure post;
      procedure delete;
  end;
implementation

{ TApiRouteItensIfc }

constructor TApiRouteItensIfc.Create(AOwner: TComponent);
begin
  inherited;
  ObjOperInterface := TItensIfc.create;
  Lista := TListaItensIfc.create;
end;

procedure TApiRouteItensIfc.delete;
Var
  LcStrJSon : String;
begin
  configComponents('delete','operinterface','delete','');
  LcStrJSon := TJson.ObjectToJsonString(ObjOperInterface);
  sendData(LcStrJSon);
end;

destructor TApiRouteItensIfc.Destroy;
begin
  ObjOperInterface.disposeOf;
  Lista.disposeOf;
  inherited;
end;

procedure TApiRouteItensIfc.getList(Projeto:Integer);
Var
  LcStrJSon : String;
  Lc_item :TItensIfc;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  configComponents('get','itensifc','getlist',IntToStr(Projeto));
  getData('');
  if verificaretorno then
  BEgin
    LcStrJSon := RESTResponse.Content;
    //Lista := TJson.JsonToObject<TListaScript>(LcStrJSon);
    try
      try
        LArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LcStrJSon),0) as TJSONArray;
        for LValue in LArray do
        begin
          LJsonObject := TJSONObject.ParseJSONValue(LValue.ToJSON) as TJSONObject;
          try
            Lc_item := TJSON.JsonToObject<TItensIfc>(LJsonObject);
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

procedure TApiRouteItensIfc.post;
Var
  LcStrJSon : String;
begin
  configComponents('post','operinterface','post','');
  LcStrJSon := TJson.ObjectToJsonString(ObjOperInterface);
  sendData(LcStrJSon);
end;

procedure TApiRouteItensIfc.put;
Var
  LcStrJSon : String;
begin
  configComponents('put','operinterface','put','');
  LcStrJSon := TJson.ObjectToJsonString(ObjOperInterface);
  sendData(LcStrJSon);
end;

end.
