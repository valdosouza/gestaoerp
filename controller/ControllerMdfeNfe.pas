unit ControllerMdfeNfe;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
     tblMdfeNfe ,Un_MSg,Generics.Collections,
  ControllerRetornoNFe,ControllerNotaFiscal;

Type
  TListaNfe = TObjectList<TMdfeNfe>;
  TControllerMdfeNfe = Class(TControllerBase)
  private

  public
    Registro : TMdfeNfe;
    Lista : TListaNfe;
    Retorno : TControllerRetornoNFe;
    NotaFiscal : TControllerNotaFiscal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    function getlist:Boolean;
    procedure Clear;
  End;

implementation

{ TControllerMdfeNfe }

procedure TControllerMdfeNfe.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeNfe.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeNfe.Create;
  Lista := TListaNfe.Create;
  Retorno := TControllerRetornoNFe.Create(self);
  NotaFiscal := TControllerNotaFiscal.Create(self);
end;

function TControllerMdfeNfe.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeNfe.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  Retorno.DisposeOf;
  NotaFiscal.DisposeOf;
  inherited;
end;


procedure TControllerMdfeNfe.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeNfe.getlist: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TMdfeNfe;
begin
  try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.Clear;
      sql.add(concat(
                'SELECT * ',
                'FROM tb_mdfe_Nfe ',
                'WHERE (tb_institution_id=:tb_institution_id) ',
                'and (tb_mdfe_id=:tb_mdfe_id )'
              ));
      ParamByName('tb_institution_id').AsInteger := REgistro.Estabelecimento;
      ParamByName('tb_mdfe_id').AsInteger := REgistro.MDFE;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TMdfeNfe.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;


function TControllerMdfeNfe.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeNfe.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerMdfeNfe.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
