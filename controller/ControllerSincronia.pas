unit ControllerSincronia;

interface
uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
      Un_sistema, tblSincronia ,ControllerDskRestMenu,
      Generics.Collections, controllerSyncTable, ControllerEstoque;


Type
  TListaSincronia = TObjectList<TSincronia>;

  TControllerSincronia = Class(TControllerBase)
  private

  protected

  public
    Registro : TSincronia;
    Lista :TListaSincronia;
    SyncClient : TControllerSyncTable;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function saveReturn:boolean;
    function insert:boolean;
    function update:boolean;
    procedure Clear;
    procedure getById;
    procedure getList;
    procedure getListProduto;
    procedure deleteAfterSyncProdutos;
    procedure deleteBeforeSyncProdutos;
    procedure deleteByTable;
    procedure deleteByTableRegistro;
    procedure getListTrayImage;
    procedure getListForRetaguarda;
    Function delete:boolean;
    function deleteAll:Boolean;
    procedure DeleteAfterRestMenu;
  End;

implementation

{ TControllerEmpresa }

uses Un_Regra_Negocio;

procedure TControllerSincronia.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerSincronia.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TSincronia.Create;
  Lista := TListaSincronia.Create;
  SyncClient := TcontrollerSyncTable.Create(Self);
end;

function TControllerSincronia.delete: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                    'DELETE ',
                    'FROM tb_sincronia ',
                    'WHERE ( SRC_TABELA   =:SRC_TABELA ) ',
                    ' AND  ( SRC_CHAVE    =:SRC_CHAVE ) ',
                    ' AND  ( SRC_REGISTRO =:SRC_REGISTRO ) '
      ));
      ParamByName('SRC_TABELA').AsString    := Registro.Tabela;
      ParamByName('SRC_CHAVE').AsString     := Registro.Chave;
      ParamByName('SRC_REGISTRO').AsInteger  := Registro.Registro;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerSincronia.deleteAfterSyncProdutos;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                'DELETE FROM tb_sincronia ',
                'WHERE SRC_CODIGO IN( ',
                'select src_codigo ',
                'FROM tb_sincronia S ',
                'WHERE S.src_registro =:PRO_CODIGO ',
                'UNION ',
                'select src_codigo ',
                'FROM tb_sincronia S ',
                '   INNER JOIN tb_estoque E ',
                '   ON (E.est_codigo = S.src_registro) ',
                'WHERE e.est_codpro =:PRO_CODIGO ',
                'UNION ',
                'select src_codigo ',
                'FROM tb_sincronia S ',
                '   INNER JOIN tb_preco p ',
                '   ON (p.prc_codigo = S.src_registro) ',
                'WHERE p.prc_codpro =:PRO_CODIGO ',
                ')'
      ));
      ParamByName('PRO_CODIGO').AsInteger:= Registro.Registro;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerSincronia.deleteAll: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Result := True;
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                    'DELETE ',
                    'FROM tb_sincronia '
      ));
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

procedure TControllerSincronia.DeleteAfterRestMenu;
var
  I : Integer;
  Lc_RestMenu : TControllerDskRestMenu;
begin
  TRy
    Lc_RestMenu := TControllerDskRestMenu.Create(nil);
    Lc_RestMenu.Registro.Codigo := Self.Registro.Registro;
    Lc_RestMenu.getbyId;
    Lc_RestMenu.getListbyDescription;
    for I := 0 to Lc_RestMenu.Lista.Count -1 do
    Begin
      Self.registro.Tabela:= 'TB_PRODUTO';
      Self.registro.Registro := Lc_RestMenu.Lista[I].Codigo;
      self.deleteByTableRegistro;
    End;
  Finally
    Lc_RestMenu.DisposeOf;
  End;

end;

procedure TControllerSincronia.deleteBeforeSyncProdutos;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                  'delete from tb_sincronia where src_codigo in ( ',
                  'select S.src_codigo ', //--, S.src_tabela, S.src_registro, s.src_time,LT.id
                  'FROM tb_sincronia S ',
                  '    inner join tb_produto pd ',
                  '    on (pd.pro_codigo = s.src_registro) ',
                  '    left outer join tb_loja_tray lt ',
                  '    on (lt.id = s.src_registro)and (lt.tabela  =''TB_PRODUTO'') ',
                  'WHERE S.src_tabela =''TB_PRODUTO'' ',
                  'and pd.pro_internet = ''N''  ',
                  'and lt.ID is null ',
                  'UNION ',
                  'select S.src_codigo ', //--, S.src_tabela, e.est_codpro src_registro, s.src_time ,LT.id
                  'FROM tb_sincronia S ',
                  '   INNER JOIN tb_estoque E ',
                  '   ON (E.est_codigo = S.src_registro) ',
                  '   inner join tb_produto pd ',
                  '    on (pd.pro_codigo = e.est_codpro) ',
                  '    left outer join tb_loja_tray lt ',
                  '    on (lt.id = s.src_registro) and (lt.tabela  =''TB_ESTOQUE'') ',
                  'WHERE S.src_tabela =''TB_ESTOQUE'' ',
                  'and pd.pro_internet = ''N'' ',
                  'and lt.ID is null ',
                  'UNION ',
                  'select S.src_codigo ', //--, S.src_tabela, pc.prc_codpro src_registro, s.src_time,LT.id
                  'FROM tb_sincronia S ',
                  '   INNER JOIN tb_preco pc ',
                  '   ON (pc.prc_codigo = S.src_registro) ',
                  '   inner join tb_produto pd ',
                  '   on (pd.pro_codigo = pc.prc_codpro) ',
                  '    left outer join tb_loja_tray lt ',
                  '    on (lt.id = s.src_registro) and (lt.tabela  =''TB_PRECO'') ',
                  'WHERE S.src_tabela = ''TB_PRECO'' ',
                  'and pd.pro_internet = ''N'' ',
                  'and lt.ID is null ',
                  ') '
      ));
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerSincronia.deleteByTable;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                  'delete from tb_sincronia  ',
                  'WHERE (src_tabela = :src_tabela) '
      ));
      ParamByName('src_tabela').AsString := Registro.Tabela;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerSincronia.deleteByTableRegistro;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                  'delete from tb_sincronia  ',
                  'WHERE (src_tabela = :src_tabela) ',
                  ' and (SRC_REGISTRO=:SRC_REGISTRO) '
      ));
      ParamByName('src_tabela').AsString := Registro.Tabela;
      ParamByName('src_registro').AsInteger := Registro.Registro;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;


end;

destructor TControllerSincronia.Destroy;
begin
  SyncClient.DisposeOf;
  Lista.DisposeOf;
  Registro.DisposeOf;
  inherited;
end;



function TControllerSincronia.save: boolean;
begin
  SaveObj(Registro);
end;

function TControllerSincronia.saveReturn: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin  //Seleciona REgistros do Servidor
      sql.add( concat(
                'UPDATE TB_SINCRONIA S SET ',
                'S.src_log =:src_log ',
                'WHERE S.src_registro=:src_registro ',
                ' and S.SRC_TABELA =:SRC_TABELA '
          ));
      ParamByName('SRC_TABELA').AsString := Registro.Tabela;
      ParamByName('src_log').AsString := Registro.LogResult;
      ParamByName('src_registro').AsInteger := Registro.Registro;
      ExecSQL;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;

end;

function TControllerSincronia.update: boolean;
begin
  UpdateObj(Registro);
end;


procedure TControllerSincronia.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerSincronia.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                    'SELECT ',
                    '    SRC_REGISTRO, ',
                    '    SRC_TABELA, ',
                    '    SRC_CHAVE, ',
                    '    MAX(SRC_TIME) SRC_TIME ',
                    'FROM tb_sincronia S ',
                    'WHERE ( cast (substring( (cast (SRC_TIME as varchar(25))) from 1 for 19) as timeStamp) >=:SRC_TIME ) ',
                    '  AND ( src_tabela =:SRC_TABELA ) ',
                    '  and (SRC_OPER = ''D'' ) ',
                    '  and  (SRC_LOG is null)  ',
                    'GROUP BY 1,2,3 ',
                    'ORDER BY 4 ASC '
                    //'SELECT * FROM TB_SINCRONIA ',
                    //'WHERE (SRC_TIME > :SRC_TIME) ',
                    //'AND SRC_TABELA =:SRC_TABELA ',
                    //' order by SRC_TIME asc '
      ));
      ParamByName('SRC_TIME').AsDateTime := Registro.Tempo;
      ParamByName('SRC_TABELA').AsString := Registro.Tabela;
      Active := True;
      FetchAll;
      First;
      Lista := TListaSincronia.Create;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TSincronia.Create;
        LcLista.Codigo   := 0;
        LcLista.Tabela   := FieldByNAme('SRC_TABELA').AsString;
        LcLista.Chave    := FieldByNAme('SRC_CHAVE').AsString;
        LcLista.Operacao := 'D';
        LcLista.Tempo    := FieldByNAme('SRC_TIME').AsDateTime;
        LcLista.Registro := FieldByNAme('SRC_REGISTRO').AsInteger;
        Lista.add(LcLista);
        next;
      end;
      //Pegar os itens Excluidos
      Active := False;
      sql.Clear;
      sql.add( concat(
                    'SELECT ',
                    '    SRC_REGISTRO, ',
                    '    SRC_TABELA, ',
                    '    SRC_CHAVE, ',
                    '    MAX(SRC_TIME) SRC_TIME ',
                    'FROM tb_sincronia S ',
                    'WHERE ( cast (substring( (cast (SRC_TIME as varchar(25))) from 1 for 19) as timeStamp) >=:SRC_TIME ) ',
                    '  AND ( src_tabela =:SRC_TABELA ) ',
                    '  and (SRC_OPER <> ''D'' ) ',
                    '  and  (SRC_LOG is null)  ',
                    'GROUP BY 1,2,3 ',
                    'ORDER BY 4 ASC '
      ));
      ParamByName('SRC_TIME').AsDateTime := Registro.Tempo;
      ParamByName('SRC_TABELA').AsString := Registro.Tabela;
      Active := True;
      FetchAll;
      First;
      while not eof do
      Begin
        LcLista := TSincronia.Create;
        LcLista.Codigo   := 0;
        LcLista.Tabela   := FieldByNAme('SRC_TABELA').AsString;
        LcLista.Chave    := FieldByNAme('SRC_CHAVE').AsString;
        LcLista.Operacao := 'U';
        LcLista.Tempo    := FieldByNAme('SRC_TIME').AsDateTime;
        LcLista.Registro := FieldByNAme('SRC_REGISTRO').AsInteger;
        Lista.add(LcLista);
        next
      End;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerSincronia.getListForRetaguarda;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
 //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                    'SELECT ',
                    '    SRC_REGISTRO, ',
                    '    SRC_TABELA, ',
                    '    SRC_CHAVE, ',
                    '    MAX(SRC_TIME) SRC_TIME ',
                    'FROM tb_sincronia S ',
                    'WHERE ( SRC_TIME > :SRC_TIME ) ',
                    '  and ( src_tabela =:SRC_TABELA ) ',
                    '  and ( SRC_OPER <> ''D'' ) ',
                    'GROUP BY 1,2,3 ',
                    'ORDER BY 4 ASC '
      ));

      ParamByName('SRC_TIME').AsDateTime := Registro.Tempo;
      ParamByName('SRC_TABELA').AsString := Registro.Tabela;
      Active := True;
      FetchAll;
      First;
      Lista := TListaSincronia.Create;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TSincronia.Create;
        LcLista.Codigo   := 0;
        LcLista.Tabela   := FieldByNAme('SRC_TABELA').AsString;
        LcLista.Chave    := FieldByNAme('SRC_CHAVE').AsString;
        LcLista.Operacao := 'U';
        LcLista.Tempo    := FieldByNAme('SRC_TIME').AsDateTime;
        LcLista.Registro := FieldByNAme('SRC_REGISTRO').AsInteger;
        Lista.add(LcLista);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerSincronia.getListProduto;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  //Seleciona REgistros do Servidor
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add( concat(
                'select src_registro, MAX(SRC_TIME) SRC_TIME ',
                'FRom ( ',
                'select S.src_registro, s.src_time ',
                'FROM tb_sincronia S ',
                'WHERE S.src_tabela =''TB_PRODUTO'' ',
                'UNION ',
                'select e.est_codpro src_registro, s.src_time ',
                'FROM tb_sincronia S ',
                '   INNER JOIN tb_estoque E ',
                '   ON (E.est_codigo = S.src_registro) ',
                'WHERE S.src_tabela =''TB_ESTOQUE'' ',
                'UNION ',
                'select p.prc_codpro src_registro, s.src_time ',
                'FROM tb_sincronia S ',
                '   INNER JOIN tb_preco p ',
                '   ON (p.prc_codigo = S.src_registro) ',
                'WHERE S.src_tabela = ''TB_PRECO'' ',
                ') ',
                'GROUP BY 1 '
      ));
      Active := True;
      FetchAll;
      First;
      Lista := TListaSincronia.Create;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TSincronia.Create;
        LcLista.Codigo   := 0;
        LcLista.Tabela   := 'TB_PRODUTO';
        LcLista.Chave    := 'PRO_CODIGO';
        LcLista.Operacao := 'U';
        LcLista.Tempo    := FieldByNAme('SRC_TIME').AsDateTime;
        LcLista.Registro := FieldByNAme('SRC_REGISTRO').AsInteger;
        Lista.add(LcLista);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerSincronia.getListTrayImage;
var
  Lc_Qry : TSTQuery;
  LcLista : TSincronia;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin  //Seleciona REgistros do Servidor
      sql.add( concat(
                  'SELECT DISTINCT i.table_id, max(s.src_time) src_time ',
                  'FROM tb_images i ',
                  '  inner join tb_sincronia s ',
                  '  on (i.id = s.src_registro) ',
                  'where ( s.src_tabela =:src_tabela) ',
                  ' and ( s.src_time >= :src_time ) ',
                  'group by 1 '
          ));

      ParamByName('SRC_TABELA').AsString := Registro.Tabela;
      ParamByName('src_time').AsDateTime := Registro.Tempo;
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TSincronia.Create;
        with LcLista do
        Begin
          Codigo := 0;
          Tabela := 'TB_IMAGES';
          Chave := 'PRO_CODIGO';
          Operacao := 'U';
          Tempo := fieldByName('SRC_TIME').asDateTime;
          Registro := fieldByName('table_id').asInteger;
        end;
        Lista.add(LcLista);
        next;
      end;
    end;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

function TControllerSincronia.insert: boolean;
begin
  InsertObj(Registro);
end;

end.
