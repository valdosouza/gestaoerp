unit ControllerMdfeRetorno;

interface

uses STDatabase,System.Classes, Vcl.Grids,STQuery, System.SysUtils,ControllerBase,
     tblMdfeRetorno ,Un_MSg,
  ACBrMDFe, System.AnsiStrings,pcnConversao, pmdfeConversaoMDFe;

Type

  TControllerMdfeRetorno = Class(TControllerBase)
  private

  public
    Registro              : TMdfeRetorno;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function salva:boolean;
    procedure getbyId;
    function insere:boolean;
    function update:Boolean;
    Function delete:boolean;
    procedure Clear;
  End;
implementation

{ TControllerMdfeRetorno }

procedure TControllerMdfeRetorno.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeRetorno.Create(AOwner: TComponent);
begin
  inherited;
  Registro        := TMdfeRetorno.Create;
end;

function TControllerMdfeRetorno.delete: boolean;
begin
  Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeRetorno.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerMdfeRetorno.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeRetorno.insere: boolean;
begin
  Try
    InsertObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

function TControllerMdfeRetorno.salva: boolean;
begin
  SaveObj(Registro);
end;

function TControllerMdfeRetorno.update: Boolean;
begin
   Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
