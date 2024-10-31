unit ControllerBotao;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblBotao, prm_button_image, Data.DB;

Type
  TListaBotao = TObjectList<TBotao>;
  TControllerBotao = Class(TControllerBase)

  private
    FParametros: TPrmButtonImage;
    procedure setFParametros(const Value: TPrmButtonImage);
  public
    Registro : TBotao;
    Lista : TListaBotao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
    function salva:boolean;
    procedure getbyId;
    procedure DeleteitemProduto(Botao,Produto:Integer);

    procedure Search;
    property Parametros : TPrmButtonImage read FParametros write setFParametros;
  End;

  implementation
{ ControllerBotao}

procedure TControllerBotao.clear;
begin
  clearObj(Registro);
end;

constructor TControllerBotao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TBotao.Create;
  FParametros := TPrmButtonImage.Create;
  Lista := TListaBotao.Create;
end;

destructor TControllerBotao.Destroy;
begin
  FreeAndNil(Registro);
  FreeAndNil(FParametros);
  FreeAndNil(Lista);
  inherited;
end;

function TControllerBotao.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerBotao.DeleteitemProduto(Botao,Produto:Integer);
Var
  Lc_Qry : TSTQuery;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      Active := False;
      SQL.Add('DELETE FROM TB_ITENS_BTN '+
              'WHERE (IBT_CODBTN =:IBT_CODBTN ) '+
              '  AND (IBT_CODPRO =:IBT_CODPRO) ');
      //Tabela 1 - normal
      ParamByName('IBT_CODBTN').AsInteger := Botao;
      ParamByName('IBT_CODPRO').AsInteger := Produto;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerBotao.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerBotao.salva: boolean;
begin
  Result := True;
  if Registro.Codigo = 0 then
    Registro.Codigo := getNextByField(Registro,'btn_codigo',0);
  SaveObj(Registro);
end;

function TControllerBotao.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerBotao.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TBotao;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text := ' SELECT * FROM tb_botao where 1=1 ';

      if FParametros.FieldName.Codigo > 0 then
      begin
        SQL.Text := SQL.Text + ' AND btn_codigo = :btn_codigo';
        ParamByName('btn_codigo').AsInteger := FParametros.FieldName.Codigo;
      end;

      if FParametros.FieldName.Descricao <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND btn_descricao LIKE :btn_descricao';
        ParamByName('btn_descricao').AsString := Concat('%',FParametros.FieldName.Descricao,'%');
      end;

      SQL.Text := SQL.Text + ' ORDER BY btn_descricao ';

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TBotao.Create;
        get(Lc_Qry, LITem);
        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerBotao.setFParametros(const Value: TPrmButtonImage);
begin
  FParametros := Value;
end;

function TControllerBotao.getAllByKey: boolean;
begin
  Result := True;
  getByKey;
end;

procedure TControllerBotao.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerBotao.getByKey: Boolean;
begin
  Result := True;
  _getByKey(Registro);
end;

end.

