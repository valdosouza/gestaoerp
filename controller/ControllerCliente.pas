unit ControllerCliente;

interface
uses STDatabase,Classes, STQuery, SysUtils,ControllerBase,
      tblCliente ,Generics.Collections, tblCustomer,
      ControllerEmpresa,ControllerColaborador, un_funcoes,ObjCustomer,tbladdress,tblphone,
  Vcl.StdCtrls;


Type
  TListCliente = TObjectList<TCliente>;

  TControllerCliente = Class(TControllerBase)

  private

  protected


  public
    Registro : TCliente;
    Lista :TListCliente;
    Empresa : TControllerEmpresa;
    Vendedor : TControllerColaborador;
    Obj : TObjCustomer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    function update:Boolean;
    procedure getById;
    procedure getList;
    procedure getallByKey;
    procedure saveObjWeb(pCustomer:TObjCustomer);
    procedure saveCustomer(pCustomer:TCustomer);
    procedure fillDataObjeto(pCliente:TCliente;pObj:TObjCustomer);
    procedure fillCustomer(pCliente:TCustomer);
    procedure clear;
    function Delete:Boolean;
    procedure criarClienteSemCPFCNPJ;
    procedure PreencheComboBox(Order:String;Cb: TComboBox);
    function getByFieldName(strTable, field, Content: String):Boolean;
  End;

implementation

{ TControllerCashier }

uses Un_Regra_Negocio;

procedure TControllerCliente.clear;
begin
  clearObj(registro);
  Empresa.Clear;
end;

constructor TControllerCliente.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TCliente.Create;
  Empresa := TControllerEmpresa.Create(Self);
  Vendedor := TControllerColaborador.Create(Self);
  Lista := TListCliente.Create;
  Obj := TObjCustomer.Create;
end;

procedure TControllerCliente.criarClienteSemCPFCNPJ;
begin
  empresa.Registro.CpfCNPJ := '12345677654321';
  empresa.getByDocumento;
  if not empresa.exist then
  Begin
    Empresa.criarEmpresaSemCPFCNPJ;
    clear;
    Registro.Codigo             := Empresa.Registro.Codigo;
    Registro.Ativo              := 'S';
    Registro.IndicadorIE_Dest   := '1';
    Registro.EnviaEmailNFeAuto  := 'N';
    Registro.EnviarSomenteXML   := 'N';
    salva;
  End;
end;

function TControllerCliente.Delete: Boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

destructor TControllerCliente.Destroy;
begin
  Obj.Destroy;
  Registro.disposeof;
  Lista.disposeof;
  Empresa.disposeof;
  Vendedor.disposeof;
  inherited;
end;

procedure TControllerCliente.fillCustomer(pCliente: TCustomer);
begin

  pCliente.Codigo                := pCliente.Codigo;
  pCliente.Vendedor              := Empresa.Registro.CodigoVendedor;
  pCliente.Transportador         := Empresa.Registro.CodigoTransportadora;
  pCliente.SituacaoCredito       := Empresa.Registro.SituacaoCredito;
  pCliente.ValorCredito          := Empresa.Registro.ValorCredito;
  if Empresa.Registro.VendaEmCarteira > 0 then
    pCliente.VendeEmCarteira := 'S'
  else
    pCliente.VendeEmCarteira := 'N';
  pCliente.ConsumidorFinal        := Empresa.Registro.ConsumidorFinal;
  pCliente.Ativo                  := Empresa.Registro.Ativa;
  pCliente.Multiplicador          := Empresa.Registro.Multiplicador;
  pCliente.IgnoraST               := Empresa.Registro.IgnorarCalculoST;
end;

procedure TControllerCliente.fillDataObjeto(pCliente: TCliente;pObj:TObjCustomer);
Var
  LcPhone : TPhone;
  LcAddress : TAddress;
begin
  Empresa.Registro.Codigo := pCliente.Codigo;
  Empresa.getAllBykey;
  Empresa.fillDataObjeto(Empresa.Registro,pObj.Fiscal);


  pObj.Fiscal.Juridica.IndExigibilidadeISS     := Registro.IssExigibilidade;
  pObj.Fiscal.Juridica.RetencaoISS             := Registro.IssRetido;
  pObj.Fiscal.Juridica.IncentFiscalISS         := Registro.IssIncentivoFiscal;
  pObj.Fiscal.Juridica.NumeroProcessoISS       := Registro.IssNumeroProcesso;
  pObj.Fiscal.Juridica.EnviarSomenteXMLNFe     := Registro.EnviarSomenteXML;


  pObj.Cliente.Codigo                := pCliente.Codigo;
  pObj.Cliente.Vendedor              := Empresa.Registro.CodigoVendedor;
  Vendedor.Registro.Codigo           := pObj.Cliente.Vendedor;
  pObj.DocFiscalVendedor             := Vendedor.getDocByID;

  pObj.Cliente.Transportador         := Empresa.Registro.CodigoTransportadora;
  pObj.Cliente.SituacaoCredito       := Empresa.Registro.SituacaoCredito;
  pObj.Cliente.ValorCredito          := Empresa.Registro.ValorCredito;
  if Empresa.Registro.VendaEmCarteira > 0 then
    pObj.Cliente.VendeEmCarteira := 'S'
  else
    pObj.Cliente.VendeEmCarteira := 'N';
  pObj.Cliente.ConsumidorFinal := Empresa.Registro.ConsumidorFinal;
  pObj.Cliente.Ativo           := Registro.Ativo;
  pObj.Cliente.Multiplicador   := Empresa.Registro.Multiplicador;
  pObj.Cliente.IgnoraST        := Empresa.Registro.IgnorarCalculoST;
  pObj.Cliente.Estabelecimento := pObj.Estabelecimento;
end;

procedure TControllerCliente.getallByKey;
begin
  getById;
  if (exist) then
  Begin
    Empresa.Registro.Codigo := Registro.Codigo;
    Empresa.getAllBykey;

    Vendedor.Registro.Codigo := Empresa.Registro.CodigoVendedor;
    Vendedor.getbyId;
  End;
end;

function TControllerCliente.getByFieldName(strTable, field,
  Content: String): Boolean;
var
    Lc_Qry : TSTQuery;
begin
  Try
    Lc_Qry := getbyField(strTable,Field,Content);
    exist  := ( Lc_Qry.RecordCount > 0 );
    if exist then
    Begin
      Empresa.exist := True;
      clearObj(Empresa.Registro);
      get(Lc_Qry,Empresa.Registro) ;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCliente.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerCliente.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TCliente;
begin
  Try
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_CLIENTE ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TCliente.Create;
        get(Lc_qry,LcLista);
        Lista.add(LcLista);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerCliente.PreencheComboBox(Order:String;Cb: TComboBox);
var
  Lc_Qry : TSTQuery;
  Lc_Filter: TStrings;
begin
  Try
    Lc_Filter := TStringList.Create;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      sql.add(concat(
                'select  ',
                ' EMP_CODIGO, ',
                ' EMP_NOME, ',
                ' EMP_FANTASIA ',
                'FROM tb_empresa E ',
                '  INNER JOIN tb_cliente c ',
                '  on (c.cli_codemp = e.emp_codigo) ',
                'where cli_ativo = ''S'' '));
      IF Order = 'EMP_NOME' then
        sql.add( ' ORDER BY EMP_CODIGO desc, EMP_NOME asc ')
      else
        sql.add( ' ORDER BY EMP_CODIGO desc, EMP_FANTASIA ASC ');
      Active := True;
      FetchAll;
      First;
      disablecontrols;
      Cb.items.beginUpdate;
      Lc_Filter.Clear;
      while not eof do
      Begin
        if Order = 'EMP_NOME' then
          Lc_Filter.Add(FieldByName('EMP_NOME').AsString)
        else
          Lc_Filter.Add(FieldByName('EMP_FANTASIA').AsString);
        next;
      end;
      Cb.Items.Assign(Lc_Filter);
      Cb.items.endUpdate;
      enablecontrols;
    end;
  Finally
    Lc_Filter.free;
    FinalizaQuery(Lc_Qry);
  End;

end;

function TControllerCliente.salva: boolean;
begin
  Try
    SaveObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerCliente.saveCustomer(pCustomer: TCustomer);
begin
  with Registro do
  Begin
    Codigo              := pCustomer.Codigo;
    Ativo               := pCustomer.Ativo;
    ObservacaoNF        := '';
    EnviarSomenteXML    := 'N';
    IndicadorIE_Dest    := '9';
    IssRetido           := 'N';
    IssExigibilidade    := '';
    IssIncentivoFiscal  := '';
    IssNumeroProcesso   := '';
    ValorEntrega        := 0;
    EnviaEmailNFeAuto   := 'N';
  End;
  salva;
end;

procedure TControllerCliente.saveObjWeb(pCustomer: TObjCustomer);
Var
  LcEndereco : TAddress;
  LcFone : TPhone;
  I : Integer;
begin
  empresa.saveObjWeb(pCustomer.Fiscal);
  with Empresa.Registro do
  Begin
    ValorCredito                      := 0;
    CodigoVendedor                    := pCustomer.Vendedor;
    ConsumidorFinal                   := pCustomer.Cliente.ConsumidorFinal;
    OptantePeloSimples                := pCustomer.Fiscal.Juridica.CRTmodal ;
    Ativa                             := pCustomer.Cliente.Ativo;
    Status                            := pCustomer.Cliente.SituacaoCredito;
  End;
  Empresa.Update;

  with Registro do
  Begin
    Codigo              := Empresa.Registro.Codigo;
    Ativo               := Empresa.Registro.Ativa;
    ObservacaoNF        := '';
    EnviarSomenteXML    := 'N';
    IndicadorIE_Dest    := Empresa.Registro.IndicadorInscricaoEstadual;
    IssRetido           := 'N';
    IssExigibilidade    := '';
    IssIncentivoFiscal  := '';
    IssNumeroProcesso   := '';
    ValorEntrega        := 0;
    EnviaEmailNFeAuto   := 'N';
  End;
  salva;
end;

function TControllerCliente.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;

end;

end.
