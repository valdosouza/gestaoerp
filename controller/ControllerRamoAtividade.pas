unit ControllerRamoAtividade;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
      Un_MSg,System.Generics.Collections, tblRamoAtividade;

Type
  TListaRamoAtividade = TObjectList<TRamoAtividade>;

  TControllerRamoAtividade = Class(TControllerBase)

  private


  public
    Registro : TRamoAtividade;
    Lista : TListaRamoAtividade;
    procedure clear;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
  End;

implementation

{ TControllerRamoAtividade }

procedure TControllerRamoAtividade.clear;
begin
  clearObj(Registro);

end;

constructor TControllerRamoAtividade.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRamoAtividade.Create;
  Lista := TListaRamoAtividade.Create;

end;

function TControllerRamoAtividade.delete: boolean;
begin

end;

destructor TControllerRamoAtividade.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;


procedure TControllerRamoAtividade.getbyId;
begin

end;

function TControllerRamoAtividade.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TRamoAtividade;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_RAMO_ATIVIDADE '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TRamoAtividade.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerRamoAtividade.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CARGO');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

function TControllerRamoAtividade.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerRamoAtividade.salva: boolean;
begin

end;

function TControllerRamoAtividade.update: boolean;
begin

end;

end.
