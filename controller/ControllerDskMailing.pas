unit ControllerDskMailing;

interface
    uses  Classes,ControllerBase;

  type TControllerDskMailing = class(TControllerBase)
    private { private declarations }
      FID : Integer;
      FEmail : String;
    protected { protected declarations }

    public { public declarations }
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function ExistEmail():Boolean;
    published { published declarations }
      property ID : Integer read FID write FID;
      property email : string read FEmail write FEmail;
  end;

implementation




constructor TControllerDskMailing.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TControllerDskMailing.Destroy;
begin
  inherited Destroy;

end;

function TControllerDskMailing.ExistEmail():Boolean;
Begin
  Result := true;

End;


end.
