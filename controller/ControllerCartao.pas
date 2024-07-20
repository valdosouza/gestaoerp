unit ControllerCartao;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,tblCartao,
      Un_Regra_Negocio, tblFinanceiro,ControllerCartaoEletronico ;


Type
  TControllerCartao = Class(TControllerBase)
  private

  public
    Registro : TCartao;
    Eletronico : TControllerCartaoEletronico;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function Atualiza:boolean;
    function Delete:boolean;
    function insere:boolean;
    Function getByCodigoQuitacao:Boolean;
    procedure Clear;
  End;

implementation

{ TControllerCashier }


function TControllerCartao.Atualiza: boolean;
begin
  updateObj(REgistro);
end;

procedure TControllerCartao.Clear;
begin
  clearObj(Registro);
  Eletronico.clear;
end;

constructor TControllerCartao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCartao.Create;
  Eletronico := TControllerCartaoEletronico.Create(self);
end;

function TControllerCartao.Delete: boolean;
begin
  deleteObj(Registro)
end;

destructor TControllerCartao.Destroy;
begin
  Eletronico.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;

function TControllerCartao.getByCodigoQuitacao: Boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Clear;
      SQL.Add(concat(
              'SELECT * ',
              ' FROM tb_cartao ',
              ' WHERE ( CRT_CODQT_REC=:CRT_CODQT_REC) '
      ));
      ParamByName('CRT_CODQT_REC').AsInteger := Registro.CodigoQuitacaoRec;
      Active := true;
      First;
      exist := ( RecordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

function TControllerCartao.insere: boolean;
begin
  Registro.Codigo := Generator('GN_CARTAO');
  SaveObj(Registro);
end;

function TControllerCartao.salva: boolean;
begin
  if registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CARTAO');
  SaveObj(Registro);
end;

end.
