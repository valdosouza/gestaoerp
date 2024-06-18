unit ControllerNcm;


interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblNcm ,Un_MSg,Generics.Collections,ControllerNcmControle,
      IBX.IBScript ;

Type
  TListaNcm = TObjectList<TNcm>;

  TControllerNcm = Class(TControllerBase)

  private

  public
    Registro : TNcm;
    Controle : TControllerNcmControle;
    Lista : TListaNcm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    Function deleteAll:boolean;
    function getList:Boolean;
    function replace:boolean;
    function getSqlCommandReplace:String;
    function ComandoIBScript(Lista:TStrings):boolean;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerNcm.ComandoIBScript(Lista:TStrings): boolean;
Var
  Lc_Script : TSTScript;
  I : Integer;
begin
  try
    Lc_Script := GeraIBScript;
    Lc_Script.Script.Clear;
    Lc_Script.Script.AddStrings(Lista);
    Lc_Script.ExecuteScript;
  finally
    FinalizaISQL(Lc_Script);
  end;
end;

constructor TControllerNcm.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TNcm.Create;
  Lista := TListaNcm.Create;
  Controle := TControllerNcmControle.create(Self);
end;

function TControllerNcm.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerNcm.deleteAll: boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TNcm;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('DELETE FROM TB_NCM '));
      ExecSQL;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerNcm.Destroy;
begin
  Controle.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerNcm.insert: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;


function TControllerNcm.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerNcm.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerNcm.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerNcm.getById;
begin
  _getByKey(Registro);
end;

function TControllerNcm.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TNcm;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_NCM '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TNcm.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

function TControllerNcm.getSqlCommandReplace: String;
begin
  REsult := getSqlCommandReplaceObj(registro);
end;

end.
