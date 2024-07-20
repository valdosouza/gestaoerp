unit ControllerTributacao;

interface
uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
       tblTributacao , System.Generics.Collections;


Type
  TListaTributacao = TObjectList<TTributacao>;

  TControllerTributacao = Class(TControllerBase)

  private

  public
    Registro : TTributacao;
    Lista : TListaTributacao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    function insert:boolean;
    function salva:boolean;
    function migra:Boolean;
    procedure getList;
    procedure Clear;

  End;


implementation

{ TControllerTributacao }

uses Un_Regra_Negocio;

procedure TControllerTributacao.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerTributacao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTributacao.Create;
  Lista := TListaTributacao.Create;
end;

destructor TControllerTributacao.Destroy;
begin
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;


procedure TControllerTributacao.getById;
begin
  _getbykey(Registro);
end;

procedure TControllerTributacao.getList;
var
  Lc_Qry : TSTQuery;
  LITem : TTributacao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      sql.add(concat('SELECT * ',
                      'FROM TB_TRIBUTACAO ',
                      'WHERE TRB_CODIGO IS NOT NULL '
                    ));
      //Incremento SQL
      if Registro.Produto >0 then
        sql.add(' AND TRB_CODPRO =:TRB_CODPRO');
      //Passsagem de Parametros
      if Registro.Produto >0 then
        ParamByName('TRB_CODPRO').AsInteger := Registro.Produto;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TTributacao.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerTributacao.insert: boolean;
begin
  TRy
    Registro.Codigo := Generator('GN_TRIBUTACAO');
    insertObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

function TControllerTributacao.migra: Boolean;
begin
  SaveObj(Registro);
end;

function TControllerTributacao.salva: boolean;
begin
  TRy
    SaveObj(Registro);
    Result := True;
  except
    Result := False;
  End;
end;

end.
