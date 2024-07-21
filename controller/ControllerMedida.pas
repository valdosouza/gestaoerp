unit ControllerMedida;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,FireDAC.Stan.Param,
       tblMedida ,Un_MSg,Generics.Collections, ObjRestGroupHasMeasure;

Type
  TListaMedida  = TObjectList<TMedida>;
  TControllerMedida = Class(TControllerBase)

  private

  public
    Registro : TMedida;
    Lista : TListaMedida;
    ObjRest:TObjRestGroupHasMeasure;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function migra:boolean;
    procedure getIdAutoByDesc;
    procedure getbyId;
    procedure getoSincronia;
    procedure getbyDescricao;
    procedure getbyDescricaoMedidaCardapio;
    procedure getbyMedidaEspecial;
    procedure AlteraMedidaEspecial(NEW_MED,OLD_MED:String);
    function insere:boolean;
    function replace:boolean;
    function update:Boolean;
    Function delete:boolean;
    Function getList:boolean;
    procedure AtivarDesativarProdutos(medidaId:Integer;oper:boolean);
    procedure Clear;
    procedure AtivarDesativar;
    function autocreate(pMedida,pAbreviatura: String):Integer;
    procedure FillDataRestGroupMeasure(medida: TMedida;ObjRestGroupMeasure:TObjRestGroupHasMeasure; institutioWebId:Integer);
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

procedure TControllerMedida.AlteraMedidaEspecial(NEW_MED,OLD_MED:String);
Var
  Lc_Qry :TSTQuery;
begin
  Lc_Qry := GeraQuery;
  try
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      SQL.Add(concat(
            'UPDATE TB_MEDIDA SET ',
            'MED_ESPECIAL =:MED_ESPECIAL ' ,
            'where MED_ESPECIAL=:OLD_MED_ESPECIAL '
      ));
      ParamByName('MED_ESPECIAL').AsString := NEW_MED;
      ParamByName('OLD_MED_ESPECIAL').AsString := OLD_MED;
      ExecSQL;
    End;
  finally
    FinalizaQuery(Lc_Qry);
  end;
end;

procedure TControllerMedida.AtivarDesativar;
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
                'update tb_MEDIDA set ',
                'MED_ATIVO =:MED_ATIVO ',
                'WHERE MED_CODIGO =:MED_CODIGO '
      ));
      ParamByName('MED_ATIVO').AsString := Registro.Ativo;
      ParamByName('MED_CODIGO').AsInteger := Registro.Codigo;
      ExecSql;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;




end;

procedure TControllerMedida.AtivarDesativarProdutos(medidaId: Integer;
  oper: boolean);
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
                'update tb_produto set ',
                'PRO_ATIVO=:PRO_ATIVO ',
                'WHERE PRO_CODMED=:PRO_CODMED '
      ));
      if oper then
        ParamByName('PRO_ATIVO').AsString := 'S'
      else
        ParamByName('PRO_ATIVO').AsString := 'N';
      ParamByName('PRO_CODMED').AsInteger := medidaId;
      ExecSql;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;


end;

function TControllerMedida.autocreate(pMedida,pAbreviatura: String): Integer;
begin
  Registro.Descricao := pMedida;
  if exist then
  Begin
    Result := Registro.Codigo;
  End
  else
  Begin
    Registro.Codigo             := Generator('GN_MEDIDA');
    Registro.Descricao          := pMedida;
    Registro.Abreviatura        := pAbreviatura;
    InsertObj(Registro);
    Result := Registro.Codigo;
  End;

end;

procedure TControllerMedida.Clear;
begin
  ClearObj(Registro);
end;

constructor TControllerMedida.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMedida.Create;
  Lista := TListaMedida.create;
  ObjRest:= TObjRestGroupHasMeasure.Create;
end;

function TControllerMedida.delete: boolean;
begin
  Result := True;
  Try
    DeleteObj(Registro);
  Except
    Result := False;
  End;
end;

destructor TControllerMedida.Destroy;
begin
  ObjRest.DisposeOf;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

procedure TControllerMedida.FillDataRestGroupMeasure(medida: TMedida;
  ObjRestGroupMeasure: TObjRestGroupHasMeasure; institutioWebId: Integer);
begin
  ObjRestGroupMeasure.Grupo                         := medida.MedidaCardapio;
  ObjRestGroupMeasure.Medida.Descricao              := medida.Descricao;
  ObjRestGroupMeasure.Medida.Abreviatura            := Copy(medida.Abreviatura,1,3);
  ObjRestGroupMeasure.Estabelecimento               := institutioWebId;
  ObjRestGroupMeasure.GRupoMedida.Estabelecimento   := institutioWebId;
  ObjRestGroupMeasure.GRupoMedida.Grupo             := 0;
  ObjRestGroupMeasure.GRupoMedida.Medida            := 0;
  ObjRestGroupMeasure.GRupoMedida.PartesSabores     := 1;

end;

function TControllerMedida.insere: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_MEDIDA');
    InsertObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerMedida.migra: boolean;
begin
  Result := True;
  SaveObj(Registro);
end;

function TControllerMedida.replace: boolean;
begin
  Result := True;
  Try
    replaceObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerMedida.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MEDIDA');
  SaveObj(Registro);
end;

function TControllerMedida.update: Boolean;
begin
  Result := True;
  Try
    UpdateObj(Registro);
  Except
    Result := False;
  End;
end;

procedure TControllerMedida.getById;
Begin
  _getByKey(Registro);
end;

procedure TControllerMedida.getbyDescricao;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      {Cuidado ao mexer nesta funçao, se colocar o get aqui dentro vai ter problema
      na alteração dos sabores - se precisar deste dos para validar coloque o get fora }
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_MEDIDA '+
              'WHERE ( UPPER( MED_DESCRICAO ) =:MED_DESCRICAO ) ');
      ParamByName('MED_DESCRICAO').AsString := UpperCase( Registro.Descricao );
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0 ;
      if exist then
        get(lc_Qry,registro);
    End;
  Finally
    FinalizaQuery(LC_Qry)
  End;
end;

procedure TControllerMedida.getbyDescricaoMedidaCardapio;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
    {Cuidado ao mexer nesta funçao, se colocar o get aqui dentro vai ter problema
      na alteração dos sabores - se precisar deste dos para validar coloque o get fora }
      exist := False;
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
      exist := RecordCount > 0;
      if exist then get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry)
  End;
end;

procedure TControllerMedida.getbyMedidaEspecial;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add('SELECT * '+
              'FROM TB_MEDIDA '+
              'WHERE MED_ESPECIAL =:MED_ESPECIAL '+
              'ORDER BY MED_SEQUENCIA ');
      ParamByName('MED_ESPECIAL').AsString := Registro.MedidaCardapio;
      Active := True;
      FetchAll;
      First;
      exist := RecordCount > 0;
      if exist then     
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerMedida.getIdAutoByDesc;
begin
  getbyDescricao;
  if not exist then
  Begin
    Registro.Codigo := 0;
    Registro.Escala := '0';
    if Registro.Abreviatura = '' then
      Registro.Abreviatura := Copy(Registro.Descricao,1,3);
    Registro.MedidaCardapio := '';
    Registro.Proporcao := 0;
    Registro.Sequencia :=0;
    insere;
  End;

end;

function TControllerMedida.getList: boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TMedida;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'SELECT * FROM TB_MEDIDA ',
                'WHERE ( MED_CODIGO IS NOT NULL ) '
      ));
      if (Registro.MedidaCardapio <> '') then
      sql.add(' AND ( MED_ESPECIAL IS NOT NULL ) ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TMedida.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;


procedure TControllerMedida.getoSincronia;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      exist := False;
      active := False;
      sql.Clear;
      SQL.Add(concat(
              'SELECT M.* ',
              'FROM TB_MEDIDA M '
      ));
      if Registro.MedidaCardapio <> '' then
      Begin
        SQL.Add(concat(
              '  inner join tb_grupos g ',
              '  on (g.grp_descricao = m.med_especial ) '
        ));

      End;
      SQL.Add('WHERE MED_CODIGO =:MED_CODIGO ');

      if Registro.MedidaCardapio <> '' then
        SQL.Add(' AND MED_ESPECIAL IS NOT NULL ')
      else
        SQL.Add(' AND MED_ESPECIAL IS NULL ');

      ParamByName('MED_CODIGO').AsInteger := Registro.Codigo;
      Active := True;
      FetchAll;
      exist  := ( RecordCount > 0 );
      if exist then get(Lc_Qry,Registro) ;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

end.
