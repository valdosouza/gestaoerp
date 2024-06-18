unit ControllerCardapioItens;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      Un_sistema,Un_funcoes,Un_Regra_Negocio, tblMedida ,Un_MSg;

Type
  TControllerMedida = Class(TControllerBase)
  private

  public
    Registro : TMedida;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    procedure getbyDescricaoMedidaCardapio;
    procedure getbyMedidaEspecial;
    function insere:boolean;
    Function delete:boolean;
  End;

implementation

uses RN_Estoque, RN_Produto;

constructor TControllerMedida.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMedida.Create;
end;

function TControllerMedida.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMedida.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerMedida.insere: boolean;
begin
  Registro.Codigo := Generator('GN_MEDIDA');
  SaveObj(Registro);
end;

function TControllerMedida.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MEDIDA');
  SaveObj(Registro);
end;

procedure TControllerMedida.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerMedida.getbyDescricaoMedidaCardapio;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    {Cuidado ao mexer nesta funçao, se colocar o get aqui dentro vai ter problema
      na alteração dos sabores - se precisar deste dos para validar coloque o get fora }
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_MEDIDA '+
              'WHERE ( MED_DESCRICAO =:MED_DESCRICAO ) '+
              ' AND ( MED_ESPECIAL =:MED_ESPECIAL ) '+
              'ORDER BY MED_SEQUENCIA ');
      ParamByName('MED_DESCRICAO').AsString := Registro.Descricao;
      ParamByName('MED_ESPECIAL').AsString := Registro.MedidaCardapio;
      Active := True;
      FetchAll;
      First;
      exist := ( RecordCount > 0 );
      if exist then
        get(Lc_Qry,registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMedida.getbyMedidaEspecial;
Var
  Lc_Qry : TSTQuery;
Begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      SQL.Add('SELECT * '+
              'FROM TB_MEDIDA '+
              'WHERE MED_ESPECIAL =:MED_ESPECIAL '+
              'ORDER BY MED_SEQUENCIA ');
      ParamByName('MED_ESPECIAL').AsString := Registro.MedidaCardapio;
      Active := True;
      FetchAll;
      First;
      exist := ( RecordCount > 0 );
      if exist then
        get(Lc_Qry,registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


end.
