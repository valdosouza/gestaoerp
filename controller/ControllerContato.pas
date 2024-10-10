unit ControllerContato;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,
      tblContato,  System.Generics.Collections, prm_contacts;
Type
  TListContato = TObjectList<TContato>;

  TControllerContato = Class(TControllerBase)


  private
    FParametros: TPrmContacts;
    procedure setFParametros(const Value: TPrmContacts);

  public
    Registro : TContato;
    Lista : TListContato ;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    Function getList:Boolean;
    procedure getById;
    Function delete:boolean;
    function salva:boolean;
    procedure clear;
    property Parametros : TPrmContacts read FParametros write setFParametros;
    procedure search;
  End;

implementation

{ ControllerContato }

procedure TControllerContato.clear;
begin
  clearObj(Registro);
end;

constructor TControllerContato.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TContato.Create;
  Lista := TListContato.Create;
  FParametros := TPrmContacts.Create;
end;

function TControllerContato.delete: boolean;
begin
  try
    deleteObj(Registro);
    Result := True;
  except
    Result := False;
  end;
end;

destructor TControllerContato.Destroy;
begin
  Lista.DisposeOf;
  Registro.DisposeOf;
  FParametros.DisposeOf;
  inherited;
end;

function TControllerContato.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerContato.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CONTATO');
  SaveObj(Registro);
end;

function TControllerContato.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerContato.search;
var
  Lc_Qry : TSTQuery;
  LITem : TContato;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT DISTINCT TB_CONTATO.*, tb_cargo.CRG_DESCRICAO '+
                  '   FROM TB_CONTATO '+
                  '   LEFT JOIN TB_CARGO tb_cargo ON (tb_cargo.CRG_CODIGO=tb_contato.CTO_CARGO) '+
                  '   LEFT join TB_EMPRESA tb_empresa ON (tb_empresa.EMP_CODIGO=tb_contato.CTO_CODEMP) ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND Cto_Codigo = :Cto_Codigo';
        ParamByName('Cto_Codigo').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Nome <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND ((TB_CONTATO.CTO_NOME LIKE :NOME) OR (tb_empresa.EMP_FANTASIA LIKE :NOME)) ';
        ParamByName('NOME').AsString := Concat('%',FParametros.FieldName.Nome,'%');
      end;

      if FParametros.FieldName.CRG_DESCRICAO <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND tb_cargo.CRG_DESCRICAO LIKE :CRG_DESCRICAO';
        ParamByName('CRG_DESCRICAO').AsString := Concat('%',FParametros.FieldName.CRG_DESCRICAO,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY TB_CONTATO.CTO_NOME ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TContato.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerContato.setFParametros(const Value: TPrmContacts);
begin
  FParametros := Value;
end;

function TControllerContato.getAllByKey: boolean;
begin
  getByKey;
end;

procedure TControllerContato.getById;
begin
  _getByKey(Registro);
end;

function TControllerContato.getByKey: Boolean;
begin
end;

function TControllerContato.getList: Boolean;
var
  Lc_Qry : TSTQuery;
  LcLista : TContato;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add(concat(
                'Select * ',
                'from tb_contato c '
          ));
      Active := True;

      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TContato.Create;
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

