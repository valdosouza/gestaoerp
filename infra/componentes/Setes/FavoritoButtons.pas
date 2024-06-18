unit FavoritoButtons;

interface

uses
  SysUtils, Classes, Controls, Buttons;

type
  TFavoritoButtons = class(TBitBtn)
  private
    { Private declarations }
      CodigoFavorito: Integer;
      procedure SetCodigoFavorito(Value: Integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CodigoEscolhido: Integer read CodigoFavorito write SetCodigoFavorito default 0;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Setes', [TFavoritoButtons]);
end;

constructor TFavoritoButtons.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
end;

destructor TFavoritoButtons.Destroy;
begin
  inherited Destroy;
end;

procedure TFavoritoButtons.SetCodigoFavorito(Value: Integer);
begin
  if CodigoFavorito <> Value then
  begin
    CodigoFavorito := Value;
  end;
end;

end.

