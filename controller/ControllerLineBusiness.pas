unit ControllerLineBusiness;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblRamoAtividade, prm_line_business;

Type
  TListLineBusiness = TObjectList<TRamoAtividade>;
  TControllerLineBusiness = Class(TControllerBase)
  private
    FParametros: TPrmLineBusiness;
    procedure setFParametros(const Value: TPrmLineBusiness);

  public
    Registro : TRamoAtividade;
    Lista : TListLineBusiness;
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
    property Parametros : TPrmLineBusiness read FParametros write setFParametros;
  End;

implementation

{ ControllerCfgEtiqueta}

function TControllerLineBusiness.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerLineBusiness.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRamoAtividade.Create;
  FParametros := TPrmLineBusiness.Create;
  Lista := TListLineBusiness.Create;
end;

function TControllerLineBusiness.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerLineBusiness.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerLineBusiness.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerLineBusiness.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_RAMO_ATIVIDADE');
  SaveObj(Registro);
end;

function TControllerLineBusiness.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerLineBusiness.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TRamoAtividade;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_RAMO_ATIVIDADE where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND ID = :ID';
        ParamByName('ID').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND DESCRIPTION LIKE :DESCRIPTION';
        ParamByName('DESCRIPTION').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY DESCRIPTION ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TRamoAtividade.Create;
        get(Lc_Qry, LITem);

        Lista.add(LITem);
        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerLineBusiness.setFParametros(const Value: TPrmLineBusiness);
begin
  FParametros := Value;
end;

procedure TControllerLineBusiness.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerLineBusiness.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

