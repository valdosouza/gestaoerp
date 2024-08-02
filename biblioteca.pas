unit biblioteca;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, FavoritoButtons;

type
  TValidar = class
  public
    class function Data(const DataStr: string): Boolean;
  end;

implementation

class function TValidar.Data(const DataStr: string): Boolean;
var
  Data: TDateTime;
begin
  Result := TryStrToDate(DataStr, Data);
end;

end.
