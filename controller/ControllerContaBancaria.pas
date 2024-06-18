unit ControllerContaBancaria;

interface

uses STDatabase,System.Classes, STQuery, System.SysUtils,ControllerBase,ObjBankAccount,
      tblContaBancaria, System.Generics.Collections,ControllerBanco;
Type
  TListContaCorrente = TObjectList<TContaBancaria>;

  TControllerContaBancaria = Class(TControllerBase)

  private
  public
    Registro : TContaBancaria;
    Obj: TObjBankAccount;
    Lista : TListContaCorrente;
    Banco : TControllerBanco;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    function update:boolean;
    function migra:Boolean;
    function insert:boolean;
    Function delete:boolean;

    procedure getById;
    procedure getList;
    procedure clear;
    procedure FillDataObjects(PcCC: TContaBancaria;Obj:TObjBankAccount);
  End;

  implementation
{ ControllerContaBancaria }

procedure TControllerContaBancaria.clear;
begin
  clearObj(Registro);
end;

constructor TControllerContaBancaria.Create(AOwner: TComponent);
begin
  inherited;
  Registro  := TContaBancaria.Create;
  Lista     := TListContaCorrente.Create;
  Obj       := TObjBankAccount.create;
  Banco := TControllerBanco.create(Self);
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
  Banco.DisposeOf;
  Obj.Destroy;
  Registro.DisposeOf;
  Lista.DisposeOf;
  inherited;
end;

procedure TControllerContaBancaria.FillDataObjects(PcCC: TContaBancaria;
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
end;

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

function TControllerContaBancaria.migra: Boolean;
begin
  SaveObj(Registro);
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
  Try
    Lc_Qry := GeraQuery;
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
