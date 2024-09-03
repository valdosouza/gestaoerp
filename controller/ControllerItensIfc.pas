unit ControllerItensIfc;

interface

uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,prm_itens_ifc,
      tblItensIfc ,Un_MSg,Generics.Collections,EncdDecd,synacode;

Type
  TListaItensIfc = TObjectList<TItensIfc>;
  TControllerItensIfc = Class(TControllerBase)
  private
    FParametros: TPrmItensIfc;
    procedure setFParametros(const Value: TPrmItensIfc);

  public
    Registro : TItensIfc;
    Lista : TListaItensIfc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getByKey;
    function insert:boolean;
    Function delete:boolean;
    function AchaOperacao(CodigoOpf: Integer): Boolean;
    procedure search;
    property Parametros : TPrmItensIfc read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

function TControllerItensIfc.AchaOperacao(CodigoOpf: Integer): Boolean;
Var
  I : Integer;
begin
  Result := False;
  for I := 0 to Lista.Count -1 do
  Begin
    if (Lista[I].CodigoOperacao = CodigoOpf)  then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

constructor TControllerItensIfc.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TItensIfc.Create;
  Lista := TListaItensIfc.Create;
  FParametros := TPrmItensIfc.Create;
end;

function TControllerItensIfc.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerItensIfc.Destroy;
begin
  FreeAndNil( Lista );
  FreeAndNil( Registro );
  FreeAndNil( FParametros );
  inherited;
end;


function TControllerItensIfc.insert: boolean;
begin
  Result := True;
  _getByKey(registro);
  if ( not exist ) then
  Begin
    Registro.Codigo := getNextByField(Registro,'IIF_CODIGO',0); //Registro.Codigo := Generator('GN_ITENS_IFC');
    InsertObj(Registro);
  End;
end;


procedure TControllerItensIfc.search;
var
  Lc_Qry : TSTQuery;
  LITem : TItensIfc;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := concat(
                  'SELECT i.*, op.OPF_DESCRICAO ',
                  'FROM TB_ITENS_IFC i ',
                  '    inner join tb_oper_interface op ',
                  '    on (i.IIF_CODOPF = op.OPF_CODIGO) ',
                  'WHERE IIF_CODIFC =:IIF_CODIFC '
                  );
      ParamByName('IIF_CODIFC').AsInteger := FParametros.FieldName.CodigoInterface;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TItensIfc.Create;
        get(Lc_Qry,LITem);
        LITem.DescricaoOperacao := FieldByname('OPF_DESCRICAO').AsString;
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


procedure TControllerItensIfc.setFParametros(const Value: TPrmItensIfc);
begin
  FParametros := Value;
end;

procedure TControllerItensIfc.getByKey;
begin
  _getByKey(Registro);
end;


end.
