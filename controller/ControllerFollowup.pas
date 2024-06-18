unit ControllerFollowup;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,tblFollowup, Generics.Collections;


Type
  TListaFollowUp  = TObjectList<TFollowup>;

  TControllerFollowup = Class(TControllerBase)
  private

  public
    Registro : TFollowUp;
    Lista : TListaFollowUp;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function insere:boolean;
    procedure getbyKey;
    procedure clear;
    procedure getList;
    function delete:Boolean;
  End;

implementation

{ TControllerFollowup }

procedure TControllerFollowup.clear;
begin
  clearObj(Registro);
end;

constructor TControllerFollowup.Create(AOwner: TComponent);
begin
  inherited;
  Registro := Tfollowup.Create;
  Lista := TListaFollowUp.Create;
end;

function TControllerFollowup.delete: Boolean;
begin
  deleteObj(Registro);
end;

destructor TControllerFollowup.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;



procedure TControllerFollowup.getbyKey;
begin
  _getByKey(Registro);
end;

procedure TControllerFollowup.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TFollowup;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM tb_followup ',
                'WHERE ( TB_INSTITUTION_ID =:TB_INSTITUTION_ID ) ',
                ' AND  ( TERMINAL =:TERMINAL ) ',
                ' AND  ( TB_ORDER_ID =:TB_ORDER_ID ) ',
                ' AND  ( PROCESS =:PROCESS ) '
                ));

      sql.add('ORDER BY DT_FORECAST DESC , DT_DONE asc ');
      ParamByName('TB_INSTITUTION_ID').AsInteger  := Registro.Estabelecimento;
      ParamByName('TERMINAL').AsInteger           := Registro.Terminal;
      ParamByName('TB_ORDER_ID').AsInteger        := Registro.Ordem;
      ParamByName('PROCESS').AsString             := Registro.Processo;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TFollowUp.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerFollowup.insere: boolean;
begin
  SaveObj(Registro);
end;

function TControllerFollowup.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'ID',Registro.Estabelecimento);
  SaveObj(Registro);
end;


end.
