unit api_route_oper_interface;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, System.SysUtils, tblOperInterface, System.Contnrs,Generics.Collections;

type
  TListaOperInterface = TObjectList<TOperInterface>;

  TApiRouteOperInterface = class(TBaseApiAdmDesktop)
    private

    public
      ObjOperInterface : TOperInterface;
      Lista : TListaOperInterface;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure getList();
  end;
implementation

{ TApiRouteOperInterface }

constructor TApiRouteOperInterface.Create(AOwner: TComponent);
begin
  inherited;
  ObjOperInterface := TOperInterface.create;
  Lista := TListaOperInterface.create;
end;

destructor TApiRouteOperInterface.Destroy;
begin
  ObjOperInterface.disposeOf;
  Lista.disposeOf;
  inherited;
end;

procedure TApiRouteOperInterface.getList();
Var
  LcStrJSon : String;
  Lc_item :TOperInterface;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  configComponents('get','operinterface','getlist','');
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
            Lc_item := TJSON.JsonToObject<TOperInterface>(LJsonObject);
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

end.
