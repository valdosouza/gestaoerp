unit prm_base;

interface

uses
  System.SysUtils, System.Classes, GenericORM;

Type
  TPrmBase = class(TComponent)
  private
    FUltimaAtualizacao: String;
    FLimite: String;
    FUsuario: Integer;
    FDataFinal: TDate;
    FDataInicial: TDate;
    FPagina: Integer;
    FPeriodo: Boolean;
    FEstabelecimento: Integer;
    FTerminal: Integer;
    procedure setFDataFinal(const Value: TDate);
    procedure setFDataInicial(const Value: TDate);
    procedure setFLimite(const Value: String);
    procedure setFPagina(const Value: Integer);
    procedure setFUltimaAtualizacao(const Value: String);
    procedure setFUsuario(const Value: Integer);
    procedure setFPeriodo(const Value: Boolean);
    procedure setFEstabelecimento(const Value: Integer);
    procedure setFTerminal(const Value: Integer);
  protected
    function clearObj<T: class>(Obj: T):Boolean;

  public
    constructor create;
    destructor destroy;override;
    procedure Clear;Virtual;
    property Estabelecimento: Integer read FEstabelecimento write setFEstabelecimento;
    property Usuario: Integer read FUsuario write setFUsuario;
    property Periodo : Boolean read FPeriodo write setFPeriodo;
    property Pagina : Integer read FPagina write setFPagina;
    property DataInicial : TDate read FDataInicial write setFDataInicial;
    property DataFinal : TDate read FDataFinal write setFDataFinal;
    property Limite : String read FLimite write setFLimite;
    property Terminal : Integer read FTerminal write setFTerminal;
    property UltimaAtualizacao:String read FUltimaAtualizacao write setFUltimaAtualizacao;

  end;
implementation

{ TPrmBase }


function TPrmBase.clearObj<T>(Obj: T): Boolean;
begin
  Try
    TGenericORM._Clear(Obj);
    Result := True;
  except
    Result := False;
  End;
end;

procedure TPrmBase.Clear;
begin
  FUltimaAtualizacao := '';
  FLimite := '';
  FUsuario := 0;
  FDataFinal := Date;
  FDataInicial := Date;
  FPagina := 0;
  FPeriodo := False;;
  FEstabelecimento := 0;
end;

constructor TPrmBase.Create;
begin

end;

destructor TPrmBase.Destroy;
begin

end;

procedure TPrmBase.setFDataFinal(const Value: TDate);
begin
  FDataFinal := Value;
end;

procedure TPrmBase.setFDataInicial(const Value: TDate);
begin
  FDataInicial := Value;
end;

procedure TPrmBase.setFEstabelecimento(const Value: Integer);
begin
  FEstabelecimento := Value;
end;

procedure TPrmBase.setFLimite(const Value: String);
begin
  FLimite := Value;
end;

procedure TPrmBase.setFPagina(const Value: Integer);
begin
  FPagina := Value;
end;

procedure TPrmBase.setFPeriodo(const Value: Boolean);
begin
  FPeriodo := Value;
end;

procedure TPrmBase.setFTerminal(const Value: Integer);
begin
  FTerminal := Value;
end;

procedure TPrmBase.setFUltimaAtualizacao(const Value: String);
begin
  FUltimaAtualizacao := Value;
end;

procedure TPrmBase.setFUsuario(const Value: Integer);
begin
  FUsuario := Value;
end;

end.
