unit ControllerRetaguardaSendToLocal;


interface

uses
   Classes,System.SysUtils,System.StrUtils, Gauges, Vcl.Forms,
    STDatabase,
   ControllerSincronia,ControllerEmpresa,ControllerEndereco,
   ControllerGrupos, ControllerSubGrupos, ControllerMarcaProduto,
   ControllerMedida, ControllerEmbalagem, ControllerProduto, ControllerPreco,
   ControllerTabelaPreco, ControllerFormaPagamento, ControllerColaborador,
   ControllerUsuario, ControllerCargo, ControllerEstoque, ControllerEstoques,
   tblEmpresa, tblSincronia, tblSyncTable;

type

  TControllerRetaguardaSendToLocal = Class(TComponent)
    private
      FSincronia   : TControllerSincronia;
    FDBRetaguarda: TSTDatabase;
    FDBTerminal: TSTDatabase;
      procedure getListSincronia(Tabela:String);
      procedure updateTableSync(Tabela:String;tempo:TDateTime);
      procedure Sync_tb_usuario;
      procedure Sync_tb_cargo;
      procedure Sync_tb_Colaborador;
      procedure Sync_tb_empresa;
      procedure Sync_tb_formapagto;
      procedure Sync_tb_grupo;
      procedure Sync_tb_subgrupo;
      procedure Sync_tb_marcaproduto;
      procedure Sync_tb_Medida;
      procedure Sync_tb_embalagem;
      procedure Sync_tb_produto;
      procedure Sync_tb_estoques;
      procedure Sync_tb_estoque;
      procedure Sync_tb_tabela_preco;
      procedure Sync_tb_preco;
    procedure setFDBRetaguarda(const Value: TSTDatabase);
    procedure setFDBTerminal(const Value: TSTDatabase);

    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Execute;
      property DBRetaguarda : TSTDatabase read FDBRetaguarda write setFDBRetaguarda;
      property DBTerminal : TSTDatabase read FDBTerminal write setFDBTerminal;
  end;

implementation

{ TControllerRetaguardaSendToLocal }

constructor TControllerRetaguardaSendToLocal.Create(AOwner: TComponent);
begin
  inherited;
  FSincronia   := TControllerSincronia.create(Self);
end;

destructor TControllerRetaguardaSendToLocal.Destroy;
begin
  FSincronia.DisposeOf;
  inherited;
end;

procedure TControllerRetaguardaSendToLocal.Execute;
begin
  Sync_tb_usuario;
  Sync_tb_cargo;
  Sync_tb_Colaborador;
  Sync_tb_empresa;
  Sync_tb_formapagto;
  Sync_tb_grupo;
  Sync_tb_subgrupo;
  Sync_tb_marcaproduto;
  Sync_tb_Medida;
  Sync_tb_embalagem;
  Sync_tb_produto;
  Sync_tb_estoques;
  Sync_tb_estoque;
  Sync_tb_tabela_preco;
  Sync_tb_preco;
end;

procedure TControllerRetaguardaSendToLocal.getListSincronia(Tabela:String);
Var
  LcSyncTable : TSyncTable;
begin
  //Banco Local
  FSincronia.DataBase := Self.FDBTerminal;
  with FSincronia.SyncClient.Registro do
  Begin
    Codigo := Tabela;
    //R - Recieve / S - Send / W - Web
    Sentido := 'R';
  End;
  LcSyncTable := FSincronia.SyncClient.getTime;
  //Banco Servidor
  FSincronia.DataBase := Self.FDBRetaguarda;
  FSincronia.Registro.Tabela := Tabela;
  FSincronia.Registro.Tempo := LcSyncTable.Data + LcSyncTable.Hora;
  FSincronia.getList;
end;



procedure TControllerRetaguardaSendToLocal.setFDBRetaguarda(
  const Value: TSTDatabase);
begin
  FDBRetaguarda := Value;
end;

procedure TControllerRetaguardaSendToLocal.setFDBTerminal(
  const Value: TSTDatabase);
begin
  FDBTerminal := Value;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_cargo;
Var
  I : Integer;
  LcCargo : TControllerCargo;
  LcTabela : String;
begin
  LcTabela := 'tb_cargo';
  getListSincronia(LcTabela);
  LcCargo := TControllerCargo.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcCargo.Registro.Codigo := FSincronia.Lista[I].Registro;
    LcCargo.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(FSincronia.Lista[I].Operacao), ['I','U','D']) of
      0 : LcCargo.insert;
      1 : LcCargo.update;
      2 : LcCargo.delete;
    end;
    updateTableSync(LcTabela,FSincronia.Lista[I].Tempo);
  End;


end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_Colaborador;
Var
  I : Integer;
  LcColaborador : TControllerColaborador;
  LcTabela : String;
begin
  LcTabela := 'tb_colaborador';
  getListSincronia(LcTabela);
  LcColaborador := TControllerColaborador.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcColaborador.Registro.Codigo := FSincronia.Lista[I].Registro;
    LcColaborador.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(FSincronia.Lista[I].Operacao), ['I','U','D']) of
      0 : LcColaborador.insert;
      1 : LcColaborador.update;
      2 : LcColaborador.delete;
    end;
    updateTableSync(LcTabela,FSincronia.Lista[I].Tempo);
  End;

end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_embalagem;
Var
  I : Integer;
  Registro : TSincronia;
  LcEmbalagem : TControllerEmbalagem;
  LcTabela : String;
begin
  LcTabela := 'tb_embalagem';
  getListSincronia(LcTabela);
  LcEmbalagem := TControllerEmbalagem.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcEmbalagem.Registro.Codigo := Registro.Registro;
    LcEmbalagem.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcEmbalagem.insert;
      1 : LcEmbalagem.update;
      2 : LcEmbalagem.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_empresa;
Var
  I : Integer;
  Registro : TSincronia;
  LcEmpresa : TControllerEmpresa;
  LcLocal   : TControllerEmpresa;
  LcTabela : String;
begin
  LcTabela := 'tb_empresa';
  getListSincronia(LcTabela);
  LcEmpresa := TControllerEmpresa.create(self);
  LcLocal   := TControllerEmpresa.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcEmpresa.Registro.Codigo := Registro.Registro;
    LcEmpresa.getById;
    LcEmpresa.Endereco.Registro.CodigoEmpresa := LcEmpresa.Registro.Codigo;
    LcEmpresa.Endereco.getByEmpresa;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    //Verifica se o CNPJ já não existe
    LcLocal.Registro.CpfCNPJ := LcEmpresa.Registro.CpfCNPJ;
    LcLocal.getByDocumento;
    //Tratar somente se o cadastro não existir no terminal
    if not LcLocal.exist then
    Begin
      //Insere Empresa
      LcEmpresa.Registro.Codigo := -1;
      LcEmpresa.insert;
      //Insere Endereco
      LcEmpresa.Endereco.Registro.Codigo := -1;
      LcEmpresa.Endereco.Registro.CodigoEmpresa := LcEmpresa.Registro.Codigo;
      LcEmpresa.Endereco.insert;
    End;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_estoque;
Var
  I : Integer;
  Registro : TSincronia;
  LcEstoque : TControllerEstoque;
  LcTabela : String;
begin
  LcTabela := 'tb_estoque';
  getListSincronia(LcTabela);
  LcEstoque := TControllerEstoque.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcEstoque.Registro.Codigo := Registro.Registro;
    LcEstoque.getByCodigo;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcEstoque.insert;
      1 : LcEstoque.update;
      2 : LcEstoque.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;

end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_estoques;
Var
  I : Integer;
  Registro : TSincronia;
  LcEstoques : TControllerEstoques;
  LcTabela : String;
begin
  LcTabela := 'tb_estoques';
  getListSincronia(LcTabela);
  LcEstoques := TControllerEstoques.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcEstoques.Registro.Codigo := Registro.Registro;
    LcEstoques.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcEstoques.insert;
      1 : LcEstoques.update;
      2 : LcEstoques.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;

end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_formapagto;
Var
  I : Integer;
  Registro : TSincronia;
  LcFormaPagto : TControllerFormaPagamento;
  LcTabela : String;
begin
  LcTabela := 'tb_formapagto';
  getListSincronia(LcTabela);
  LcFormaPagto := TControllerFormaPagamento.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcFormaPagto.Registro.Codigo := Registro.Registro;
    LcFormaPagto.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcFormaPagto.insert;
      1 : LcFormaPagto.update;
      2 : LcFormaPagto.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_grupo;
Var
  I : Integer;
  Registro : TSincronia;
  LcGrupo : TControllerGrupos;
  LcTabela : String;
begin
  LcTabela := 'tb_grupos';
  getListSincronia(LcTabela);
  LcGrupo := TControllerGrupos.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcGrupo.Registro.Codigo := Registro.Registro;
    LcGrupo.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcGrupo.insert;
      1 : LcGrupo.update;
      2 : LcGrupo.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_marcaproduto;
Var
  I : Integer;
  Registro : TSincronia;
  LcMarca : TControllerMarcaProduto;
  LcTabela : String;
begin
  LcTabela := 'tb_marca_produto';
  getListSincronia(LcTabela);
  LcMarca := TControllerMarcaProduto.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcMarca.Registro.Codigo := Registro.Registro;
    LcMarca.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcMarca.insert;
      1 : LcMarca.update;
      2 : LcMarca.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_Medida;
Var
  I : Integer;
  Registro : TSincronia;
  LcMedida : TControllerMedida;
  LcTabela : String;
begin
  LcTabela := 'tb_medida';
  getListSincronia(LcTabela);
  LcMedida := TControllerMedida.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcMedida.Registro.Codigo := Registro.Registro;
    LcMedida.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcMedida.insere;
      1 : LcMedida.update;
      2 : LcMedida.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_preco;
Var
  I : Integer;
  Registro : TSincronia;
  LcPreco : TControllerPreco;
  LcTabela : String;
begin
  LcTabela := 'tb_preco';
  getListSincronia(LcTabela);
  LcPreco := TControllerPreco.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcPreco.Registro.Codigo := Registro.Registro;
    LcPreco.getByCodigo;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcPreco.insert;
      1 : LcPreco.update;
      2 : LcPreco.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_produto;
Var
  I : Integer;
  Registro : TSincronia;
  LcProduto : TControllerProduto;
  LcTabela : String;
begin
  LcTabela := 'tb_produto';
  getListSincronia(LcTabela);
  LcProduto := TControllerProduto.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcProduto.Registro.Codigo := Registro.Registro;
    LcProduto.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcProduto.insert;
      1 : LcProduto.update;
      2 : LcProduto.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;

end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_subgrupo;
Var
  I : Integer;
  Registro : TSincronia;
  LcSubGrupo : TControllerSubGrupos;
  LcTabela : String;
begin
  LcTabela := 'tb_subgrupos';
  getListSincronia(LcTabela);
  LcSubGrupo := TControllerSubGrupos.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LcSubGrupo.Registro.Codigo := Registro.Registro;
    LcSubGrupo.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LcSubGrupo.insert;
      1 : LcSubGrupo.update;
      2 : LcSubGrupo.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_tabela_preco;
Var
  I : Integer;
  Registro : TSincronia;
  LctTabela : TControllerTabelaPreco;
  LcTabela : String;
begin
  LcTabela := 'tb_tabela_preco';
  getListSincronia(LcTabela);
  LctTabela := TControllerTabelaPreco.create(self);
  for I := 0 to FSincronia.Lista.Count - 1 do
  Begin
    Registro := FSincronia.Lista[I];
    //Get no servidor
    FSincronia.DataBase := Self.FDBRetaguarda;
    LctTabela.Registro.Codigo := Registro.Registro;
    LctTabela.getById;
    //set no local
    FSincronia.DataBase := Self.FDBTerminal;
    case AnsiIndexStr(UpperCase(Registro.Operacao), ['I','U','D']) of
      0 : LctTabela.insert;
      1 : LctTabela.update;
      2 : LctTabela.delete;
    end;
    updateTableSync(LcTabela,Registro.Tempo);
  End;
end;

procedure TControllerRetaguardaSendToLocal.Sync_tb_usuario;
Var
  I : Integer;
  LcUsuario : TControllerUsuario;
  LcTabela : String;
begin
  TRy
    LcTabela := 'tb_usuario';
    getListSincronia(LcTabela);
    LcUsuario := TControllerUsuario.create(self);
    for I := 0 to FSincronia.Lista.Count - 1 do
    Begin
      //Get no servidor
      FSincronia.DataBase := Self.FDBRetaguarda;
      LcUsuario.Registro.Codigo := FSincronia.Lista[I].Registro;
      LcUsuario.getById;
      //set no local
      FSincronia.DataBase := Self.FDBTerminal;
      case AnsiIndexStr(UpperCase( FSincronia.Lista[I].Operacao), ['I','U','D']) of
        0 : LcUsuario.insert;
        1 : LcUsuario.update;
        2 : LcUsuario.delete;
      end;
      updateTableSync(LcTabela,FSincronia.Lista[I].Tempo);
    End;
  Finally
    LcUsuario.DisposeOf;
  End;

end;

procedure TControllerRetaguardaSendToLocal.updateTableSync(Tabela:String;tempo: TDateTime);
Var
  LcStrDataTime : String;
begin
  with FSincronia.SyncClient.Registro do
  Begin
    Codigo := Tabela;
    Sentido := 'R';
    LcStrDataTime := DateTimeToStr(Tempo);
    //13/12/2017 01:37:38
    Data := StrToDate(Copy(LcStrDataTime,1,10));
    Hora := StrToTime(Copy(LcStrDataTime,12,8 )) + StrToTime('00:00:01');
    OPerador := 0;
  End;
  FSincronia.SyncClient.save;
end;

end.

