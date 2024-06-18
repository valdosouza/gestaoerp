unit ControllerretaguardawebSync;

interface

uses ControllerBase, tblRetaguardaSync, STQuery, STDatabase,
  System.Classes, Vcl.StdCtrls, Vcl.Samples.Gauges;

Type

  TControllerretaguardawebSync = Class(TControllerBase)
  private
    FBancoPDV: TSTDatabase;
    FMsgProcessamento: TLabel;
    FLogListBox: TListBox;
    FEstabelecimento: Integer;
    FProgresso: TGauge;
    FDataFinal: TDate;
    FDataInicial: TDate;
    function getFBancoRetaguarda: TSTDatabase;
    procedure setFBancoPDV(const Value: TSTDatabase);
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
    procedure setFEstabelecimento(const Value: Integer);
    procedure setFLogListBox(const Value: TListBox);
    procedure setFMsgProcessamento(const Value: TLabel);
    procedure setFProgresso(const Value: TGauge);

  public
    Registro : TRetaguardaSync;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DesativarAllTriggers;
    procedure resetDataRecebimento;

    property BancoPDV : TSTDatabase read FBancoPDV write setFBancoPDV;
    property BancoRetaguarda : TSTDatabase read getFBancoRetaguarda;
    property Estabelecimento : Integer read FEstabelecimento write setFEstabelecimento;
    property LogListBox : TListBox read FLogListBox write setFLogListBox;
    property MsgProcessamento : TLabel read FMsgProcessamento write setFMsgProcessamento;
    property Progresso : TGauge read FProgresso write setFProgresso;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;

  End;


implementation

{ TControllerretaguardawebSync }

constructor TControllerretaguardawebSync.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TRetaguardaSync.Create;;
end;

procedure TControllerretaguardawebSync.DesativarAllTriggers;
begin

end;

destructor TControllerretaguardawebSync.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

function TControllerretaguardawebSync.getFBancoRetaguarda: TSTDatabase;
begin

end;

procedure TControllerretaguardawebSync.resetDataRecebimento;
Var
  Lc_Qry: TSTQuery;
begin
  Try
    DataBase := FBancoPDV;
    Lc_Qry := GeraQuery;
    with Lc_Qry do
    Begin
      Active := False;
      sql.Clear;
      sql.Add(concat(
                'UPDATE tb_retaguarda_sync set ',
                'SYN_TIME =:SYN_TIME ',
                'where way is not null '
      ));
      if Registro.Sentido <> '' then
        sql.Add(' AND (way = :WAY) ');

      ParambyName('SYN_TIME').AsDateTime := Registro.Tempo;
      if Registro.Sentido <> '' then
        ParambyName('WAY').asString := Registro.Sentido;
      ExecSQL;
    End;
  Finally
    FinalizaQuery(Lc_Qry);
  End;

end;

procedure TControllerretaguardawebSync.setFBancoPDV(const Value: TSTDatabase);
begin
  FBancoPDV := Value;
end;

procedure TControllerretaguardawebSync.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TControllerretaguardawebSync.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TControllerretaguardawebSync.setFEstabelecimento(
  const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TControllerretaguardawebSync.setFLogListBox(const Value: TListBox);
begin
  FLogListBox := Value;
end;

procedure TControllerretaguardawebSync.setFMsgProcessamento(
  const Value: TLabel);
begin
  FMsgProcessamento := Value;
end;

procedure TControllerretaguardawebSync.setFProgresso(const Value: TGauge);
begin
  FProgresso := Value;
end;

end.
