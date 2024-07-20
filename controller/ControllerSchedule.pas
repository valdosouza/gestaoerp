unit ControllerSchedule;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblSchedule ,Un_MSg,Generics.Collections;

Type
  TListaSchedule = TObjectList<TSchedule>;

  TControllerSchedule = Class(TControllerBase)

  private

  public
    Registro : TSchedule;
    Lista : TListaSchedule;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure Clear;
    function ValidaInclusao:Boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerSchedule.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerSchedule.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSchedule.Create;
  Lista := TListaSchedule.Create;
end;

function TControllerSchedule.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerSchedule.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerSchedule.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_SCHEDULE');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerSchedule.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerSchedule.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_SCHEDULE');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerSchedule.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerSchedule.ValidaInclusao: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TSchedule;
begin
  Result := False;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                     'FROM TB_SCHEDULE ',
                     'where tb_institution_id =:tb_institution_id ',
                     ' and (DT_RECORD =:DT_RECORD ) ',
                     ' and (TM_RECORD =:TM_RECORD ) ',
                     ' and (CLERK_ID =:CLERK_ID ) ',
                     ' and (ID<>:ID) '
      ));
      ParamByName('ID').AsInteger                 := Registro.Codigo;
      ParamByName('tb_institution_id').AsInteger  := Registro.Estabelecimento;
      ParamByName('DT_RECORD').AsDate             := Registro.Data;
      ParamByName('TM_RECORD').AsString           := Registro.Hora;
      ParamByName('CLERK_ID').AsInteger           := Registro.Atendente;
      Active := True;
      FetchAll;
      Result := (RecordCount = 0);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

procedure TControllerSchedule.getById;
begin
  _getByKey(Registro);
end;


function TControllerSchedule.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TSchedule;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_SCHEDULE '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TSchedule.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
