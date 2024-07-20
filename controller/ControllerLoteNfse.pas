unit ControllerLoteNfse;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema,Un_Regra_Negocio, tblLoteNfse ;


Type
  TControllerLoteNfse = Class(TControllerBase)
  private

  public
    Registro : TLoteNfse;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Salva:boolean;
    procedure nextLote;
    function existLote: boolean;
    procedure get;
    function deletebyNF:Boolean;
  End;

implementation

{ TControllerCashier }

constructor TControllerLoteNfse.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TLoteNfse.Create;

end;

function TControllerLoteNfse.deletebyNF: Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat(
                'DELETE FROM TB_LOTE_NFSE '+
                ' WHERE TB_NOTAFISCAL_ID =:NFL_CODIGO '
      ));
      parambyname('NFL_CODIGO').asInteger := Registro.CodigoNotaFiscal;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

destructor TControllerLoteNfse.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;


function TControllerLoteNfse.Salva: boolean;
begin
  //Insere o lote novo
  nextLote;
  SaveObj(Registro);
end;


procedure TControllerLoteNfse.nextLote;
Var
  Lc_Qry : TSTQuery;
begin
  if Registro.Numero = 0 then
  Begin
    Lc_Qry := GeraQuery;
    Try
      with Lc_Qry do
      Begin
        sql.add('SELECT max(nf.numerolote) numero '+
                'FROM tb_lote_nfse nf '+
                'where nf.tb_institution_id =:tb_institution_id ');
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


function TControllerLoteNfse.existLote: boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add('SELECT nf.numerolote '+
              'FROM tb_lote_nfse nf '+
              'where nf.tb_institution_id =:tb_institution_id '+
              '  and (nf.numerolote =:numerolote ) ');
      parambyname('tb_institution_id').asInteger := Registro.CodigoEstabelecimento;
      parambyname('numerolote').asInteger := Registro.Numero;
      active := True;
      fetchall;
      if (RecordCount > 0) then
        Result:= true
      else
        Result:=false;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerLoteNfse.get;
begin
  _getByKey(Registro);
end;

end.
