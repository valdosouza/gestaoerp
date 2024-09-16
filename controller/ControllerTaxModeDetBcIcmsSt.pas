unit ControllerTaxModeDetBcIcmsSt;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblTaxModeDetBcIcmsSt, prm_Tax_Mode_Det_Bc_Icms_St;

Type
  TListTaxModeDetBcIcmsSt = TObjectList<TTaxModeDetBcIcmsSt>;
  TControllerTaxModeDetBcIcmsSt = Class(TControllerBase)
  private
    FParametros: TPrmTaxModeDetBcIcmsSt;
    procedure setFParametros(const Value: TPrmTaxModeDetBcIcmsSt);
  public
    Registro : TTaxModeDetBcIcmsSt;
    Lista : TListTaxModeDetBcIcmsSt;
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
    property Parametros : TPrmTaxModeDetBcIcmsSt read FParametros write setFParametros;
  End;

implementation

function TControllerTaxModeDetBcIcmsSt.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerTaxModeDetBcIcmsSt.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxModeDetBcIcmsSt.Create;
  FParametros := TPrmTaxModeDetBcIcmsSt.Create;
  Lista := TListTaxModeDetBcIcmsSt.Create;
end;

function TControllerTaxModeDetBcIcmsSt.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTaxModeDetBcIcmsSt.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerTaxModeDetBcIcmsSt.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerTaxModeDetBcIcmsSt.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'MDB_CODIGO',0);
  SaveObj(Registro);
end;

function TControllerTaxModeDetBcIcmsSt.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerTaxModeDetBcIcmsSt.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxModeDetBcIcmsSt;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_MOD_DET_BC_ICMS_ST where 1=1 ';

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
        LITem := TTaxModeDetBcIcmsSt.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTaxModeDetBcIcmsSt.setFParametros(const Value: TPrmTaxModeDetBcIcmsSt);
begin
  FParametros := Value;
end;

procedure TControllerTaxModeDetBcIcmsSt.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerTaxModeDetBcIcmsSt.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

