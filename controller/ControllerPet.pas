unit ControllerPet;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      tblPet ,Un_MSg,Generics.Collections, Vcl.StdCtrls;

Type
  TListaPet = TObjectList<TPet>;

  TControllerPet = Class(TControllerBase)

  private

  public
    Registro : TPet;
    Lista : TListaPet;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getbyId;
    function insert:boolean;
    function update:boolean;
    Function delete:boolean;
    function getList:Boolean;
    procedure ComboRace(Combo:TComboBox);
    procedure ComboHair(Combo:TComboBox);
    procedure ComboColor(Combo:TComboBox);
    procedure ComboAttendance(Combo:TComboBox);
  End;

implementation

uses Un_sistema, Un_funcoes,Un_Regra_Negocio;

procedure TControllerPet.ComboAttendance(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct pe.attendance name ',
                'from TB_PET pe ',
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

procedure TControllerPet.ComboColor(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct pe.COLOR name ',
                'from TB_PET pe ',
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

procedure TControllerPet.ComboHair(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct pe.HAIR name ',
                'from TB_PET pe ',
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

procedure TControllerPet.ComboRace(Combo: TComboBox);
var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select distinct pe.race name ',
                'from TB_PET pe ',
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

constructor TControllerPet.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TPet.Create;
  Lista := TListaPet.Create;
end;

function TControllerPet.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerPet.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerPet.insert: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_PET');
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPet.migra: boolean;
begin
  SaveObj(Registro);
end;

function TControllerPet.salva: boolean;
begin
  Try
    if registro.Codigo = 0 then
      registro.Codigo := Generator('GN_PET');
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerPet.update: boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerPet.getById;
begin
  _getByKey(Registro);
end;



function TControllerPet.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TPet;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_PET_ORDER '));
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TPet.Create;
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
