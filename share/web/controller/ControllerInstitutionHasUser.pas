unit ControllerInstitutionHasUser;

interface
uses System.Classes, System.SysUtils,BaseController,
      tblInstitutionHasUser,FireDAC.Comp.Client,Md5,
      FireDAC.Stan.Param,TypesCollection;

Type
  TControllerInstitutionHasUser = Class(TBaseController)
    procedure clear;
  private

  public
    Registro : TInstitutionHasUser;
    Lista : TListInstitutionHasUser;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function  delete:Boolean;
    function getbyKey:Boolean;
    function getList:Boolean;
  End;

implementation

{ ControllerInterface }

procedure TControllerInstitutionHasUser.clear;
begin
  clearObj(Registro);
end;

constructor TControllerInstitutionHasUser.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TInstitutionHasUser.Create;
  Lista := TListInstitutionHasUser.Create;
end;

function TControllerInstitutionHasUser.delete: Boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerInstitutionHasUser.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerInstitutionHasUser.getbyKey: Boolean;
begin
  _getByKey(Registro);
end;

function TControllerInstitutionHasUser.getList: Boolean;
var
  Lc_Qry : TFDQuery;
  lcItem : TInstitutionHasUser;
begin
  Try
    Lc_Qry := createQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
               'select * ',
               ' from tb_institution_has_user ',
               ' where tb_user_id is not null '
      ));

      //Incrementa SQL
      if registro.Usuario > 0 then
        sql.add('and tb_user_id =:tb_user_id ');

      //Passagem de parametros
      parambyname('tb_user_id').AsInteger := Registro.Usuario;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcITem := TInstitutionHasUser.Create;
        get(Lc_Qry,LcITem);
        Lista.add(LcITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerInstitutionHasUser.save: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
