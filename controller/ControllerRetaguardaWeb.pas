unit ControllerRetaguardaWeb;

interface
uses STDatabase,Classes,  SysUtils,ControllerBase,tblRetaguardaWeb ,
      Generics.Collections, STQuery,ControllerRetaguardaSync,
      ControllerTrigger;


Type

  TControllerRetaguardaWeb = Class(TControllerBase)
  private
    FBancoRetaguarda: TSTDatabase;
    FBancoPDV: TSTDatabase;

    procedure recebeDados;
    procedure EnviaDados;

    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure execSQL(Qry:TSTQuery);
  public
    Registro : TRetaguardaWeb;
    RetaguardaSync :TControllerRetaguardaSync;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateTrigguer;
    function save:boolean;
    function insert:boolean;
    function update:boolean;
    procedure getFirst;
    Function delete:boolean;
    Function ConfiguraBancoRetaguarda:Boolean;
    function ValidaConexaoRetaguarda:Boolean;
    procedure IniciaSincronia;
    property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
  End;


implementation


{ TControllerRetaguardaWeb }

uses un_sistema,  Un_Regra_Negocio;

function  TControllerRetaguardaWeb.ConfiguraBancoRetaguarda:Boolean;
begin
  Result := False;
  with FBancoRetaguarda do
  Begin
    Connected := False;
    Params.Clear;
    LoginPrompt := False;
    Params.add(concat('user_name=',Registro.UserName));
    Params.add(concat('password=',Registro.UserFrase));
    Params.add('lc_ctype=WIN1252');
    DatabaseName := concat(Registro.CaminhoServidor,'/',Registro.PortaBanco,':',Registro.CaminhoBancoDados);
  End;
  IF Registro.CaminhoBancoDados <> '' then
  Begin
    Try
      FBancoRetaguarda.Connected := True;
      Result := True;
    Except
      FBancoRetaguarda.Connected := False;
      Result := False;
    End;
  End;
end;

constructor TControllerRetaguardaWeb.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetaguardaWeb.Create;
  FBancoRetaguarda := TSTDatabase.Create(self);
  RetaguardaSync := TControllerRetaguardaSync.Create(self);
end;

procedure TControllerRetaguardaWeb.CreateTrigguer;
Var
  Lc_Qry : TSTQuery;
  LcListaTrigger : TControllerTrigger;
  I : Integer;
  LcInsertSincronia : String;
begin
  DataBase := FBancoRetaguarda;
  Lc_Qry := GeraQuery;
  LcListaTrigger := TControllerTrigger.Create(nil);
  LcListaTrigger.getlistretaguarda;
  LcInsertSincronia := ' INSERT INTO TB_SINCRONIA(SRC_CODIGO, SRC_TABELA, SRC_CHAVE, SRC_OPER,SRC_REGISTRO, SRC_TIME) VALUES( ';
  Try
    for I := 0 to LcListaTrigger.Lista.Count - 1 do
    Begin
      if Trim( LcListaTrigger.Lista[I].Tabela)<> '' then
      Begin
        Lc_Qry.sql.Clear;
        Lc_Qry.sql.Add(concat(
                'CREATE OR ALTER TRIGGER TG_SRC_DEL_',LcListaTrigger.Lista[I].Tabela, ' FOR TB_',LcListaTrigger.Lista[I].Tabela,
                ' ACTIVE AFTER DELETE POSITION 0 ',
                'AS begin ',LcInsertSincronia,'0,','''TB_',LcListaTrigger.Lista[I].Tabela,''',''',LcListaTrigger.Lista[I].Campo,''',''D'',OLD.',LcListaTrigger.Lista[I].Campo,',CURRENT_TIMESTAMP);end '
        ));
        execSQL(Lc_Qry);
        //UPDATE
        Lc_Qry.sql.Clear;
        Lc_Qry.sql.Add(concat(
                'CREATE OR ALTER TRIGGER TG_SRC_EDI_',LcListaTrigger.Lista[I].Tabela, ' FOR TB_',LcListaTrigger.Lista[I].Tabela,
                ' ACTIVE AFTER UPDATE POSITION 0 ',
                'AS begin ',LcInsertSincronia,'0,','''TB_',LcListaTrigger.Lista[I].Tabela,''',''',LcListaTrigger.Lista[I].Campo,''',''U'',OLD.',LcListaTrigger.Lista[I].Campo,',CURRENT_TIMESTAMP);end '
        ));
        execSQL(Lc_Qry);
        //insert
        Lc_Qry.sql.Clear;
        Lc_Qry.sql.Add(concat(
                'CREATE OR ALTER TRIGGER TG_SRC_INS_',LcListaTrigger.Lista[I].Tabela, ' FOR TB_',LcListaTrigger.Lista[I].Tabela,
                ' ACTIVE AFTER INSERT POSITION 0 ',
                'AS begin ',LcInsertSincronia,'0,','''TB_',LcListaTrigger.Lista[I].Tabela,''',''',LcListaTrigger.Lista[I].Campo,''',''I'',NEW.',LcListaTrigger.Lista[I].Campo,',CURRENT_TIMESTAMP);end '
        ));
        execSQL(Lc_Qry);
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerRetaguardaWeb.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerRetaguardaWeb.Destroy;
begin
  FBancoRetaguarda.Close;
  FBancoRetaguarda.DisposeOf;
  Registro.DisposeOf;
  RetaguardaSync.DisposeOf;
  inherited;
end;

procedure TControllerRetaguardaWeb.EnviaDados;
begin
    RetaguardaSync.Send;
end;

procedure TControllerRetaguardaWeb.execSQL(Qry: TSTQuery);
begin
  with Qry do
  Begin
    try
      Prepare;
      ExecSQL;
    except
      Unprepare;
      Close;
    end;
  End;
end;

function TControllerRetaguardaWeb.save: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerRetaguardaWeb.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

function TControllerRetaguardaWeb.update: boolean;
begin
  UpdateObj(Registro);
end;

function TControllerRetaguardaWeb.ValidaConexaoRetaguarda: Boolean;
begin
  try
    Result := ConfiguraBancoRetaguarda;
  except
    Result := False;
  end;
end;

procedure TControllerRetaguardaWeb.getFirst;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT first 1 * ',
                      'FROM TB_RETAGUARDA_WEB '));
      Active := True;
      FetchAll;
      First;
      exist  := ( RecordCount > 0 );
      if exist then
      Begin
        clearObj(Registro);
        get(Lc_Qry,Registro) ;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;



procedure TControllerRetaguardaWeb.IniciaSincronia;
begin
  ConfiguraBancoRetaguarda;
  recebeDados;
  EnviaDados;
end;

function TControllerRetaguardaWeb.insert: boolean;
begin
  insertObj(Registro);
end;

procedure TControllerRetaguardaWeb.recebeDados;
begin
  RetaguardaSync.BancoRetaguarda  := Self.FBancoRetaguarda;
  RetaguardaSync.BancoPDV         := Self.FBancoPDV;
  RetaguardaSync.receive;
end;

end.
