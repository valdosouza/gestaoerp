unit ControllerMdfeTrailer;

interface

uses STDatabase,Classes, Vcl.Grids,STQuery, SysUtils,ControllerBase,
       tblMdfeTrailer ,Un_MSg,Generics.Collections;

Type

  TControllerMdfeTrailer = Class(TControllerBase)
  private

  public
    Registro : TMdfeTrailer;

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

{ TControllerMdfeTrailer }

procedure TControllerMdfeTrailer.Clear;
begin
  clearObj(Registro);
end;

constructor TControllerMdfeTrailer.Create(AOwner: TComponent);
begin
  inherited;
  Registro := TMdfeTrailer.Create;
end;

function TControllerMdfeTrailer.delete: boolean;
begin
 Try
    DeleteObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

destructor TControllerMdfeTrailer.Destroy;
begin
  Registro.DisposeOf;
  inherited;
end;

procedure TControllerMdfeTrailer.getbyId;
begin
  _getByKey(Registro);
end;

function TControllerMdfeTrailer.insere: boolean;
begin
   if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDFE_TRAILER');
   Try
      InsertObj(Registro);
      Result := True;
   Except
      Result := False;
   End;
end;

function TControllerMdfeTrailer.salva: boolean;
begin
  if Registro.Codigo = 0 then
    Registro.Codigo := Generator('GN_MDFE_TRAILER');
  SaveObj(Registro);
end;

function TControllerMdfeTrailer.update: Boolean;
begin
  Try
    UpdateObj(Registro);
    Result := True;
  Except
    Result := False;
  End;
end;

end.
