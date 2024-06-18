unit ControllerRetaguarda;

interface
uses STDatabase,Classes,  SysUtils,ControllerBase,tblRetaguarda ,
      Generics.Collections, STQuery,ControllerRetaguardaSync,
      ControllerTrigger;


Type

  TControllerRetaguarda = Class(TControllerBase)
  private
    FBancoRetaguarda: TSTDatabase;
    FBancoPDV: TSTDatabase;

    procedure recebeDados;
    procedure EnviaDados;

    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure execSQL(Qry:TSTQuery);
  public
    Registro : TRetaguarda;
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

{ TControllerRetaguarda }

uses un_sistema,  Un_Regra_Negocio;

function  TControllerRetaguarda.ConfiguraBancoRetaguarda:Boolean;
Var
  SServer,SNomeBanco,SUserName,SPassword : String;
begin
  getFirst;
  FBancoRetaguarda.Connected := False;
  with FBancoRetaguarda do
  Begin
    LoginPrompt := False;
//    DM.IBD_Gestao.Close;
//    DM.IBD_Gestao.Params.Clear;
//    DM.IBD_Gestao.Params.Add('Server='+sServer);
//    DM.IBD_Gestao.Params.Add('Database='+sNomeBanco);
//    DM.IBD_Gestao.Params.Add('User_Name='+sUsername);
//    DM.IBD_Gestao.Params.Add('Password='+sPassword);
//    DM.IBD_Gestao.Params.Add('DriverID=FB');
//    DM.IBD_Gestao.Params.Add('Port=3350');


  End;
  IF Registro.CaminhoBancoDados <> '' then
  Begin
    Try
      FBancoRetaguarda.Connected := True;
    Except
      FBancoRetaguarda.Connected := False;
    End;
  End;
end;

constructor TControllerRetaguarda.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetaguarda.Create;
  FBancoRetaguarda := TSTDatabase.Create(self);
  FBancoPDV        := TSTDatabase.Create(self);
  RetaguardaSync := TControllerRetaguardaSync.Create(self);
end;

procedure TControllerRetaguarda.CreateTrigguer;
Var
  Lc_Qry : TSTQuery;
  LcListaTrigger : TControllerTrigger;
  I : Integer;
  LcInsertSincronia : String;
begin
  Try
    DataBase := FBancoRetaguarda;
    Lc_Qry := GeraQuery;
    LcListaTrigger := TControllerTrigger.Create(nil);
    LcListaTrigger.getlistretaguarda;
    LcInsertSincronia := ' INSERT INTO TB_SINCRONIA(SRC_CODIGO, SRC_TABELA, SRC_CHAVE, SRC_OPER,SRC_REGISTRO, SRC_TIME) VALUES( ';
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

function TControllerRetaguarda.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerRetaguarda.Destroy;
begin
  FBancoRetaguarda.Close;
  FBancoRetaguarda.DisposeOf;
  FBancoPDV.Close;
  FBancoPDV.DisposeOf;

  Registro.DisposeOf;
  RetaguardaSync.DisposeOf;
  inherited;
end;

procedure TControllerRetaguarda.EnviaDados;
begin
    RetaguardaSync.Send;
end;

procedure TControllerRetaguarda.execSQL(Qry: TSTQuery);
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

function TControllerRetaguarda.save: boolean;
begin
  SaveObj(Registro);
end;


procedure TControllerRetaguarda.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

function TControllerRetaguarda.update: boolean;
begin
  UpdateObj(Registro);
end;

function TControllerRetaguarda.ValidaConexaoRetaguarda: Boolean;
begin
  try
    Result := ConfiguraBancoRetaguarda;
  except
    Result := False;
  end;
end;

procedure TControllerRetaguarda.getFirst;
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT first 1 * ',
                      'FROM TB_RETAGUARDA '));
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



procedure TControllerRetaguarda.IniciaSincronia;
begin
  ConfiguraBancoRetaguarda;
  recebeDados;
  EnviaDados;
end;

function TControllerRetaguarda.insert: boolean;
begin
  insertObj(Registro);
end;

procedure TControllerRetaguarda.recebeDados;
begin
  RetaguardaSync.BancoRetaguarda  := Self.FBancoRetaguarda;
  RetaguardaSync.BancoPDV         := Self.FBancoPDV;
  RetaguardaSync.receive;
end;

end.
