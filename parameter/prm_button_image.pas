unit prm_button_image;

interface

uses
  prm_base, tblBotao, System.SysUtils;

Type
  TPrmButtonImage = class(TPrmBase)
  private
    FFieldName: TBotao;
    procedure setFFieldName(const Value: TBotao);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; Override;
    property FieldName : TBotao read FFieldName write setFFieldName;
  end;

implementation

{ TPrmButtonImage }

procedure TPrmButtonImage.Clear;
begin
  inherited;
  clearObj(FFieldName)
end;

constructor TPrmButtonImage.Create;
begin
  FFieldName := TBotao.Create;
end;

destructor TPrmButtonImage.Destroy;
begin
  FreeAndNil(FFieldName);
  inherited;
end;

procedure TPrmButtonImage.setFFieldName(const Value: TBotao);
begin
  FFieldName := Value;
end;

end.
