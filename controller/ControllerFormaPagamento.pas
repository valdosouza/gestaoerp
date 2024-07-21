unit ControllerFormaPagamento;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblFormaPagamento ,FireDAC.Stan.Param,
      Generics.Collections, ControllerPayTypeHasInterm;


Type
  TListaFormasPagto  = TObjectList<TFormaPagamento>;

  TControllerFormaPagamento = Class(TControllerBase)
    Lista : TListaFormasPagto;
  private

  public
    Registro : TFormaPagamento;
    Intermediador : TControllerPayTypeHasInterm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure getById;
    procedure getByDescricao;
    procedure getByPartDescription;
    function save:boolean;
    function migra:boolean;
    function autocreate(Descricao:String):boolean;
    function insert:boolean;
    function update:boolean;
    function delete:boolean;
    procedure getlist;
    procedure Clear;
    function Replace:boolean;
    procedure getlistSync(LasUpdate:TDAteTime);
    function ValidaLimiteFormaPagamento(Codigo:Integer):Boolean;
  End;

implementation

{ TControllerFormaPagamento }

uses Un_Regra_Negocio,Un_sistema;


function TControllerFormaPagamento.autocreate(Descricao: String): boolean;
begin
  Result := True;
  Registro.codigo := 0;
  Registro.Descricao := Descricao;
  getByDescricao;
  if not (Registro.codigo > 0 ) then
  Begin
    with Registro do
    Begin
      Codigo := 0;
      Descricao := Descricao;
      Bloqueia := 'N';
      Finalidade := '3';
      Limite := 'S';
      FormaPagamentoNFCE := '99';
      ParcelamentoMaximo := 1;
      CentroCusto := 0;
      ContaResultado := 0;
      Ativo := 'S';
    End;
    insert;
  End;
end;

procedure TControllerFormaPagamento.Clear;
begin
  clearObj(registro);
end;

constructor TControllerFormaPagamento.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TFormaPagamento.Create;
  Lista := TListaFormasPagto.Create;
  Intermediador := TControllerPayTypeHasInterm.create(Self);
end;

function TControllerFormaPagamento.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;

end;

destructor TControllerFormaPagamento.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  Intermediador.DisposeOf;
  inherited;
end;

function TControllerFormaPagamento.insert: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Fc_Generator('GN_FORMAPAGTO','','FPT_CODIGO');
  Try
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerFormaPagamento.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerFormaPagamento.Replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerFormaPagamento.save: boolean;
begin
  Result := True;
  if Registro.Codigo  = 0 then
      Registro.Codigo := Fc_Generator('GN_FORMAPAGTO','TB_FORMAPAGTO','FPT_CODIGO');
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;


end;

function TControllerFormaPagamento.update: boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerFormaPagamento.ValidaLimiteFormaPagamento(
  Codigo: Integer): Boolean;
Var
  Lc_Qry : TSTQuery;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Add(concat(
                ' select FPT_LIMITE FROM TB_FORMAPAGTO ',
                ' WHERE fPT_codigo =:FPT_CODIGO '
      ));
      ParamByName('FPT_CODIGO').AsInteger:= Codigo;
      Open;
      FetchAll;
      Result := (FieldByName('FPT_LIMITE').AsString = 'S');
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFormaPagamento.getByDescricao;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              ' select * ',
              'FROM TB_FORMAPAGTO ',
              ' WHERE fPT_DESCRICAO =:FPT_DESCRICAO '
              ));
      //17-04-2019 - Alterado Valdo/Thiago - getbydescrição deve ser pelo texto exato
      //14/07/2020 - para pegar por parte do nome usar o getByPartDescription;
      ParamByName('FPT_DESCRICAO').AsString:= Registro.Descricao;
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0;
     if (exist) then
      get(Lc_Qry,Registro);
     if Registro.Ativo = 'N' then
     Begin
        Registro.Bloqueia := 'N';
        Registro.Finalidade := '3';
        Registro.Limite     := 'S';
        if Registro.FormaPagamentoNFCE = '' then
          Registro.FormaPagamentoNFCE := '99';
        Registro.Ativo := 'S';
        updateObj(Registro);
     End;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFormaPagamento.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerFormaPagamento.getByPartDescription;
var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
              ' select * ',
              'FROM TB_FORMAPAGTO ',
              ' WHERE fPT_DESCRICAO LIKE :FPT_DESCRICAO '
              ));
      ParamByName('FPT_DESCRICAO').AsString:= Concat('%',Registro.Descricao,'%');
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0;
     if (exist) then get(Lc_Qry,Registro);
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFormaPagamento.getlist;
var
  Lc_Qry : TSTQuery;
  LcLista : TFormaPagamento;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_FORMAPAGTO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TFormaPagamento.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerFormaPagamento.getlistSync(LasUpdate:TDAteTime);
var
  Lc_Qry : TSTQuery;
  LcLista : TFormaPagamento;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_FORMAPAGTO ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TFormaPagamento.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
