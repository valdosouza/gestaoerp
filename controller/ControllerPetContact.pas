unit ControllerPetContact;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPetContact ,Un_MSg,Generics.Collections, Vcl.StdCtrls;

Type
  TListaPetContact = TObjectList<TPetContact>;

  TControllerPetContact = Class(TControllerBase)

  private

  public
    Registro : TPetContact;
    Lista : TListaPetContact;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure Clear;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;


procedure TControllerPetContact.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerPetContact.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPetContact.Create;
  Lista := TListaPetContact.Create;
end;

function TControllerPetContact.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPetContact.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPetContact.insert: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_PET_CONTACT');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPetContact.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPetContact.salva: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_PET_CONTACT');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPetContact.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPetContact.getById;
begin
  _getByKey(Registro);
end;



function TControllerPetContact.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPetContact;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PET_CONTACT ',
                      'WHERE TB_PET_ID =:TB_PET_ID '
      ));
      ParamByName('TB_PET_ID').AsInteger := Registro.Pet;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPetContact.Create;
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
