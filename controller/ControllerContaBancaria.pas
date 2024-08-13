unit ControllerContaBancaria;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase,
     tblContaBancaria, ControllerBoletoEletronico, prm_banking_account, ControllerBanco, ControllerEmpresa;

Type
  TListContaCorrente = TObjectList<TContaBancaria>;

  TControllerContaBancaria = Class(TControllerBase)

  private
    FParametros: TPrmBankingAccount;
    procedure setFParametros(const Value: TPrmBankingAccount);
  public
    Registro : TContaBancaria;
    //Obj: TObjBankAccount;
    Banco : TControllerBanco;
    Empresa : TControllerEmpresa;
    Lista : TListContaCorrente;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:boolean;
    function salva:boolean;
    procedure migra;
    function insert:boolean;
    Function delete:boolean;

    procedure getById;
    procedure getList;
   // procedure FillDataObjects(PcCC: TContaBancaria;Obj:TObjBankAccount);
    function Clear:Boolean;
    procedure Search;
    property Parametros : TPrmBankingAccount read FParametros write setFParametros;
  End;

  implementation
{ ControllerContaBancaria }

uses Un_sistema, Un_Regra_Negocio, Env;

function TControllerContaBancaria.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerContaBancaria.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TContaBancaria.Create;
  Lista     := TListContaCorrente.Create;
 // Obj       := TObjBankAccount.create;
  Parametros := TPrmBankingAccount.Create;
  Banco := TControllerBanco.Create(self);
  Empresa := TControllerEmpresa.Create(self);
end;

function TControllerContaBancaria.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerContaBancaria.Destroy;
begin
  //Obj.Destroy;
  Registro.DisposeOf;
  Lista.DisposeOf;
  FreeAndNil(FParametros);
  FreeAndNil(Banco);
  FreeAndNil(Empresa);
  inherited;
end;

{procedure TControllerContaBancaria.FillDataObjects(PcCC: TContaBancaria;
  Obj: TObjBankAccount);
begin
  with Obj do
  Begin
    NumeroBanco := IntToStr(Banco.getNumber(registro.CodigoBanco));
    ContaCorrente.Codigo          :=  PcCC.Codigo;
    ContaCorrente.Estabelecimento :=  Estabelecimento;
    ContaCorrente.Banco           :=  PcCC.CodigoBanco;
    ContaCorrente.DataAbertura    :=  PcCC.DataAbertura;
    ContaCorrente.Agencia         :=  PcCC.Agencia;
    ContaCorrente.AgenciaDv       :=  PcCC.DigitoAgencia;
    ContaCorrente.Numero          :=  PcCC.Conta;
    ContaCorrente.NumeroDv        :=  PcCC.DigitoContaCorrente;
    ContaCorrente.Fone            :=  PcCC.Fone;
    ContaCorrente.Gerente         :=  PcCC.Gerente;
    ContaCorrente.ValorLimite     :=  PcCC.ValorLimite;
    ContaCorrente.DataContrato    :=  PcCC.DataVencto;
  End;
end;    }

function TControllerContaBancaria.insert: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_CONTA_BANCARIA');
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

procedure TControllerContaBancaria.migra;
begin
  SaveObj(Registro);
end;

function TControllerContaBancaria.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := getNextByField(Registro,'CTB_CODIGO',0);
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerContaBancaria.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerContaBancaria.Search;
var
  Lc_Qry : TSTQuery;
  LITem : TContaBancaria;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      SQL.Text :=
        'SELECT tb_contabancaria.*, tb_banco.EMP_FANTASIA '+
        'FROM TB_CONTABANCARIA tb_contabancaria                                               '+
        '   INNER JOIN TB_EMPRESA tb_banco                                                    '+
        '   ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO )                           '+
        'WHERE (tb_contabancaria.CTB_CODIGO IS NOT NULL) AND (CTB_CODMHA=:CTB_CODMHA)         ';

      ParamByName('CTB_CODMHA').AsInteger := Gb_CodMha;

      if Parametros.FieldName.Agencia <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND Ctb_Agencia LIKE :Ctb_Agencia';
        ParamByName('Ctb_Agencia').AsString := Concat('%',Parametros.FieldName.Agencia,'%');
      end;

      if Parametros.FieldName.Conta <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND Ctb_Conta LIKE :Ctb_Conta';
        ParamByName('Ctb_Conta').AsString := Concat('%',Parametros.FieldName.Conta,'%');
      end;

      if Parametros.FieldName.NomeBanco <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND EMP_FANTASIA LIKE :EMP_FANTASIA';
        ParamByName('EMP_FANTASIA').AsString := Concat('%',Parametros.FieldName.NomeBanco,'%');
      end;

      Active := True;
      FetchAll;
      First;
      Lista.Clear;

      while not Eof do
      Begin
        LITem := TContaBancaria.Create;
        get(Lc_Qry, LITem);

        LItem.NomeBanco := FieldByName('EMP_FANTASIA').AsString;

        Lista.add(LITem);

        Next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerContaBancaria.setFParametros(
  const Value: TPrmBankingAccount);
begin
  FParametros := Value;
end;

function TControllerContaBancaria.update: boolean;
begin
  try
    updateObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

procedure TControllerContaBancaria.getById;
begin
  _getByKey(Registro);
end;

procedure TControllerContaBancaria.getList;
var
  Lc_Qry : TSTQuery;
  LcLista : TContaBancaria;
begin
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      active := False;
      sql.Clear;
      sql.add('SELECT * FROM TB_CONTABANCARIA ');
      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LcLista := TContaBancaria.Create;
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
