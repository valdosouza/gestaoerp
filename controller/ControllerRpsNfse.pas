unit ControllerRpsNfse;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblRpsNfse ;


Type
  TControllerRpsNfse = Class(TControllerBase)
  private

  public
    Registro : TRpsNfse;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function insere:boolean;
    function salva:boolean;
    procedure next;
    procedure get;
    function deletebyNF:Boolean;
  End;

implementation


constructor TControllerRpsNfse.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRpsNfse.Create;

end;

function TControllerRpsNfse.deletebyNF: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'DELETE FROM tb_rps_nfse '+
                ' WHERE TB_NOTAFISCAL_ID =:NFL_CODIGO '
      ));
      parambyname('NFL_CODIGO').asInteger := Registro.CodigoNotaFiscal;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerRpsNfse.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerRpsNfse.insere: boolean;
begin
  //Insere o lote novo
  next;
  InsertObj(Registro);
end;

function TControllerRpsNfse.salva: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerRpsNfse.next;
Var
  Lc_Qry : TSTQuery;
begin
  if Registro.Numero = 0 then
  Begin
    Try
      Lc_Qry := GeraQuery;
      with Lc_Qry do
      Begin
        sql.add('SELECT max(numero) numero '+
                'FROM tb_rps_nfse '+
                'where tb_institution_id =:tb_institution_id ');
        parambyname('tb_institution_id').asInteger := Registro.CodigoEstabelecimento;
        active := True;
        fetchall;
        if recordCount > 0 then
          Registro.Numero := FieldByname('numero').Asinteger  +1
        else
          Registro.Numero := 1;
      End;
    Finally
      FinalizaQuery(Lc_Qry);
    End;
  End;
end;




procedure TControllerRpsNfse.get;
begin
  _getByKey(Registro);
end;

end.
