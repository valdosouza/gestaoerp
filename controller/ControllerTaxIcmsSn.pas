unit ControllerTaxIcmsSn;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, TblTaxIcmsSn, prm_TaxIcmsSn;

Type
  TListTaxIcmsSn = TObjectList<TTaxIcmsSn>;
  TControllerTaxIcmsSn = Class(TControllerBase)
  private
    FParametros: TPrmTaxIcmsSn;
    procedure setFParametros(const Value: TPrmTaxIcmsSn);

  public
    Registro : TTaxIcmsSn;
    Lista : TListTaxIcmsSn;
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
    property Parametros : TPrmTaxIcmsSn read FParametros write setFParametros;
  End;

implementation

function TControllerTaxIcmsSn.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerTaxIcmsSn.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTaxIcmsSn.Create;
  FParametros := TPrmTaxIcmsSn.Create;
  Lista := TListTaxIcmsSn.Create;
end;

function TControllerTaxIcmsSn.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerTaxIcmsSn.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerTaxIcmsSn.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerTaxIcmsSn.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_TRIB_ICMS_SN');
  SaveObj(Registro);
end;

function TControllerTaxIcmsSn.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerTaxIcmsSn.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TTaxIcmsSn;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_TRIB_ICMS_SN where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND TBI_CODIGO = :TBI_CODIGO';
        ParamByName('TBI_CODIGO').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND TBI_DESCRICAO LIKE :TBI_DESCRICAO';
        ParamByName('TBI_DESCRICAO').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY TBI_DESCRICAO ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TTaxIcmsSn.Create;
        get(Lc_Qry, LITem);

        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerTaxIcmsSn.setFParametros(const Value: TPrmTaxIcmsSn);
begin
  FParametros := Value;
end;

procedure TControllerTaxIcmsSn.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerTaxIcmsSn.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

