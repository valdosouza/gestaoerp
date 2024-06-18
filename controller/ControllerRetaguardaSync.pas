unit ControllerRetaguardaSync;

interface

uses STDatabase, Classes, SysUtils, ControllerBase, tblRetaguardaSync,
     Generics.Collections, STQuery,ControllerSincronia,
     ControllerRetaguardareceive, ControllerRetaguardaSendToLocal;

Type
  TListaRetaguardaSync = TObjectList<TRetaguardaSync>;

  TControllerRetaguardaSync = Class(TControllerBase)
  private
    FSincronia : TControllerSincronia;
    FRetaguardareceive : TControllerRetaguardareceive;
    FBancoRetaguarda: TSTDatabase;
    FBancoPDV: TSTDatabase;

    procedure ReceiveUsuario;
    procedure ReceiveCargo;
    procedure ReceiveColaborador;
    procedure ReceiveEmpresa;
    procedure ReceiveFormapagto;
    procedure ReceiveGrupo;
    procedure ReceiveSubgrupo;
    procedure ReceiveMarcaproduto;
    procedure ReceiveMedida;
    procedure ReceiveEmbalagem;
    procedure ReceiveProduto;
    procedure ReceiveEstoques;
    procedure ReceiveEstoque;
    procedure ReceiveTabelaPreco;
    procedure ReceivePreco;

    function getTime: TDateTime;
    Function delete: boolean;

    procedure setFBancoRetaguarda(const Value: TSTDatabase);
    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure Inicializa;
  public
    Registro: TRetaguardaSync;
    Lista: TListaRetaguardaSync;
    SendtoLocal : TControllerRetaguardaSendToLocal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save: boolean;
    function insert: boolean;
    function update: boolean;
    procedure getById;
    procedure Receive;
    procedure Send;
    function getList: boolean;
    property BancoRetaguarda : TSTDatabase read FBancoRetaguarda write setFBancoRetaguarda;
    property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
  End;

implementation

{ TControllerEmpresa }

uses un_sistema, un_funcoes, Un_Regra_Negocio;

constructor TControllerRetaguardaSync.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetaguardaSync.Create;
  FSincronia := TControllerSincronia.create(self);
  FRetaguardareceive := TControllerRetaguardareceive.create(self);
  SendtoLocal := TControllerRetaguardaSendToLocal.create(self);
  Lista := TListaRetaguardaSync.Create;
end;

function TControllerRetaguardaSync.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerRetaguardaSync.Destroy;
begin
  FSincronia.Destroy;
  FRetaguardareceive.Destroy;
  FBancoRetaguarda.Destroy;
  FBancoPDV.Destroy;
  Registro.DisposeOf;
  SendtoLocal.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

function TControllerRetaguardaSync.save: boolean;
begin
  SaveObj(Registro);
end;

procedure TControllerRetaguardaSync.Send;
begin

end;

procedure TControllerRetaguardaSync.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

procedure TControllerRetaguardaSync.setFBancoRetaguarda(
  const Value: TSTDatabase);
begin
  FBancoRetaguarda := Value;
end;



function TControllerRetaguardaSync.update: boolean;
begin
  updateObj(Registro);
end;

procedure TControllerRetaguardaSync.getById;
begin
  _getByKey(Registro);
  if not exist then
  Begin
    Registro.Tempo := StrToDateTimeDef('01/01/2022 00:00:00',Now);
  End;
end;


function TControllerRetaguardaSync.getList: boolean;
Var
  Lc_Qry: TSTQuery;
  LITem : TRetaguardaSync;
begin

end;

function TControllerRetaguardaSync.getTime: TDateTime;
Var
  Lc_Qry: TSTQuery;
begin
  Try
    // 13/12/2017 01:37:38
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat('SELECT DT_UPDATE, TM_UPDATE ', 'FROM TB_RETAGUARDA_SYNC ',
        'WHERE ( ID=:ID ) ', 'AND ( WAY=:WAY )'));
      ParamByName('ID').AsString := Registro.Codigo;
      ParamByName('WAY').AsString := Registro.Sentido;
      Active := True;
      FetchAll;
      if RecordCount > 0 then
        Result := FieldByName('DT_UPDATE').AsDateTime + FieldByName('TM_UPDATE')
          .AsDateTime
      else
        Result := StrToDateTime('01/01/2016 00:00:01');
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerRetaguardaSync.Inicializa;
begin
  FRetaguardareceive.BancoRetaguarda  := Self.FBancoRetaguarda;
  FRetaguardareceive.BancoPDV         := Self.FBancoPDV;
end;

function TControllerRetaguardaSync.insert: boolean;
begin
  insertObj(Registro);
end;

procedure TControllerRetaguardaSync.Receive;
begin
  Inicializa;
  ReceiveUsuario;
  ReceiveCargo;
  ReceiveColaborador;
  ReceiveEmpresa;
  ReceiveFormapagto;
  ReceiveGrupo;
  ReceiveSubgrupo;
  ReceiveMarcaproduto;
  ReceiveMedida;
  ReceiveEmbalagem;
  ReceiveProduto;
  ReceiveEstoques;
  ReceiveEstoque;
  ReceiveTabelaPreco;
  ReceivePreco;
end;

procedure TControllerRetaguardaSync.ReceiveCargo;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_CARGO';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.cargo;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;

end;

procedure TControllerRetaguardaSync.ReceiveColaborador;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_COLABORADOR';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.Colaborador;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;

end;

procedure TControllerRetaguardaSync.ReceiveEmbalagem;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_EMBALAGEM';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.embalagem;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveEmpresa;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_EMPRESA';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.empresa;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;

end;

procedure TControllerRetaguardaSync.ReceiveEstoque;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_ESTOQUE';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.estoque;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveEstoques;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_ESTOQUES';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.estoques;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveFormapagto;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_FORMAPAGTO';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.formapagto;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;

end;

procedure TControllerRetaguardaSync.ReceiveGrupo;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_GRUPOS';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.grupo;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveMarcaproduto;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_MARCA_PRODUTO';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.marcaproduto;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveMedida;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_MEDIDA';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.Medida;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceivePreco;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_PRECO';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.preco;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveProduto;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  FSincronia.DataBase := FBancoPDV;
  self.Registro.Codigo := 'TB_PRODUTO';
  self.Registro.Sentido := 'R';
  self.getById;

  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.produto;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveSubgrupo;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_SUBGRUPOS';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.subgrupo;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveTabelaPreco;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_TABELA_PRECO';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.tabela_preco;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;


end;

procedure TControllerRetaguardaSync.ReceiveUsuario;
Var
  I : Integer;
begin
  //Pega os dados da Ultima atualiazação registrada
  self.Registro.Codigo := 'TB_USUARIO';
  self.Registro.Sentido := 'R';
  self.getById;
  FSincronia.DataBase := FBancoRetaguarda;
  FSincronia.Registro.Tabela       := self.Registro.Codigo;
  FSincronia.Registro.Tempo        := self.Registro.Tempo;
  FSincronia.getListForRetaguarda;
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    FRetaguardareceive.Sincronia := FSincronia.Lista[I];
    FRetaguardareceive.usuario;
    self.Registro.Tempo := FSincronia.Lista[I].Tempo;
    self.save;
  End;

end;

end.


