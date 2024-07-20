unit ControllerPDV;

interface
uses STDatabase,Classes,  SysUtils,ControllerBase,
      Generics.Collections, STQuery,ControllerTrigger;


Type

  TControllerPDV = Class(TControllerBase)
  private
    FBancoPDV: TSTDatabase;
    procedure execSQL(Qry:TSTQuery);
    procedure setFBancoPDV(const Value: TSTDatabase);
  public
    Trigguer : TControllerTrigger;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateTrigguer;
    property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
  End;

implementation

{ TControllerPDV }

constructor TControllerPDV.Create(AOwner: TComponent);
begin
  inherited;
  Trigguer := TControllerTrigger.create(Self);
end;

procedure TControllerPDV.CreateTrigguer;
Var
  Lc_Qry : TSTQuery;
  LcListaTrigger : TControllerTrigger;
  I : Integer;
  LcInsertSincronia : String;
begin
  DataBase := FBancoPDV;
  Lc_Qry := GeraQuery;
  LcListaTrigger := TControllerTrigger.Create(nil);
  LcListaTrigger.getlistPDV;
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

destructor TControllerPDV.Destroy;
begin

  inherited;
end;

procedure TControllerPDV.execSQL(Qry: TSTQuery);
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

procedure TControllerPDV.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

end.
