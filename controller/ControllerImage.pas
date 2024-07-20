unit ControllerImage;

interface

uses STDatabase,Classes, SysUtils,ControllerBase,
      tblImage, Md5, STQuery;

Type
  TControllerImage = Class(TControllerBase)

  private

  public
    Registro : TTableImage;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    procedure clear;
    procedure DeleteitemProduto(Botao,Produto:Integer);
  End;

  implementation
{ ControllerBotao}

procedure TControllerImage.clear;
begin

end;

constructor TControllerImage.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TTableImage.Create;
end;

function TControllerImage.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerImage.DeleteitemProduto(Botao,Produto:Integer);
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

destructor TControllerImage.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerImage.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerImage.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;


function TControllerImage.getByKey: Boolean;
begin
  _getByKey(Registro);
end;
end.

