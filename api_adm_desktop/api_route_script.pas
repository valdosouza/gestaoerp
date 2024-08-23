unit api_route_script;

interface

uses
  un_base_api_adm_desktop, System.Classes, Jsons, tblProjeto,REST.Json,System.Json,
  Vcl.Dialogs, System.SysUtils, tblScript, System.Contnrs,Generics.Collections;

type
  TListaScript = TObjectList<TScript>;

  TApiRouteScript = class(TBaseApiAdmDesktop)
    private

    public
      ObjScript : TScript;
      Lista : TListaScript;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure getList(Cliente:Integer);
  end;
implementation

{ TApiRouteScript }

constructor TApiRouteScript.Create(AOwner: TComponent);
begin
  inherited;
  ObjScript := TScript.create;
  Lista := TListaScript.create;
end;

destructor TApiRouteScript.Destroy;
begin
  ObjScript.disposeOf;
  Lista.disposeOf;
  inherited;
end;

procedure TApiRouteScript.getList(Cliente: Integer);
Var
  LcStrJSon : String;
  Lc_item :Tscript;
  LArray: TJSONArray;
  LValue: TJSONValue;
  LJsonObject: TJSONObject;

begin
  configComponents('get','script','getlist',IntToStr(Cliente));
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
            Lc_item := TJSON.JsonToObject<TScript>(LJsonObject);
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
