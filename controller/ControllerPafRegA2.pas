unit ControllerPafRegA2;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblPafRegA2 ,Un_MSg,Generics.Collections;

Type
  TListaPafRegA2 = TObjectList<TPafRegA2>;

  TControllerPafRegA2 = Class(TControllerBase)

  private
    FDataFinal: TDate;
    FDataInicial: TDate;
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);

  public
    Registro : TPafRegA2;
    Lista : TListaPafRegA2;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    procedure Clear;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerPafRegA2.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerPafRegA2.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPafRegA2.Create;
  Lista := TListaPafRegA2.Create;
end;

function TControllerPafRegA2.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPafRegA2.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPafRegA2.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPafRegA2.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPafRegA2.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPafRegA2.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerPafRegA2.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

function TControllerPafRegA2.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPafRegA2.getById;
begin
  _getByKey(Registro);
end;

function TControllerPafRegA2.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPafRegA2;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'SELECT * ',
                'FROM TB_PAF_REG_A2 ',
                'WHERE ( DT_RECORD BETWEEN :DATAINI AND :DATAFIM ) '
      ));
      ParamByName('DATAINI').AsDate := FDataInicial;
      ParamByName('DATAFIM').AsDate := FDataFinal;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPafRegA2.Create;
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
