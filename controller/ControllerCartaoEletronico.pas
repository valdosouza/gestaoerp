unit ControllerCartaoEletronico;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblCartaoEletronico, prm_electronic_card, ControllerFormaPagamento;

Type
  TListCartaoEletronico = TObjectList<TCartaoEletronico>;
  TControllerCartaoEletronico = Class(TControllerBase)
  private
    FParametros: TPrmElectronicCard;
    procedure setFParametros(const Value: TPrmElectronicCard);

  public
    Registro : TCartaoEletronico;
    FormaPagto: TControllerFormaPagamento;
    Lista : TListCartaoEletronico;
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
    property Parametros : TPrmElectronicCard read FParametros write setFParametros;
  End;

implementation

function TControllerCartaoEletronico.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  FParametros.Clear;
end;

constructor TControllerCartaoEletronico.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCartaoEletronico.Create;
  FParametros := TPrmElectronicCard.Create;
  Lista := TListCartaoEletronico.Create;
  FormaPagto := TControllerFormaPagamento.Create(Self);
end;

function TControllerCartaoEletronico.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerCartaoEletronico.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(Lista);
  FreeAndNil(FParametros);
  FreeAndNil(FormaPagto);
  inherited;
end;

function TControllerCartaoEletronico.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerCartaoEletronico.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'cte_codigo',0);
  SaveObj(Registro);
end;

function TControllerCartaoEletronico.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerCartaoEletronico.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TCartaoEletronico;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM TB_CARTAOELETRONICO where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND cte_codigo = :cte_codigo';
        ParamByName('cte_codigo').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND cte_descricao LIKE :cte_descricao';
        ParamByName('cte_descricao').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY cte_descricao ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TCartaoEletronico.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCartaoEletronico.setFParametros(const Value: TPrmElectronicCard);
begin
  FParametros := Value;
end;

procedure TControllerCartaoEletronico.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerCartaoEletronico.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;

end.

