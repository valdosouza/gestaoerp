unit ControllerBotao;

interface

uses STDatabase,Classes, SysUtils,ControllerBase,
      tblBotao, Md5, STQuery;

Type
  TControllerBotao = Class(TControllerBase)

  private

  public
    Registro : TBotao;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    procedure clear;
    procedure DeleteitemProduto(Botao,Produto:Integer);
  End;

  implementation
{ ControllerBotao}

procedure TControllerBotao.clear;
begin

end;

constructor TControllerBotao.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TBotao.Create;
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

destructor TControllerBotao.Destroy;
begin
  Registro.DisposeOf;
  inherited;
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

function TControllerBotao.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerBotao.getAllByKey: boolean;
begin
  getByKey;
end;

function TControllerBotao.getByKey: Boolean;
begin
  _getByKey(Registro);
end;
end.

