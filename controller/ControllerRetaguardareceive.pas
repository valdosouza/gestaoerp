unit ControllerRetaguardareceive;

interface

uses STDatabase, Classes, SysUtils, ControllerBase, tblRetaguardaSync,
      Generics.Collections, STQuery,ControllerUsuario,tblSincronia,
      ControllerCargo,ControllerColaborador,ControllerEmpresa,ControllerFormaPagamento,
      ControllerGrupos,ControllerSubGrupos,ControllerMarcaProduto,
      ControllerMedida,ControllerEmbalagem,ControllerProduto,ControllerEstoques,
      ControllerEstoque,ControllerTabelaPreco,ControllerPreco;

Type
  //TListaRetaguardaSync = TObjectList<TRetaguardaSync>;

  TControllerRetaguardareceive = Class(TControllerBase)
  private
    FSincronia: TSincronia;
    FBancoPDV: TSTDatabase;
    FBancoRetaguarda: TSTDatabase;

    FCtrlUsuario : TControllerUsuario;
    FCtrlCargo : TControllerCargo;
    FCtrlColaborador : TControllerColaborador;
    FCtrlEmpresa : TControllerEmpresa;
    FCtrlFormaPagto : TControllerFormaPagamento;
    FCtrlGrupo : TControllerGrupos;
    FCtrlSubGrupo : TControllerSubGrupos;
    FCtrlMarca : TControllerMarcaProduto;
    FCtrlMedida : TControllerMedida;
    FCtrlEmbalagem : TControllerEmbalagem;
    FCtrlProduto : TControllerProduto;
    FCtrlEstoques : TControllerEstoques;
    FCtrlEstoque : TControllerEstoque;
    FCtrltTabela : TControllerTabelaPreco;
    FCtrlPreco : TControllerPreco;

    procedure setFTSincronia(const Value: TSincronia);
    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure setFBancoRetaguarda(const Value: TSTDatabase);

  public
      procedure usuario;
      procedure cargo;
      procedure Colaborador;
      procedure empresa;
      procedure formapagto;
      procedure grupo;
      procedure subgrupo;
      procedure marcaproduto;
      procedure Medida;
      procedure embalagem;
      procedure produto;
      procedure estoques;
      procedure estoque;
      procedure tabela_preco;
      procedure preco;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      property Sincronia : TSincronia Read FSincronia write setFTSincronia;
      property BancoRetaguarda : TSTDatabase read FBancoRetaguarda write setFBancoRetaguarda;
      property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
  End;

implementation

{ TControllerRetaguardareceive }

procedure TControllerRetaguardareceive.cargo;
begin
  //Configura o banco do servidor no controle
  with FCtrlCargo do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;
end;

procedure TControllerRetaguardareceive.Colaborador;
begin
  //Configura o banco do servidor no controle
  with FCtrlColaborador do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;
end;

constructor TControllerRetaguardareceive.Create(AOwner: TComponent);
begin
  FCtrlUsuario      := TControllerUsuario.Create(self);
  FCtrlCargo        := TControllerCargo.Create(self);
  FCtrlColaborador  := TControllerColaborador.Create(self);
  FCtrlEmpresa      := TControllerEmpresa.Create(self);
  FCtrlFormaPagto   := TControllerFormaPagamento.Create(self);
  FCtrlGrupo        := TControllerGrupos.Create(self);
  FCtrlSubGrupo     := TControllerSubGrupos.Create(self);
  FCtrlMarca        := TControllerMarcaProduto.Create(self);
  FCtrlMedida       := TControllerMedida.Create(self);
  FCtrlEmbalagem    := TControllerEmbalagem.Create(self);
  FCtrlProduto      := TControllerProduto.Create(self);
  FCtrlEstoques     := TControllerEstoques.Create(self);
  FCtrlEstoque      := TControllerEstoque.Create(self);
  FCtrltTabela      := TControllerTabelaPreco.Create(self);
  FCtrlPreco        := TControllerPreco.Create(self);
  inherited;
end;

destructor TControllerRetaguardareceive.Destroy;
begin
  FCtrlUsuario.DisposeOf;
  FCtrlCargo.DisposeOf;
  FCtrlColaborador.DisposeOf;
  FCtrlEmpresa.DisposeOf;
  FCtrlFormaPagto.DisposeOf;
  FCtrlGrupo.DisposeOf;
  FCtrlSubGrupo.DisposeOf;
  FCtrlMarca.DisposeOf;
  FCtrlMedida.DisposeOf;
  FCtrlEmbalagem.DisposeOf;
  FCtrlProduto.DisposeOf;
  FCtrlEstoques.DisposeOf;
  FCtrlEstoque.DisposeOf;
  FCtrltTabela.DisposeOf;
  FCtrlPreco.DisposeOf;

  inherited;
end;

procedure TControllerRetaguardareceive.embalagem;
begin
  //Configura o banco do servidor no controle
  with FCtrlEmbalagem do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.empresa;
begin
  //Configura o banco do servidor no controle
  with FCtrlEmpresa do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;
end;

procedure TControllerRetaguardareceive.estoque;
begin
  //Configura o banco do servidor no controle
  with FCtrlEstoque do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    //Na sincronia não temos chave composta. por isso precisa ser direto pelo est_codigo
    getByCodigo;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.estoques;
begin
  //Configura o banco do servidor no controle
  with FCtrlEstoques do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.formapagto;
begin
  //Configura o banco do servidor no controle
  with FCtrlFormaPagto do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.grupo;
begin
  //Configura o banco do servidor no controle
  with FCtrlGrupo do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.marcaproduto;
begin
  //Configura o banco do servidor no controle
  with FCtrlMarca do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.Medida;
begin
  //Configura o banco do servidor no controle
  with FCtrlMedida do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.preco;
begin
  //Configura o banco do servidor no controle
  with FCtrlPreco do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getByCodigo;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.produto;
begin
  //Configura o banco do servidor no controle
  with FCtrlProduto do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

procedure TControllerRetaguardareceive.setFBancoRetaguarda(
  const Value: TSTDatabase);
begin
  FBancoRetaguarda := Value;
end;

procedure TControllerRetaguardareceive.setFTSincronia(const Value: TSincronia);
begin
  FSincronia := Value;
end;

procedure TControllerRetaguardareceive.subgrupo;
begin
  //Configura o banco do servidor no controle
  with FCtrlSubGrupo do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.tabela_preco;
begin
  //Configura o banco do servidor no controle
  with FCtrltTabela do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;

end;

procedure TControllerRetaguardareceive.usuario;
begin
  //Configura o banco do servidor no controle
  with FCtrlUsuario do
  Begin
    DataBase := BancoRetaguarda;
    Registro.Codigo := FSincronia.Registro;
    getById;
    if exist then
    Begin
      //Configura o banco do PDV no controle
      DataBase := BancoPDV;
      Replace;
    End;
  End;
end;

end.
