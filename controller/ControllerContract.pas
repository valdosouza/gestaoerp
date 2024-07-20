unit ControllerContract;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblContract ,Un_MSg,Generics.Collections, Vcl.StdCtrls,
      ControllerContractChaves;

Type
  TListaContrato = TObjectList<TContract>;

  TControllerContract = Class(TControllerBase)

  private

  public
    Registro : TContract;
    Lista : TListaContrato;
    ChavesField : TControllerContractChaves;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    function replace:boolean;
    procedure ComboKind(Combo:TComboBox);
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerContract.ComboKind(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct co.kind name ',
                'from TB_CONTRACT co ',
                'order by 1 '
      ));
      Active := True;
      FetchAll;
      combo.Items.Clear;
      while not eof do
      Begin
        combo.Items.Add(FieldByName('name').AsString);
        next;
      End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

constructor TControllerContract.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TContract.Create;
  Lista := TListaContrato.Create;
  ChavesField := TControllerContractChaves.create(self);
end;

function TControllerContract.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerContract.Destroy;
begin
  ChavesField.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerContract.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CONTRACT');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContract.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerContract.replace: boolean;
begin
  replaceObj(Registro);
end;

function TControllerContract.salva: boolean;
begin
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_CONTRACT');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerContract.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerContract.getById;
begin
  _getByKey(Registro);
end;


function TControllerContract.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TContract;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_CONTRACT '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TContract.Create;
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
