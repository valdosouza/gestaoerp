unit ControllerSyncTable;

interface
uses STDatabase,Classes,  SysUtils,ControllerBase,FireDAC.Stan.Param,
      tblSyncTable ,  Generics.Collections, STQuery;


Type

  TControllerSyncTable = Class(TControllerBase)
  private

  public
    Registro : TSyncTable;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    function update:boolean;
    procedure getById;
    function getTime:TSyncTable;
    Function delete:boolean;
    function setTimeToWEb:Boolean;
  End;

implementation

{ TControllerEmpresa }

uses un_sistema,  Un_Regra_Negocio;

constructor TControllerSynctable.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSyncTable.Create;
end;

function TControllerSynctable.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerSynctable.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerSynctable.save: boolean;
begin
  SaveObj(Registro);
end;

function TControllerSyncTable.setTimeToWEb: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
   //13/12/2017 01:37:38
   with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
              'update TB_SYNC_TABLE SET  ',
              'DT_UPDATE =:DT_UPDATE,    ',
              'TM_UPDATE =:TM_UPDATE    '
      ));
      if Registro.Sentido <> 'A' then
        sql.Add(' WHERE (WAY=:WAY ) ');
      ParamByName('DT_UPDATE').AsDateTime := Registro.Data;
      ParamByName('TM_UPDATE').AsDateTime := Registro.Hora;
      if Registro.Sentido <> 'A' then
        ParamByName('WAY').AsString := Registro.Sentido;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerSynctable.update: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
              'update TB_SYNC_TABLE SET  ',
              'DT_UPDATE =:DT_UPDATE,    ',
              'TM_UPDATE =:TM_UPDATE    ',
              'WHERE ( ID:ID )',
              ' AND ( WAY=:WAY ) ',
              ' AND ( DT_UPDATE >:DT_UPDATE ) ',
              ' AND ( TM_UPDATE >:TM_UPDATE ) '
      ));
      ParamByName('ID').AsString := Registro.Codigo;
      ParamByName('WAY').AsString := Registro.Sentido;
      ParamByName('DT_UPDATE').AsDateTime := Registro.Data;
      ParamByName('TM_UPDATE').AsDateTime := Registro.Hora;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerSynctable.getById;
begin
  _getByKey(Registro);
end;


function TControllerSyncTable.getTime: TSyncTable;
Var
  Lc_Qry : TSTQuery;
begin
  Result := TSyncTable.create;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
              'SELECT * ',
              'FROM TB_SYNC_TABLE ',
              'WHERE ( ID=:ID ) ',
              ' AND ( WAY=:WAY )',
              ' AND (KIND =:KIND) '
      ));
      ParamByName('ID').AsString := Registro.Codigo;
      ParamByName('WAY').AsString := Registro.Sentido;
      ParamByName('KIND').AsString := Registro.Tipo;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
      Begin
        get(Lc_Qry,Result);
        Result.Hora := Result.Hora + StrTotime('00:00:01');
      End
      else
      Begin
        Result.Codigo := Registro.Codigo;
        Result.Sentido := Registro.Sentido;
        Result.Tipo := Registro.Tipo;
        Result.Data := StrToDate('01/01/2016');
        Result.Hora := StrToTime('00:00:01');
      End;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerSynctable.insert: boolean;
begin
  try
    Result := True;
    insertObj(Registro);
  Except
    Result := False;
  end;


end;

end.
