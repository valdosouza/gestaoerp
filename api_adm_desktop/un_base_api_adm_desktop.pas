unit un_base_api_adm_desktop;

interface

uses  Classes,SysUtils,StrUtils, Gauges, Vcl.Forms,REST.Json,Json,
    Vcl.Dialogs,    ControllerProduto,un_funcoes, tblProduto,
   REST.Response.Adapter, REST.Client,REST.Types, Data.Bind.Components,
   Data.Bind.ObjectScope, IniFiles, ControllerPedido, FireDAC.Comp.Client,
   STDatabase, Data.DB, ControllerSincronia, UnFunctions, Vcl.StdCtrls,
   GenericORM;
type

  TBaseApiAdmDesktop = Class(TComponent)

    private
      FURL :String;
      procedure ResetToDefaults;
    procedure setFDBLocal(const Value: TSTDatabase);

    protected
      FDBLocal: TSTDatabase;
      RESTClient: TRESTClient;
      RESTRequest: TRESTRequest;
      RESTResponse: TRESTResponse;
      RESTResponseDSA: TRESTResponseDataSetAdapter;

      function ConverteDataHora(Tempo:String):TDateTime;
      function gerarAccessToken:Boolean;
      function AtualizarAccessToken:Boolean;
      function verificaretorno:Boolean;


      procedure configComponents(Metodo, Route,Resource, Param: String);
      function sendData(Data:WideString):Boolean;Virtual;
      function getData(Data:String):Boolean;


    public
      progresso : TGauge;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure ClonarObj<T: class>(ObjOri: T;ObjClone: T);
      function  AtualizarToken:Boolean;
      property DBLocal : TSTDatabase read FDBLocal write setFDBLocal;

  End;

implementation

{ TBaseApiAdmDesktop }

uses Un_DM, UnGeraLog;

function TBaseApiAdmDesktop.AtualizarAccessToken: Boolean;
Var
  LcStrJSon : String;
  LcJSon : TJsonObject;
  LcValorJSon : TJSONValue;
  Lc_Arq_Ini: TIniFile;
  Value : String;
  LcValidade : TDateTime;
begin
  try
    Result := True;
    Lc_Arq_Ini        := TIniFile.Create( getPathExe + 'config.ini');
    LcValidade := ConverteDataHora(Lc_Arq_Ini.ReadString('TRAY', 'date_expiration_refresh_token',''));
    if (LcValidade <= Now ) then
    Begin
      Result := False;
      ResetToDefaults;
      with RESTRequest.Params.AddItem do
      Begin
        Kind := pkGETorPOST;
        name := 'refresh_token';
        Value := Lc_Arq_Ini.ReadString('TRAY', 'refresh_token','');
      End;

      RESTRequest.Method := rmGET;
      RESTRequest.Resource := 'auth';
      TRy
        RESTRequest.Execute;
        //
        Value := getCamposJsonString(RESTResponse.Content,'message');
        Lc_Arq_Ini.WriteString('TRAY', 'message',Value);

        Value := getCamposJsonString(RESTResponse.Content,'access_token');
        Lc_Arq_Ini.WriteString('TRAY', 'access_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'refresh_token');
        Lc_Arq_Ini.WriteString('TRAY', 'refresh_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'date_expiration_access_token');
        Lc_Arq_Ini.WriteString('TRAY', 'date_expiration_access_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'date_expiration_refresh_token');
        Lc_Arq_Ini.WriteString('TRAY', 'date_expiration_refresh_token',Value);
        Result := True;
      Except on E: Exception do
         begin
          Result := False;
          GeralogFile('AtualizarAccessToken',E.Message);
         End;
      End;
    End;
  finally
    FreeAndNil(Lc_Arq_Ini);
  end;
end;

function  TBaseApiAdmDesktop.AtualizarToken:Boolean;
begin
  Result := gerarAccessToken;
  Result := AtualizarAccessToken;
end;

procedure TBaseApiAdmDesktop.ClonarObj<T>(ObjOri, ObjClone: T);
begin
  TGenericORM._assign(ObjOri,ObjClone);
end;

procedure TBaseApiAdmDesktop.configComponents(Metodo, Route,Resource, Param: String);
Var
  LcUrl : String;
begin
  ResetToDefaults;
  RESTClient.ContentType := 'application/json';
  RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient.AcceptCharset := 'UTF-8, *;q=0.8';



  case AnsiIndexStr(UpperCase(Metodo), ['POST', 'PUT','DELETE','GET']) of
    0:Begin
        LcUrl := concat(FURL,Route);
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmPOST;
        with RESTRequest.Params.AddItem do
        Begin
          Kind := pkREQUESTBODY;
          name := 'body';
          Value := '';
        End;
        RESTRequest.Params.ParameterByName('body').Options := [poDoNotEncode];

    End;
    1:Begin
        LcUrl := concat(FURL,Route);
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmPUT;
    End;
    2:Begin
        LcUrl := concat(FURL,Route);
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmDELETE;
    End;
    3:Begin
        LcUrl := concat(FURL,Route,'/',Resource);
        if Param <> '' then
        Begin
          LcUrl := concat(LcUrl,'/',Param);
        End;
        RESTClient.BaseURL := LcUrl;
        RESTRequest.Method := rmGET;
    End;
  end;
end;

function TBaseApiAdmDesktop.ConverteDataHora(Tempo: String): TDateTime;
Var
  LcAno:String;
  LcMes:String;
  LcDia:String;
  LcTime:String;
begin
  //2018-09-19 01:12:18'
  LcAno   := Copy(Tempo,1,4);
  LcMes   := Copy(Tempo,6,2);
  LcDia   := Copy(Tempo,9,2);
  LcTime  := Copy(Tempo,12,8);
  Result := StrToDateTimeDef(concat(LcDia,'/',LcMes,'/',LcAno,' ',LcTime),now);


end;

constructor TBaseApiAdmDesktop.Create(AOwner: TComponent);
begin
  inherited;
  FDBLocal := DM.IBD_Gestao;
  //FURL := 'http://localhost:3000/';
  FURL := 'https://admdesktop.setesgestao.com.br/';
  RESTClient    := TRESTClient.Create(FURL);
  RESTRequest   := TRESTRequest.Create(Self);
  RESTResponse  := TRESTResponse.Create(Self);
  RESTResponseDSA := TRESTResponseDataSetAdapter.Create(Self);


  //Configura
  RESTRequest.Client := RESTClient;
  RESTRequest.Response := RESTResponse;
  RESTResponseDSA.Response := RESTResponse;
  RESTResponseDSA.NestedElements := TRue;
end;


destructor TBaseApiAdmDesktop.Destroy;
begin
  RESTClient.DisposeOf;
  RESTRequest.DisposeOf;
  RESTResponseDSA.DisposeOf;
  inherited;
end;

function TBaseApiAdmDesktop.gerarAccessToken: Boolean;
Var
  LcStrJSon : String;
  LcJSon : TJsonObject;
  LcValorJSon : TJSONValue;
  Lc_Arq_Ini: TIniFile;
  Value : String;
  LcValidade : TDateTime;
begin
  try
    Result := True;
    Lc_Arq_Ini        := TIniFile.Create(getPathExe + 'config.ini');
    //'2018-09-19 01:12:18'
    LcValidade := ConverteDataHora(Lc_Arq_Ini.ReadString('TRAY', 'date_expiration_access_token',''));
    if (LcValidade <= Now ) then
    Begin
      Result := False;
      ResetToDefaults;

      with RESTRequest.Params.AddItem do
      Begin
        Kind := pkGETorPOST;
        name := 'consumer_key';
        Value := '9f6b18d0f8e17724a1a8b6d6bc3727bc8d6da93294dccbe03b87fd76ab6d01b4'; //Lc_Arq_Ini.ReadString('TRAY', 'consumer_key','');

      End;
      with RESTRequest.Params.AddItem do
      Begin
        Kind := pkGETorPOST;
        name := 'consumer_secret';
        Value := '9fc029ff4e3974ea0663672740f0461d6a597e11fc2e00f1453a6bcc8f6f051d'; //Lc_Arq_Ini.ReadString('TRAY', 'consumer_secret','');
      End;
      with RESTRequest.Params.AddItem do
      Begin
        Kind := pkGETorPOST;
        name := 'code';
        Value := Lc_Arq_Ini.ReadString('TRAY', 'code','');
      End;
      with RESTRequest.Params.AddItem do
      Begin
        Kind := pkGETorPOST;
        name := 'store_id';
        Value := Lc_Arq_Ini.ReadString('TRAY', 'store_id','');
      End;

      RESTRequest.Method := rmPOST;
      RESTRequest.Resource := 'auth';
      TRy
        RESTRequest.Execute;
        //
        Value := getCamposJsonString(RESTResponse.Content,'message');
        Lc_Arq_Ini.WriteString('TRAY', 'message',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'access_token');
        Lc_Arq_Ini.WriteString('TRAY', 'access_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'refresh_token');
        Lc_Arq_Ini.WriteString('TRAY', 'refresh_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'date_expiration_access_token');
        Lc_Arq_Ini.WriteString('TRAY', 'date_expiration_access_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'date_expiration_refresh_token');
        Lc_Arq_Ini.WriteString('TRAY', 'date_expiration_refresh_token',Value);
        //
        Value := getCamposJsonString(RESTResponse.Content,'date_activated');
        Lc_Arq_Ini.WriteString('TRAY', 'date_activated',Value);
        Result := True;
      Except on E: Exception do
         begin
          Result := False;
          GeralogFile('gerarAccessToken',E.Message);
         End;
      End;
    End;
  finally
    FreeAndNil(Lc_Arq_Ini);
  end;
end;

function TBaseApiAdmDesktop.getData(Data: String): Boolean;
begin
  Try
    RESTRequest.Execute;
    Result := True;
  except
    on E : Exception do
    Begin
      GeralogFile('APIADMDESKTOP.Recebido',RESTResponse.Content);
      GeralogFile('APIADMDESKTOP.getData - Error: ',e.Message);
      Result := False;
    End;
  End;

end;

procedure TBaseApiAdmDesktop.ResetToDefaults;
begin
  RESTResponse.RootElement := '';
  RESTRequest.Params.Clear;

  //RESTClient.ResetToDefaults;
  RESTRequest.ResetToDefaults;
  RESTResponse.ResetToDefaults;
  RESTResponseDSA.Active := false;
end;

function TBaseApiAdmDesktop.sendData(Data: WideString): Boolean;
begin
  Try
    RESTResponse.RootElement := '';
    RESTRequest.Body.Add(Data, TRESTContentType.ctAPPLICATION_JSON);
    RESTRequest.Execute;
    RESTResponse.Content;
    Result := True;
  except
    on E : Exception do
    Begin
      Result := False;
      GeralogFile('APIADMDESKTOP.Enviado',RESTResponse.Content);
      GeralogFile('APIADMDESKTOP.sendData - Error: ',e.Message);
    End;
  End;
end;

procedure TBaseApiAdmDesktop.setFDBLocal(const Value: TSTDatabase);
begin
  FDBLocal := Value;
end;

function TBaseApiAdmDesktop.verificaretorno: Boolean;
Var
  Lcstr : TStringList;
  objJson : TJSONObject;
  LcRetorno : Boolean;
begin
  Result := False;
  if Trim(RESTResponse.Content) <> '' then
  Begin
    Result := true;
  End;
end;

end.
