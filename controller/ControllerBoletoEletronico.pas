unit ControllerBoletoEletronico;

interface

uses System.Classes, System.SysUtils, Generics.Collections, FireDAC.Stan.Param,
     STQuery, ControllerBase, tblBoletoEletronico, prm_electronic_slip;

Type
  TListaBoletoEletronico = TObjectList<TBoletoEletronico>;
  TControllerBoletoEletronico = Class(TControllerBase)
  private
    FParametros: TPrmElectronicSlip;
    procedure setFParametros(const Value: TPrmElectronicSlip);
  public
    Registro : TBoletoEletronico;
    Lista : TListaBoletoEletronico;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function save:boolean;
    procedure getbyId;
    function salva:boolean;
    function insert:boolean;
    Function delete:boolean;
    function getByKey:Boolean;
    function getAllByKey:boolean;
    function getFirst:boolean;
    function Clear:Boolean;
    function Search:Boolean;
    property Parametros : TPrmElectronicSlip read FParametros write setFParametros;
  End;

implementation

uses Un_sistema, Un_Regra_Negocio;

{ ControllerBoletoEletronico}

function TControllerBoletoEletronico.Clear: Boolean;
begin
  Result := True;
  clearObj(Registro);
  Parametros.Clear;
end;

constructor TControllerBoletoEletronico.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TBoletoEletronico.Create;
  Lista := TListaBoletoEletronico.Create;
  Parametros := TPrmElectronicSlip.Create;
end;

function TControllerBoletoEletronico.delete: boolean;
begin
  Try
    deleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerBoletoEletronico.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerBoletoEletronico.insert: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerBoletoEletronico.salva: boolean;
begin
  Result := True;
  Try
    if Registro.Codigo = 0 then
      Registro.Codigo := Generator('GN_BOLETO_ELETRONICO');
    SaveObj(Registro);
  Except
    Result := False;
  End;
end;

function TControllerBoletoEletronico.save: boolean;
begin
  try
    SaveObj(Registro);
    Result := true;
  except
    Result := False;
  end;
end;

function TControllerBoletoEletronico.Search: Boolean;
var
  Lc_Qry : TSTQuery;
  LITem : TBoletoEletronico;
begin
  Result := True;
  Lc_Qry := GeraQuery;
  Try
    with Lc_Qry do
    Begin
      //SQL.Text := ' SELECT * FROM TB_BOLETO_ELETRONICO WHERE 1=1';


      SQL.Text:=
          'SELECT  tb_banco.EMP_NUMBCO ,CTB_AGENCIA, CTB_CONTA, CTB_CODIGO, BLE_CODIGO, '+
          'tb_carteira_cobranca.ctr_numero,tb_carteira_cobranca.ctr_descricao '+
          'FROM TB_BOLETO_ELETRONICO tb_boletoeletronico '+
          '  INNER JOIN TB_CONTABANCARIA tb_contabancaria '+
          '  ON (tb_boletoeletronico.BLE_CODCTB = tb_contabancaria.ctb_codigo) '+
          '  INNER JOIN TB_EMPRESA tb_banco '+
          '  ON (tb_banco.EMP_CODIGO = tb_contabancaria.CTB_CODBCO ) '+
          '  inner join tb_carteira_cobranca '+
          '  on (tb_carteira_cobranca.ctr_codigo = tb_boletoeletronico.ble_codctr) '+
          'WHERE 1=1 ';
          //'WHERE (CTB_CODMHA=:CTB_CODMHA) ';

              {

  if Trim(E_BuscaBanco.Text) = '' then
    Lc_Banco := False
  else
    Lc_Banco := True;



  if Lc_Banco then
    sqltxt := sqltxt +'AND (EMP_CODBCO =:EMP_CODBCO) ';




      if Parametros.FieldName.Codigo <> EmptyStr then
      begin
        SQL.Text := SQL.Text + ' AND IMP_DESCRICAO LIKE :IMP_DESCRICAO';
        ParamByName('IMP_DESCRICAO').AsString := Concat('%',Parametros.FieldName.Descricao,'%');
      end;           }

      Active := True;
      FetchAll;
      First;
      Lista.Clear;
      while not eof do
      Begin
        LITem := TBoletoEletronico.Create;
        get(Lc_Qry,LITem);
        Lista.add(LITem);
        next;
      end;
    end;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

procedure TControllerBoletoEletronico.setFParametros(
  const Value: TPrmElectronicSlip);
begin
  FParametros := Value;
end;

function TControllerBoletoEletronico.getAllByKey: boolean;
begin
  getByKey;
end;

procedure TControllerBoletoEletronico.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerBoletoEletronico.getByKey: Boolean;
begin
  Result := True;
  Self._getByKey(Registro);
end;
function TControllerBoletoEletronico.getFirst: boolean;
Var
  Lc_Qry : TSTQuery;
Begin
  Lc_Qry := GeraQuery;
  TRy
    with Lc_Qry do
    BEgin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM TB_BOLETO_ELETRONICO ');
      Active := True;
      FetchAll;
      exist := (recordCount > 0);
      if exist then
        get(Lc_Qry,Registro);
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;
end;

end.
