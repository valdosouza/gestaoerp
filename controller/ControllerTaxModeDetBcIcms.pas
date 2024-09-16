unit ControllerTaxModeDetBcIcms;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblTaxModeDetBcIcms, prm_Tax_Mode_Det_Bc_Icms;

Type
  TListTaxModeDetBcIcms = TObjectList<TTaxModeDetBcIcms>;
  TControllerTaxModeDetBcIcms = Class(TControllerBase)
  private
    FParametros: TPrmTaxModeDetBcIcms;
    procedure setFParametros(const Value: TPrmTaxModeDetBcIcms);
  public
    Registro : TTaxModeDetBcIcms;
    Lista : TListTaxModeDetBcIcms;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function salva:boolean;
    procedure getbyId;

    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmTaxModeDetBcIcms read FParametros write setFParametros;
  End;

implementation

function TControllerTaxModeDetBcIcms.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerTaxModeDetBcIcms.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxModeDetBcIcms.Create;
  FParametros := TPrmTaxModeDetBcIcms.Create;
  Lista := TListTaxModeDetBcIcms.Create;
end;

function TControllerTaxModeDetBcIcms.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTaxModeDetBcIcms.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerTaxModeDetBcIcms.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerTaxModeDetBcIcms.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'MDB_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerTaxModeDetBcIcms.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerTaxModeDetBcIcms.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxModeDetBcIcms;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_MOD_DET_BC_ICMS where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND MDB_CODIGO = :MDB_CODIGO';
        ParamByName('MDB_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND MDB_DESCRICAO LIKE :MDB_DESCRICAO';
        ParamByName('MDB_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY MDB_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTaxModeDetBcIcms.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTaxModeDetBcIcms.setFParametros(const Value: TPrmTaxModeDetBcIcms);
begin
  FParametros := Value;
end;

procedure TControllerTaxModeDetBcIcms.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerTaxModeDetBcIcms.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

